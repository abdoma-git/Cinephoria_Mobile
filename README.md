# 🎬 Cinéphoria – Application Mobile

Bienvenue dans l'application **Cinéphoria Mobile**, une solution mobile Flutter connectée à une API PHP et une base de données MySQL. Cette application permet aux utilisateurs de se connecter, consulter leurs réservations de séances de cinéma et générer des QR codes pour accéder aux séances.

---

## 📱 Fonctionnalités principales

- 🔐 **Authentification** : connexion via email et mot de passe.
- 🎟️ **Consultation des réservations** : voir les séances réservées avec affiches, horaires et nombre de places.
- 📅 **Détails des séances** : titre du film, salle, heure de début et de fin.
- 📲 **QR Code** : génération d’un QR code unique par réservation.
- 🔁 **Actualisation** des données par glisser pour recharger les séances.

---

## ⚙️ Architecture de l'application

- **Frontend Mobile** : Flutter
- **Backend** : PHP (API REST)
- **Base de données** : MySQL
- **Communication** : via `http` avec des appels `GET` et `POST`

### 📦 Structure technique

- `/models/user.dart` : classe de l'utilisateur
- `/models/seance.dart` : classe de la séance réservée
- `login.php` : script de connexion de l’utilisateur (via API)
- `get_reservation.php` : récupère les réservations pour un utilisateur donné

> ⚠️ L’API doit être hébergée en local (avec WAMP/XAMPP) ou sur un serveur distant.  
> Exemple d’URL : `http://192.168.X.X/Cinephoria/Api/`

---

## 📥 Installation de l'application sur Android

### 🔗 Télécharger l’APK

➡️ [Télécharger Cinéphoria Mobile (.apk)](https://github.com/abdoma-git/Cinephoria_Mobile/blob/master/app-release.apk)

### 📲 Étapes pour installer sur un téléphone Android

1. **Télécharge le fichier `app-release.apk`** depuis le lien ci-dessus.
2. **Copie-le sur ton téléphone** (via câble USB ou envoi par mail/cloud).
3. Sur le téléphone :
   - Va dans **Paramètres > Sécurité > Sources inconnues**
   - Active **"Autoriser l’installation d’applications inconnues"**
4. Ouvre le fichier `.apk` sur le téléphone pour lancer l’installation.
5. Une fois installée, ouvre l’application et connecte-toi avec tes identifiants (présents dans la base `employer`).

---

## 🔧 Configuration requise

- 📱 Android 7.0 ou supérieur
- 📶 Connexion réseau locale ou internet pour accéder à l’API
- 🌐 API disponible à l’adresse : `http://10.0.2.2/Cinephoria/Api` (émulateur) ou `http://192.168.X.X/...` (réseau local)

---

## 🔒 Accès à la base de données

L'application repose sur les tables suivantes :

```sql
CREATE TABLE employer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255),
    mot_de_passe VARCHAR(255),
    nom VARCHAR(255)
);

CREATE TABLE seances (
    id INT AUTO_INCREMENT PRIMARY KEY,
    film VARCHAR(255),
    jour_projection DATE,
    heure_debut TIME,
    heure_fin TIME,
    numero_salle VARCHAR(50)
);

CREATE TABLE reservations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    seance_id INT,
    places INT
);
