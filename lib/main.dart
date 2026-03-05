import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/repository/auth_repository.dart';
import 'auth/cubit/auth_cubit.dart';
import 'auth/screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final authRepository = AuthRepository();
  final isLoggedIn = await authRepository.isLoggedIn();

  runApp(MyApp(
    authRepository: authRepository,
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final bool isLoggedIn;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(authRepository),
        ),
      ],
      child: MaterialApp(
        title: 'study app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.black,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
          useMaterial3: true,
        ),
        home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
      ),
    );
  }
}
