import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login_repository/login_repository.dart';
import 'package:password_manager/auth/auth.dart';
import 'package:password_manager/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.loginRepository,
    required this.authRepository,
  });

  final LoginRepository loginRepository;
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: loginRepository),
        RepositoryProvider.value(value: authRepository),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _theme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const AuthPage(),
      title: 'Password Manager',
    );
  }

  ThemeData get _theme {
    const color = Color(0xFF13B9FF);
    return ThemeData(
      appBarTheme: const AppBarTheme(color: color),
      colorScheme: ColorScheme.fromSwatch(accentColor: color),
    );
  }
}
