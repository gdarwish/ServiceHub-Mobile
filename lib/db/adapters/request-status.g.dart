// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/request-status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestStatusAdapter extends TypeAdapter<RequestStatus> {
  @override
  final int typeId = 11;

  @override
  RequestStatus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RequestStatus(
      id: fields[0] as int,
      title: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RequestStatus obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
