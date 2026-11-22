import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';

import 'pages/resume_page.dart';
import 'theme.dart';

void main() => runApp(const ResumeApp());

class ResumeApp extends StatelessWidget {
  const ResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const _AllDevicesScrollBehavior(),
      theme: buildTheme(),
      home: const ResumePage(),
    );
  }
}

/// Lets the carousel be dragged with a mouse / trackpad on web & desktop.
class _AllDevicesScrollBehavior extends MaterialScrollBehavior {
  const _AllDevicesScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => PointerDeviceKind.values.toSet();
}
