
class Answer {
  List<String> correctAnswers;
  List<String> wrongAnswers;
  List<String> wrongMeanings;  

  Answer(this.correctAnswers, this.wrongAnswers, this.wrongMeanings);

  void displayChoices() {
    List<String> allAnswers = correctAnswers + wrongAnswers;
    allAnswers.shuffle();
    print('Choices: ${allAnswers.join(', ')}');
  }

  int checkSingleChoiceAnswer(String answer) {
    if (correctAnswers.contains(answer)) {
      return 2; // 2 marks for the first correct attempt
    } else if (wrongAnswers.contains(answer)) {
      return -1; // -1 mark for the first incorrect attempt
    } else {
      return 0;
    }
  }

  int checkMultipleChoiceAnswers(List<String> selectedAnswers) {
    int correctCount = 0;

    for (var selected in selectedAnswers) {
      if (correctAnswers.contains(selected)) {
        correctCount++;
      } else if (wrongAnswers.contains(selected)) {
        displayWrongMeaning(selected);
      }
    }

    // Return score based on number of correct answers (max 3)
    return correctCount > 3 ? 3 : correctCount;
  }

  void displayWrongMeaning(String studentAnswer) {
    int index = wrongAnswers.indexOf(studentAnswer);
    if (index != -1) {
      print('Wrong! Explain: ${wrongMeanings[index]}');
    }
  }
}
