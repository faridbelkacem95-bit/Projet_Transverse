*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    Collections        # Import de la bibliothèque pour la manipulation de collections

*** Variables ***
${Base_URL}             https://mock-api-h0g7.onrender.com/    # URL de base de l'API
${API_KEY}              Cle-API-ReqRes-test-academy            # Clé API pour l'authentification
${FirstName_Attendu}    Anass                                  # Prénom attendu dans la réponse
${LastName_Attendu}     Rami                                   # Nom de famille attendu dans la réponse
${Email_Attendu}        anass.rami@api.testacademy.fr          # Email attendu dans la réponse

*** Test Cases ***
Test Requete POST
    &{headers}=                      Create Dictionary                Authorization=Bearer ${API_KEY}
    &{Corps_Requete}=                Create Dictionary                first_name=${FirstName_Attendu}    last_name=${LastName_Attendu}    email=${Email_Attendu}
    ${Reponse}=                      POST                             ${Base_URL}api/users               json=${Corps_Requete}            headers=${headers}    expected_status=201
    Log                              ${Reponse.json()}

    # Vérification que les clés "id" et "createdAt" existent bien dans la réponse
    Dictionary Should Contain Key    ${Reponse.json()}                id
    Dictionary Should Contain Key    ${Reponse.json()}                createdAt

    # Extraction et vérification du prénom
    ${first_name}=                   Get From Dictionary              ${Reponse.json()}                  first_name
    Should Be Equal As Strings       ${FirstName_Attendu}             ${first_name}

    # Extraction et vérification du nom de famille
    ${last_name}=                    Get From Dictionary              ${Reponse.json()}                  last_name
    Should Be Equal As Strings       ${LastName_Attendu}              ${last_name}

    # Extraction et vérification de l'email
    ${email}=                        Get From Dictionary              ${Reponse.json()}                  email
    Should Be Equal As Strings       ${Email_Attendu}                 ${email}
