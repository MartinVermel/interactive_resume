import 'package:material_ui/material_ui.dart';

/// One card of the skills carousel.
class Skill {
  const Skill({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.description,
    this.highlights = const [],
  });

  /// Big title on the front of the card (e.g. "Flutter").
  final String title;

  /// Short line under the title (e.g. "3 years · Mobile & Web").
  final String subtitle;

  /// Icon shown on the front of the card.
  final IconData icon;

  /// Accent color of the card (also tints the page background).
  final Color color;

  /// Text shown on the back of the card when flipped.
  final String description;

  /// Small tags shown on the back of the card.
  final List<String> highlights;
}
