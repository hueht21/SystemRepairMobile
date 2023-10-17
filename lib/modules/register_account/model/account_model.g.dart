// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountModelAdapter extends TypeAdapter<AccountModel> {
  @override
  final int typeId = 0;

  @override
  AccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountModel(
      auth: fields[0] as int?,
      latitude: fields[1] as double?,
      longitude: fields[2] as double?,
      nameAccout: fields[3] as String?,
      numberPhone: fields[4] as String?,
      uid: fields[5] as String?,
      email: fields[6] as String,
      address: fields[7] as String,
      imgUser: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AccountModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.auth)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.nameAccout)
      ..writeByte(4)
      ..write(obj.numberPhone)
      ..writeByte(5)
      ..write(obj.uid)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.address)
      ..writeByte(8)
      ..write(obj.imgUser);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
