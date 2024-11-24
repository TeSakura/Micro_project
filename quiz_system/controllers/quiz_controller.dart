

import 'dart:io';
import 'dart:math'; // Added import
import '../models/participant.dart'; // Import the Participant class
import '../services/quiz_service.dart';

class QuizController {
  void startQuiz() {
    print('Enter your first name:');
    String firstName = stdin.readLineSync()!.toLowerCase();
    print('Enter your last name:');
    String lastName = stdin.readLineSync()!.toLowerCase();

    // Generate a random ID
    String studentID = generateRandomID();
    print('Your student ID: $studentID');

    // Create a Participant instance
    Participant participant = Participant(firstName: firstName, lastName: lastName, studentID: studentID);

    // Start the quiz
    QuizService().quizSession(participant.fullName, participant.studentID);
  }

  String generateRandomID() {
    var rng = Random();
    return 'ID${rng.nextInt(10000)}'; // Generates a random ID like ID1234
  }
}
