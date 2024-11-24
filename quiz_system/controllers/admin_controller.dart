

import 'dart:io';
import '../services/quiz_service.dart';

class AdminController {
  void showMenu() { // Updated method name
    while (true) {
      print('\nAdmin Menu:');
      print('1. Add Question');
      print('2. Exit');

      String choice = stdin.readLineSync()!;
      if (choice == '1') {
        addQuestion();
      } else if (choice == '2') {
        break;
      } else {
        print('Invalid choice. Try again.');
      }
    }
  }

  void addQuestion() {
    print('Enter question:');
    String question = stdin.readLineSync()!;
    print('Is this a single choice question? (yes/no):');
    String isSingleChoice = stdin.readLineSync()!.toLowerCase();
    print('Enter correct answer(s) (comma-separated):');
    String correctAnswer = stdin.readLineSync()!;
    print('Enter wrong answer(s) (comma-separated):');
    String wrongAnswers = stdin.readLineSync()!;
    print('Enter meanings of wrong answers (comma-separated):');
    String wrongMeanings = stdin.readLineSync()!;

    String entry = '$question|$isSingleChoice|$correctAnswer|$wrongAnswers|$wrongMeanings\n';
    File('data/Q&A.txt').writeAsStringSync(entry, mode: FileMode.append);
    print('Question added successfully.');
  }
}
