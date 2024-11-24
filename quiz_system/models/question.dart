
class Question {
  String text;
  bool isSingleChoice;
  List<String> correctAnswers;
  List<String> wrongAnswers;
  List<String> wrongMeanings;

  Question({
    required this.text,
    required this.isSingleChoice,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.wrongMeanings,
  });
}
