// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentAdapter extends TypeAdapter<Comment> {
  @override
  final int typeId = 2;

  @override
  Comment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Comment(
      user: fields[0] as String,
      isEdited: fields[1] as bool,
      text: fields[2] as String,
      likes: (fields[3] as List).cast<dynamic>(),
      id: fields[4] as String,
      image: (fields[5] as List).cast<dynamic>(),
      createdAt: fields[6] as String,
      replies: (fields[7] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Comment obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.isEdited)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.likes)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.replies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
