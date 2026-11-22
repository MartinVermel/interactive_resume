import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/profile.dart';
import '../theme.dart';

/// "Let's talk." block + footer.
class ContactFooter extends StatelessWidget {
  const ContactFooter({super.key, required this.nav});

  /// (label, onTap) — same entries as the top nav.
  final List<(String, VoidCallback)> nav;

  @override
  Widget build(BuildContext context) {
    final pad = pagePadding(context);
    final wide = isWide(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: pad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                const TextSpan(
                  text: "Let's talk",
                  children: [
                    TextSpan(
                      text: '.',
                      style: TextStyle(color: AppColors.accentText),
                    ),
                  ],
                ),
                style: displayStyle(wide ? 96 : 56),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Text(
                  Profile.contactPitch,
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.45,
                    color: AppColors.muted,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const _EmailRow(),
              const SizedBox(height: 20),
              Wrap(
                spacing: 20,
                runSpacing: 8,
                children: [
                  for (final (label, url) in Profile.links)
                    _LinkText(label: label, url: url),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 96),
        Container(height: 1, color: AppColors.line),
        const SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: pad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 64,
                runSpacing: 28,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${Profile.firstName}.',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text(Profile.title,
                          style: const TextStyle(color: AppColors.muted)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EXPLORE', style: monoStyle(size: 10)),
                      const SizedBox(height: 10),
                      for (final (label, onTap) in nav)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: _HoverText(label: label, onTap: onTap),
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('GET IN TOUCH', style: monoStyle(size: 10)),
                      const SizedBox(height: 10),
                      _HoverText(
                        label: '${Profile.email} ↗',
                        onTap: () => _open('mailto:${Profile.email}'),
                      ),
                      const SizedBox(height: 6),
                      Text('© ${Profile.year} ${Profile.name}',
                          style: monoStyle(size: 11)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Text(
                Profile.footerLine,
                style: displayStyle(wide ? 40 : 28),
              ),
            ],
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}

Future<void> _open(String url) =>
    launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');

class _EmailRow extends StatelessWidget {
  const _EmailRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 8,
      children: [
        _HoverText(
          label: '${Profile.email} ↗',
          onTap: () => _open('mailto:${Profile.email}'),
          size: 20,
          strong: true,
        ),
        IconButton.outlined(
          tooltip: 'Copy email',
          onPressed: () {
            Clipboard.setData(const ClipboardData(text: Profile.email));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                width: 220,
                backgroundColor: AppColors.surfaceHi,
                content: Text('Email copied',
                    style: monoStyle(color: AppColors.text)),
              ),
            );
          },
          style: IconButton.styleFrom(
            side: const BorderSide(color: AppColors.line),
            foregroundColor: AppColors.muted,
          ),
          icon: const Icon(Icons.copy_rounded, size: 16),
        ),
      ],
    );
  }
}

class _LinkText extends StatelessWidget {
  const _LinkText({required this.label, required this.url});

  final String label;
  final String url;

  @override
  Widget build(BuildContext context) =>
      _HoverText(label: '$label ↗', onTap: () => _open(url), mono: true);
}

/// Text that turns white + underlines on hover.
class _HoverText extends StatefulWidget {
  const _HoverText({
    required this.label,
    required this.onTap,
    this.size = 14,
    this.strong = false,
    this.mono = false,
  });

  final String label;
  final VoidCallback onTap;
  final double size;
  final bool strong;
  final bool mono;

  @override
  State<_HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<_HoverText> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final color = _hover
        ? AppColors.accentText
        : (widget.strong ? AppColors.text : AppColors.muted);
    final base = widget.mono
        ? monoStyle(size: widget.size - 2, color: color)
        : TextStyle(
            fontFamily: AppFonts.display,
            fontSize: widget.size,
            color: color,
            fontWeight: widget.strong ? FontWeight.w500 : FontWeight.w400,
          );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: base.copyWith(
            decoration: _hover ? TextDecoration.underline : null,
            decorationColor: AppColors.accentText,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
