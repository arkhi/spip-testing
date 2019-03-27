Ce dépôt permet de définir un environnement de développement pour [Spip](https://www.spip.net/).

Vous pouvez copier et coller les commandes suivantes dans votre terminal.

## Procédure

1. [Installer Virtualbox](https://www.virtualbox.org/wiki/Downloads) sur votre machine.

1. [Installer Vagrant](https://www.vagrantup.com/downloads.html) sur votre machine.

1. Cloner ce dépôt :

    ```sh
    git clone git@github.com:arkhi/spip-testing --origin arkhi
    ```

1. Lancer la machine virtuelle :

    ```sh
    vagrant up
    ```

    S’il s’agit de la première fois que la machine est lancée, le « [provisioning](https://www.vagrantup.com/docs/provisioning/index.html) » paramètrera l’environnement automatiquement. C’est à dire que tous les logiciels nécessaires seront installés. Cette opération n’est nécessaire que la première fois, ou lorsque des changements interviennent au niveau des logiciels utilisés.

1. Vous pouvez [naviguer sur le site](http://192.168.50.4).

## Nota bene

### Mémoire de la machine virtuelle.

Selon la puissance de votre machine, vous pouvez attribuer plus ou moins de mémoire à la machine. Il suffit de modifier cette ligne dans /Vagrantfile : `vb.customize ["modifyvm", :id, "--memory", "512"]`

### Provisioning partiel

La première fois, tous les provisioners seront exécutés, mais afin de ne pas perdre son temps lors d’une mise à jour du système, il est possible de ne provisioner qu’une partie de la machine :


- `os`: Installe les packages natifs du système (Ubuntu).
- `spip`: Télécharge et décompresse Spip (en écrasant les fichiers existans) à la racine du serveur.
- `clean`: Nettoie la machine virtuelle.
- `done`: Lance un script en fin de processus à chaque fois que la machine est lancée.

Par exemple, pour installer une nouvelle version de Spip, il suffit de lancer `vagrant provision --provision-with spip`.
