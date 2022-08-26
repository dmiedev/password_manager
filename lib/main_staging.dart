import 'package:login_repository/login_repository.dart';
import 'package:password_manager/app/app.dart';
import 'package:password_manager/bootstrap.dart';

Future<void> main() async {
  final loginRepository = LoginRepository();

  await loginRepository.initialize();

  await bootstrap(
    () => App(
      loginRepository: loginRepository,
    ),
  );
}
