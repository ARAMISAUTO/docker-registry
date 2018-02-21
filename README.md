# docker-registry

Installation et configuration d'un registre Docker avec un certificat auto-signé.

## Installation

*Cette procédure a été testée avec les distributions suivantes : Ubuntu 17.10, Debian 9*

- Récupérer les sources du projet :
    ```sh
    git clone https://github.com/ARAMISAUTO/docker-registry.git
    ```
- Lancer le script d'installation :
     ```
     cd docker-registry
     REGISTRY_HOST=myregistry.com make install
     ```
- Copier le certificat du registre `certs/domain.crt` sur tous les hôtes Docker qui doivent y faire appel dans le dossier `/etc/docker/certs.d/${REGISTRY_HOST}/ca.crt`.

## Utilisation

- Démarrer le registre :
    ```sh
    docker-compose up -d
    ```
