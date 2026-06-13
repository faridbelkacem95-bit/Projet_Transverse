*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

*** Variables ***
${Base_URL}    https://mock-api-h0g7.onrender.com/
${API_KEY}     Cle-API-ReqRes-test-academy

*** Test Cases ***
Test Requete GET User By Id
    &{headers}=                      Create Dictionary    Authorization=Bearer ${API_KEY}

    # Étape 1 : créer un utilisateur pour obtenir un ID valide
    &{body}=                         Create Dictionary    first_name=Lokmane    last_name=Test    email=lokmane@test.fr
    ${u}=                            POST                 ${Base_URL}api/users    json=${body}    headers=${headers}    expected_status=201
    ${id}=                           Set Variable         ${u.json()['id']}

    # Étape 2 : récupérer l'utilisateur par son ID
    ${reponse}=                      GET                  ${Base_URL}api/users/${id}    headers=${headers}    expected_status=200
    ${reponseJson}=                  Set Variable         ${reponse.json()}
    Log                              ${reponseJson}

    # Vérifications
    Dictionary Should Contain Key    ${reponseJson}    data
    Dictionary Should Contain Key    ${reponseJson}    support
    ${data}=                         Get From Dictionary  ${reponseJson}    data
    ${id_recu}=                      Get From Dictionary  ${data}           id
    Should Be Equal As Integers      ${id_recu}           ${id}
