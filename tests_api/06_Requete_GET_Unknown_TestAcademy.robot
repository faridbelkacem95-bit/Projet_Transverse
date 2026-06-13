*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    JSONLibrary        # Import de la bibliothèque pour la manipulation JSON
Library    Collections        # Import de la bibliothèque pour la manipulation de collections

*** Variables ***
${Base_URL}    https://mock-api-h0g7.onrender.com/    # Définition de l'URL de base de l'API
${API_KEY}     Cle-API-ReqRes-test-academy            # Clé API pour l'authentification

*** Test Cases ***
Test Requete GET Unknown
    &{Params}=                Create Dictionary      page=1                                 per_page=6
    &{headers}=               Create Dictionary      Authorization=Bearer ${API_KEY}
    ${Reponse}=               GET                    ${Base_URL}api/unknown                 params=${Params}       headers=${headers}    expected_status=200
    ${ReponseJson}=           Set Variable           ${Reponse.json()}                      # Convertir la réponse JSON en dictionnaire
    Log                       ${ReponseJson}
    
    # Vérifier que la réponse contient "data"
    Dictionary Should Contain Key    ${ReponseJson}                   data
    
    # Extraire et vérifier une ressource
    ${ListeResources}=        Get Value From Json    ${ReponseJson}                         data[:]
    ${PremiereResource}=      Get From List          ${ListeResources}                      0
    
    Dictionary Should Contain Key    ${PremiereResource}              id
    Dictionary Should Contain Key    ${PremiereResource}              name
    Dictionary Should Contain Key    ${PremiereResource}              year
    Dictionary Should Contain Key    ${PremiereResource}              color
    Dictionary Should Contain Key    ${PremiereResource}              pantone_value
