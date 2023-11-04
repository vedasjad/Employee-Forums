import 'dart:convert';

import 'package:collection/collection.dart';

class Comment {
   final String user;
  final bool isEdited;
  final String text;
  final List<dynamic> likes;
  final String id;
  final List<dynamic> image;
  final String createdAt;
  final List<dynamic> replies;
  Comment({
    required this.user,
    required this.isEdited,
    required this.text,
    required this.likes,
    required this.id,
    required this.image,
    required this.createdAt,
    required this.replies,
  });

  Comment copyWith({
    String? user,
    bool? isEdited,
    String? text,
    List<dynamic>? likes,
    String? id,
    List<dynamic>? image,
    String? createdAt,
    List<dynamic>? replies,
  }) {
    return Comment(
      user: user ?? this.user,
      isEdited: isEdited ?? this.isEdited,
      text: text ?? this.text,
      likes: likes ?? this.likes,
      id: id ?? this.id,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      replies: replies ?? this.replies,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'user': user});
    result.addAll({'isEdited': isEdited});
    result.addAll({'text': text});
    result.addAll({'likes': likes});
    result.addAll({'id': id});
    result.addAll({'image': image});
    result.addAll({'createdAt': createdAt});
    result.addAll({'replies': replies});
  
    return result;
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      user: map['user'] ?? '',
      isEdited: map['isEdited'] ?? false,
      text: map['text'] ?? '',
      likes: List<dynamic>.from(map['likes']),
      id: map['id'] ?? '',
      image: List<dynamic>.from(map['image']),
      createdAt: map['createdAt'] ?? '',
      replies: List<dynamic>.from(map['replies']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(user: $user, isEdited: $isEdited, text: $text, likes: $likes, id: $id, image: $image, createdAt: $createdAt, replies: $replies)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is Comment &&
      other.user == user &&
      other.isEdited == isEdited &&
      other.text == text &&
      listEquals(other.likes, likes) &&
      other.id == id &&
      listEquals(other.image, image) &&
      other.createdAt == createdAt &&
      listEquals(other.replies, replies);
  }

  @override
  int get hashCode {
    return user.hashCode ^
      isEdited.hashCode ^
      text.hashCode ^
      likes.hashCode ^
      id.hashCode ^
      image.hashCode ^
      createdAt.hashCode ^
      replies.hashCode;
  }
}
