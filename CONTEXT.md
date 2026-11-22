# Project context — Interactive Resume (Flutter)

_Last updated: 2026-11-22_

## What it is
Personal interactive resume of Martin Vermel, built with Flutter (web first, also android/ios/macos).
Dark monochrome editorial design; skill colors used only as small accents.
Git repo: https://github.com/MartinVermel/interactive_resume (public, branch main, created 2026-11-22). The 3 project repos are public too.

## Stack
- Flutter SDK at `~/flutter/bin/flutter` (not on PATH — call it by full path).
- Dart `>=3.5.0 <4.0.0`.
- Deps: `material_ui` (used instead of `package:flutter/material.dart` imports), `flutter_animate`, `url_launcher`.
- Fonts (assets/fonts): SpaceGrotesk (display), JetBrainsMono (mono labels).
- Images: `assets/images/hero_main.jpg`, `assets/images/hero_small.jpg`.

## Structure
```
lib/
  main.dart
  theme.dart              AppColors, AppFonts, monoStyle(), displayStyle(), pagePadding(), isWide() (>=900px)
  models/skill.dart       Skill(title, subtitle, icon, color, level 0-1, description, highlights)
  models/project.dart     Project(title, description, url, tags)
  data/profile.dart       All resume text (static consts in class Profile) — still PLACEHOLDER values
  data/skills.dart        const List<Skill> skills — still PLACEHOLDER content
  data/projects.dart      const List<Project> projects — real data (3 GitHub repos)
  pages/resume_page.dart  Page layout + private _SectionHeader(title, count, optional hint)
  widgets/
    intro_section.dart    Giant intro title
    hero_section.dart     Hero (greeting, tagline with **bold** markup, images B&W -> color on hover)
    skill_carousel.dart   Infinite 3D coverflow, flip cards, autoplay, keyboard
    skill_card.dart
    project_list.dart     Editorial hoverable rows, open repo in new tab
    top_nav.dart          Floating glass pill nav
    contact_footer.dart   "Let's talk." + footer (giant faded name + "Back to top" link removed 2026-11-22)
test/widget_test.dart     2 tests (header + carousel, wide hero layout)
```

## Page order (resume_page.dart)
Intro → Hero (About) → Skills (carousel) → Projects → Contact/footer.
Nav items (top nav + footer EXPLORE): About, Skills, Projects, Contact — defined once in `_nav`.

## Projects (lib/data/projects.dart)
| # | Title | URL |
|---|-------|-----|
| 01 | Habit Tracker | https://github.com/MartinVermel/flutter_habit_tracker (Hive, fl_chart, flutter_slidable, animate_do) |
| 02 | Movie Explorer | https://github.com/MartinVermel/flutter_movie_explorer (BLoC, go_router, shimmer, Hero) |
| 03 | Weather App | https://github.com/MartinVermel/flutter_weather_app (Riverpod, Dio, flutter_animate, CustomPainter) |
Titles/descriptions written by Claude from repo descriptions — user may reword.

## Decisions
- 2026-11-22 user removed: Skills hint ("Swipe, use ← →…"), ©year in intro bottom row, giant faded "YOUR." in footer, footer "Back to top ↑" link. Top-nav ↑ button kept.
- **Data stays in Dart files, not JSON**: compile-time type checks, synchronous access (no FutureBuilder),
  `Icons.*`/`Color` stored directly, and icon tree-shaking keeps working (runtime IconData from JSON
  breaks `flutter build web` unless `--no-tree-shake-icons`). Reconsider JSON only if content must
  change without rebuild, non-dev editors, i18n, or reuse by other tools.
- New content types follow the same pattern: model in `models/`, `// EDIT ME` const list in `data/`, widget in `widgets/`.

## TODO / open items
- Replace placeholders in `profile.dart` (name, title, tagline, email, LinkedIn/GitHub links, currently line).
- Replace placeholder skills in `skills.dart` with real ones.
- Add real hero images in `assets/images/`.
- Visual check of Projects section in browser (`~/flutter/bin/flutter run -d chrome`) — not done yet.
- Deploy: `flutter build web --release` (GitHub Pages needs `--base-href /<repo>/`).

## Verify
```sh
~/flutter/bin/flutter analyze   # last run: no issues
~/flutter/bin/flutter test      # last run: 2/2 pass
```
