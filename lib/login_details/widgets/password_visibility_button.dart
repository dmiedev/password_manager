import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/l10n/l10n.dart';
import 'package:password_manager/login_details/bloc/login_details_bloc.dart';

class PasswordVisibilityButton extends StatelessWidget {
  const PasswordVisibilityButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginDetailsBloc, LoginDetailsState>(
      buildWhen: (previous, current) {
        return previous.passwordIsVisible != current.passwordIsVisible;
      },
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            state.passwordIsVisible ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () => _handlePress(context),
        );
      },
    );
  }

  void _handlePress(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    context.read<LoginDetailsBloc>().add(
          LoginDetailsPasswordVisibilitySwitched(
            dialogMessage: l10n.passwordAuthenticationDialogTitle,
          ),
        );
  }
}
