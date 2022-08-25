import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/home/bloc/home_bloc.dart';
import 'package:password_manager/home/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(const HomeLoaded()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Password Manager'),
        ),
        floatingActionButton: _buildFloatingActionButton(state),
        body: _buildBody(context, state),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    if (state is HomeLoadSuccess) {
      return ListView.builder(
        itemCount: state.logins.length,
        itemBuilder: (context, index) {
          final login = state.logins[index];
          return LoginTile(
            serviceName: login.serviceName,
            userName: login.userName,
          );
        },
      );
    } else if (state is HomeLoadFailure) {
      return const ErrorMessage();
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget? _buildFloatingActionButton(HomeState state) {
    if (state is! HomeLoadSuccess) {
      return null;
    }
    return FloatingActionButton(
      onPressed: _handleAddButtonPress,
      child: const Icon(Icons.add),
    );
  }

  void _handleAddButtonPress() {}
}
