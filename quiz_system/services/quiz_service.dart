
import 'dart:io';
import '../models/answer.dart';
import '../models/question.dart'; // Import the Question class

class QuizService {
  void quizSession(String studentName, String studentID) {
    // Read questions from the Q&A.txt file
    List<Question> questions = [];
    for (var line in File('data/Q&A.txt').readAsLinesSync()) {
      var parts = line.split('|');
      if (parts.length != 5) continue; // Skip malformed lines

      questions.add(Question(
        text: parts[0],
        isSingleChoice: parts[1].trim() == 'yes',
        correctAnswers: parts[2].split(',').map((a) => a.trim()).toList(),
        wrongAnswers: parts[3].split(',').map((wa) => wa.trim()).toList(),
        wrongMeanings: parts[4].split(',').map((wm) => wm.trim()).toList(),
      ));
    }

    int totalCorrectAnswers = 0;  // Track total possible correct answers
    int studentInputCorrectAnswers = 0;  // Track how many answers the student input correctly
    List<String> results = [];  // Store individual results for each question.

    for (var question in questions) {
      print('\nQuestion: ${question.text}');
      Answer answer = Answer(question.correctAnswers, question.wrongAnswers, question.wrongMeanings);
      answer.displayChoices();

      String firstAttempt = "No Answer";
      String secondAttempt = "Deactivate";
      int questionScore = 0;

      // Handle single-choice questions
      if (question.isSingleChoice) {
        print('You have 2 attempts. Please choose one correct answer:');
        firstAttempt = stdin.readLineSync()!.trim();
        questionScore = answer.checkSingleChoiceAnswer(firstAttempt);

        if (questionScore == -1) {
          print('Incorrect. You have one more attempt.');
          answer.displayWrongMeaning(firstAttempt);
          secondAttempt = stdin.readLineSync()!.trim();
          questionScore = answer.checkSingleChoiceAnswer(secondAttempt);
        }
      } else {  // Multiple choice questions
        print('Please choose multiple correct answers (comma-separated):');
        String studentAnswer = stdin.readLineSync()!.trim();
        List<String> selectedAnswers = studentAnswer.split(',').map((a) => a.trim()).toList();
        questionScore = answer.checkMultipleChoiceAnswers(selectedAnswers);
        
        firstAttempt = studentAnswer; // Store the first attempt
      }

      // Count how many correct answers the student inputted
      if (questionScore == question.correctAnswers.length) {
        studentInputCorrectAnswers += questionScore; // Increment by the score received
        print('Correct!'); // Indicate correct answer
      }

      // Add the total number of correct answers for this question to totalCorrectAnswers
      totalCorrectAnswers += question.correctAnswers.length;

      results.add('Question: ${question.text}\nFirst Attempt: $firstAttempt\nSecond Attempt: $secondAttempt\nScore: $questionScore\n');
    }

    // Calculate percentage
    double percentage = (totalCorrectAnswers > 0) ? (studentInputCorrectAnswers / totalCorrectAnswers) * 100 : 0;

    // Display total score as correct/total correct answers
    print('\nTotal Correct Answers Inputted: $studentInputCorrectAnswers / $totalCorrectAnswers');
    print('Percentage: ${percentage.toStringAsFixed(2)}%');

    // Save results to file
    String resultFileName = 'student_records/${studentID}.txt'; // Corrected path to student records
    File(resultFileName).writeAsStringSync(
      'Results for $studentName\n'
      '---------------------------\n'
      '${results.join("\n")}'
      '---------------------------\n'
      'Total Correct Answers Inputted: $studentInputCorrectAnswers / $totalCorrectAnswers\n'
      'Percentage: ${percentage.toStringAsFixed(2)}%\n',
      mode: FileMode.append);
    print('Results saved for $studentName.');
  } 
}
