class Quiz {
  int id;
  String question;
  int correct;
  List<String> options;

  Quiz({
    required this.id,
    required this.question,
    required this.correct,
    required this.options,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      question: json['question'],
      correct: json['correct'],
      options: json['options'].cast<String>(),
    );
  }
}
