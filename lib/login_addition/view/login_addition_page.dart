import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_repository/login_repository.dart';
import 'package:password_manager/l10n/l10n.dart';
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
      create: (context) => LoginAdditionBloc(
        loginRepository: RepositoryProvider.of<LoginRepository>(context),
      ),
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
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.loginAdditionPageAppBarTitle),
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
    final l10n = AppLocalizations.of(context);
    final isSaving =
        context.watch<LoginAdditionBloc>().state is LoginAdditionSaveInProgress;
    return [
      TextFormField(
        enabled: !isSaving,
        controller: _serviceNameFieldController,
        validator: _validateField,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.business),
          labelText: l10n.serviceNameFieldLabel,
        ),
      ),
      TextFormField(
        enabled: !isSaving,
        controller: _userNameFieldController,
        validator: _validateField,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          labelText: l10n.userNameFieldLabel,
        ),
      ),
      TextFormField(
        obscureText: true,
        enableSuggestions: false,
        enabled: !isSaving,
        controller: _passwordFieldController,
        validator: _validateField,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.password),
          labelText: l10n.passwordFieldLabel,
        ),
      ),
    ];
  }

  Widget _buildAddButton() {
    final l10n = AppLocalizations.of(context);
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
                  label: Text(l10n.savingButtonLabel),
                );
              }
              return FloatingActionButton.extended(
                onPressed: _handleAddButtonPress,
                icon: const Icon(Icons.add),
                label: Text(l10n.addLoginButtonLabel),
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
    final l10n = AppLocalizations.of(context);
    return l10n.incorrectValueFieldErrorMessage;
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
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(l10n.loginSaveFailureMessage)),
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
