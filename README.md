# Rhythm

Focus, habits, reading and mood on one daily screen: a Flutter MVP.

> **Status: early prototype (December 2025).** The app shell, habit list, focus timer and mood check-in work on
> in-memory data. Persistence (Supabase/Isar), streaks, Google Drive import and real insights are designed but not
> built yet. Nothing here is published to an app store.

## What and why

Most people who want to be consistent juggle a habit tracker, a Pomodoro timer, a reading app and a mood journal.
Rhythm puts all four on one **Today** screen, so a day's plan and check-ins live in one place. The product goals are
in [`REQUIREMENTS.md`](REQUIREMENTS.md); the design decisions are in [`ARCHITECTURE.md`](ARCHITECTURE.md).

## Features

What works in this build:

- **Today view**: date header, habit list with empty/loading/error states, and quick actions for Focus and Mood.
- **Habits**: add a habit by name and tick it off for today. Habits are kept in memory for the session.
- **Focus**: a 25-minute Pomodoro timer with start, pause, resume and stop, and a progress ring.
- **Mood**: a 1–5 check-in with tags (Sleep, Stress, Energy, Exercise, Social, Work).
- **Light and dark themes**: Material 3, following the system setting.

Not built yet (screens exist with placeholder or sample data):

- Saving habits, focus sessions and mood entries; habit schedule and time-of-day options; streaks.
- Reading: the Library tab lists two sample books; Google Drive import is not implemented.
- Insights: the cards and chart use sample numbers.
- Supabase sync and Isar offline storage.

## Architecture

- **Flutter** app, feature-first layout: `lib/features/<feature>/{domain,data,presentation}`.
- **State**: Riverpod 2 with code-generated providers (`riverpod_generator`).
- **Routing**: GoRouter (a single `/` route to the home shell with bottom navigation).
- **Models**: Freezed + `json_serializable` for `Habit`, `FocusSession`, `MoodEntry` and `Book`.
- **Data today**: `HabitRepository` keeps an in-memory list; `DriveService` returns sample books.
- **Planned**: Supabase (auth, Postgres, storage) and Isar as a local cache. `supabase_flutter` is already a
  dependency (`lib/services/supabase_service.dart`) but is not initialised in `lib/main.dart`.

```text
lib/
├── main.dart                  # ProviderScope + RhythmApp
├── app.dart                   # GoRouter, Material 3 themes
├── features/
│   ├── home/                  # Today view and bottom navigation
│   ├── habits/                # Habit model, in-memory repository, provider, screens
│   ├── focus/                 # Pomodoro timer (Riverpod notifier) and screen
│   ├── mood/                  # Mood model and check-in sheet
│   ├── reading/               # Book model, mock Drive service, library screen
│   └── insights/              # Insights screen (sample data)
└── services/                  # Supabase and Isar wrappers (not wired up yet)
```

## Quick start

Requirements: Flutter SDK 3.24 or later (Dart 3.5+), plus Xcode for iOS or Android Studio for Android.

```bash
git clone https://github.com/avnishyadav25/Rhythm.git
cd Rhythm
flutter pub get
# Only needed after you change a Freezed model or a @riverpod provider
# (the generated *.g.dart and *.freezed.dart files are committed):
dart run build_runner build --delete-conflicting-outputs
flutter run
```

No accounts, keys or environment variables are needed for the current build. When Supabase is wired up it will need
a project URL and an anon key; pass them at build time (for example `--dart-define=SUPABASE_URL=...` and
`--dart-define=SUPABASE_ANON_KEY=...`) rather than committing them.

## Usage

1. On **Today**, tap the plus icon next to Habits and create a habit.
2. Tick a habit to mark it done for today.
3. Tap **Focus** to run a 25-minute session; pause, resume or stop it.
4. Tap **Log Mood**, choose a score and tags, and save.
5. Open **Read** and **Insights** to see the planned screens with sample data.

## Known issues

- `test/widget_test.dart` is the default Flutter counter test and references `MyApp`, which does not exist (the app
  class is `RhythmApp`), so `flutter test` fails until it is replaced.
- Android and iOS ids are still the template `com.example.rhythm`.

## Licence

No licence file yet, so all rights are reserved by the author until one is added.

## Author

Built by [Avnish Yadav](https://avnishyadav.com).
