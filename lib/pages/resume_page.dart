import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_ui/material_ui.dart';

import '../data/projects.dart';
import '../data/skills.dart';
import '../models/skill.dart';
import '../theme.dart';
import '../widgets/contact_footer.dart';
import '../widgets/hero_section.dart';
import '../widgets/intro_section.dart';
import '../widgets/project_list.dart';
import '../widgets/skill_carousel.dart';
import '../widgets/top_nav.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  final _topKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();
  Color _accent = skills.isNotEmpty ? skills.first.color : Colors.white;

  void _onActiveChanged(Skill skill) {
    if (skill.color != _accent) setState(() => _accent = skill.color);
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
    );
  }

  List<(String, VoidCallback)> get _nav => [
        ('About', () => _scrollTo(_aboutKey)),
        ('Skills', () => _scrollTo(_skillsKey)),
        ('Projects', () => _scrollTo(_projectsKey)),
        ('Contact', () => _scrollTo(_contactKey)),
      ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final pad = pagePadding(context);
    final wide = isWide(context);
    final carouselHeight = (size.height * 0.72).clamp(520.0, 620.0);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Stack(
        children: [
          // Page stays black; only a soft glow of the active card color.
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0.9, 1.1),
                  radius: 1.4,
                  stops: const [0, 0.5, 1],
                  colors: [
                    _accent.withValues(alpha: 0.07),
                    _accent.withValues(alpha: 0.025),
                    _accent.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IntroSection(key: _topKey),
                // --- Hero ---------------------------------------------------
                Center(
                  key: _aboutKey,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 1280,
                      minHeight: wide ? size.height * 0.9 : 0,
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(pad, 96, pad, 96),
                      child: Center(
                        child: HeroSection(
                          onCtaPressed: () => _scrollTo(_skillsKey),
                        ),
                      ),
                    ),
                  ),
                ),
                // --- Skills -------------------------------------------------
                Padding(
                  key: _skillsKey,
                  padding: EdgeInsets.fromLTRB(pad, 64, pad, 40),
                  child: _SectionHeader(
                    title: 'Skills',
                    count: skills.length,
                  ),
                ),
                SizedBox(
                  height: carouselHeight,
                  child: SkillCarousel(
                    skills: skills,
                    onActiveChanged: _onActiveChanged,
                  ),
                ),
                // --- Projects -----------------------------------------------
                Padding(
                  key: _projectsKey,
                  padding: EdgeInsets.fromLTRB(pad, 160, pad, 40),
                  child: _SectionHeader(
                    title: 'Flutter Projects',
                    count: projects.length,
                    hint: 'Open source on GitHub. Click a row to open it.',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: pad),
                  child: ProjectList(projects: projects),
                ),
                const SizedBox(height: 160),
                // --- Contact + footer ---------------------------------------
                ContactFooter(key: _contactKey, nav: _nav),
              ],
            ),
          ),
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Center(
                child: TopNav(items: _nav, onTop: () => _scrollTo(_topKey)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.count,
    this.hint,
  });

  final String title;
  final int count;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final wide = isWide(context);
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.end,
      runSpacing: 12,
      spacing: 24,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: displayStyle(wide ? 72 : 48)),
            const SizedBox(width: 10),
            Text('(${count.toString().padLeft(2, '0')})',
                style: monoStyle(size: 14)),
          ],
        ),
        if (hint != null) Text(hint!, style: monoStyle(size: 11)),
      ],
    ).animate().fadeIn(duration: 600.ms);
  }
}
