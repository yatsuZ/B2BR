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

8. Pour ajouter l'ISO de Debian, cliquez sur "Settings", puis sur "Storage", sélectionnez "Add Optical Drive", naviguez vers l'emplacement de votre ISO, puis cliquez sur "Entrer".

9. FIN de la préconfiguration. 

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

1. [`Configurer les volumes chiffrés`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Cryptage/Configurer_les_volumes_chiffre.png) >> `OUI`
2. [`Créer des volumes chiffrés`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Cryptage/Creer_des_volumes_chiffre.png)
3. [Chosir `sda5`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Cryptage/selectione_sda5.png), car ce n'est que cette partie que l'on shouaite crypter.
4. [`Terminer`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Cryptage/Terminer_cryptage.png) >[`Fin du paramétrage`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Cryptage/Fin_du%20parametrage.png) >`Oui` 
5. Mettre un mot de passe fort, !!! IL FAUDRE S'EN SOUVENIR !!!

### LVM (Logical Volume Manager )

1. [```Configurer le gestionnaire de volumes logiques (LVM)```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/LVM/Configurer%20le%20gestionnaire%20de%20volumes%20logiques%20(LVM).png) >> [```Oui```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/LVM/oui_LVM.png).
3. [```Créer un groupe de volumes```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/LVM/Creer%20un%20groupe%20de%20volumes.png) >> nommé : [```LVMGroup```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/LVM/nommr_LVMGroup.png) >> selectionner : [```/dev/mapper/sda5_crypt```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/LVM/selectionner%20sda5.png).

Créer Volumes Logique:
* [```Créer un volume logique```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/LVM/afficher_les_detail_LVM.png) >>  selectionner : ```LVMGroup``` >> nommé : [```root```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/LVM/nomme.png)     >> [```2G```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/LVM/espace.png)
* ```Créer un volume logique``` >>  selectionner : ```LVMGroup``` >> nommé : ```home```     >> ```3.8G```
* ```Créer un volume logique``` >>  selectionner : ```LVMGroup``` >> nommé : ```swap_1```   >> ```973MB```

Une fois fait, [```Afficher les détails de configuration```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/LVM/affichage_info.png) pour verifier avec ce qui est demander dans le tp, apres ça -> ```Terminer```.

Définissez les systèmes de fichiers et les points de montage pour chaque volume logique :
* [Sous "LVM home",    ```#1 xxGB```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/LVM/cree_la_partie_Root.png) >> ```Utiliser comme``` >> [```Ext4```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/LVM/ext4.png) >> ```Point de montage``` >> ```/home``` >> ```Fin du ...```
* Sous "LVM root",    ```#1 xxGB``` >> ```Utiliser comme``` >> ```Ext4``` >> ```Point de montage``` >> ```/``` >> ```Fin du ...```
* Sous "LVM swap_1",  ```#1 xxGB``` >> ```Utiliser comme``` >> ```espace d´échange ("swap")``` >> ```Fin du ...```

[```Terminer le partitionement ...```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/LVM/Terminer.png)
FIN du partitionage.

---

## Finish Installation
1. [```Non```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/FIN/analyse.png), pas besoin d'analyse.
2. Choisir [```un pays```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/FIN/gestion_de_paquet_pays.png) &  [```un miriore```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/FIN/mirroire.png).
3. [ne rien metre juste skip](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/FIN/pas_de_http.png).
Si il y a [cas d'erreur](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/FIN/Erreur_depot.png) skip.
4. ```Non```, pas besoin de setudy.
5. [NE RIEN SELECTIONER !! important.](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/FIN/pas_de_logiciel.png)
6. [```Oui```, installer le GRUB](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/FIN/Grub_install.png) >> selectionner ```/dev/sda```
7. [```Continuer```](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/FIN/FIN.png).

### Installation fini BRAVO

[Entrer le mot de passe de cryptage quevous avez mis.](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/FIN/cryptage_entrer.png)
[Votre login ou root et mettre le mot de passe qui correspond.](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/FIN/login.png)

A present, verifions le partitionement et que cela correspond bien avec ce que veut le sujet.

```bash
$ lsblk
```

resultat :
<img src="https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/FIN/lsblk.png" alt="Resultat lsblk">

---

## Auteur ->

Ce projet fut inspirais par 🥁🥁 [mcombeau](https://github.com/mcombeau/Born2beroot) GROCE DEDICACE😉.

Et je remercie :
[Bam](https://github.com/mozaBit) et [Kuro](https://github.com/kvroooo) pour leur aide à la redaction.

et ce fut aussi réalisé par MOI !!! :smiley:

| Info          | Ou me retrouver                                                      |
| ------------- | -------------------------------------------------------------------- |
| Nom👋         | Zaoui                                                                |
| Prenom😄      | Yassine                                                              |
| Pseudo😁      | Yatsu                                                                |
| Login 42🏫    | Yzaoui                                                               |
| E-mail📬      | y.zaoui.pro@gmail.com                                                |
| E-mail42📩    | yzaoui@student.42.fr                                                 |
| Linkdin👨‍💻     | [Yassine Zaoui](https://www.linkedin.com/in/yassine-zaoui-23b005229/)|
| Instagram📸   | [@yatsu__officiel](https://www.instagram.com/yatsu__officiel/)       |
