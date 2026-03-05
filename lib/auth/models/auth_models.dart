class LoginRequest {
  final String email;
  final String passwordHash;

  LoginRequest({required this.email, required this.passwordHash});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password_hash': passwordHash};
  }
}

class RegisterRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String passwordHash;
  final String university;
  final String major;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.passwordHash,
    required this.university,
    required this.major,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password_hash': passwordHash,
      'university': university,
      'major': major,
    };
  }
}

class AuthResponse {
  final String status;
  final String message;
  final Map<String, dynamic>? data;

  AuthResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      status: json['status'] ?? 'error',
      message: json['message'] ?? 'Unknown error occurred',
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  bool get isSuccess => status == 'success';
}
