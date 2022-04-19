// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/report-status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReportStatusAdapter extends TypeAdapter<ReportStatus> {
  @override
  final int typeId = 9;

  @override
  ReportStatus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReportStatus(
      id: fields[0] as int,
      title: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ReportStatus obj) {
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
      other is ReportStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
