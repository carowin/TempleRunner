# TempleRunner


Petit jeu de survie permettant aux utilisateurs de chatter, pouvant être déployé sur des terminaux IOS et Android

# Partie IOS


Le code de la partie IOS est divisait en 3  Package Model contenant l'ensemble 
de la logique derrier le jeux, Util

## Road :

La route est composer de Blocks qui peuve ou etre des obstacles ou une route simple.
Tous les block attendre leur tour une fois 
selectionné il commence a décendre et une fois tous embas ils sont remis en haut et attende d'etre selectionnée pour décendre

## Generation de Pièces:
Ajouter et retirer des pièces sur le chemin, et détection des pièces pour permettre  l'incrémentation du score lorsque le joueur
collect les pièces.


## ScoreView : 

Menu permettant de jouer à une nouvelle partie ou à envoyer son hight score aux autre joueurs. 
Sert aussi de menu de pause du jeu. Menu apparaissant au dessus d'une autre vue avec animation.

## Monstre : 

Monstre avec animation poursuivant le joueur à chaque point de vie perdu du joueur, le monstre ce rapproche. 
Tue le jouer quand ces points sont égal à zéro.

# Partie Android


# Backend

## Backend score : 

Ajout des deux appels à une API pour ajouter un score à diffuser aux autres joueurs de l'application et une autre appelée qui regarde si un score doit être notifier au joueur.

## Identifiant user et persistance : 

Appel à l'API à l'ouverture de l'application pour récupérer un identifiant unique pour chaque device. Enregistrement dans un dossier persistant et tester à la prochaine ouverture, utilisation de cet identifiant si présent dans le dossier persistant.