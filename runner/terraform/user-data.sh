 #!/bin/bash
sudo dnf update -y
sudo dnf install -y curl
sudo yum install -y yum-utils
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin --enablerepo=docker-ce-stable,rhel-8-appstream-rhui-rpms,rhel-8-baseos-rhui-rpms
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | sudo bash
sudo dnf install -y gitlab- --enablerepo=*
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -a -G docker ec2-user
sudo systemctl start docker 
sudo gitlab-runner start
# Register the GitLab Runner
sudo gitlab-runner register --url "${GITLAB_RUNNER_URL}" --registration-token "${GITLAB_RUNNER_TOKEN}" --tag-list "${GITLAB_RUNNER_TAGS}"               
sudo systemctl enable gitlab-runner           