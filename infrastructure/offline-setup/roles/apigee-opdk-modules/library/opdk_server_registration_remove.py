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

import requests, json, ast
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



def delete_server_registration(target_server, username, password):
    auth = HTTPBasicAuth(username, password)
    url = 'http://' + target_server[INTERNAL_IP] + ':8080/v1/servers/'
    resp = requests.delete(url, auth=auth)
    return resp


def compare_registration(target_server, registered_server):
    return (target_server[UUID] == registered_server[UUID]) and \
           (target_server[SERVER_POD] == registered_server[SERVER_POD]) and \
           (target_server[INTERNAL_IP] == registered_server[INTERNAL_IP]) and \
           (target_server[SERVER_TYPE][0] == registered_server[TYPE][0])


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
            mgmt_server_ip=dict(required=True, type='str')
    ))

    username = module.params[USER_NAME]
    password = module.params[PASSWORD]
    mgmt_server_ip = module.params[MS_IP]
    server_self = _to_json(module.params[SERVER_SELF])

    current_registration = get_server_registration(server_self, mgmt_server_ip, username, password)
    status_code = str(current_registration.status_code)
    current_server = current_registration.json()

    server_self['registered'] = compare_registration(server_self, current_server)
    if status_code == '200':
        if server_self['registered']:
            module.exit_json(
                    changed=True,
                    ansible_facts=dict(
                            changed=True,
                            msg='server is registered',
                            rc=0,
                            registered=server_self
                    )
            )

    else:
        module.fail_json(
                msg='server is not registered ',
                rc=1,
                registered=server_self
        )


if __name__ == '__main__':
    main()
