// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/card-type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardTypeAdapter extends TypeAdapter<CardType> {
  @override
  final int typeId = 1;

  @override
  CardType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CardType.Visa;
      case 1:
        return CardType.Mastercard;
      case 2:
        return CardType.AmericanExpress;
      case 3:
        return CardType.Diners;
      case 4:
        return CardType.Discover;
      default:
        return CardType.Visa;
    }
  }

  @override
  void write(BinaryWriter writer, CardType obj) {
    switch (obj) {
      case CardType.Visa:
        writer.writeByte(0);
        break;
      case CardType.Mastercard:
        writer.writeByte(1);
        break;
      case CardType.AmericanExpress:
        writer.writeByte(2);
        break;
      case CardType.Diners:
        writer.writeByte(3);
        break;
      case CardType.Discover:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

