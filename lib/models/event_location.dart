import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

part 'event_location.g.dart';

@HiveType(typeId: 1)
class EventLocation {
  @HiveField(0)
  final String type;
  @HiveField(1)
  final List<double> coordinates;
  EventLocation({
    required this.type,
    required this.coordinates,
  });

  EventLocation copyWith({
    String? type,
    List<double>? coordinates,
  }) {
    return EventLocation(
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'type': type});
    result.addAll({'coordinates': coordinates});

    return result;
  }

  factory EventLocation.fromMap(Map<String, dynamic> map) {
    return EventLocation(
      type: map['type'] ?? '',
      coordinates: List<double>.from(map['coordinates']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventLocation.fromJson(String source) =>
      EventLocation.fromMap(json.decode(source));

  @override
  String toString() => 'EventLocation(type: $type, coordinates: $coordinates)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is EventLocation &&
        other.type == type &&
        listEquals(other.coordinates, coordinates);
  }

  @override
  int get hashCode => type.hashCode ^ coordinates.hashCode;
}
