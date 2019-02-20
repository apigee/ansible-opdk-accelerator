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

import requests
import json
import ast
from ansible.module_utils.basic import *
from requests.auth import HTTPBasicAuth

USER_NAME = 'username'
PASSWORD = 'password'
SERVER_SELF = 'server_self'
MS_IP = 'mgmt_server_ip'
SERVER_UUID = 'uuid'
UUID = 'uUID'
SERVER_POD = 'pod'
SERVER_TYPE = 'type'
REGION = 'region'
INTERNAL_IP = 'internalIP'
TYPE = 'type'
CONTENT_TYPE = 'Content-Type'
FORM_URL_ENCODING = 'application/x-www-form-urlencoded'

server_types = {
    'message-processor': ':8080/v1/organizations/{{ org_name }}/environments/{{ env_name }}/servers'
}

def get_uri(org_name, env_name):
    return ':8080/v1/organizations/' + org_name + '/environments/' + env_name + '/servers'

def register_message_processor(target_server, username, password):
    params = {}
    params['action'] = 'add'
    params[SERVER_UUID] = target_server[UUID]
    headers = {CONTENT_TYPE: FORM_URL_ENCODING}
    auth = HTTPBasicAuth(username, password)
    url = 'http://' + target_server[MS_IP] + get_uri(target_server['org'], target_server['env'])
    resp = requests.post(url, auth=auth, params=params, headers=headers)
    return resp


def _to_json(data):
    data = ast.literal_eval(data)
    data = json.dumps(data)
    data = json.loads(data)
    return data


def main():
    module = AnsibleModule(argument_spec=dict(
            username=dict(required=True, type='str', no_log=True),
            password=dict(required=True, type='str', no_log=True),
            server_self=dict(required=True, type='str'),
            mgmt_server_ip=dict(required=True, type='str'),
            org=dict(required=True, type='str'),
            env=dict(required=True, type='str')
    ))
    username = module.params[USER_NAME]
    password = module.params[PASSWORD]
    mgmt_server_ip = module.params[MS_IP]
    server_self = _to_json(module.params[SERVER_SELF])
    org = module.params['org']
    env = module.params['env']
    server_self[MS_IP] = mgmt_server_ip
    server_self['org'] = org
    server_self['env'] = env
    current_registration = register_message_processor(server_self, username, password)
    status_code = str(current_registration.status_code)
    current_server = current_registration.json()

    if status_code == '200':
            module.exit_json(
                    changed=True,
                    ansible_facts=dict(
                            changed=True,
                            msg='server is registered',
                            rc=0,
                            mp_registration=current_server
                    )
            )
    else:
        module.fail_json(
                msg='server is not registered ',
                rc=1,
                registered=current_registration.text
        )

if __name__ == '__main__':
    main()
