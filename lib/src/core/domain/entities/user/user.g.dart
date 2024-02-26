// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as int,
      fullname: fields[1] as String,
      username: fields[2] as String,
      contact: fields[3] as String,
      password: fields[4] as String?,
      sex: fields[5] as String?,
      bio: fields[6] as String?,
      link: fields[7] as String?,
      profileImage: fields[8] as String?,
      joinedDate: fields[9] as DateTime?,
      token: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullname)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.contact)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.sex)
      ..writeByte(6)
      ..write(obj.bio)
      ..writeByte(7)
      ..write(obj.link)
      ..writeByte(8)
      ..write(obj.profileImage)
      ..writeByte(9)
      ..write(obj.joinedDate)
      ..writeByte(10)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
