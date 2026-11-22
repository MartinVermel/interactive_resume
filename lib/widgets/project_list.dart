import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/project.dart';
import '../theme.dart';

/// Editorial list of projects: one hoverable row per project, opens the link.
class ProjectList extends StatelessWidget {
  const ProjectList({super.key, required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(height: 1, color: AppColors.line),
        for (var i = 0; i < projects.length; i++)
          _ProjectRow(index: i, project: projects[i])
              .animate()
              .fadeIn(delay: (120 * i).ms, duration: 500.ms)
              .slideY(begin: 0.15, curve: Curves.easeOutCubic),
      ],
    );
  }
}

class _ProjectRow extends StatefulWidget {
  const _ProjectRow({required this.index, required this.project});

  final int index;
  final Project project;

  @override
  State<_ProjectRow> createState() => _ProjectRowState();
}

class _ProjectRowState extends State<_ProjectRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final wide = isWide(context);
    final p = widget.project;
    final number = (widget.index + 1).toString().padLeft(2, '0');

    final info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          p.description,
          style: const TextStyle(
            fontSize: 15,
            height: 1.5,
            color: AppColors.muted,
          ),
        ),
        if (p.tags.isNotEmpty) ...[
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final t in p.tags) _Tag(t)],
          ),
        ],
      ],
    );

    final title = AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 250),
      style: displayStyle(
        wide ? 44 : 32,
        color: _hover ? AppColors.text : AppColors.text.withValues(alpha: 0.85),
      ),
      child: Text(p.title),
    );

    final arrow = AnimatedRotation(
      duration: const Duration(milliseconds: 250),
      turns: _hover ? 0 : -0.125,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _hover ? AppColors.accent : Colors.transparent,
          border: Border.all(
            color: _hover ? AppColors.accentText : AppColors.line,
          ),
        ),
        child: Icon(
          Icons.arrow_forward_rounded,
          size: 18,
          color: _hover ? AppColors.text : AppColors.muted,
        ),
      ),
    );

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => launchUrl(Uri.parse(p.url), webOnlyWindowName: '_blank'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(
            vertical: 32,
            horizontal: _hover && wide ? 16 : 0,
          ),
          decoration: BoxDecoration(
            color: _hover ? AppColors.surface : Colors.transparent,
            border: const Border(bottom: BorderSide(color: AppColors.line)),
          ),
          child: wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 64,
                      child: Text(
                        number,
                        style: monoStyle(
                          size: 12,
                          color:
                              _hover ? AppColors.accentText : AppColors.muted,
                        ),
                      ),
                    ),
                    Expanded(flex: 5, child: title),
                    const SizedBox(width: 32),
                    Expanded(flex: 6, child: info),
                    const SizedBox(width: 32),
                    arrow,
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          number,
                          style: monoStyle(
                            size: 12,
                            color:
                                _hover ? AppColors.accentText : AppColors.muted,
                          ),
                        ),
                        const Spacer(),
                        arrow,
                      ],
                    ),
                    const SizedBox(height: 12),
                    title,
                    const SizedBox(height: 14),
                    info,
                  ],
                ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.line),
      ),
      child: Text(label, style: monoStyle(size: 11)),
    );
  }
}
