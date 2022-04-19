// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<Settings> {
  @override
  final int typeId = 14;

  @override
  Settings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Settings()
      ..token = fields[0] as String ?? ''
      ..email = fields[1] as String ?? ''
      ..password = fields[2] as String ?? ''
      ..userType = fields[3] as String ?? ''
      ..rememberMe = fields[4] as bool ?? false
      ..listStyle = fields[5] as int ?? 0
      ..snowFilter = fields[6] as bool ?? false
      ..lawnFilter = fields[7] as bool ?? false
      ..distanceFilter = fields[8] as int ?? 50;
  }

  @override
  void write(BinaryWriter writer, Settings obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.userType)
      ..writeByte(4)
      ..write(obj.rememberMe)
      ..writeByte(5)
      ..write(obj.listStyle)
      ..writeByte(6)
      ..write(obj.snowFilter)
      ..writeByte(7)
      ..write(obj.lawnFilter)
      ..writeByte(8)
      ..write(obj.distanceFilter);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
