import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:password_manager/home/home.dart';
import 'package:password_manager/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _theme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
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
