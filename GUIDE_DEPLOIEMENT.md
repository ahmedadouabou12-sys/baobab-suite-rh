# Baobab Suite RH — déploiement centralisé gratuit (prototype à configurer)

## Ce que contient ce dossier
- `index.html` : interface existante Baobab Suite RH avec archives/régénération, adaptée à une connexion Supabase et à un stockage central JSONB.
- `supabase-config.js` : emplacement de l'URL Supabase et de la clé publique.
- `supabase-schema.sql` : table centrale et politiques RLS.

## Important avant d'utiliser des dossiers réels
Cette adaptation est un point de départ technique, pas une certification de sécurité. Testez d'abord avec des données fictives. Le stockage central est un document JSON par compte administrateur; cela simplifie la migration de l'application existante, mais n'offre pas encore un historique détaillé par champ ni une gestion multi-rôle. Un échec de synchronisation est signalé à l'écran; vérifiez toujours l'état « Données synchronisées » avant de quitter après une modification.

## 1. Créer Supabase
1. Ouvrir https://supabase.com/dashboard et créer un projet `Baobab-Suite-RH`.
2. Dans **SQL Editor**, exécuter le contenu de `supabase-schema.sql`.
3. Dans **Authentication > Users**, créer manuellement l'utilisateur administrateur (adresse et mot de passe fort). Ne pas activer l'inscription publique.
4. Dans **Project Settings > API** (ou API Keys), copier l'URL du projet et la clé `anon`/`publishable` publique.
5. Ouvrir `supabase-config.js` et remplacer `https://VOTRE-PROJET.supabase.co` et `VOTRE_CLE_PUBLISHABLE_OU_ANON` par ces valeurs. Ne jamais utiliser `service_role` ni une clé secrète côté navigateur.

## 2. Déployer sur Cloudflare Pages
1. Ouvrir https://dash.cloudflare.com/ et se connecter.
2. Aller dans **Workers & Pages** puis **Create** / **Pages** (le libellé peut varier).
3. Choisir l'option de téléversement direct / assets statiques.
4. Téléverser les trois fichiers à la racine du projet : `index.html`, `supabase-config.js`, `supabase-schema.sql` (le SQL peut aussi rester hors du site; il n'est pas nécessaire à l'exécution et ne contient aucun secret).
5. Déployer et ouvrir l'adresse `*.pages.dev` fournie.

## 3. Tests obligatoires avant données réelles
- Se connecter avec le compte administrateur.
- Créer un agent fictif et attendre l'état **Données synchronisées**.
- Actualiser la page puis vérifier que l'agent est toujours présent.
- Ouvrir l'adresse sur un autre appareil et vérifier que les mêmes données apparaissent.
- Tester génération, archivage, régénération/impression, restauration et suppression avec des actes fictifs.
- Se déconnecter et confirmer que l'application revient à l'écran de connexion.
- Vérifier dans Supabase que l'accès anonyme est refusé et que les politiques RLS sont activées.

## 4. Données existantes dans le navigateur
La version précédente utilisait `localStorage`. Cette version ne téléverse pas automatiquement ces données locales vers le cloud, pour éviter une importation accidentelle de données personnelles. Si tu as des données à conserver, exporte une sauvegarde JSON depuis l'ancienne version, puis utilise l'import prévu dans l'application connectée après connexion, en commençant par une copie de test. Vérifie toutes les données importées avant d'utiliser l'application en production.

## Limites et sécurité
- Le modèle actuel centralise le jeu de données en un seul document JSON par administrateur. Pour des données RH sensibles en production, il est préférable de normaliser les tables, renforcer la journalisation, définir les sauvegardes/restaurations et réaliser une revue de sécurité indépendante.
- Le mot de passe de l'administrateur doit être unique et protégé; activez MFA si disponible et compatible avec le mode d'accès choisi.
- Le plan gratuit peut avoir des limites de stockage, disponibilité ou mise en veille qui évoluent. Vérifiez les conditions actuelles de Supabase et Cloudflare.
- Ne mettez pas de données RH réelles avant les tests, la validation des règles d'accès et la vérification des obligations légales applicables au Burkina Faso.
