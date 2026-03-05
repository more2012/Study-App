class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String university;
  final String major;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.university,
    required this.major,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      university: json['university'] ?? '',
      major: json['major'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'university': university,
      'major': major,
    };
  }
}
