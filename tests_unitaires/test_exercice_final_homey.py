import unittest
from exercice_final_homey import HomeyManager, Propriete


class TestHomeyManager(unittest.TestCase):
    """
    Tests unitaires complets pour le système de gestion Homey.
    Mobilise toutes les assertions : assertEqual, assertTrue, assertFalse,
    assertIsNone, assertIsNotNone, assertIn, assertNotIn, assertRaises.
    """

    def setUp(self):
        """
        Prépare un HomeyManager et quelques propriétés de test avant chaque test.
        Utilisation de setUp() pour éviter la duplication de code.
        """
        self.manager = HomeyManager()

        self.propriete1 = self.manager.ajouter_propriete(1, "Villa Azur", 150.0)
        self.propriete2 = self.manager.ajouter_propriete(2, "Chalet Montagne", 200.0)
        self.propriete3 = self.manager.ajouter_propriete(3, "Studio Paris", 80.0)

    # ---------------------------------------------------------------
    # 1. Tests pour ajouter_propriete()
    # ---------------------------------------------------------------

    def test_ajouter_propriete_valide(self):
        """Ajouter une propriété valide → vérifie le nom, le prix et la disponibilité."""
        propriete = self.manager.ajouter_propriete(4, "Mas Provençal", 120.0)
        self.assertEqual(propriete.nom, "Mas Provençal")
        self.assertEqual(propriete.prix_par_nuit, 120.0)
        self.assertTrue(propriete.est_disponible)

    def test_ajouter_propriete_id_double(self):
        """Ajouter une propriété avec un ID déjà existant → ValueError."""
        with self.assertRaises(ValueError):
            self.manager.ajouter_propriete(1, "Doublon", 100.0)

    def test_ajouter_propriete_prix_negatif(self):
        """Ajouter une propriété avec un prix négatif → ValueError."""
        with self.assertRaises(ValueError):
            self.manager.ajouter_propriete(5, "Appartement", -50.0)

    # ---------------------------------------------------------------
    # 2. Tests pour supprimer_propriete()
    # ---------------------------------------------------------------

    def test_supprimer_propriete_existante(self):
        """Supprimer une propriété existante → retourne True et la propriété disparaît."""
        resultat = self.manager.supprimer_propriete(1)
        self.assertTrue(resultat)

        # Vérification que la propriété n'existe plus
        propriete_supprimee = self.manager.obtenir_propriete(1)
        self.assertIsNone(propriete_supprimee)

    def test_supprimer_propriete_inexistante(self):
        """Supprimer un ID inexistant → retourne False."""
        resultat = self.manager.supprimer_propriete(999)
        self.assertFalse(resultat)

    # ---------------------------------------------------------------
    # 3. Tests pour obtenir_propriete()
    # ---------------------------------------------------------------

    def test_obtenir_propriete_existante(self):
        """Obtenir une propriété par son ID → retourne un objet non None."""
        propriete = self.manager.obtenir_propriete(2)
        self.assertIsNotNone(propriete)
        self.assertEqual(propriete.nom, "Chalet Montagne")

    def test_obtenir_propriete_inexistante(self):
        """Obtenir une propriété avec un ID inexistant → retourne None."""
        propriete = self.manager.obtenir_propriete(999)
        self.assertIsNone(propriete)

    # ---------------------------------------------------------------
    # 4. Tests pour rechercher_par_nom()
    # ---------------------------------------------------------------

    def test_rechercher_par_nom_existant(self):
        """Rechercher 'Villa' → la Villa Azur doit être dans les résultats."""
        resultats = self.manager.rechercher_par_nom("Villa")
        self.assertIn(self.propriete1, resultats)
        self.assertNotIn(self.propriete2, resultats)

    def test_rechercher_par_nom_inexistant(self):
        """Rechercher un nom absent → liste vide."""
        resultats = self.manager.rechercher_par_nom("Château Inconnu")
        self.assertEqual(len(resultats), 0)

    # ---------------------------------------------------------------
    # 5. Tests pour reserver_propriete()
    # ---------------------------------------------------------------

    def test_reserver_propriete_valide(self):
        """Réserver une propriété disponible → retourne True et la marque indisponible."""
        resultat = self.manager.reserver_propriete(1)
        self.assertTrue(resultat)

        # Vérification que l'état a bien changé
        self.assertFalse(self.propriete1.est_disponible)

    def test_reserver_propriete_inexistante(self):
        """Réserver un ID inexistant → retourne False."""
        resultat = self.manager.reserver_propriete(999)
        self.assertFalse(resultat)

    def test_reserver_propriete_deja_reservee(self):
        """Réserver une propriété déjà réservée → retourne False."""
        # Première réservation
        premiere_reservation = self.manager.reserver_propriete(2)
        self.assertTrue(premiere_reservation)

        # Tentative en double
        deuxieme_reservation = self.manager.reserver_propriete(2)
        self.assertFalse(deuxieme_reservation)

    # ---------------------------------------------------------------
    # 6. Tests pour les listes filtrées
    # ---------------------------------------------------------------

    def test_obtenir_proprietes_disponibles(self):
        """Toutes les propriétés sont disponibles au départ, puis une est réservée."""
        # Vérification de l'état initial
        disponibles = self.manager.obtenir_proprietes_disponibles()
        self.assertEqual(len(disponibles), 3)
        self.assertIn(self.propriete1, disponibles)
        self.assertIn(self.propriete2, disponibles)
        self.assertIn(self.propriete3, disponibles)

        # Après réservation
        self.manager.reserver_propriete(1)
        disponibles = self.manager.obtenir_proprietes_disponibles()
        self.assertEqual(len(disponibles), 2)
        self.assertNotIn(self.propriete1, disponibles)

    def test_obtenir_proprietes_reservees(self):
        """Aucune propriété réservée au départ, puis une est réservée."""
        # Vérification de l'état initial
        reservees = self.manager.obtenir_proprietes_reservees()
        self.assertEqual(len(reservees), 0)

        # Après réservation
        self.manager.reserver_propriete(1)
        reservees = self.manager.obtenir_proprietes_reservees()
        self.assertEqual(len(reservees), 1)
        self.assertIn(self.propriete1, reservees)
        self.assertNotIn(self.propriete2, reservees)


if __name__ == "__main__":
    unittest.main(verbosity=2)