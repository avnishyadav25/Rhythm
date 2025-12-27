# Architecture & Tech Stack

## Overview

Rhythm uses a **Feature-First** architecture with **Riverpod** for state management and **Supabase** for the backend. The app is designed to be **Offline-First**.

## Directory Structure

```
lib/
├── core/                  # Shared utilities, theme, constants
├── features/              # Feature-based modules
│   ├── auth/              # Authentication
│   ├── home/              # "Today" timeline & main shell
│   ├── habits/            # Habit tracking domain & UI
│   ├── focus/             # Pomodoro timer
│   ├── reading/           # Google Drive book reader
│   └── mood/              # Mood tracking
├── services/              # External interfaces (Supabase, API, LocalDB)
├── main.dart              # Entry point
└── app.dart               # Root widget
```

## Key Decisions

### 1. State Management: Riverpod
-   **Why**: Compile-time safety, easy testing, and efficient state disposal.
-   **Usage**: We use `AsyncNotifier` for most logic to handle loading/error states gracefully.

### 2. Backend: Supabase
-   **Why**: Postgres offers strong relational data modeling (crucial for complex streak queries), and Auth/Storage are included out of the box.

### 3. Local Storage: Isar (Planned)
-   **Why**: High performance, supports full-text search, and acts as a local cache for offline capabilities.

### 4. Code Generation: Freezed
-   **Why**: Immutable data classes and union types reduce boilerplate and runtime errors.

## Data Flow (Typical)

1.  **UI** watches a Riverpod Provider.
2.  **Provider** calls a **Repository**.
3.  **Repository** checks **Local Storage** (Isar) first (for speed/offline).
4.  **Repository** syncs with **Supabase** in the background.
5.  **State** updates automatically.
