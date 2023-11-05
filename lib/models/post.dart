import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

import 'comment.dart';
import 'event_location.dart';

part 'post.g.dart';

@HiveType(typeId: 0)
class Post {
  @HiveField(0)
  final EventLocation eventLocation;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String userId;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String title;
  @HiveField(5)
  final List<String> image;
  @HiveField(6)
  final List<String> tags;
  @HiveField(7)
  final String eventCategory;
  @HiveField(8)
  final String eventStartAt;
  @HiveField(9)
  final String eventEndAt;
  @HiveField(10)
  final String eventId;
  @HiveField(11)
  final String eventDescription;
  @HiveField(12)
  final int likes;
  @HiveField(13)
  final int noOfComments;
  @HiveField(14)
  final List<String> likedUsers;
  @HiveField(15)
  final List<Comment> comments;
  @HiveField(16)
  final String createdAt;
  @HiveField(17)
  final int v;
  @HiveField(18)
  final bool registrationRequired;
  @HiveField(19)
  final List<dynamic> registration;
  @HiveField(20)
  Post({
    required this.eventLocation,
    required this.id,
    required this.userId,
    required this.description,
    required this.title,
    required this.image,
    required this.tags,
    required this.eventCategory,
    required this.eventStartAt,
    required this.eventEndAt,
    required this.eventId,
    required this.eventDescription,
    required this.likes,
    required this.noOfComments,
    required this.likedUsers,
    required this.comments,
    required this.createdAt,
    required this.v,
    required this.registrationRequired,
    required this.registration,
  });

  Post copyWith({
    EventLocation? eventLocation,
    String? id,
    String? userId,
    String? description,
    String? title,
    List<String>? image,
    List<String>? tags,
    String? eventCategory,
    String? eventStartAt,
    String? eventEndAt,
    String? eventId,
    String? eventDescription,
    int? likes,
    int? noOfComments,
    List<String>? likedUsers,
    List<Comment>? comments,
    String? createdAt,
    int? v,
    bool? registrationRequired,
    List<dynamic>? registration,
  }) {
    return Post(
      eventLocation: eventLocation ?? this.eventLocation,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      title: title ?? this.title,
      image: image ?? this.image,
      tags: tags ?? this.tags,
      eventCategory: eventCategory ?? this.eventCategory,
      eventStartAt: eventStartAt ?? this.eventStartAt,
      eventEndAt: eventEndAt ?? this.eventEndAt,
      eventId: eventId ?? this.eventId,
      eventDescription: eventDescription ?? this.eventDescription,
      likes: likes ?? this.likes,
      noOfComments: noOfComments ?? this.noOfComments,
      likedUsers: likedUsers ?? this.likedUsers,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
      v: v ?? this.v,
      registrationRequired: registrationRequired ?? this.registrationRequired,
      registration: registration ?? this.registration,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'eventLocation': eventLocation.toMap()});
    result.addAll({'id': id});
    result.addAll({'userId': userId});
    result.addAll({'description': description});
    result.addAll({'title': title});
    result.addAll({'image': image});
    result.addAll({'tags': tags});
    result.addAll({'eventCategory': eventCategory});
    result.addAll({'eventStartAt': eventStartAt});
    result.addAll({'eventEndAt': eventEndAt});
    result.addAll({'eventId': eventId});
    result.addAll({'eventDescription': eventDescription});
    result.addAll({'likes': likes});
    result.addAll({'noOfComments': noOfComments});
    result.addAll({'likedUsers': likedUsers});
    result.addAll({'comments': comments.map((x) => x.toMap()).toList()});
    result.addAll({'createdAt': createdAt});
    result.addAll({'v': v});
    result.addAll({'registrationRequired': registrationRequired});
    result.addAll({'registration': registration});

    return result;
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      eventLocation: EventLocation.fromMap(map['eventLocation']),
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      description: map['description'] ?? '',
      title: map['title'] ?? '',
      image: List<String>.from(map['image']),
      tags: List<String>.from(map['tags']),
      eventCategory: map['eventCategory'] ?? '',
      eventStartAt: map['eventStartAt'] ?? '',
      eventEndAt: map['eventEndAt'] ?? '',
      eventId: map['eventId'] ?? '',
      eventDescription: map['eventDescription'] ?? '',
      likes: map['likes']?.toInt() ?? 0,
      noOfComments: map['noOfComments']?.toInt() ?? 0,
      likedUsers: List<String>.from(map['likedUsers']),
      comments:
          List<Comment>.from(map['comments']?.map((x) => Comment.fromMap(x))),
      createdAt: map['createdAt'] ?? '',
      v: map['v']?.toInt() ?? 0,
      registrationRequired: map['registrationRequired'] ?? false,
      registration: List<dynamic>.from(map['registration']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(eventLocation: $eventLocation, id: $id, userId: $userId, description: $description, title: $title, image: $image, tags: $tags, eventCategory: $eventCategory, eventStartAt: $eventStartAt, eventEndAt: $eventEndAt, eventId: $eventId, eventDescription: $eventDescription, likes: $likes, noOfComments: $noOfComments, likedUsers: $likedUsers, comments: $comments, createdAt: $createdAt, v: $v, registrationRequired: $registrationRequired, registration: $registration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Post &&
        other.eventLocation == eventLocation &&
        other.id == id &&
        other.userId == userId &&
        other.description == description &&
        other.title == title &&
        listEquals(other.image, image) &&
        listEquals(other.tags, tags) &&
        other.eventCategory == eventCategory &&
        other.eventStartAt == eventStartAt &&
        other.eventEndAt == eventEndAt &&
        other.eventId == eventId &&
        other.eventDescription == eventDescription &&
        other.likes == likes &&
        other.noOfComments == noOfComments &&
        listEquals(other.likedUsers, likedUsers) &&
        listEquals(other.comments, comments) &&
        other.createdAt == createdAt &&
        other.v == v &&
        other.registrationRequired == registrationRequired &&
        listEquals(other.registration, registration);
  }

  @override
  int get hashCode {
    return eventLocation.hashCode ^
        id.hashCode ^
        userId.hashCode ^
        description.hashCode ^
        title.hashCode ^
        image.hashCode ^
        tags.hashCode ^
        eventCategory.hashCode ^
        eventStartAt.hashCode ^
        eventEndAt.hashCode ^
        eventId.hashCode ^
        eventDescription.hashCode ^
        likes.hashCode ^
        noOfComments.hashCode ^
        likedUsers.hashCode ^
        comments.hashCode ^
        createdAt.hashCode ^
        v.hashCode ^
        registrationRequired.hashCode ^
        registration.hashCode;
  }
}
