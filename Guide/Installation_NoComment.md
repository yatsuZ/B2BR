# Début Installation

Bonjour à tous ! Dans ce guide, je vais vous montrer comment j'ai réalisé la pré-installation et l'installation de ma machine virtuelle pour Born2BeRoot. J'espère que cela pourra vous aider dans vos propres projets.

## Crée une VM avec Virtual Box
1. Pour commencer, ouvrez VirtualBox et cliquez sur "New" pour créer une nouvelle machine virtuelle.

2. Nommé votre VM<br>placer la VM là ou il y a sufisament d'espace⚠️.<br>Pour le Type, choisissez "Linux"<br>la Version, "Debian 64". 

3. 1024MB de memoir sa sera bon. 

4. Crée un disque dur virtuel.

5. VDI.

6. Allouer de la Mémoir dynamique.

7.  10 à 13 GB est sufisant.

8. FIN de la préconfiguration. 

Image démonstratif pour chaque partie :
[1](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/appuyer_sur_new_pour_cree_VM.png), [2](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Nomme_laVM_LaSituer_ET_definir_L_os.png), [3](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/taille_de_la_RAM.png), [4](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Cree_un_Disk_virtuel.png), [5](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Type_de_disk.png), [6](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Memoir_dynamique.png), [7](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Preconfiguration/Taille_de_la_memoir.png).

## Début Installation Debian

1. Cliker sur Install 

2. Choisir la langue + Choisir la situation Geographique + Choisir la bonne compossition de clavier

3. Le nom de la machine devra etre ```login42``` (exemple: ```yzaoui42```)

4. Pas de domaine next vide

5. Choisir <strong>un mot de passe dur</strong> pour le root

6. Crée un nouvelle utilisateur, le nom d'utilisateur sera votre `login` (exemple:`yzaoui`)

7. Metre <strong>un mot de passe dur</strong> sans utilise le nom du login.

## Partionement

1. Choisir le partionement Manuel

2. Selectione le disque dur - [``SCSI (0,0,0) (sda)``](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/SCSI3.png)

3. ``Oui`` Partitionner les disques.

### Création de partitions : /boot non chiffré et volumes logiques chiffrés


1. [`pri/log xxGB Espace libre`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/pri-log1.png) >[`Créer une nouvelle partition`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/nouvelle_partition.png) >[`500 MB`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/500MB_size.png) >[`Primaire`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/Primaire.png) >[`Début`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/Debut.png) >[`Point de montage`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/Point_de_montage_selection.png) >[`/boot`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/choisir_boot.png) >[`Fin du paramétrage de cette partition`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/Fin_boot.png).

2. [`pri/log xxGB Espace libre`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/pri-log2.png) >[`Créer une nouvelle partition`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/nouvelle_partition.png) >[`max`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/max_size.png) >[`Logique`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/Logique.png) >[`Fin du paramétrage de cette partition`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/partition/Fin_parametrage_reste.png).

### Crypte 

1. [`Configurer les volumes chiffrés`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Cryptage/Configurer_les_volumes_chiffre.png) >> `OUI`
2. [`Créer des volumes chiffrés`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Cryptage/Creer_des_volumes_chiffre.png)
3.  [Chosir `sda5`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Cryptage/selectione_sda5.png), car ce n'est que cette partie que l'on shouaite crypte.
4.  [`Terminer`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Cryptage/Terminer_cryptage.png) >[`Fin du paramétrage`](https://github.com/yatsuZ/B2BR/blob/main/image/Installation_image/Cryptage/Fin_du%20parametrage.png) >`Oui` 
5.  Metre un mot de passe fort, !!! IL FAUDRE S EN SOUVENIR !!!

### LVM (Logical Volume Manager )

1. ```Configurer le gestionnaire de volumes logiques (LVM)``` >> ```Oui```.
3. ```Créer un groupe de volumes``` >> nommé : ```LVMGroup``` >> selectionner : ```/dev/mapper/sda5_crypt```.

Crée Volumes Logique:
* ```Créer un volume logique``` >>  selectionner : ```LVMGroup``` >> nommé : ```root```     >> ```2G```
* ```Créer un volume logique``` >>  selectionner : ```LVMGroup``` >> nommé : ```home```     >> ```3.8G```
* ```Créer un volume logique``` >>  selectionner : ```LVMGroup``` >> nommé : ```swap_1```   >> ```973MB```

Une fois fais, ```Afficher les détails de configuration``` pour verifier avec ce qui est demander dans le tp, apres cela ```Terminer```.

Définissez les systèmes de fichiers et les points de montage pour chaque volume logique :
* Sous "LVM home",    ```#1 xxGB``` >> ```Utiliser comme``` >> ```Ext4``` >> ```Point de montage``` >> ```/home``` >> ```Fin du ...```
* Sous "LVM root",    ```#1 xxGB``` >> ```Utiliser comme``` >> ```Ext4``` >> ```Point de montage``` >> ```/``` >> ```Fin du ...```
* Sous "LVM swap_1",  ```#1 xxGB``` >> ```Utiliser comme``` >> ```espace d´échange ("swap")``` >> ```Fin du ...```

```Terminer le partitionement ...```
FIN du partitionage.

---

### Installation fini BRAVO!!!

Entrer le mot de passe de cryptage quevous avez mis.
Votre login ou root et mettre le mot de passe qui correspond.

A present Verifions le partitionement et que cela correspond bien avec ce que veux le sujet.
```bash
$ lsblk
```

---
Fais par yzaoui: y.zaoui.pro@gmail.com | LinkedIn: [Yassine Zaoui](https://www.linkedin.com/in/yassine-zaoui-23b005229/).
