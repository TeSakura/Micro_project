
class Participant {
  String firstName;
  String lastName;
  String studentID;

  Participant({
    required this.firstName,
    required this.lastName,
    required this.studentID,
  });

  String get fullName => '$firstName $lastName';
}
