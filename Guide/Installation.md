# Début Installation

Bonjour à tous ! Dans ce guide, je vais vous montrer comment j'ai réalisé la pré-installation et l'installation de ma machine virtuelle pour Born2BeRoot. J'espère que cela pourra vous aider dans vos propres projets. Alors, c'est parti ! :wink:

## Crée une VM avec Virtual Box
1. Pour commencer, ouvrez VirtualBox et cliquez sur "New" pour créer une nouvelle machine virtuelle.

2. Nommez votre VM<br>placer la VM là où il y a sufisament d'espace⚠️.<br>Pour le Type, choisissez "Linux"<br>la Version, "Debian 64". 
> Assurez-vous de vous adapter en fonction de l'ISO que vous avez choisi.

3. 1024MB de mémoire ça sera bon 😄. 
> NOTE : (d'aileleurs quand il s'agit d'espace de stockage il faut ni prendre trop despace ni trop peux car soit ça prend trop de ressources pour rien, soit pas suffisant pour ce qu'on shouaite faire).

4. Créer un disque dur virtuel.

5. VDI.
> Je ne saurais pas dire pourquoi, n'hesitez pas à me contacte pour m'expliquer pourquoi 😃.

6. Allouer de la Mémoire dynamique.
> Allouer de la memoire dynamique permet de s'adpter en fonction de la mémoire donné ce qui rend la vm plus opti je suppose.

7.  10 à 13 GB est sufisant.

8. FIN de la préconfiguration. 

Image démonstrative pour chaque partie :
[1](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/appuyer_sur_new_pour_cree_VM.png), [2](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Nomme_laVM_LaSituer_ET_definir_L_os.png), [3](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/taille_de_la_RAM.png), [4](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Cree_un_Disk_virtuel.png), [5](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Type_de_disk.png), [6](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Memoir_dynamique.png), [7](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Taille_de_la_memoir.png).

## Début Installation Debian

1. Cliquer sur Install 
> Même si vous avez appuyez sur graphical install ce n'est pas tres grave car ce n'est pas ce qui determine si vous aurez une interface graphique
> Mais essaye de respecter la regle de ne pas utiliser d'interface visuelle. ***Ce qui est demandé dqns le sujet est ne pas avoir d'interface visuelle***
2. Choisir la situation Geographique + Choisir la bonne compossition de clavier
3. Le nom de la machine devra etre ```login42``` (exemple: ```yzaoui42```)
4. Pas de domaine next vide
5. Choisir <strong>un mot de passe dur</strong> pour le root
> <strong>un mot de passe dur</strong> = longuer minimum de 10 caractère, 1 majuscule minimum, 1 chiffre minimum, 1 minuscule minimum
> Verifiez dans le pdf du sujet ce qu'est un `strong password`
6. Créer un nouveau utilisateur, le nom d'utilisateur sera votre `login` (exemple:`yzaoui`)
7. Mettre <strong>un mot de passe dur</strong> sans utiliser le nom du login.

## Partitionement 💀

> La partie qui demandera le plus de temps pour l'installation :(
1. Choisir le partitionement Manuel
2. Selectioner le disque dur - ``SCSI (0,0,0) (sda)``
3. ``Oui`` Partitionner les disques.

### Création de partitions : /boot non chiffré et volumes logiques chiffrés

> Sur le Disque dur nous allons créer deux parties 
> 1. le boot non crypté, la partie qui s'occupera du démarage du pc, si on crypte cette partie il ne pourra pas demarrer
> 2. le reste qui sera crypté.

voici comment faire, appuyer sur:
1. `pri/log xxGB Espace libre` >> `Créer une nouvelle partition` >> `500 MB` >> `Primaire` >> `Début` >> `Point de montage` >> `/boot` >> `Fin du paramétrage de cette partition`.
> Voila là nous avons crée une partition de 500 MB pour le boot.
> Maintenant voici poue le LVM qui est assez similaire juste les grands changement et l'espace de stockage et le point de montage .

2. `pri/log xxGB Espace libre` >> `Créer une nouvelle partition` >> `max` >> `Logique` >> `Début` >> `Fin du paramétrage de cette partition`.
> Voila un schéma de l'espace utilisé 

### Cryptée 

1. `Configurer les volumes chiffrés` >> `OUI`
2. `Créer des volumes chiffrés` 
3.  mettre un mot de passe fort, !!! IL FAUDRE S'EN SOUVENIR !!!
4.  
