# Fin d'instalation début de Configuration
Avec ce guide nous ferons la mise en place des services:
1. sudo
2. UFW
3. SSH
4. Metre une politique de mot de passe fort
5. Crée un script qui s'executera automatiquement.

Si vous voulez savoir comment installer une VM , partition etc suivez [ce guide.](https://github.com/yatsuZ/B2BR/blob/main/Guide/Installation.md)

## Sudo Configuration

Avoir la session root:
```bash
$ su root
```

Installer sudo:
```bash
# apt update
# apt upgrade
# apt install sudo
```

Aujouter l'user dans le groupe sudo:
```bash
# sudo usermod -aG sudo <username>
```
Retourner sur la session de votre utilisateur. Pour cela faite la commande ```exit```.
Et verifions si votre user a à present le privilege sudo :
```bash
$ sudo whoami
```
La reponse devra etre ``root``. Sinon vous votre user n'as pas acces aux sudo il faudra ajouter cette ligne directement dans le fichier configuration du sudo:
```bash
username  ALL=(ALL:ALL) ALL
```
Pour y acceder au fichier de configuration du sudo (sudoers.tmp) :
```bash
# sudo visudo
```
Et ajouter les parametre pas defaut qui est demande dans le sujet :
```bash
Defaults  passwd_tries=3 #3 tentaive pour utilise le sudo
Defaults  badpass_message="Wrong password. Try again!"# Message d'erreur pour mauvais mot de passe
Defaults  log_input #On shouaite recuperer les log d'inpute
Defaults  logfile="/var/log/sudo/sudo.log" #Ou es qu'on shouaite ranger les log d'input
Defaults  log_output #On shouaite recuperer les log d'outpout
Defaults  iolog_dir="/var/log/sudo"#Ou es qu'on shouaite ranger les log d'output
Defaults  requiretty #Requiretty exige une console pour utiliser sudo
```
Si ```var/log/sudo``` le dossier sudo n'existe pas il faudra le crée, ```mkdir var/log/sudo```.

CONFIGURATION SUDO FINI.

## UFW Setup
Installer est Activer UFW:
```bash
$ sudo apt update
$ sudo apt upgrade
$ sudo apt install ufw
$ sudo ufw enable
```

Verifier l'UFW status:
```bash
$ sudo systemctl status ufw
```
ou
```bash
$ sudo ufw status verbose
```

Allow et deny ports:
```bash
$ sudo ufw allow <port>
$ sudo ufw deny <port>
```

Comment Suprimer les regles d'un port:
```bash
$ sudo ufw delete allow <port>
$ sudo ufw delete deny <port>
```
Voici une autre methode:
```bash
$ sudo ufw status numbered
$ sudo ufw delete <port index number>
```
Attention avec cette deuxieme method, l'index change apres une suppression, verifier apres chaque supression l'index.

Ce qu'il faut faire c'est davoir seulement le port 4242 en allow et deny voila le resultat attendue :
(regarde quelle est mon resulat sur ma vm pour etre sure).

FIN d'UFW

## SSH configuration
Installer OpenSSH:
```bash
$ sudo apt update
$ sudo apt upgrade
$ sudo apt install openssh-server
```

Verifier le status de SSH:
```bash
$ sudo systemctl status ssh
```

Changer le port d'ecoute de SSH pour metre le port 4242,
aller au fichier de configuration de ssh : 
```bash
$ sudo nano /etc/ssh/sshd_config
```
trouver cette ligne:
```bash
#Port 22
```
Il faut la décommenter en suprimons # et changer 22 par 4242:
```bash
Port 4242
```

!! Re activer le service SSH pour metre le nouveaux port:
```bash
$ sudo systemctl restart ssh
```

Redirigez le port hôte 4243 vers le port invité 4242 : dans VirtualBox, 
* aller sur VirtualBox >> Parrametre >> Resaux >> Adapter 1 >> Avance >> Port Forwarding.
* add a rule: Host port 4243 and guest port 4242.
(Verifier sur mon pc et faire des screen).

Re activer le service SSH apres changement.

Verifions si cela marche pour cela nous allons essaye de nous connecter depuis le terminal du PC :
```bash
$ ssh <username>@localhost -p 4243"
```
Ou:
```bash
$ ssh <username>@<l'adresse ip de la VM> -p 4243
```
Pour quiter la connection ssh faite la commande ```exit```.

Verifier que vous ne pouvez pas vous connecter en tant que root,
Pour cela  faite :
```bash
$ ssh root@<localhost -p 4243
```
essaye de metre votre code et si il vous dis acces refuser ou denied c'est bon alors.

Partie SSH Fini.
 
## Politique de mot de passe
Configurer ```/etc/login.defs``` et trouver "password aging controls". Modifier pour faire ce que le sujet demande:
```bash
PASS_MAX_DAYS 30 # tout les 30 jour un nouveaux mot de passe
PASS_MIN_DAYS 2 # Vous pouvez changer un mot de passe seulement tout les 2 jour
PASS_WARN_AGE 7 # Une alerte sera envoyer 7 jour avant la date de changement de mot de passe
```
Ces changement seront apliquer automatiquement mais pas utilisateur deja crée et au root donc il faut apliquer ces changement aux utilisateur et root :
```bash
$ sudo chage -M 30 <username/root>
$ sudo chage -m 2 <username/root>
$ sudo chage -W 7 <username/root>
```
Utilise ```chage -l <username/root>``` Pour verfier les changement.

Install une bibliotheque qui verifie la politique de mot de passe:
```bash
$ sudo apt install libpam-pwquality
```

Alons, configuere le ```/etc/security/pwquality.conf``` voila ce qu'il faudra metre:
``` bash
...
...
difok = 7
...
...
minlen = 10
...
...
dcredit = -1
...

...
ucredit = -1
# ...
maxrepeat = 3
# ...
usercheck = 1
# ...
retry = 3
...
enforce_for_root
# ...
```
A present essaye de verifier que chaque condition marche en changeant votre mot de passe user
```bash
$ sudo passwd <user/root>
```
FIN de la politique de mot de passe.

## Hostname, Users et Groups

Le hostname devra etre ```your_intra_login42```, mais le Hostname sera vouer à etre changer durant le présentation. voila la commande qui permet de change le host:
```bash
$ sudo hostnamectl set-hostname <new_hostname> 
$ hostnamectl status
```
Il doit y avoir un utilisateur avec ```your_intra_login``` comme nom d'utilisateur. Lors de l'évaluation, il vous sera demandé de créer, supprimer, modifier des comptes utilisateurs. Les commandes suivantes sont utiles à connaître :
* ```useradd``` : crée un user.
* ```usermod``` : modifie les paramètres de l'utilisateur : ```-l``` pour le nom d'utilisateur, ```-c``` pour le nom complet, ```-g``` pour les groupes par ID de groupe.
* ```userdel -r``` : supprime un utilisateur et tous les fichiers associés
* ```id -u``` : affiche l'ID utilisateur.
* ```users``` : affiche une liste de tous les utilisateurs actuellement connectés.
* ```cat /etc/passwd | cut -d ":" -f 1``` : affiche une liste de tous les utilisateurs de la machine.

L'utilisateur nommé your_intra_login doit faire partie des groupes ```sudo``` et ```user42```. Vous devez également être en mesure de manipuler les groupes d'utilisateurs lors de l'évaluation avec les commandes suivantes :
* ```groupadd``` : crée un nouveau groupe.
* ```gpasswd -a``` : ajoute un utilisateur à un groupe. 
* ```gpasswd -d``` : supprime un utilisateur d'un groupe. 
* ```groupdel``` : supprime un groupe.
* ```groups``` : affiche les groupes d'un utilisateur.
* ```id -g``` : affiche l'ID de groupe principal d'un utilisateur.
* ```getent group``` : affiche une liste de tous les utilisateurs d'un groupe.

En bref 
Avant la presentation :
1. hostanme -> votre ```intra_login42```
2. utilisateur -> votre ```intra_login```
3. vus devez crée un groupe ```user42```
4. votre utilisateur devra etre dans ```user42``` et ```sudo```
Pendant la presentation :
Modifier le hostname
cree un user 
...
Je me souviens que de sa mais pas de panique vous verrez lors de la presentation.

FIN du group hostanme etc.

## Monitoring.sh
Ecrire [```monitoring.sh```](https://github.com/yatsuZ/B2BR/blob/main/monitoring.sh) ou le placer je ne sais pas.

Donner le droit dexecution aux monotoring.sh
```bash
chmod 755 monitoring.sh
```

La commande ```wall``` nous permet de diffuser un message à tous les utilisateurs de tous les terminaux. Cela peut être incorporé dans le script monitoring.sh ou ajouté ultérieurement dans cron.

moi je l'ai mis ultérieurement.

Pour programmer la diffusion toutes les 10 minutes, nous devons activer cron:
```bash
# systemctl enable cron
```
Démarrez ensuite un fichier crontab pour root :
```bash
# crontab -e
```
Et ajoutez comme ceci:
```bash
*/10 * * * * bash <path>/monitoring.sh
```
Ou, si la commande wall n'est pas intégrée au script:
```bash
*/10 * * * * bash <path>/monitoring.sh | wall
```
À partir de là, ```monitoring.sh``` sera exécuté toutes les 10 minutes. Pour qu'il s'exécute toutes les dix minutes **à partir du démarrage du système**, On peut cree un script [```sleep.sh```](https://github.com/yatsuZ/B2BR/blob/main/sleep.sh) script qui calcule le délai entre l'heure de démarrage du serveur et la dixième minute de l'heure, puis ajoutez-le au travail cron pour appliquer le délai.
```bash
*/10 * * * * bash /root/sleep.sh && bash /root/monitoring.sh
```

Monitoring Fini et crontab fini aussi.

## Failed to send host log message
Le message d'erreur qui apparaît au démarrage de la VM, "[drm:vmw_host_log [vmwgfx]] *ERROR* Échec de l'envoi du message du journal de l'hôte" peut facilement être corrigé. C'est une erreur du contrôleur graphique. Tout ce que nous avons à faire est :
* Eteindre votre VM
* Dans Virtuall Box, aller dans les parametre de la VM. 
* ```Display``` >> ```Screen``` >> ```Graphics Controller``` >> Choisir ```VBoxVGA```.

## Signature.txt
Pour extraire la signature de la VM pour la correction, rendez-vous dans le dossier Virtual Box VMs de votre ordinateur local :
* Windows: ```%HOMEDRIVE%%HOMEPATH%\VirtualBox VMs\```
* Linux: ```~/VirtualBox VMs/```
* MacM1: ```~/Library/Containers/com.utmapp.UTM/Data/Documents/```
* MacOS: ```~/VirtualBox VMs/```

Utilisez ensuite la commande suivante (remplacez ```centos_serv``` par le nom de votre machine) :
* Windows: ```certUtil -hashfile centos_serv.vdi sha1```
* Linux: ```sha1sum centos_serv.vdi```
* For Mac M1: ```shasum Centos.utm/Images/disk-0.qcow2```
* MacOS: ```shasum centos_serv.vdi```

Et enregistrez la signature dans un fichier nommé ```signature.txt```.
---
Fais par yzaoui: y.zaoui.pro@gmail.com | LinkedIn: [Yassine Zaoui](https://www.linkedin.com/in/yassine-zaoui-23b005229/)
