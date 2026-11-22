import 'dart:ui' show ImageFilter;

import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_ui/material_ui.dart';

import '../data/profile.dart';
import '../theme.dart';

/// Floating glass pill navigation.
class TopNav extends StatelessWidget {
  const TopNav({
    super.key,
    required this.items,
    required this.onTop,
    this.activeIndex = -1,
  });

  /// (label, onTap)
  final List<(String, VoidCallback)> items;

  /// Index in [items] of the section on screen, shown in blue (-1 = none).
  final int activeIndex;
  final VoidCallback onTop;

  @override
  Widget build(BuildContext context) {
    final showLinks = MediaQuery.sizeOf(context).width >= 520;

    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 6, 6, 6),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.line),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onTop,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Text(
                    '${Profile.firstName}.',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.text,
                    ),
                  ),
                ),
              ),
              if (showLinks) ...[
                const SizedBox(width: 20),
                for (final (i, (label, onTap)) in items.indexed)
                  TextButton(
                    onPressed: onTap,
                    style: TextButton.styleFrom(
                      foregroundColor: i == activeIndex
                          ? AppColors.accentText
                          : AppColors.muted,
                      textStyle: monoStyle(
                        size: 12,
                        weight: i == activeIndex
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                    child: Text(label.toUpperCase()),
                  ),
              ],
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: onTop,
                tooltip: 'Back to top',
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.text,
                  foregroundColor: AppColors.bg,
                  minimumSize: const Size(34, 34),
                  padding: EdgeInsets.zero,
                ),
                icon: const Icon(Icons.north_rounded, size: 16),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: 900.ms, duration: 500.ms)
        .slideY(begin: -1, curve: Curves.easeOutCubic);
  }
}
