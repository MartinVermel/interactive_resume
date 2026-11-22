/// One entry of the projects list.
class Project {
  const Project({
    required this.title,
    required this.description,
    required this.url,
    this.tags = const [],
  });

  /// Project name (e.g. "Habit Tracker").
  final String title;

  /// One or two lines about what it does.
  final String description;

  /// Link opened on tap (GitHub repo, store page…).
  final String url;

  /// Small tech tags shown under the description.
  final List<String> tags;
}
