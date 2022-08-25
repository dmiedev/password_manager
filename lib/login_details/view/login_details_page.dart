import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/home/bloc/home_bloc.dart';
import 'package:password_manager/login_details/bloc/login_details_bloc.dart';
import 'package:password_manager/login_details/widgets/widgets.dart';

class LoginDetailsPage extends StatelessWidget {
  const LoginDetailsPage({
    super.key,
    required this.login,
  });

  final Login login;

  static Route<LoginDetailsPage> getRoute({required Login login}) {
    return MaterialPageRoute(
      builder: (context) => LoginDetailsPage(login: login),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginDetailsBloc(login: login),
      child: const _LoginDetailsView(),
    );
  }
}

class _LoginDetailsView extends StatefulWidget {
  const _LoginDetailsView();

  @override
  State<_LoginDetailsView> createState() => _LoginDetailsViewState();
}

class _LoginDetailsViewState extends State<_LoginDetailsView> {
  static const _hiddenPassword = '**********';

  late final TextEditingController _userNameFieldController;
  final _passwordFieldController = TextEditingController(text: _hiddenPassword);

  @override
  void initState() {
    super.initState();
    final login = context.read<LoginDetailsBloc>().state.login;
    _userNameFieldController = TextEditingController(text: login.userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Details'),
      ),
      body: BlocConsumer<LoginDetailsBloc, LoginDetailsState>(
        listener: _handleStateChange,
        buildWhen: (previous, current) => false,
        builder: (context, state) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  state.login.serviceName,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              ..._buildFields(),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildFields() {
    return [
      TextField(
        readOnly: true,
        textAlignVertical: TextAlignVertical.center,
        controller: _userNameFieldController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          labelText: 'User Name',
          suffix: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: _handleUserNameCopyButtonPress,
          ),
        ),
      ),
      TextField(
        readOnly: true,
        textAlignVertical: TextAlignVertical.center,
        controller: _passwordFieldController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.password),
          labelText: 'Password',
          suffix: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const PasswordVisibilityButton(),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: _handlePasswordCopyButtonPress,
              ),
            ],
          ),
        ),
      ),
    ];
  }

  void _handleStateChange(BuildContext context, LoginDetailsState state) {
    _passwordFieldController.text =
        state.passwordIsVisible ? state.password! : _hiddenPassword;
    if (state.action != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(_getActionSnackBarString(state.action!)),
          ),
        );
    }
  }

  String _getActionSnackBarString(LoginDetailsAction action) {
    switch (action) {
      case LoginDetailsAction.userNameCopy:
        return 'User name copied!';
      case LoginDetailsAction.passwordCopy:
        return 'Password copied!';
    }
  }

  void _handleUserNameCopyButtonPress() {
    context.read<LoginDetailsBloc>().add(const LoginDetailsUserNameCopied());
  }

  void _handlePasswordCopyButtonPress() {
    context.read<LoginDetailsBloc>().add(const LoginDetailsPasswordCopied());
  }
}
