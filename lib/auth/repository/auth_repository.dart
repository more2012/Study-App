import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_models.dart';
import '../../services/storage_service.dart';

class AuthRepository {
  static const String baseUrl = 'https://3ef9f804-7851-45b9-a6ab-3eeeeb3d02ad.mock.pstmn.io';

  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      ).timeout(const Duration(seconds: 30));

      final responseJson = json.decode(response.body);
      final authResponse = AuthResponse.fromJson(responseJson);

      if (authResponse.isSuccess && authResponse.data != null) {
        // Mock token saving logic (Adapt based on actual mock response data)
        if (authResponse.data!['token'] != null) {
            await StorageService.setString('auth_token', authResponse.data!['token']);
        }
      }

      return authResponse;
    } catch (e) {
      return AuthResponse(status: 'error', message: 'Network error: $e');
    }
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      ).timeout(const Duration(seconds: 30));

      final responseJson = json.decode(response.body);
      final authResponse = AuthResponse.fromJson(responseJson);
      
      if (authResponse.isSuccess && authResponse.data != null) {
        // Mock token saving
        if (authResponse.data!['token'] != null) {
            await StorageService.setString('auth_token', authResponse.data!['token']);
        }
      }

      return authResponse;
    } catch (e) {
      return AuthResponse(status: 'error', message: 'Network error: $e');
    }
  }

  Future<void> logout() async {
    await StorageService.remove('auth_token');
    await StorageService.remove('refresh_token');
    await StorageService.remove('user_data');
  }

  Future<bool> isLoggedIn() async {
    final token = await StorageService.getString('auth_token');
    return token != null && token.isNotEmpty;
  }
}
