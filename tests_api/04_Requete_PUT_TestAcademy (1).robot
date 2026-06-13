*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${Base_URL}             https://mock-api-h0g7.onrender.com/
${API_KEY}              Cle-API-ReqRes-test-academy
${FirstName_Attendu}    Janet
${LastName_Attendu}     Zion-Weaver
${Email_Attendu}        janet.zion@api.testacademy.fr

*** Test Cases ***
Test Requete PUT
    &{headers}=                      Create Dictionary    Authorization=Bearer ${API_KEY}

    # Étape 1 : créer un utilisateur pour obtenir un ID valide
    &{body}=                         Create Dictionary    first_name=Lokmane    last_name=Test    email=lokmane@test.fr
    ${u}=                            POST                 ${Base_URL}api/users    json=${body}    headers=${headers}    expected_status=201
    ${id}=                           Set Variable         ${u.json()['id']}

    # Étape 2 : modifier l'utilisateur créé
    &{corps_put}=                    Create Dictionary    first_name=${FirstName_Attendu}    last_name=${LastName_Attendu}    email=${Email_Attendu}
    ${reponse}=                      PUT                  ${Base_URL}api/users/${id}    json=${corps_put}    headers=${headers}    expected_status=200
    Log                              ${reponse.json()}

    # Vérifications
    Dictionary Should Contain Key    ${reponse.json()}    updatedAt
    ${first_name}=                   Get From Dictionary  ${reponse.json()}    first_name
    Should Be Equal As Strings       ${FirstName_Attendu}    ${first_name}
    ${last_name}=                    Get From Dictionary  ${reponse.json()}    last_name
    Should Be Equal As Strings       ${LastName_Attendu}     ${last_name}
    ${email}=                        Get From Dictionary  ${reponse.json()}    email
    Should Be Equal As Strings       ${Email_Attendu}        ${email}
