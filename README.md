# CineScope – Movie App

**TR:** CineScope, film tutkunlarının yeni filmleri keşfetmesini ve kişisel zevklerine göre öneriler almasını sağlayan bir iOS uygulamasıdır.  
**EN:** CineScope is an iOS app that helps movie lovers discover new films and get personalized recommendations.

---

## Amaç (TR)
- Kullanıcıların **kararsızlık yaşamadan doğru film seçimleri** yapmasını sağlamak.
- Sinema tutkunlarının **zevklerine ve ruh hallerine uygun kişisel önerilere** erişmesini kolaylaştırmak.
- **Yapay zekâ ile doğal dilde sohbet** ederek film keşfini daha eğlenceli hâle getirmek.
- Tek platformda **trendler, oyuncu aramaları, fragmanlar, favoriler** gibi keşif araçlarını sunmak.

## Mission (EN)
- Help users **pick the right movie** without indecision.
- Provide **personalized, mood-aware** recommendations.
- Make discovery **fun with AI chat** in natural language.
- Offer **trending, people search, trailers, favorites** in one place.

---

## Özellikler · Features
- **Keşif:** Trending / Popular / Categories (compositional layout)
- **Arama & Filtreleme** · **Search & Filters**
- **Fragman İzleme** · **Trailers**
- **Favoriler** (Firebase ile kalıcı) · **Favorites** (persisted in Firebase)
- **Profil & Avatar** özelleştirme · **Profile & Avatar** customization
- **Öneri Sohbeti** (OpenAI) – moda/anahtar kelimeye göre · **Recommendation Chat** (OpenAI)

---

## Tech Stack

**MİMARİ:** MVVM + Compositional Layout  
**Veri Katmanı ve Servisler:** FirebaseAuth, Firestore, Firebase Remote Config, Google Sign-In  
**Ağ:** Moya (Alamofire)  
**UI:** UIKit, SnapKit, Lottie  
**AI & Öneri:** OpenAI API

**ARCHITECTURE:** MVVM + Compositional Layout  
**Data & Services:** FirebaseAuth, Firestore, Firebase Remote Config, Google Sign-In  
**Networking:** Moya (Alamofire)  
**UI:** UIKit, SnapKit, Lottie  
**AI & Recommendations:** OpenAI API

---

## Architecture (Short)
ViewControllers: `HomeViewController`, `SearchViewController`, `TrailerViewController`,  
`ProfileViewController`, `SettingsViewController`, `RecommendationChatViewController`  
ViewModels: `HomeViewModel`, `SearchViewModel`, `TrailerViewModel`, `ProfileViewModel`  
Services: `MovieService` (network), `OpenAIService`, `UserService` (Firestore), `RC.shared` (Remote Config)  
Utilities: Section/CellConfigurator pattern, image loading, error/state handling

---
## Screenshots

<p align="center">
  <a href="https://github.com/user-attachments/assets/6128fda7-6367-47c8-a8b3-38da265bca00">
    <img src="https://github.com/user-attachments/assets/6128fda7-6367-47c8-a8b3-38da265bca00" alt="Home 1" width="320">
  </a>
  <a href="https://github.com/user-attachments/assets/8be8956d-9871-417c-98fe-375c9cf0872b">
    <img src="https://github.com/user-attachments/assets/8be8956d-9871-417c-98fe-375c9cf0872b" alt="Home 2" width="320">
  </a>
</p>

<p align="center">
  <a href="https://github.com/user-attachments/assets/866a7dac-e685-432b-9ace-952f9a7d79f0">
    <img src="https://github.com/user-attachments/assets/866a7dac-e685-432b-9ace-952f9a7d79f0" alt="Search" width="320">
  </a>
  <a href="https://github.com/user-attachments/assets/85e7b33d-073f-4bf9-b959-c46f722ffdda">
    <img src="https://github.com/user-attachments/assets/85e7b33d-073f-4bf9-b959-c46f722ffdda" alt="Categories" width="320">
  </a>
</p>

<p align="center">
  <a href="https://github.com/user-attachments/assets/d60c80bf-6349-4f1d-9d21-4c8f3e591d6f">
    <img src="https://github.com/user-attachments/assets/d60c80bf-6349-4f1d-9d21-4c8f3e591d6f" alt="Detail 1" width="320">
  </a>
  <a href="https://github.com/user-attachments/assets/df4dc591-fe61-4886-b11a-6a77da911974">
    <img src="https://github.com/user-attachments/assets/df4dc591-fe61-4886-b11a-6a77da911974" alt="Detail 2" width="320">
  </a>
</p>

<p align="center">
  <a href="https://github.com/user-attachments/assets/5233202c-7e70-49ff-a0b1-b2c0ed0e1a22">
    <img src="https://github.com/user-attachments/assets/5233202c-7e70-49ff-a0b1-b2c0ed0e1a22" alt="Trailer" width="320">
  </a>
  <a href="https://github.com/user-attachments/assets/d6fb4734-8b03-4487-83ca-8a5023dabd01">
    <img src="https://github.com/user-attachments/assets/d6fb4734-8b03-4487-83ca-8a5023dabd01" alt="Favorites" width="320">
  </a>
</p>

<p align="center">
  <a href="https://github.com/user-attachments/assets/3b87d188-cad0-47f1-9dca-d16acee3b23b">
    <img src="https://github.com/user-attachments/assets/3b87d188-cad0-47f1-9dca-d16acee3b23b" alt="Profile (Desktop capture)" width="320">
  </a>
  <a href="https://github.com/user-attachments/assets/9218eef1-617a-4e08-8271-bd195c9f2da1">
    <img src="https://github.com/user-attachments/assets/9218eef1-617a-4e08-8271-bd195c9f2da1" alt="Chat / Recommendations" width="320">
  </a>
</p>

<p align="center">
  <a href="https://github.com/user-attachments/assets/7880c518-cfca-41e8-b73d-809336820216">
    <img src="https://github.com/user-attachments/assets/7880c518-cfca-41e8-b73d-809336820216" alt="Settings (Desktop capture)" width="320">
  </a>
  <a href="https://github.com/user-attachments/assets/58ab5335-b1e7-4da9-99af-a5071c45a3d6">
    <img src="https://github.com/user-attachments/assets/58ab5335-b1e7-4da9-99af-a5071c45a3d6" alt="Player / Trailer 2" width="320">
  </a>
</p>

<p align="center">
  <a href="https://github.com/user-attachments/assets/4ba7e1e0-6011-4b44-beaa-e7aafde414c3">
    <img src="https://github.com/user-attachments/assets/4ba7e1e0-6011-4b44-beaa-e7aafde414c3" alt="Home 3" width="320">
  </a>
</p>
