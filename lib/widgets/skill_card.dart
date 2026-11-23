import 'dart:math' as math;

import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_ui/material_ui.dart';

import '../models/skill.dart';
import '../theme.dart';

/// Dark glass skill card that flips in 3D when tapped (only when centered).
class SkillCard extends StatefulWidget {
  const SkillCard({
    super.key,
    required this.skill,
    required this.index,
    required this.total,
    required this.isActive,
    required this.onTapInactive,
    this.onFlipChanged,
  });

  final Skill skill;
  final int index;
  final int total;
  final bool isActive;
  final VoidCallback onTapInactive;
  final ValueChanged<bool>? onFlipChanged;

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flip = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );
  late final Animation<double> _curve =
      CurvedAnimation(parent: _flip, curve: Curves.easeInOutCubic);

  bool get _isFlipped =>
      _flip.status == AnimationStatus.forward ||
      _flip.status == AnimationStatus.completed;

  @override
  void didUpdateWidget(covariant SkillCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive && !widget.isActive && _isFlipped) {
      _flip.reverse();
      widget.onFlipChanged?.call(false);
    }
  }

  @override
  void dispose() {
    _flip.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!widget.isActive) {
      widget.onTapInactive();
      return;
    }
    if (_isFlipped) {
      _flip.reverse();
      widget.onFlipChanged?.call(false);
    } else {
      _flip.forward();
      widget.onFlipChanged?.call(true);
    }
  }

  String get _counter => '${(widget.index + 1).toString().padLeft(2, '0')} / '
      '${widget.total.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedBuilder(
          animation: _curve,
          builder: (context, _) {
            final angle = _curve.value * math.pi;
            final showBack = angle > math.pi / 2;
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0012)
                ..rotateY(angle),
              child: showBack
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: _CardBack(skill: widget.skill, counter: _counter),
                    )
                  : _CardFront(
                      skill: widget.skill,
                      counter: _counter,
                      isActive: widget.isActive,
                    ),
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------

class _CardShell extends StatelessWidget {
  const _CardShell({
    required this.accent,
    required this.child,
    this.active = false,
  });

  final Color accent;
  final Widget child;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.surface,
        border: Border.all(
          color: active ? Colors.white.withValues(alpha: 0.22) : AppColors.line,
        ),
        boxShadow: [
          BoxShadow(
            color: active
                ? accent.withValues(alpha: 0.18)
                : Colors.black.withValues(alpha: 0.4),
            blurRadius: active ? 60 : 24,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(23),
        child: Stack(
          children: [
            // Accent glow in the top-right corner.
            Positioned.fill(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: active ? 1 : 0.35,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(1.1, -1.1),
                      radius: 1.1,
                      colors: [
                        accent.withValues(alpha: 0.35),
                        accent.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: DefaultTextStyle.merge(
                style: const TextStyle(color: AppColors.text),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccentDot extends StatelessWidget {
  const _AccentDot(this.color);

  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color, blurRadius: 10)],
        ),
      );
}

class _CardFront extends StatelessWidget {
  const _CardFront({
    required this.skill,
    required this.counter,
    required this.isActive,
  });

  final Skill skill;
  final String counter;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      accent: skill.color,
      active: isActive,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(counter, style: monoStyle(size: 11)),
              const Spacer(),
              _AccentDot(skill.color),
            ],
          ),
          const SizedBox(height: 28),
          Container(
            width: 108,
            height: 108,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: AppColors.line),
            ),
            child: Icon(skill.icon, size: 56, color: AppColors.text),
          )
              .animate(target: isActive ? 1 : 0)
              .scaleXY(begin: 0.88, end: 1, curve: Curves.easeOutBack),
          const Spacer(),
          Text(skill.title, style: displayStyle(32)),
          const SizedBox(height: 10),
          Text(skill.subtitle.toUpperCase(), style: monoStyle(size: 11)),
          const SizedBox(height: 28),
          AnimatedOpacity(
            opacity: isActive ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Text('TAP TO FLIP ↻', style: monoStyle(size: 10)),
          ),
        ],
      ),
    );
  }
}

class _CardBack extends StatelessWidget {
  const _CardBack({required this.skill, required this.counter});

  final Skill skill;
  final String counter;

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      accent: skill.color,
      active: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(counter, style: monoStyle(size: 11)),
              const Spacer(),
              _AccentDot(skill.color),
            ],
          ),
          const SizedBox(height: 20),
          Text(skill.title, style: displayStyle(24)),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    skill.description,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.55,
                      color: Color(0xFFCFCFCF),
                    ),
                  ).animate().fadeIn(duration: 350.ms, delay: 100.ms),
                  const SizedBox(height: 22),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final h in skill.highlights)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: AppColors.line),
                            color: Colors.white.withValues(alpha: 0.03),
                          ),
                          child: Text(h,
                              style:
                                  monoStyle(size: 11, color: AppColors.text)),
                        ),
                    ]
                        .animate(interval: 60.ms, delay: 200.ms)
                        .fadeIn(duration: 300.ms)
                        .slideY(begin: 0.4, curve: Curves.easeOutCubic),
                  ),
                ],
              ),
            ),
          ),
          Text('TAP TO FLIP BACK ↺', style: monoStyle(size: 10)),
        ],
      ),
    );
  }
}
