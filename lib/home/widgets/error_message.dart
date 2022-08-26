import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/home/bloc/home_bloc.dart';
import 'package:password_manager/l10n/l10n.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.errorOccurredMessage),
          TextButton(
            onPressed: () => _handleRetryButtonPress(context),
            child: Text(l10n.retryButtonLabel),
          ),
        ],
      ),
    );
  }

  void _handleRetryButtonPress(BuildContext context) {
    context.read<HomeBloc>().add(const HomeSubscriptionRequested());
  }
}
