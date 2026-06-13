*** Settings ***
Library     SeleniumLibrary
Resource    commun.resource


*** Test Cases ***
Le Tableau De Bord Doit Etre Visible Apres Une Connexion Réussie
    [Setup]    Ouvrir le Navigateur Et Accéder A l'Application
    Effectuer Une Connexion Avec Un Compte Valide
    Vérifier Que Le Tableau De Bord Est Visible
    Effectuer Une Déconnexion Réussie
    [Teardown]    Fermer Le Navigateur

Le Lien De Connexion Devrait Etre Visible Après Une Déconnexion Réussie
    [Setup]    Ouvrir le Navigateur Et Accéder A l'Application
    Effectuer Une Connexion Avec Un Compte Valide
    Vérifier Que Le Tableau De Bord Est Visible
    Effectuer Une Déconnexion Réussie
    Vérifier Que L'Accueil est Visible
    Vérifier Que Le Lien De Connexion Est Visible
    [Teardown]    Fermer Le Navigateur
