import 'dart:async';
import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import '../models/skill.dart';
import 'skill_card.dart';

/// Infinite 3D "coverflow" carousel.
///
/// - drag / swipe (touch, mouse, trackpad)
/// - arrow buttons + keyboard ← →
/// - tap side card to bring it to center, tap center card to flip it
/// - autoplay, paused on hover, while dragging, and while a card is flipped
class SkillCarousel extends StatefulWidget {
  const SkillCarousel({
    super.key,
    required this.skills,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.onActiveChanged,
  });

  final List<Skill> skills;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final ValueChanged<Skill>? onActiveChanged;

  @override
  State<SkillCarousel> createState() => _SkillCarouselState();
}

class _SkillCarouselState extends State<SkillCarousel> {
  static const _maxCardWidth = 340.0;
  static const _maxCardHeight = 460.0;
  static const _slideDuration = Duration(milliseconds: 650);

  PageController? _controller;
  double _fraction = 0;
  late double _page;
  int _activeIndex = 0;
  Timer? _timer;
  bool _hovering = false;
  bool _flipped = false;

  int get _count => widget.skills.length;

  @override
  void initState() {
    super.initState();
    // Start far from 0 so the user can scroll left "infinitely".
    _page = (_count * 1000).toDouble();
    _startAutoPlay();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _count > 0) widget.onActiveChanged?.call(widget.skills[0]);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Recreate the controller when the screen size bucket changes so the
    // number of visible side cards adapts (mobile / tablet / desktop).
    final fraction = _fractionFor(MediaQuery.sizeOf(context).width);
    if (fraction == _fraction) return;
    _fraction = fraction;
    final old = _controller;
    _controller = PageController(
      viewportFraction: fraction,
      initialPage: _page.round(),
    )..addListener(_onScroll);
    if (old != null) {
      old.removeListener(_onScroll);
      WidgetsBinding.instance.addPostFrameCallback((_) => old.dispose());
    }
  }

  double _fractionFor(double width) {
    if (width < 600) return 0.78;
    if (width < 1000) return 0.45;
    return 0.30;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.removeListener(_onScroll);
    _controller?.dispose();
    super.dispose();
  }

  void _onScroll() {
    final c = _controller;
    if (c == null || !c.hasClients || !c.position.haveDimensions) return;
    final page = c.page ?? _page;
    setState(() => _page = page);
    final index = page.round() % _count;
    if (index != _activeIndex) {
      _activeIndex = index;
      widget.onActiveChanged?.call(widget.skills[index]);
    }
  }

  // --- Autoplay -------------------------------------------------------------

  void _startAutoPlay() {
    _timer?.cancel();
    if (!widget.autoPlay || _count < 2) return;
    _timer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (_hovering || _flipped) return;
      _animateBy(1);
    });
  }

  void _stopAutoPlay() => _timer?.cancel();

  // --- Navigation -----------------------------------------------------------

  void _animateTo(int page) {
    final c = _controller;
    if (c == null || !c.hasClients) return;
    c.animateToPage(page, duration: _slideDuration, curve: Curves.easeOutCubic);
  }

  void _animateBy(int delta) => _animateTo(_page.round() + delta);

  /// User-triggered navigation: also resets the autoplay countdown.
  void _userGo(int delta) {
    _animateBy(delta);
    _startAutoPlay();
  }

  void _jumpToSkill(int realIndex) {
    _animateTo(_page.round() - _activeIndex + realIndex);
    _startAutoPlay();
  }

  // --- Build ----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    if (_count == 0) {
      return const Center(
          child: Text('Add your skills in lib/data/skills.dart'));
    }

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () => _userGo(-1),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () => _userGo(1),
      },
      child: Focus(
        autofocus: true,
        child: Column(
          children: [
            Expanded(
              child: MouseRegion(
                onEnter: (_) => _hovering = true,
                onExit: (_) => _hovering = false,
                child: Listener(
                  onPointerDown: (_) => _stopAutoPlay(),
                  onPointerUp: (_) => _startAutoPlay(),
                  onPointerCancel: (_) => _startAutoPlay(),
                  child: PageView.builder(
                    controller: _controller,
                    clipBehavior: Clip.none,
                    itemBuilder: (context, index) => _buildItem(index),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.outlined(
                    style: IconButton.styleFrom(
                      side: const BorderSide(color: Color(0x1FFFFFFF)),
                      foregroundColor: Colors.white,
                    ),
                    tooltip: 'Previous',
                    onPressed: () => _userGo(-1),
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: _PageDots(
                      count: _count,
                      active: _activeIndex,
                      colors: [for (final s in widget.skills) s.color],
                      onTap: _jumpToSkill,
                    ),
                  ),
                  const SizedBox(width: 16),
                  IconButton.outlined(
                    style: IconButton.styleFrom(
                      side: const BorderSide(color: Color(0x1FFFFFFF)),
                      foregroundColor: Colors.white,
                    ),
                    tooltip: 'Next',
                    onPressed: () => _userGo(1),
                    icon: const Icon(Icons.chevron_right_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    final skill = widget.skills[index % _count];

    // delta: 0 = centered, -1 = one slot left, +1 = one slot right…
    final delta = index - _page;
    final distance = delta.abs();
    final t = distance.clamp(0.0, 1.0);

    final scale = 1 - 0.18 * t;
    final rotation = (-delta).clamp(-1.0, 1.0) * 0.45; // radians
    final opacity = (1 - 0.5 * distance).clamp(0.0, 1.0);
    final isActive = distance < 0.5;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = math.min(constraints.maxWidth - 16, _maxCardWidth);
        final height = math.min(constraints.maxHeight, _maxCardHeight);

        return Center(
          child: Opacity(
            opacity: opacity,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateY(rotation),
              child: Transform.scale(
                scale: scale,
                child: SizedBox(
                  width: width,
                  height: height,
                  child: SkillCard(
                    skill: skill,
                    index: index % _count,
                    total: _count,
                    isActive: isActive,
                    onTapInactive: () {
                      _animateTo(index);
                      _startAutoPlay();
                    },
                    onFlipChanged: (flipped) {
                      if (isActive) _flipped = flipped;
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({
    required this.count,
    required this.active,
    required this.colors,
    required this.onTap,
  });

  final int count;
  final int active;
  final List<Color> colors;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 6,
      children: [
        for (var i = 0; i < count; i++)
          GestureDetector(
            onTap: () => onTap(i),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                width: i == active ? 28 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: i == active
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
