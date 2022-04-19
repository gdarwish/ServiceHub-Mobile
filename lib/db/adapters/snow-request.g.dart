// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/snow-request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SnowRequestAdapter extends TypeAdapter<SnowRequest> {
  @override
  final int typeId = 13;

  @override
  SnowRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SnowRequest(
      id: fields[0] as int,
      requestNumber: fields[1] as String,
      customer: fields[3] as Profile,
      provider: fields[4] as Profile,
      status: fields[5] as RequestStatus,
      address: fields[6] as Address,
      payment: fields[7] as Payment,
      price: fields[8] as double,
      currency: fields[9] as String,
      date: fields[10] as DateTime,
      customerImages: (fields[11] as List)?.cast<String>(),
      providerBeforeImages: (fields[12] as List)?.cast<String>(),
      providerAfterImages: (fields[13] as List)?.cast<String>(),
      createdAt: fields[14] as DateTime,
      driveway: fields[15] as String,
      sidewalk: fields[16] as bool,
      walkway: fields[17] as bool,
      salting: fields[18] as bool,
      instructions: fields[19] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SnowRequest obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.requestNumber)
      ..writeByte(3)
      ..write(obj.customer)
      ..writeByte(4)
      ..write(obj.provider)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.payment)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.currency)
      ..writeByte(10)
      ..write(obj.date)
      ..writeByte(11)
      ..write(obj.customerImages)
      ..writeByte(12)
      ..write(obj.providerBeforeImages)
      ..writeByte(13)
      ..write(obj.providerAfterImages)
      ..writeByte(14)
      ..write(obj.createdAt)
      ..writeByte(15)
      ..write(obj.driveway)
      ..writeByte(16)
      ..write(obj.sidewalk)
      ..writeByte(17)
      ..write(obj.walkway)
      ..writeByte(18)
      ..write(obj.salting)
      ..writeByte(19)
      ..write(obj.instructions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnowRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
