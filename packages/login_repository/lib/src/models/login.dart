import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'login.g.dart';

@HiveType(typeId: 0)
class Login extends HiveObject with EquatableMixin {
  Login({
    required this.userName,
    required this.serviceName,
  });

  @HiveField(0)
  final String userName;

  @HiveField(1)
  final String serviceName;

  @override
  List<Object?> get props => [userName, serviceName];
}
