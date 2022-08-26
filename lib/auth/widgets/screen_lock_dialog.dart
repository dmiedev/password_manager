import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:password_manager/l10n/l10n.dart';

class ScreenLockDialog extends StatelessWidget {
  const ScreenLockDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.screenLockDialogTitle),
      content: Text(l10n.screenLockDialogBody),
      actions: [
        TextButton(
          onPressed: () => _handleCancelButtonPress(context),
          child: Text(l10n.cancelButtonLabel),
        ),
        TextButton(
          onPressed: () => _handleGoToSettingsButtonPress(context),
          child: Text(l10n.goToSettingsButtonLabel),
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
