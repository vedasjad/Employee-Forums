// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventLocationAdapter extends TypeAdapter<EventLocation> {
  @override
  final int typeId = 1;

  @override
  EventLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventLocation(
      type: fields[0] as String,
      coordinates: (fields[1] as List).cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, EventLocation obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.coordinates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventLocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
