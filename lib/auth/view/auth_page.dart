import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/auth/bloc/auth_bloc.dart';
import 'package:password_manager/home/home.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        authRepository: RepositoryProvider.of<AuthRepository>(context),
      )..add(
          const AuthRequested(
            displayMessage: 'Authenticate to access Password Manager',
          ),
        ),
      child: const _AuthView(),
    );
  }
}

class _AuthView extends StatelessWidget {
  const _AuthView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: _handleStateChange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Password Manager is locked! 🔒',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => _handleAuthenticateButtonPress(context),
                child: const Text('AUTHENTICATE'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleStateChange(BuildContext context, AuthState state) {
    if (state.status == AuthStatus.success) {
      Navigator.pushReplacement(context, HomePage.route);
    } else if (state.status == AuthStatus.failure) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to authenticate!')),
      );
    }
  }

  void _handleAuthenticateButtonPress(BuildContext context) {
    context.read<AuthBloc>().add(
          const AuthRequested(
            displayMessage: 'Authenticate to access Password Manager',
          ),
        );
  }
}
