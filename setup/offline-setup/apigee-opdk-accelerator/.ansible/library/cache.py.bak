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

def main():
    module = AnsibleModule(
            argument_spec=dict(
                    key=dict(required=True, type='str'),
                    value=dict(required=False, type='str')
            )
    )
    kv = {module.params['key']: module.params['value']}
    module.exit_json(
            changed=True,
            ansible_facts=kv
    )

if __name__ == '__main__':
    main()
