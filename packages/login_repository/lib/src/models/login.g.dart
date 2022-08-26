// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginAdapter extends TypeAdapter<Login> {
  @override
  final int typeId = 0;

  @override
  Login read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Login(
      userName: fields[0] as String,
      serviceName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Login obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.serviceName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
