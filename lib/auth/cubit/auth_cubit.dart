import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/auth_repository.dart';
import '../models/auth_models.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final request = LoginRequest(email: email.trim(), passwordHash: password.trim());
      final response = await _authRepository.login(request);

      if (response.isSuccess) {
        emit(AuthSuccess(response));
      } else {
        emit(AuthFailure(response.message));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String university,
    required String major,
  }) async {
    emit(AuthLoading());
    try {
      final request = RegisterRequest(
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        email: email.trim(),
        passwordHash: password.trim(), // Maps exactly to the requested payload
        university: university.trim(),
        major: major.trim(),
      );
      
      final response = await _authRepository.register(request);

      if (response.isSuccess) {
         emit(AuthSuccess(response));
      } else {
         emit(AuthFailure(response.message));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(AuthInitial());
  }
}
