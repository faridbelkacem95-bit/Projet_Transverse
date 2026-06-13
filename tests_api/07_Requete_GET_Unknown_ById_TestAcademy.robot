*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    JSONLibrary        # Import de la bibliothèque pour la manipulation JSON
Library    Collections        # Import de la bibliothèque pour la manipulation de collections

*** Variables ***
${Base_URL}         https://mock-api-h0g7.onrender.com/    # Définition de l'URL de base de l'API
${API_KEY}          Cle-API-ReqRes-test-academy            # Clé API pour l'authentification
${Id_Resource}      5                                      # ID de la ressource à récupérer

*** Test Cases ***
Test Requete GET Unknown By Id
    &{headers}=                      Create Dictionary                Authorization=Bearer ${API_KEY}
    ${Reponse}=                      GET                              ${Base_URL}api/unknown/${Id_Resource}    headers=${headers}    expected_status=200
    ${ReponseJson}=                  Set Variable                     ${Reponse.json()}
    Log                              ${ReponseJson}
    
    # Vérification que la clé "data" existe bien dans la réponse
    Dictionary Should Contain Key    ${ReponseJson}                   data

    # Vérification de l'id de la ressource
    ${data}=                         Get From Dictionary              ${ReponseJson}                            data
    ${id}=                           Get From Dictionary              ${data}                                   id
    Should Be Equal As Integers      ${id}                            ${Id_Resource}
