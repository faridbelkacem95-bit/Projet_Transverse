*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${Base_URL}    https://mock-api-h0g7.onrender.com/
${API_KEY}     Cle-API-ReqRes-test-academy

*** Test Cases ***
Test Requete DELETE
    &{headers}=     Create Dictionary    Authorization=Bearer ${API_KEY}

    # Étape 1 : créer un utilisateur pour obtenir un ID valide
    &{body}=        Create Dictionary    first_name=Lokmane    last_name=Test    email=lokmane@test.fr
    ${u}=           POST                 ${Base_URL}api/users    json=${body}    headers=${headers}    expected_status=201
    ${id}=          Set Variable         ${u.json()['id']}

    # Étape 2 : supprimer l'utilisateur créé
    ${reponse}=     DELETE               ${Base_URL}api/users/${id}    headers=${headers}    expected_status=204
