import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/auth/bloc/auth_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const _AuthView(),
    );
  }
}

class _AuthView extends StatelessWidget {
  const _AuthView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Password Manager is locked! 🔒',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _handleAuthenticateButtonPress,
              child: const Text('AUTHENTICATE'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAuthenticateButtonPress() {}
}
