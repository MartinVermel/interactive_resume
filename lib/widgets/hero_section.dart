import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_ui/material_ui.dart';

import '../data/profile.dart';
import '../theme.dart';

/// "Hi, I'm Name." on the left, big B&W picture on the right,
/// smaller picture overlapping its bottom-left corner.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key, this.onCtaPressed});

  final VoidCallback? onCtaPressed;

  @override
  Widget build(BuildContext context) {
    final text = _HeroText(onCtaPressed: onCtaPressed);
    const pictures = _HeroPictures();

    if (isWide(context)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 5, child: text),
          const SizedBox(width: 56),
          const Expanded(flex: 6, child: pictures),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [text, const SizedBox(height: 48), pictures],
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText({this.onCtaPressed});

  final VoidCallback? onCtaPressed;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final nameSize = width >= 1200 ? 88.0 : (width >= 600 ? 68.0 : 48.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${Profile.greeting}\n${Profile.firstName}.',
          style: displayStyle(nameSize),
        ),
        const SizedBox(height: 20),
        Text(
          '${Profile.title}.',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: _RichTagline(Profile.tagline),
        ),
        const SizedBox(height: 28),
        Container(height: 1, width: 280, color: AppColors.line),
        const SizedBox(height: 16),
        Text(Profile.currentlyLabel, style: monoStyle(size: 10)),
        const SizedBox(height: 8),
        Text(
          Profile.currentlyLine1,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),
        Text(Profile.currentlyLine2,
            style: const TextStyle(color: AppColors.muted)),
        const SizedBox(height: 32),
        OutlinedButton(
          onPressed: onCtaPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.text,
            side: const BorderSide(color: AppColors.line),
            backgroundColor: AppColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Explore my skills',
                  style: monoStyle(size: 12, color: AppColors.text)),
              const SizedBox(width: 10),
              const Icon(Icons.north_east_rounded, size: 14),
            ],
          ),
        ),
      ]
          .animate(interval: 80.ms)
          .fadeIn(duration: 500.ms)
          .slideY(begin: 0.2, curve: Curves.easeOutCubic),
    );
  }
}

/// Parses **bold** segments: bold = white, rest = muted.
class _RichTagline extends StatelessWidget {
  const _RichTagline(this.source);

  final String source;

  @override
  Widget build(BuildContext context) {
    final parts = source.split('**');
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 18,
          height: 1.45,
          color: AppColors.muted,
        ),
        children: [
          for (var i = 0; i < parts.length; i++)
            TextSpan(
              text: parts[i],
              style: i.isOdd
                  ? const TextStyle(
                      color: AppColors.text,
                      fontWeight: FontWeight.w700,
                    )
                  : null,
            ),
        ],
      ),
    );
  }
}

class _HeroPictures extends StatelessWidget {
  const _HeroPictures();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.05,
      child: LayoutBuilder(
        builder: (context, c) {
          final bigW = c.maxWidth * 0.82;
          final smallW = c.maxWidth * 0.40;
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 0,
                right: 0,
                width: bigW,
                bottom: c.maxHeight * 0.12,
                child: const _Picture(
                  path: Profile.heroImage,
                  radius: 28,
                  label: 'hero_main.jpg',
                )
                    .animate()
                    .fadeIn(duration: 800.ms, delay: 200.ms)
                    .blurXY(begin: 10, end: 0, duration: 800.ms)
                    .scaleXY(begin: 1.04, end: 1, curve: Curves.easeOutCubic),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                width: smallW,
                height: smallW,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: AppColors.bg, width: 8),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 40,
                        offset: Offset(0, 20),
                      ),
                    ],
                  ),
                  child: const _Picture(
                    path: Profile.heroSmallImage,
                    radius: 14,
                    label: 'hero_small.jpg',
                    grayscale: false,
                  ),
                )
                    .animate()
                    .scaleXY(
                      begin: 0.7,
                      duration: 600.ms,
                      delay: 700.ms,
                      curve: Curves.easeOutBack,
                    )
                    .fadeIn(duration: 400.ms, delay: 700.ms)
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(
                      begin: 0,
                      end: -8,
                      duration: 2400.ms,
                      curve: Curves.easeInOutSine,
                    ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Picture that is black & white and fades to color on hover
/// (or always in color when [grayscale] is false).
class _Picture extends StatefulWidget {
  const _Picture({
    required this.path,
    required this.radius,
    required this.label,
    this.grayscale = true,
  });

  final String path;
  final double radius;
  final String label;

  /// When false, the picture always shows in full color.
  final bool grayscale;

  @override
  State<_Picture> createState() => _PictureState();
}

class _PictureState extends State<_Picture> {
  bool _hover = false;

  static List<double> _saturation(double s) {
    const r = 0.2126, g = 0.7152, b = 0.0722;
    final i = 1 - s;
    return [
      r * i + s, g * i, b * i, 0, 0, //
      r * i, g * i + s, b * i, 0, 0, //
      r * i, g * i, b * i + s, 0, 0, //
      0, 0, 0, 1, 0,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: (_hover || !widget.grayscale) ? 1 : 0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
          builder: (context, s, child) => ColorFiltered(
            colorFilter: ColorFilter.matrix(_saturation(s)),
            child: child,
          ),
          child: Image.asset(
            widget.path,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, _, __) => Container(
              color: AppColors.surfaceHi,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.image_outlined,
                      size: 32, color: AppColors.faint),
                  const SizedBox(height: 8),
                  Text(
                    'assets/images/${widget.label}',
                    textAlign: TextAlign.center,
                    style: monoStyle(size: 10, color: AppColors.faint),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
