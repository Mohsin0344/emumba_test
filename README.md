
# 📅 Events Manager App

A Flutter-powered **Event Management App** that lets users create, update, delete, and view events with local database support using SQLite via **SqfEntity ORM**. Clean architecture with repository and state management for scalability.

---

## ✨ Features

- 🔸 **Create Events**
    - Add event name, description, type, date & time, and optional attachment.
    - Only allows creating events for future dates.

- 🔍 **View Events**
    - View all events.
    - Filter by event date (e.g., today's events).
    - Filter by event type.

- 🔄 **Update Events**
    - Edit existing event details.

- ❌ **Delete Events**
    - Remove events from the local database.

- 🗄️ **Local Storage**
    - SQLite with **SqfEntity** ORM for structured database management.

---

## 📂 Folder Structure

```
lib/
├── app_routes/               # App navigation and route management
│   ├── route_names.dart
│   └── routes.dart
│
├── data/                     # Repositories for data handling
│   └── events_repository.dart
│
├── models/                   # Database models generated via SqfEntity
│   ├── model.dart
│   └── model.g.dart
│
├── providers/                # Bloc providers setup
│   └── bloc_providers.dart
│
├── view_models/              # View models (Cubit/Bloc for each feature)
│   ├── events/               # Event-specific view models
│   │   ├── create_event_view_model.dart
│   │   ├── delete_event_view_model.dart
│   │   ├── get_events_view_model.dart
│   │   └── update_event_view_model.dart
│   ├── app_states.dart
│   └── test_view_model_cubit.dart
│
├── views/                    # UI Screens
│   ├── screens/
│   │   └── home_screen.dart
│   └── widgets/              # Reusable UI components
│
└── main.dart                 # App entry point
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart >=3.0.0

### 🔧 Setup

1. Clone the repo:
   ```bash
   git clone https://github.com/mohsin0344/emumba_test.git
   cd events_manager_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

---

## 🧰 Tech Stack

- **Flutter + Dart**
- **SqfEntity ORM** for local SQLite database
- **Bloc/Cubit** for state management


---

## 👤 Author

**Mohsin Elahi**  
*Flutter Developer*
