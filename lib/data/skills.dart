import 'package:material_ui/material_ui.dart';

import '../models/skill.dart';

// ---------------------------------------------------------------------------
// EDIT ME — your skills.
// Add, remove or reorder entries freely; the carousel adapts automatically.
// Icons: https://fonts.google.com/icons (use Icons.<name>)
//
// Descriptions are based on the 3 GitHub projects (habit tracker, movie
// explorer, weather app). Keep them true to what you actually built.
// ---------------------------------------------------------------------------
const List<Skill> skills = [
  Skill(
    title: 'Flutter',
    subtitle: '1 year · Mobile & Web',
    icon: Icons.flutter_dash,
    color: Color(0xFF2F7BEA),
    description: 'Three apps built for mobile and the web: a habit '
        'tracker with charts and swipe actions, a movie browser with infinite '
        'scroll and Hero transitions, and a weather dashboard with custom '
        'animated icons, each one deployable to the web with Docker + nginx.',
    highlights: [
      'Custom widgets',
      'Animations',
      'Hero transitions',
      'fl_chart',
      'go_router',
      'Responsive UI',
    ],
  ),
  Skill(
    title: 'Dart',
    subtitle: 'Language',
    icon: Icons.code_rounded,
    color: Color(0xFF0E8A86),
    description:
        'Null-safe, strongly typed Dart across all projects: async/await and '
        'streams for network and real-time data, immutable models with '
        'Equatable, generated Hive adapters, and unit tests for business '
        'logic such as streak calculations.',
    highlights: [
      'Null safety',
      'Async / Streams',
      'Code generation',
      'Unit tests',
    ],
  ),
  Skill(
    title: 'State management',
    subtitle: 'Riverpod · BLoC',
    icon: Icons.account_tree_rounded,
    color: Color(0xFF7A4FD6),
    description: 'BLoC with events/states for the movie explorer, bridged to a '
        'pagination controller for infinite scroll. Riverpod AsyncNotifier '
        'for the weather app, so loading and error states come for free, with '
        'a debounced city search. Hive listenables for the local-first habit '
        'tracker.',
    highlights: [
      'BLoC',
      'Riverpod',
      'AsyncNotifier',
      'Debounced search',
      'Hive listenables',
    ],
  ),
  Skill(
    title: 'Web architecture',
    subtitle: 'Patterns · APIs · SPA',
    icon: Icons.architecture_rounded,
    color: Color(0xFF3E9B6A),
    description:
        'Feature-first projects with a clear split between data, logic and '
        'presentation: repositories and services wrap REST APIs (Dio), state '
        'lives in BLoC or Riverpod, and widgets only render. Apps are served '
        'as single-page applications, with deep links handled by go_router '
        'and an nginx fallback to index.html.',
    highlights: [
      'MVC',
      'MVVM',
      'Clean Architecture',
      'Repository pattern',
      'REST APIs',
      'SPA',
    ],
  ),
  Skill(
    title: 'Firebase',
    subtitle: 'Backend as a service',
    icon: Icons.local_fire_department_rounded,
    color: Color(0xFFD9661F),
    description:
        'Cloud sync for the habit tracker: anonymous sign-in that can be '
        'upgraded to an email account, Firestore real-time streams, and '
        'batched writes (500 ops max) to keep sync fast and cheap. Data stays '
        'local-first in Hive and syncs when online.',
    highlights: [
      'Firebase Auth',
      'Firestore',
      'Batched writes',
      'Offline-first sync',
    ],
  ),
  Skill(
    title: 'Docker',
    subtitle: 'Containers · nginx',
    icon: Icons.inventory_2_rounded,
    color: Color(0xFF1E9BD7),
    description:
        'Every Flutter project ships with a multi-stage Dockerfile: a Flutter '
        'image builds the web release, then a small nginx:alpine image serves '
        'it. nginx is tuned for single-page apps (fallback to index.html), '
        'gzip, and long-term caching of hashed assets. API keys are passed as '
        'build args and docker compose starts each app on its own port.',
    highlights: [
      'Dockerfile',
      'Multi-stage builds',
      'docker compose',
      'nginx',
      'Build args',
      'Caching',
    ],
  ),
  Skill(
    title: 'Git & GitHub',
    subtitle: 'Version control',
    icon: Icons.merge_type_rounded,
    color: Color(0xFFC2364F),
    description:
        'Every project is versioned on GitHub with Conventional Commits '
        '(feat, fix, build, docs, chore). Secrets stay out of the repo: API '
        'keys are injected at build time with --dart-define. This resume is '
        'itself deployed on GitHub Pages.',
    highlights: [
      'Git',
      'GitHub',
      'Conventional Commits',
      'GitHub Pages',
    ],
  ),
];
