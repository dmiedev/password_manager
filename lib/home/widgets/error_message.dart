import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/home/bloc/home_bloc.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('An error occurred'),
          TextButton(
            onPressed: () => _handlePress(context),
            child: const Text('RETRY'),
          ),
        ],
      ),
    );
  }

  void _handlePress(BuildContext context) {
    context.read<HomeBloc>().add(const HomeSubscriptionRequested());
  }
}
