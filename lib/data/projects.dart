import '../models/project.dart';

// ---------------------------------------------------------------------------
// EDIT ME — your projects. Add, remove or reorder entries freely.
// ---------------------------------------------------------------------------
const List<Project> projects = [
  Project(
    title: 'Habit Tracker',
    description: 'Daily habit tracker with local persistence, progress charts, '
        'swipe actions and smooth entrance animations.',
    url: 'https://github.com/MartinVermel/flutter_habit_tracker',
    tags: ['Hive', 'fl_chart', 'flutter_slidable', 'animate_do'],
  ),
  Project(
    title: 'Movie Explorer',
    description: 'Movie browser with infinite scroll, shimmer loading states '
        'and Hero transitions between list and details.',
    url: 'https://github.com/MartinVermel/flutter_movie_explorer',
    tags: ['BLoC', 'go_router', 'shimmer', 'Hero animations'],
  ),
  Project(
    title: 'Weather App',
    description: 'Weather dashboard with custom-painted visuals, animated '
        'transitions and a networked data layer.',
    url: 'https://github.com/MartinVermel/flutter_weather_app',
    tags: ['Riverpod', 'Dio', 'flutter_animate', 'CustomPainter'],
  ),
];
