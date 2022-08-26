import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class ScreenLockDialog extends StatelessWidget {
  const ScreenLockDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('No screen lock set'),
      content: const Text('Password Manager requires a screen lock to be set.'),
      actions: [
        TextButton(
          onPressed: () => _handleCancelButtonPress(context),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () => _handleGoToSettingsButtonPress(context),
          child: const Text('GO TO SETTINGS'),
        ),
      ],
    );
  }

  void _handleGoToSettingsButtonPress(BuildContext context) {
    AppSettings.openLockAndPasswordSettings();
    Navigator.pop(context);
  }

  void _handleCancelButtonPress(BuildContext context) {
    Navigator.pop(context);
  }
}
