# Rhythm

**Focus + Habits + Reading + Mood.** All in one timeline: **Today**.

Rhythm is a personal operating system designed to help you build consistency without juggling 5 different apps. It anchors everything to a single daily view.

## Features

-   **✅ Habits**: Track daily routines with streak motivation.
-   **🍅 Focus**: Built-in Pomodoro timer to stay productive.
-   **📚 Reading**: Import PDF/EPUBs from Google Drive and track reading progress.
-   **🙂 Mood**: Log daily mood and well-being to find correlations.
-   **📊 Insights**: See how your habits affect your mood and focus (Coming Soon).

## Architecture

-   **Frontend**: Flutter (Mobile - iOS/Android)
-   **State Management**: Riverpod
-   **Backend**: Supabase (Auth, Postgres, Storage)
-   **Local Database**: Isar (Offline-first support)

## Getting Started

1.  **Prerequisites**: Flutter SDK, Supabase Account.
2.  **Clone the repo**:
    ```bash
    git clone https://github.com/yourusername/rhythm.git
    cd rhythm
    ```
3.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
4.  **Run Code Generation**:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
5.  **Run the App**:
    ```bash
    flutter run
    ```
