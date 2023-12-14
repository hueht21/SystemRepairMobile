// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixer_account_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FixerAccountModelAdapter extends TypeAdapter<FixerAccountModel> {
  @override
  final int typeId = 1;

  @override
  FixerAccountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FixerAccountModel(
      address: fields[0] as String?,
      age: fields[1] as int?,
      email: fields[2] as String?,
      imgAcc: fields[3] as String?,
      latitude: fields[4] as double?,
      longitude: fields[5] as double?,
      name: fields[6] as String?,
      numberPhone: fields[7] as String?,
      status: fields[8] as bool?,
      uid: fields[9] as String?,
      token: fields[10] as String?,
      isActive: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FixerAccountModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.imgAcc)
      ..writeByte(4)
      ..write(obj.latitude)
      ..writeByte(5)
      ..write(obj.longitude)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.numberPhone)
      ..writeByte(8)
      ..write(obj.status)
      ..writeByte(9)
      ..write(obj.uid)
      ..writeByte(10)
      ..write(obj.token)
      ..writeByte(11)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FixerAccountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
