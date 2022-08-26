import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/auth/bloc/auth_bloc.dart';
import 'package:password_manager/auth/widgets/widgets.dart';
import 'package:password_manager/home/home.dart';
import 'package:password_manager/l10n/l10n.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocProvider(
      create: (context) => AuthBloc(
        authRepository: RepositoryProvider.of<AuthRepository>(context),
      )..add(
          AuthRequested(displayMessage: l10n.authenticationDialogTitle),
        ),
      child: const _AuthView(),
    );
  }
}

class _AuthView extends StatelessWidget {
  const _AuthView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: _handleStateChange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.authPageText,
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => _handleAuthenticateButtonPress(context),
                child: Text(l10n.authenticateButtonLabel),
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
    } else if (state.status == AuthStatus.screenLockNotSet) {
      showDialog<void>(
        context: context,
        builder: (context) => const ScreenLockDialog(),
      );
    } else if (state.status == AuthStatus.failure) {
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(l10n.authenticationFailureMessage)),
        );
    }
  }

  void _handleAuthenticateButtonPress(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    context.read<AuthBloc>().add(
          AuthRequested(displayMessage: l10n.authenticationDialogTitle),
        );
  }
}
