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
    master_ip       = terraform_output.get('kubernetes_master_ip', {}).get('value')
    worker_ips      = terraform_output.get('kubernetes_worker_ips', {}).get('value', [])
    external_ip     = terraform_output.get('proxy_external_ip', {}).get('value', [])
    internal_ip     = terraform_output.get('proxy_internal_ip', {}).get('value', [])
    mongodb_ip      = terraform_output.get('mongodb_ip', {}).get('value', [])
    logging_ip      = terraform_output.get('logging_ip', {}).get('value', [])
    monitoring_ip   = terraform_output.get('monitoring_ip', {}).get('value', [])
    
    inventory= {
        'all': {
            'vars': {
                'ansible_user': 'ec2-user',
                'ansible_ssh_private_key_file': '~/.ssh/terraform.pem'
            }
        },
            'master': {
                'hosts': [master_ip],
                    'vars': {
                        'ansible_user': 'ec2-user',
                        'ansible_ssh_private_key_file': '~/.ssh/terraform.pem'
                    }
            },
            'worker': {
                'hosts': [worker_ips],
                    'vars': {
                        'ansible_user': 'ec2-user',
                        'ansible_ssh_private_key_file': '~/.ssh/terraform.pem'
                    }
            },
            'external': {
                'hosts': [external_ip],
                    'vars': {
                        'ansible_user': 'ec2-user',
                        'ansible_ssh_private_key_file': '~/.ssh/terraform.pem'
                    }
            },
            'internal': {
                'hosts': [internal_ip],
                    'vars': {
                        'ansible_user': 'ec2-user',
                        'ansible_ssh_private_key_file': '~/.ssh/terraform.pem'
                    }
            },
            'mongodb': {
                'hosts': [mongodb_ip],
                    'vars': {
                        'ansible_user': 'ec2-user',
                        'ansible_ssh_private_key_file': '~/.ssh/terraform.pem'
                    }
            },
            'logging': {
                'hosts': [logging_ip],
                    'vars': {
                        'ansible_user': 'ec2-user',
                        'ansible_ssh_private_key_file': '~/.ssh/terraform.pem'
                    }
            },
            'monotoring': {
                'hosts': [monitoring_ip],
                    'vars': {
                        'ansible_user': 'ec2-user',
                        'ansible_ssh_private_key_file': '~/.ssh/terraform.pem'
                    }
            }
        }
    
if __name__ == '__main__':
    main()
