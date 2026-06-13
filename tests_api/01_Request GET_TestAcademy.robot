*** Settings ***
Library    RequestsLibrary    # Import de la bibliothèque pour les requêtes HTTP
Library    JSONLibrary        # Import de la bibliothèque pour la manipulation JSON
Library    Collections        # Import de la bibliothèque pour la manipulation de collections

*** Variables ***
${Base_URL}    https://mock-api-h0g7.onrender.com/    # Définition de l'URL de base de l'API
${API_KEY}     Cle-API-ReqRes-test-academy            # Clé API pour l'authentification

*** Test Cases ***
Test 001 Requete GET
    &{Params}=                Create Dictionary      page=1                                 per_page=6             # Créer un dictionnaire de paramètres pour la requête
    &{headers}=               Create Dictionary      Authorization=Bearer ${API_KEY}
    ${Reponse}=               GET                    ${Base_URL}api/users                   params=${Params}       headers=${headers}    expected_status=200
    ${ReponseJson}=           Set Variable           ${Reponse.json()}                      # Convertir la réponse JSON en dictionnaire
    Log                       ${ReponseJson}
    ${ListeUtilisateurs}=     Get Value From Json    ${ReponseJson}                         data[:]                # Extraire la liste des utilisateurs du dictionnaire JSON
    ${PremierUtilisateur}=    Get From List          ${ListeUtilisateurs}                   0                      # Obtenir le premier utilisateur de la liste
    ${PrenomAttendu}=         Set Variable           ${PremierUtilisateur['first_name']}    # Récupérer dynamiquement le prénom du premier utilisateur
    Should Be Equal           ${PremierUtilisateur['first_name']}    ${PrenomAttendu}       # Vérifier que le prénom correspond bien à celui de la réponse JSON
