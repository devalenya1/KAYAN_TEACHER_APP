class Holiday {
  Holiday({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
  });
  late final int id;
  late final String date;
  late final String title;
  late final String description;

  Holiday.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    date = json['date'] ?? "";
    title = json['title'] ?? "";
    description = json['description'] ?? "";
  }
}
