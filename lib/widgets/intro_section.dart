import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_ui/material_ui.dart';

import '../data/profile.dart';
import '../theme.dart';

/// Giant "< FLUTTER / DEVELOPER />" title over a faint wall of code.
class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final pad = pagePadding(context);
    final wide = isWide(context);
    final lines = Profile.introLines;

    return SizedBox(
      height: (size.height * 0.92).clamp(480.0, 1000.0),
      child: Stack(
        children: [
          // Faint code wall.
          Positioned.fill(
            child: ClipRect(
              child: Text(
                _codeWall,
                overflow: TextOverflow.clip,
                style: monoStyle(
                  size: 11,
                  color: Colors.white.withValues(alpha: 0.045),
                  letterSpacing: 0,
                ).copyWith(height: 1.7),
              ),
            ).animate().fadeIn(duration: 1500.ms),
          ),
          // Fade the code wall out on every edge.
          for (final (begin, end) in const [
            (Alignment.topCenter, Alignment.bottomCenter),
            (Alignment.bottomCenter, Alignment.topCenter),
            (Alignment.centerLeft, Alignment.centerRight),
            (Alignment.centerRight, Alignment.centerLeft),
          ])
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: begin,
                      end: end,
                      stops: const [0, 0.35],
                      colors: [AppColors.bg, AppColors.bg.withValues(alpha: 0)],
                    ),
                  ),
                ),
              ),
            ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.fromLTRB(pad, 96, pad, 32),
              child: Column(
                children: [
                  const Spacer(),
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1100),
                      child: Column(
                        children: [
                          _TitleLine(
                            leading: '<',
                            text: lines.first,
                            alignment: Alignment.centerLeft,
                          )
                              .animate()
                              .fadeIn(duration: 700.ms, delay: 150.ms)
                              .blurXY(begin: 12, end: 0, duration: 700.ms)
                              .slideX(begin: -0.06, curve: Curves.easeOutCubic),
                          if (lines.length > 1)
                            _TitleLine(
                              text: lines.last,
                              trailing: '/>',
                              alignment: Alignment.centerRight,
                            )
                                .animate()
                                .fadeIn(duration: 700.ms, delay: 400.ms)
                                .blurXY(begin: 12, end: 0, duration: 700.ms)
                                .slideX(
                                    begin: 0.06, curve: Curves.easeOutCubic),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Spacer(),
                      if (wide)
                        Column(
                          children: [
                            Text('SCROLL', style: monoStyle(size: 10)),
                            const SizedBox(height: 6),
                            const Icon(Icons.south_rounded,
                                    size: 16, color: AppColors.muted)
                                .animate(onPlay: (c) => c.repeat(reverse: true))
                                .moveY(begin: -3, end: 3, duration: 900.ms),
                          ],
                        ),
                      if (wide) const Spacer(),
                      Flexible(
                        child: Text(
                          '{{ /${Profile.introTag} }}',
                          textAlign: TextAlign.right,
                          style: monoStyle(
                            size: wide ? 13 : 10,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleLine extends StatelessWidget {
  const _TitleLine({
    required this.text,
    required this.alignment,
    this.leading,
    this.trailing,
  });

  final String text;
  final Alignment alignment;
  final String? leading;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    const big = 150.0;
    final symbol = TextStyle(
      fontFamily: AppFonts.display,
      fontSize: big * 0.62,
      fontWeight: FontWeight.w400,
      color: AppColors.muted,
    );

    return Align(
      alignment: alignment,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              Text(leading!, style: symbol),
              const SizedBox(width: 18),
            ],
            Text(text, style: displayStyle(big)),
            if (trailing != null) ...[
              const SizedBox(width: 18),
              Text(trailing!, style: symbol),
              Text('_', style: symbol.copyWith(color: AppColors.text))
                  .animate(onPlay: (c) => c.repeat())
                  .fadeOut(delay: 500.ms, duration: 1.ms)
                  .then(delay: 500.ms)
                  .fadeIn(duration: 1.ms),
            ],
          ],
        ),
      ),
    );
  }
}

final _codeWall = List.filled(12, r'''
class Resume extends StatelessWidget {  const Resume({super.key});  @override  Widget build(BuildContext context) {
  return MaterialApp(theme: ThemeData.dark(), home: const Portfolio());  }  }  final skills = <Skill>[];  void main() => runApp(const Resume());
  Future<void> ship() async { await build(); await test(); await deploy(); }  setState(() => _page = controller.page ?? 0);
  AnimatedBuilder(animation: _flip, builder: (context, child) => Transform(transform: Matrix4.rotationY(_flip.value * pi), child: child));
  StreamBuilder<List<Project>>(stream: repo.watchAll(), builder: (context, snap) => ListView(children: [for (final p in snap.data ?? []) ProjectTile(p)]));
''').join();
