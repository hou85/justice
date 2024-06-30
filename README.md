# justice
## Authors

- [@ABDI HOUSSEM EDDINE](https://github.com/hou85)


# Titre de projet

Ce projet consiste à déploier une infrastucture automatisée en utlisant Terraform pour la provisionnement et ansible pour la configuration en utlisant la branche "dev"

Cette infrastructure contient:
- Une ec2 serveur gitlab-ce 
- Une ec2 gitlab-runner
- Un cluster kuberenetes: deux noeuds: ec2 master et ec2 worker
- Une base des données mongodb
- Une ec2 pour un système logging ELK: Elasticsearch Logstash Kibana
- Une ec2 proxy externe
- Une ec2 proxy interne




## Environment Variables

Pour exécuter ce projet, vous devrez ajouter les configurations suivantes: avec la commande "aws configure"

`AWS Access Key ID`

`AWS Secret Access Key`


## Installation

I- Gitalb-ce

1 - Provisionnement de serveur gitlab-ce avec terraform

```bash
  cd git/terraform
  terraform init
  terraform plan
  terraform apply
```

2 - Configuration de serveur gitlab-ce avec ansible en utlisant l'inventaire dynamique "terraform_inventory.py"

```bash
  cd git/terraform
  chmod +x terraform_inventory.py
  ansible-playbook -i terraform_inventory.py ../ansible/install_gitlab.yml
```
3- Création runner projet: 
```bash
   - Connecter: http://ip_adresse_gitlab:7000   
   - clique: Settings --> CI/CD --> Runners --> Expand
   - clique: New project runner --> Ajouter Tags --> Create Runner
   - choisir plateform :  Operating systems: Linux
   - Copoier et Enregistrer "runner authentication token"
```


II- Gitalb-runner

1 - Provisionnement de gitlab-runner avec terraform

```bash
  cd runner/terraform
  terraform init
  terraform plan
  terraform apply
```

2 - Configuration de serveur gitlab-runner avec ansible en utlisant l'inventaire dynamique "terraform_inventory.py"

```bash
  cd runner/terraform
  chmod +x terraform_inventory.py
  ansible-playbook -i terraform_inventory.py ../ansible/install_gitlab.yml
  Entrer: runner authentication token
```

III- Création infrastructure:

Pour créer l'infrastructure principale:
```bash
 - Créer un projet dans gitlab-ce et pusher le dossier infra dans ce projet
 - Modifier le nom de runner dans les stages
 - Lancer pipeline: Build --> Pipelines --> Run pipeline
```


IV- Application:

Pour déployer application: 
```bash
 - Modifier la variable de pipeline :DOCKER_REGISTRY avec url de gitlab-ce 
 - Lancer pipeline: Build --> Pipelines --> Run pipeline
```
