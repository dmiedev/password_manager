import 'package:flutter/material.dart';

class LoginTile extends StatelessWidget {
  const LoginTile({
    super.key,
    required this.serviceName,
    required this.userName,
    this.onTap,
  });

  final String serviceName;
  final String userName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Text(serviceName.substring(0, 1)),
        ),
        title: Text(serviceName),
        subtitle: Text(userName),
      ),
    );
  }
}
