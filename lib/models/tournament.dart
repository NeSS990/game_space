class Tournament {
  final int id;
  final String title;

  final String description;

  Tournament({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}
