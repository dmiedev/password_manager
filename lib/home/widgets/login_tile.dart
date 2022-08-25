import 'package:flutter/material.dart';

class LoginTile extends StatelessWidget {
  const LoginTile({
    super.key,
    required this.serviceName,
    required this.userName,
  });

  final String serviceName;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.password),
        ),
        title: Text(serviceName),
        subtitle: Text(userName),
      ),
    );
  }
}
