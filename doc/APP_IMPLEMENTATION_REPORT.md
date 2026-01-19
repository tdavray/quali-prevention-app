# Rapport d’implémentation — Application mobile

## 1) Correction du chevauchement de la barre de navigation (Android)
**Instruction :** Éviter le chevauchement de la navbar avec la barre système Android.

**Ce qui a été fait :**
- Ajout d’un `SafeArea` et réduction du padding bas de la barre afin de respecter l’inset système.
- Décalage du bouton flottant en tenant compte du padding bas.

**Emplacement :**
- [../quali-prevention-app/lib/ui/main/navigation_page.dart](../quali-prevention-app/lib/ui/main/navigation_page.dart)

## 2) Renommer « Formations » en « Ressources »
**Instruction :** Renommer l’onglet de navigation.

**Ce qui a été fait :**
- Libellé du bouton remplacé par « Ressources ».

**Emplacement :**
- [../quali-prevention-app/lib/ui/main/navigation_page.dart](../quali-prevention-app/lib/ui/main/navigation_page.dart)

## 3) Trier les actualités par date la plus récente
**Instruction :** Afficher les actus les plus récentes en premier.

**Ce qui a été fait :**
- Tri des articles par `createdAt` décroissant après chargement.

**Emplacement :**
- [../quali-prevention-app/lib/ui/main/4_news/news_page.dart](../quali-prevention-app/lib/ui/main/4_news/news_page.dart)

## 4) Mapping progression commission + statuts CRM → statuts appli (côté API)
**Instruction :** Appliquer la progression et le mapping des statuts côté CRM (endpoints API).

**Ce qui a été fait :**
- Alignement du statut simplifié renvoyé par l’API sur les nouveaux statuts appli.
- Calcul de la progression (0/25/50/75/100) basé sur ce statut simplifié.

**Emplacements :**
- [app/Traits/HasClientStatus.php](app/Traits/HasClientStatus.php)
- [app/Http/Controllers/Api/ClientController.php](app/Http/Controllers/Api/ClientController.php)
