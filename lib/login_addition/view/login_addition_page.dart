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

class _LoginAdditionView extends StatefulWidget {
  const _LoginAdditionView();

  @override
  State<_LoginAdditionView> createState() => _LoginAdditionViewState();
}

class _LoginAdditionViewState extends State<_LoginAdditionView> {
  final _formKey = GlobalKey<FormState>();
  final _serviceNameFieldController = TextEditingController();
  final _userNameFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Login'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<LoginAdditionBloc, LoginAdditionState>(
            listener: (context, state) => _handleSaveSuccess(),
            listenWhen: (previous, current) {
              return current is LoginAdditionSaveSuccess;
            },
          ),
          BlocListener<LoginAdditionBloc, LoginAdditionState>(
            listener: (context, state) => _handleSaveFailure(),
            listenWhen: (previous, current) {
              return current is LoginAdditionSaveFailure;
            },
          ),
        ],
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(children: _buildFields()),
            ),
            const SizedBox(height: 30),
            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFields() {
    final isSaving =
        context.watch<LoginAdditionBloc>().state is LoginAdditionSaveInProgress;
    return [
      TextFormField(
        enabled: !isSaving,
        controller: _serviceNameFieldController,
        validator: _validateField,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.business),
          labelText: 'Service Name',
        ),
      ),
      TextFormField(
        enabled: !isSaving,
        controller: _userNameFieldController,
        validator: _validateField,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          labelText: 'User Name',
        ),
      ),
      TextFormField(
        enabled: !isSaving,
        obscureText: true,
        enableSuggestions: false,
        controller: _passwordFieldController,
        validator: _validateField,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.password),
          labelText: 'Password',
        ),
      ),
    ];
  }

  Widget _buildAddButton() {
    return Column(
      children: [
        SizedBox(
          width: 150,
          child: BlocBuilder<LoginAdditionBloc, LoginAdditionState>(
            builder: (context, state) {
              if (state is LoginAdditionSaveInProgress) {
                return FloatingActionButton.extended(
                  onPressed: () {},
                  backgroundColor: Colors.grey,
                  icon: const CircularProgressIndicator(),
                  label: const Text('Saving...'),
                );
              }
              return FloatingActionButton.extended(
                onPressed: _handleAddButtonPress,
                icon: const Icon(Icons.add),
                label: const Text('Add Login'),
              );
            },
          ),
        ),
      ],
    );
  }

  String? _validateField(String? value) {
    if (value != null && value.isNotEmpty) {
      return null;
    }
    return 'Incorrect value!';
  }

  void _handleAddButtonPress() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<LoginAdditionBloc>().add(
          LoginAdditionCompleted(
            serviceName: _serviceNameFieldController.text,
            userName: _userNameFieldController.text,
            password: _passwordFieldController.text,
          ),
        );
  }

  void _handleSaveSuccess() {
    Navigator.pop(context);
  }

  void _handleSaveFailure() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Failed to save login!')),
      );
  }

  @override
  void dispose() {
    _serviceNameFieldController.dispose();
    _userNameFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }
}
