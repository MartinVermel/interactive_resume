import 'package:material_ui/material_ui.dart';

import '../models/skill.dart';

// ---------------------------------------------------------------------------
// EDIT ME — your skills.
// Add, remove or reorder entries freely; the carousel adapts automatically.
// Icons: https://fonts.google.com/icons (use Icons.<name>)
// ---------------------------------------------------------------------------
const List<Skill> skills = [
  Skill(
    title: 'Flutter',
    subtitle: 'X years · Mobile & Web',
    icon: Icons.flutter_dash,
    color: Color(0xFF2F7BEA),
    description:
        'Describe what you built with Flutter: apps, scale, platforms, '
        'architecture choices, things you are proud of.',
    highlights: ['Widgets', 'Animations', 'Responsive UI', 'Platform channels'],
  ),
  Skill(
    title: 'Dart',
    subtitle: 'Language',
    icon: Icons.code_rounded,
    color: Color(0xFF0E8A86),
    description: 'Describe your Dart experience here.',
    highlights: ['Null safety', 'Async / Streams', 'Isolates'],
  ),
  Skill(
    title: 'State management',
    subtitle: 'Riverpod · Bloc · Provider',
    icon: Icons.account_tree_rounded,
    color: Color(0xFF7A4FD6),
    description: 'Which patterns you use and why.',
    highlights: ['Riverpod', 'Bloc', 'Clean architecture'],
  ),
  Skill(
    title: 'Firebase',
    subtitle: 'Backend as a service',
    icon: Icons.local_fire_department_rounded,
    color: Color(0xFFD9661F),
    description: 'Auth, Firestore, Cloud Functions, push notifications…',
    highlights: ['Auth', 'Firestore', 'FCM', 'Crashlytics'],
  ),
  Skill(
    title: 'Testing',
    subtitle: 'Unit · Widget · Integration',
    icon: Icons.science_rounded,
    color: Color(0xFF2E9A4F),
    description: 'How you test your apps.',
    highlights: ['flutter_test', 'mocktail', 'Golden tests'],
  ),
  Skill(
    title: 'Git & CI/CD',
    subtitle: 'Tooling',
    icon: Icons.merge_type_rounded,
    color: Color(0xFFC2364F),
    description: 'Your workflow: branches, reviews, pipelines, store releases.',
    highlights: ['GitHub Actions', 'Codemagic', 'Fastlane'],
  ),
];
