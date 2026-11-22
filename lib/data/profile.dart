class Profile {
  static const firstName = 'Martin';
  static const name = 'Martin Vermel';
  static const title = 'FullStack Developer';

  // --- Intro (giant title at the top) ---------------------------------------
  static const introLines = ['FLUTTER', 'DEVELOPER'];
  static const introTag = 'MOBILE & WEB DEVELOPMENT';

  // --- Hero -----------------------------------------------------------------
  static const greeting = "Hi, I'm";

  /// Wrap words in **double stars** to make them bold/white.
  static const tagline =
      'I dev **smooth, animated apps and Websites** with Flutter for **iOS, Android '
      'and the web**, from first sketch to store release.';

  static const currentlyLabel = 'CURRENTLY';
  static const currentlyLine1 = 'Référent Pédagogique at Epitech';
  static const currentlyLine2 = 'Starbourg';

  /// Drop your pictures in assets/images/ with these names (or change paths).
  /// Shown in full color.
  static const heroImage = 'assets/images/hero_main.jpg'; // big, right
  static const heroSmallImage =
      'assets/images/hero_small.jpg'; // small, bottom-left

  // --- Contact / footer -----------------------------------------------------
  static const email = 'martin.vermel@gmail.com';
  static const contactPitch =
      "Whether it's a full-time role or a freelance project, my inbox is open.";

  /// (label, url)
  static const links = <(String, String)>[
    ('LinkedIn', 'https://www.linkedin.com/in/martin-vermel'),
    ('GitHub', 'https://github.com/MartinVermel'),
  ];

  static const footerLine = 'See you around.';

  /// Current year, shown in the footer copyright line.
  static int get year => DateTime.now().year;
}
