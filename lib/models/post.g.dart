// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostAdapter extends TypeAdapter<Post> {
  @override
  final int typeId = 0;

  @override
  Post read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Post(
      eventLocation: fields[0] as EventLocation,
      id: fields[1] as String,
      userId: fields[2] as String,
      description: fields[3] as String,
      title: fields[4] as String,
      image: (fields[5] as List).cast<String>(),
      tags: (fields[6] as List).cast<String>(),
      eventCategory: fields[7] as String,
      eventStartAt: fields[8] as String,
      eventEndAt: fields[9] as String,
      eventId: fields[10] as String,
      eventDescription: fields[11] as String,
      likes: fields[12] as int,
      noOfComments: fields[13] as int,
      likedUsers: (fields[14] as List).cast<String>(),
      comments: (fields[15] as List).cast<Comment>(),
      createdAt: fields[16] as String,
      v: fields[17] as int,
      registrationRequired: fields[18] as bool,
      registration: (fields[19] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Post obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.eventLocation)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.tags)
      ..writeByte(7)
      ..write(obj.eventCategory)
      ..writeByte(8)
      ..write(obj.eventStartAt)
      ..writeByte(9)
      ..write(obj.eventEndAt)
      ..writeByte(10)
      ..write(obj.eventId)
      ..writeByte(11)
      ..write(obj.eventDescription)
      ..writeByte(12)
      ..write(obj.likes)
      ..writeByte(13)
      ..write(obj.noOfComments)
      ..writeByte(14)
      ..write(obj.likedUsers)
      ..writeByte(15)
      ..write(obj.comments)
      ..writeByte(16)
      ..write(obj.createdAt)
      ..writeByte(17)
      ..write(obj.v)
      ..writeByte(18)
      ..write(obj.registrationRequired)
      ..writeByte(19)
      ..write(obj.registration);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
