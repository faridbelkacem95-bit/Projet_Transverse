# Exercice Final: Système de Gestion de Location Saisonnière Homey
# ================================================================

class Propriete:
    """Représente une propriété de location saisonnière sur Homey."""
    
    def __init__(self, propriete_id, nom, prix_par_nuit):
        self.propriete_id = propriete_id
        self.nom = nom
        self.prix_par_nuit = prix_par_nuit
        self.est_disponible = True
    
    def __str__(self):
        statut = "Disponible" if self.est_disponible else "Réservée"
        return f"Propriété {self.propriete_id}: '{self.nom}' - {self.prix_par_nuit}€/nuit - {statut}"


class HomeyManager:
    """Gère une collection de propriétés de location saisonnière sur Homey."""
    
    def __init__(self):
        self.proprietes = []
    
    def ajouter_propriete(self, propriete_id, nom, prix_par_nuit):
        if prix_par_nuit <= 0:
            raise ValueError("Le prix par nuit doit être positif")
        for propriete in self.proprietes:
            if propriete.propriete_id == propriete_id:
                raise ValueError(f"Une propriété avec l'ID {propriete_id} existe déjà")
        nouvelle_propriete = Propriete(propriete_id, nom, prix_par_nuit)
        self.proprietes.append(nouvelle_propriete)
        return nouvelle_propriete
    
    def supprimer_propriete(self, propriete_id):
        for i, propriete in enumerate(self.proprietes):
            if propriete.propriete_id == propriete_id:
                del self.proprietes[i]
                return True
        return False
    
    def obtenir_propriete(self, propriete_id):
        for propriete in self.proprietes:
            if propriete.propriete_id == propriete_id:
                return propriete
        return None
    
    def rechercher_par_nom(self, nom_recherche):
        resultats = []
        for propriete in self.proprietes:
            if nom_recherche.lower() in propriete.nom.lower():
                resultats.append(propriete)
        return resultats
    
    def reserver_propriete(self, propriete_id):
        propriete = self.obtenir_propriete(propriete_id)
        if propriete is None or not propriete.est_disponible:
            return False
        propriete.est_disponible = False
        return True
    
    def liberer_propriete(self, propriete_id):
        propriete = self.obtenir_propriete(propriete_id)
        if propriete is None or propriete.est_disponible:
            return False
        propriete.est_disponible = True
        return True
    
    def obtenir_proprietes_disponibles(self):
        return [propriete for propriete in self.proprietes if propriete.est_disponible]
    
    def obtenir_proprietes_reservees(self):
        return [propriete for propriete in self.proprietes if not propriete.est_disponible]