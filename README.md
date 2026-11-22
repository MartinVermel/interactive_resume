# Interactive Resume (Flutter)

Animated, interactive resume with a 3D skills carousel.

## Edit your content

| What | File |
|------|------|
| Name, title, tagline, contacts | `lib/data/profile.dart` |
| Skill cards (add / remove / reorder) | `lib/data/skills.dart` |
| Projects list (title, description, link, tags) | `lib/data/projects.dart` |

Each skill: `title`, `subtitle`, `icon`, `color`, `level` (0–1), `description` (card back), `highlights` (tags on card back).

## First run

```sh
# 1. Install Flutter: https://docs.flutter.dev/get-started/install
# 2. Generate platform folders (keeps existing lib/ and test/ files)
flutter create . --project-name interactive_resume --platforms=web,android,ios,macos
# 3. Run
flutter pub get
flutter run -d chrome
```

## Carousel features

- Infinite 3D coverflow (custom `PageView` + `Transform`)
- Drag/swipe (touch, mouse, trackpad), arrow buttons, keyboard ← →
- Tap side card → centers it; tap center card → 3D flip to details
- Autoplay (4s), paused on hover / drag / flipped card
- Animated proficiency bar, background tinted by active skill color
- Entrance + staggered animations via [`flutter_animate`](https://pub.dev/packages/flutter_animate)

Tune in `lib/widgets/skill_carousel.dart`: `autoPlay`, `autoPlayInterval`, `_maxCardWidth/Height`, `_fractionFor()` (cards visible per screen size).

## Deploy (share a link in applications)

```sh
flutter build web --release
# upload build/web to GitHub Pages, Firebase Hosting, Netlify, Vercel…
```
For GitHub Pages under a repo path: `flutter build web --base-href /<repo-name>/`.
