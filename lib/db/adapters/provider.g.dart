// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/provider.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProviderAdapter extends TypeAdapter<Provider> {
  @override
  final int typeId = 8;

  @override
  Provider read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Provider(
      id: fields[0] as int,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      imageURL: fields[3] as String,
      email: fields[4] as String,
      verified: fields[5] as bool,
      reviews: (fields[6] as List)?.cast<Review>(),
      reports: (fields[7] as List)?.cast<Report>(),
      serviceRequests: (fields[8] as List)?.cast<ServiceRequest>(),
      stripeId: fields[9] as String,
      requestNumber: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Provider obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.imageURL)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.verified)
      ..writeByte(6)
      ..write(obj.reviews)
      ..writeByte(7)
      ..write(obj.reports)
      ..writeByte(8)
      ..write(obj.serviceRequests)
      ..writeByte(9)
      ..write(obj.stripeId)
      ..writeByte(10)
      ..write(obj.requestNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProviderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
