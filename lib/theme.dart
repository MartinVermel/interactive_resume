import 'package:material_ui/material_ui.dart';

/// Monochrome palette. Skill colors (lib/data/skills.dart) are only used
/// as small accents: card glow, dot, page glow.
class AppColors {
  static const bg = Color(0xFF0D0D0D);
  static const surface = Color(0xFF151515);
  static const surfaceHi = Color(0xFF1D1D1D);
  static const line = Color(0x1FFFFFFF);
  static const text = Color(0xFFF2F2F0);
  static const muted = Color(0xFF8E8E8E);
  static const faint = Color(0xFF4A4A4A);
}

class AppFonts {
  static const display = 'SpaceGrotesk';
  static const mono = 'JetBrainsMono';
}

/// Small monospace label style (e.g. "©2026", "{{ … }}", "01 / 06").
TextStyle monoStyle({
  double size = 12,
  Color color = AppColors.muted,
  FontWeight weight = FontWeight.w400,
  double letterSpacing = 0.6,
}) =>
    TextStyle(
      fontFamily: AppFonts.mono,
      fontSize: size,
      color: color,
      fontWeight: weight,
      letterSpacing: letterSpacing,
    );

/// Big grotesk display style.
TextStyle displayStyle(double size, {Color color = AppColors.text}) =>
    TextStyle(
      fontFamily: AppFonts.display,
      fontSize: size,
      height: 0.95,
      fontWeight: FontWeight.w700,
      letterSpacing: -size * 0.03,
      color: color,
    );

ThemeData buildTheme() => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppFonts.display,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.text,
        onPrimary: AppColors.bg,
        surface: AppColors.surface,
        onSurface: AppColors.text,
      ),
    );

/// Horizontal padding used by every section.
double pagePadding(BuildContext context) =>
    MediaQuery.sizeOf(context).width >= 900 ? 72 : 24;

bool isWide(BuildContext context) => MediaQuery.sizeOf(context).width >= 900;
