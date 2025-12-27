# Product Requirements Document (PRD)

## 1. Product Summary
**Name**: Rhythm
**Goal**: A daily system for consistency focusing on Habits, Focus, Reading, and Mood.
**Platform**: iOS + Android (Flutter)

## 2. Core Features (MVP)

### A) Habits + Streak Engine
-   Create daily/weekly habits.
-   Check-in mechanic (checkbox).
-   Streak calculation (current/best).

### B) Focus (Pomodoro)
-   Timer with Work/Break cycles.
-   Presets (25/5, 50/10).
-   Session history logging.

### C) Reading
-   Import books from Google Drive (PDF).
-   Track reading time and pages.
-   Bookmark current position.

### D) Mood Tracking
-   Daily 1-5 score.
-   Optional tags (sleep/stress/energy) and notes.

### E) The "Today" Timeline
-   Single view aggregating all the above.
-   "Start Focus", "Read Book", "Check Habit" all in one place.

## 3. Data Model

-   **User**: ID, email.
-   **Habit**: Title, Schedule, Target.
-   **HabitCompletion**: Date, Value.
-   **FocusSession**: Start, Duration, Label.
-   **Book**: Title, Source, Progress.
-   **MoodEntry**: Date, Score, Tags.

## 4. Non-Functional Requirements
-   **Privacy**: Mental health data is sensitive.
-   **Performance**: "Today" screen loads < 1s.
-   **Offline**: All core features work without internet.
