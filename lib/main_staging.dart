import 'package:auth_repository/auth_repository.dart';
import 'package:login_repository/login_repository.dart';
import 'package:password_manager/app/app.dart';
import 'package:password_manager/bootstrap.dart';

Future<void> main() async {
  final loginRepository = LoginRepository();
  final authRepository = AuthRepository();

  await loginRepository.initialize();

  await bootstrap(
    () => App(
      loginRepository: loginRepository,
      authRepository: authRepository,
    ),
  );
}
