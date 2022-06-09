class Lessons {
  int id;
  String title;
  String content;

  Lessons({
    required this.id,
    required this.title,
    required this.content,
  });

  factory Lessons.fromJson(Map<String, dynamic> json) {
    return Lessons(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }
}
