
import 'dart:io';

class StudentRecordController {
  void showStudentQuizRecord() {
    print('Enter your Student ID:');
    String studentID = stdin.readLineSync()!.trim();
    
    String resultFileName = 'student_records/$studentID.txt';
    if (File(resultFileName).existsSync()) {
      String results = File(resultFileName).readAsStringSync();
      print('\nQuiz Results for Student ID $studentID:');
      print(results);
    } else {
      print('No results found for Student ID $studentID.');
    }
  }
}


