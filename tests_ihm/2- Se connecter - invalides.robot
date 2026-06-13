*** Settings ***
Library             SeleniumLibrary
Resource            commun.resource

Test Template       Un Message d'Erreur Doit Etre Visible Apres Une Connexion Incorrecte
Test Setup            Ouvrir le Navigateur Et Accéder A l'Application
Test Teardown         Fermer le Navigateur



*** Test Cases ***
#                                                              Utilisateur        Mot De Passe
Test Utilisateur Valide____ ET Mot De Passe Vide                robot              ${EMPTY}
Test Utilisateur Vide______ ET Mot De Passe Valide              ${EMPTY}           robot
Test Utilisateur Vide______ ET Mot De Passe Vide                ${EMPTY}           ${EMPTY}
Test Utilisateur Non Valide ET Mot De Passe Valide              azerty             robot
Test Utilisateur Valide____ ET Mot De Passe Non Valide          robot              azerty
Test Utilisateur Non Valide ET Mot De Passe Non Valide          azerty             azerty



