// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/report.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReportAdapter extends TypeAdapter<Report> {
  @override
  final int typeId = 10;

  @override
  Report read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Report(
      id: fields[0] as int,
      userDetails: fields[2] as String,
      adminDetails: fields[3] as String,
      images: (fields[4] as List)?.cast<String>(),
      serviceRequest: fields[5] as ServiceRequest,
      requestNumber: fields[6] as String,
      createdAt: fields[7] as DateTime,
    )..status = fields[1] as ReportStatus;
  }

  @override
  void write(BinaryWriter writer, Report obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.userDetails)
      ..writeByte(3)
      ..write(obj.adminDetails)
      ..writeByte(4)
      ..write(obj.images)
      ..writeByte(5)
      ..write(obj.serviceRequest)
      ..writeByte(6)
      ..write(obj.requestNumber)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
