import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/login_addition/bloc/login_addition_bloc.dart';

class LoginAdditionPage extends StatelessWidget {
  const LoginAdditionPage({super.key});

  static Route<LoginAdditionPage> get route {
    return MaterialPageRoute(
      builder: (context) => const LoginAdditionPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginAdditionBloc(),
      child: const _LoginAdditionView(),
    );
  }
}

class _LoginAdditionView extends StatelessWidget {
  const _LoginAdditionView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Login'),
      ),
      body: ListView(
        children: [
          Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.business),
                    labelText: 'Service Name',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'User Name',
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    labelText: 'Password',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Column(
            children: [
              SizedBox(
                width: 150,
                child: FloatingActionButton.extended(
                  onPressed: _handleAddButtonPress,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Login'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleAddButtonPress() {}
}
