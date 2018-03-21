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
from requests.exceptions import RequestException
from requests.auth import HTTPBasicAuth
from ansible.module_utils.basic import *

BASE_SERVER_URL = 'http://localhost'
SERVER_SELF_URI = '/v1/servers/self'
SERVER_PORTS = {'ms': '8080',
                'router': '8081',
                'r': '8081',
                'mp': '8082',
                'rmp': '8082',
                'qs': '8083',
                'ps': '8084'}


def get_server_self(server_type, username, password):
    auth = HTTPBasicAuth(username, password)
    url = BASE_SERVER_URL + ':' + SERVER_PORTS[server_type] + SERVER_SELF_URI
    resp = requests.get(url, auth=auth)
    return resp


def map_server_self(server_self):
    reported = server_self.json()
    for p in reported['tags']['property']:
        name = p['name']
        value = p['value']
        reported[name] = value
    del reported['tags']
    return reported


def main():
    module = AnsibleModule(
            argument_spec=dict(
                    username=dict(required=True, type='str', no_log=True),
                    password=dict(required=True, type='str', no_log=True),
                    server_type=dict(required=True, type='str', choices=['ms', 'router', 'r', 'mp', 'qs', 'ps', 'rmp'])
            )
    )

    username = module.params['username']
    password = module.params['password']
    server_type = module.params['server_type']
    try:
        resp = get_server_self(server_type, username, password)
        status_code = resp.status_code
    except RequestException as ex:
        status_code = 500
        msg = str(ex) + " Did you run on the correct server?"
        print(msg)

    if status_code >= 200 and status_code < 300:
        server_self = map_server_self(resp)
        facts = {}
        facts['edge_' + server_type + '_self'] = server_self
        module.exit_json(
                changed=True,
                ansible_facts=facts
        )
    elif status_code > 400:
        err_msg = "Error status code returned: ["
        if 'msg' in globals():
            err_msg += msg
        module.fail_json(
                changed=False,
                msg=err_msg,
                status_code=status_code,
        )


if __name__ == '__main__':
    main()
