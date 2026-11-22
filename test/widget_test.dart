import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

import 'package:interactive_resume/data/profile.dart';
import 'package:interactive_resume/data/skills.dart';
import 'package:interactive_resume/main.dart';

void main() {
  testWidgets('renders header and skill carousel', (tester) async {
    await tester.pumpWidget(const ResumeApp());
    await tester
        .pump(const Duration(seconds: 2)); // let entrance animations run

    expect(find.textContaining(Profile.email), findsWidgets);
    expect(find.text(skills.first.title), findsWidgets);

    // Dispose the tree so autoplay timers are cancelled.
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('wide hero layout renders without errors', (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const ResumeApp());
    await tester.pump(const Duration(seconds: 2));

    expect(find.textContaining(Profile.email), findsWidgets);
    expect(find.text("Let's talk."), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
  });
}
