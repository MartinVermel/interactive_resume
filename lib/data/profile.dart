class Profile {
  static const firstName = 'Martin';
  static const name = 'Martin Vermel';
  static const title = 'Flutter Developer';

  // --- Intro (giant title at the top) ---------------------------------------
  static const introLines = ['FLUTTER', 'DEVELOPER'];
  static const introTag = 'MOBILE & WEB DEVELOPMENT';

  // --- Hero -----------------------------------------------------------------
  static const greeting = "Hi, I'm";

  /// Wrap words in **double stars** to make them bold/white.
  static const tagline =
      'I build **smooth, animated apps** with Flutter for **iOS, Android '
      'and the web**, from first sketch to store release.';

  static const currentlyLabel = 'CURRENTLY';
  static const currentlyLine1 = 'Epitech';
  static const currentlyLine2 = 'Starbourg';

  /// Drop your pictures in assets/images/ with these names (or change paths).
  /// They are shown in black & white, in color on hover.
  static const heroImage = 'assets/images/hero_main.jpg'; // big, right
  static const heroSmallImage =
      'assets/images/hero_small.jpg'; // small, bottom-left

  // --- Contact / footer -----------------------------------------------------
  static const email = 'martin.vermel@gmail.com';
  static const contactPitch =
      "Whether it's a full-time role or a freelance project, my inbox is open.";

  /// (label, url)
  static const links = <(String, String)>[
    ('LinkedIn', 'https://linkedin.com/in/you'),
    ('GitHub', 'https://github.com/'),
  ];

  static const footerLine = 'See you around.';
}
