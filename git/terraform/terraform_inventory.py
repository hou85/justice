#!/usr/bin/env python3
import json
import subprocess
import sys

def get_terraform_output():
    result = subprocess.run(['terraform', 'output', '-json'], capture_output=True, text=True)
    if result.returncode != 0:
        print("Error running terraform output", file=sys.stderr)
        print(result.stderr, file=sys.stderr)
        sys.exit(result.returncode)
    return json.loads(result.stdout)

def main():
    terraform_output = get_terraform_output()
    instance_ip = terraform_output.get('instance_public_ip', {}).get('value')
    
    if instance_ip:
        inventory = {
            'gitlab': {
                'hosts': [instance_ip],
                'vars': {
                    'ansible_user': 'ec2-user',
                    'ansible_ssh_private_key_file': '~/.ssh/terraform.pem'
                }
            }
        }
    else:
        print("No instance IP found", file=sys.stderr)
        inventory = {}

    print(json.dumps(inventory, indent=2))

if __name__ == '__main__':
    main()
