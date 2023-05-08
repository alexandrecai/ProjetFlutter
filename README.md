# projetflutter

**M1 IMIS 2022/2023**
**Groupe E:** Fatoumata Barry , Alexandre Cailloux & Matthieu Bonbon

#### Plan d'Application :

- Scénarios d'utilisation - Description de l'architecture
- Description courte de la mise en œuvre du design pattern : Le Singleton
- Présentation d'un Widget élaboré
- Description de la campagne de tests de l'application

*Voir les détails de fonctionnement  dans la documentation technique*

Notre application de gestion de livres «mini-bibliothèque» utilise une base de données et une API que nous avons mis en place.
Elle renferme dans le dossier */lib* 4 sous-dossiers:
1. Controllers : contient les contrôleurs des entités pour réaliser les appels vers l'API afin de récupérer les données de la base de données.
2. Objects : contient les classes des différentes entités (Author,Book,Categorie,MaisonEdition,User,Whishlist).
3. Pages : contient les pages de chaque entité pour la gestion des fonctionnalités, elle a aussi la page principale (MainPage.dart).
4. Utils : concerne les fonctions utilitaires du projet comme, par exemple, la classe permettant d'utiliser le pattern Singleton pour récupérer la même instance de l'URL dans les différents contrôleurs.

Nous avons également la classe principale : main.dart

