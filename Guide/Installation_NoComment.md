# Début Installation

Bonjour à tous ! Dans ce guide, je vais vous montrer comment j'ai réalisé la pré-installation et l'installation de ma machine virtuelle pour Born2BeRoot. J'espère que cela pourra vous aider dans vos propres projets. Alors, c'est parti ! :wink:

## Crée une VM avec Virtual Box
1. Pour commencer, ouvrez VirtualBox et cliquez sur "New" pour créer une nouvelle machine virtuelle.

2. Nommé votre VM<br>placer la VM là ou il y a sufisament d'espace⚠️.<br>Pour le Type, choisissez "Linux"<br>la Version, "Debian 64". 
> Assurez-vous de vous adapter en fonction de l'ISO que vous avez choisi.

3. 1024MB de memoir sa sera bon 😄. 
> NOTE : (d'ailleuir quand il s'agit d'espace de stockage faut pas trop prendre trop despace et ni trop peux car soit sa prend trop de ressource pour rien ou soit pas suffisant pour ce quon shouaite faire).

4. Crée un disque dur virtuel.

5. VDI.
> Je ne serais pas dire pourquoi n'hesite pas a me contacte pour expliquer pourquoi 😃.

6. Allouer de la Mémoir dynamique.
> Allouer de la memoir dynamique permetre de sadpter en fonction de la memoir donné ce qui rend la vm plus opti je supose.

7.  10 à 13 GB est sufisant.

8. FIN de la préconfiguration. 

Image démonstratif pour chaque partie :
[1](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/appuyer_sur_new_pour_cree_VM.png), [2](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Nomme_laVM_LaSituer_ET_definir_L_os.png), [3](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/taille_de_la_RAM.png), [4](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Cree_un_Disk_virtuel.png), [5](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Type_de_disk.png), [6](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Memoir_dynamique.png), [7](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Taille_de_la_memoir.png).

## Début Installation Debian

1. Cliker sur Install 
> Meme si vous avez apuyer sur graphical install ce n'est pas tres grave car ce n'est pas qui determine si vous auriez une interface graphique
> Mais essaye de respecter la regle de ne pas utilise d'interface Visuel. ***Ce qui est demander de le sujet et ne pas d'avoir d'interface Visuel***
2. Choisir la situation Geographique + Choisir la bonne compossition de clavier
3. Le nom de la machine devra etre ```login42``` (exemple: ```yzaoui42```)
4. Pas de domaine next vide
5. Choisir <strong>un mot de passe dur</strong> pour le root
> <strong>un mot de passe dur</strong> = longuer minimume de 10 character, 1 majuscule minimum, 1 chiffre minimume, 1 minuscule minimum
> Verifier dans le pdf du sujet ce qu'es un `strong password`
6. Crée un nouvelle utilisateur, le nom d'utilisateur sera votre `login` (exemple:`yzaoui`)
7. Metre <strong>un mot de passe dur</strong> sans utilise le nom du login.

## Partionement 💀

> La partie qui demandera le plus de temp pour linstallation :(
1. Choisir le partionement Manuel
2. Selectione le disque dur - ``SCSI (0,0,0) (sda)``
3. ``Oui`` Partitionner les disques.

### Création de partitions : /boot non chiffré et volumes logiques chiffrés

> Sur le Disque dur nous allons cree deux partie 
> 1. le boot non crypte, la partie qui soccupera du demarage du  pc si on crypte cette partie il ne pourra pas demarrer
> 2. le reste qui sera crypte.

voici comment faire appuyer sur:
1. `pri/log xxGB Espace libre` >> `Créer une nouvelle partition` >> `500 MB` >> `Primaire` >> `Début` >> `Point de montage` >> `/boot` >> `Fin du paramétrage de cette partition`.
> Voila là nous avons crée une partition de 500 MB pour le boot.
> Maintenant voici poue le LVM qui est assez similaire juste les grand changement et lespace de stockage et le point de montage .

2. `pri/log xxGB Espace libre` >> `Créer une nouvelle partition` >> `max` >> `Logique` >> `Début` >> `Fin du paramétrage de cette partition`.
> Voila un schéma de lespace utilise 

### Crypte 

1. `Configurer les volumes chiffrés` >> `OUI`
2. `Créer des volumes chiffrés` 
3.  metre un mot de passe fort, !!! IL FAUDRE S EN SOUVENIR !!!
4.  
