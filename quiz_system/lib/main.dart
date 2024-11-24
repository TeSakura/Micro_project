
import 'dart:io';
import '../controllers/admin_controller.dart';
import '../controllers/quiz_controller.dart';
import '../controllers/student_record_controller.dart';

void main() {
  while (true) {
    print('Menu:');
    print('1. Admin');
    print('2. Start the Quiz');
    print('3. Show Student Quiz Record');
    print('4. Exit');

    String choice = stdin.readLineSync()!;
    
    if (choice == '1') {
      if (adminLogin()) {
        AdminController().showMenu(); // Updated method name
      } else {
        print('Invalid admin credentials. Returning to main menu.');
      }
    } else if (choice == '2') {
      QuizController().startQuiz(); // Updated method name
    } else if (choice == '3') {
      StudentRecordController().showStudentQuizRecord(); // Updated method name
    } else if (choice == '4') {
      break; // Exit the program
    } else {
      print('Invalid choice. Try again.');
    }
  }
}

bool adminLogin() {
  print('Enter admin username:');
  String username = stdin.readLineSync()!.toLowerCase();
  print('Enter admin password:');
  String password = stdin.readLineSync()!.toLowerCase();

  return username == 'admin' && password == 'admin123';
}
