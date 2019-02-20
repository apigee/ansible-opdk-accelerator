# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from ansible.module_utils.basic import *
import ast
import json

GROUPS = 'groups'
PUBLIC_ADDRESS = 'public_address'
RACK = "rack"
PRIVATE_ADDRESS = 'private_address'
NOT_DEFINED = 'NOT DEFINED'
LEAD_GROUP = 'lead_group'


def build_cass_hosts_config(inventory_hostname, hostvars):
    cassandra_groups = extract_cassandra_groups(hostvars[inventory_hostname], hostvars)
    configured_cassandra_racks = configure_cassandra_racks(cassandra_groups)
    cassandra_lead_found = determine_lead_group(configured_cassandra_racks,
                                                inventory_hostname,
                                                hostvars[inventory_hostname][GROUPS])
    prioritized_groups = prioritize_cassandra_groups(cassandra_lead_found)
    return ' '.join(prioritized_groups)


def extract_cassandra_groups(inventory_vars, hostvars):
    cassandra_groups = {}
    for name in inventory_vars[GROUPS]:
        if 'dc-' in name and '-ds' in name:
            cassandra_groups[name] = list(inventory_vars[GROUPS][name])

    cassandra_ip_mappings= { 'lead_group': '' }
    for cassandra_group_name in cassandra_groups:
        cassandra_ip_mappings[cassandra_group_name] = {}
        for ds_ip in cassandra_groups[cassandra_group_name]:
            if ds_ip in hostvars:
                hostvar = hostvars[ds_ip]
                if PRIVATE_ADDRESS in hostvar:
                    private_ip = hostvar[PRIVATE_ADDRESS]
                else:
                    private_ip = NOT_DEFINED

                if 'rack' in hostvar:
                    rack = hostvar['rack']
                else:
                    rack = 1

                if 'region' in hostvar:
                    region = hostvar['region']
                else:
                    region = None

            cassandra_ip_map = cassandra_ip_mappings[cassandra_group_name]
            cassandra_ip_map[ds_ip] = { 'private_ip': private_ip, 'rack': rack, 'region': region}
    return cassandra_ip_mappings


def configure_cassandra_racks(cassandra_groups):
    for cassandra_group_name in cassandra_groups:
        region_parts = cassandra_group_name.split('-')
        for ds_ip in cassandra_groups[cassandra_group_name]:
            rack = cassandra_groups[cassandra_group_name][ds_ip]['rack']
            if rack is None:
                rack = 1
            if cassandra_groups[cassandra_group_name][ds_ip]['region'] is None:
                region = region_parts[1]
            else:
                region = cassandra_groups[cassandra_group_name][ds_ip]['region']

            region_nums = region.split('-')
            if region_nums.__len__() < 2:
                region_nums = ['dc', '1']

            cassandra_groups[cassandra_group_name][ds_ip]['private_ip'] = cassandra_groups[cassandra_group_name][ds_ip]['private_ip'] + ":" + str(region_nums[1]) + ',' + str(rack)
    return cassandra_groups


def determine_lead_group(cassandra_groups, inventory_hostname, groups):
    for group_name in groups:
        if 'dc-' in group_name:
            if inventory_hostname in groups[group_name]:
                group_name_split = group_name.split('-')
                cassandra_groups['lead_group'] = group_name_split[0] + '-' + group_name_split[1]
                break
    return cassandra_groups


def prioritize_cassandra_groups(cassandra_groups):
    prioritized_groups = []
    ds_lead_group = cassandra_groups['lead_group'] + '-ds'
    del cassandra_groups['lead_group']

    for ds_ip in cassandra_groups[ds_lead_group]:
            prioritized_groups.append(cassandra_groups[ds_lead_group][ds_ip]['private_ip'])
    del cassandra_groups[ds_lead_group]

    for cassandra_group_name in cassandra_groups:
        for ds_ip in cassandra_groups[cassandra_group_name]:
            prioritized_groups.append(cassandra_groups[cassandra_group_name][ds_ip]['private_ip'])

    return prioritized_groups


def main():
    module = AnsibleModule(
            argument_spec=dict(
                    inventory_hostname=dict(required=True, type='str'),
                    hostvars=dict(required=True, type="str")
            )
    )

    inventory_hostname = module.params['inventory_hostname']
    hostvars = module.params['hostvars']
    try:
        hostvars = ast.literal_eval(hostvars)
    except SyntaxError as e:
        hostvars = hostvars.replace('{u', '{')
        hostvars = hostvars.replace(", u'", ", '")
        hostvars = hostvars.replace(": u'", ": '")
        hostvars = hostvars.replace("[u'", "['")
        hostvars = hostvars.replace("'", "\"")

        try:
            hostvars = ast.literal_eval(hostvars)
        except SyntaxError as e:
            msg = "ast.literal_eval conversion failed on line {0} with {1}. ".format(e.lineno, e.msg)
            msg += "This occurred due to an operating system setting or memory exhaustion. There is a way around."
            msg += "Separate the process by running --tags=config to generate the silent-install.conf file."
            msg += "Then complete the installation with --skip-tags=config or by adding config to your existing list of --skip-tags."
            module.fail_json(
                changed=False,
                msg=msg,
            )
            return

    hostvars = json.dumps(hostvars)

    try:
        hostvars = json.loads(hostvars)
    except SyntaxError as e:
        msg = "json.loads conversion failed: {0} {1}".format(e.lineno, e.msg)
        module.fail_json(
            changed=False,
            msg=msg,
        )
        return


    try:
        cass_hosts = build_cass_hosts_config(inventory_hostname, hostvars)
    except SyntaxError as e:
        msg = "build_cass_hosts_config failed on line {0} with {1}".format(e.lineno, e.msg)
        module.fail_json(
            changed=False,
            msg=msg,
        )
        return

    cass_hosts = json.dumps(cass_hosts)
    cass_hosts = json.loads(cass_hosts)

    module.exit_json(
            changed=True,
            ansible_facts=dict(
                    cassandra_hosts=cass_hosts
            )
    )

if __name__ == '__main__':
    main()
