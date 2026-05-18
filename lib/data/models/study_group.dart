import 'package:equatable/equatable.dart';

class StudyGroup extends Equatable {
  final int id;
  final int userId;
  final String subject;
  final String description;
  final String category;

  const StudyGroup({
    required this.id,
    required this.userId,
    required this.subject,
    required this.description,
    this.category = 'General',
  });

  factory StudyGroup.fromJson(Map<String, dynamic> json) {
    return StudyGroup(
      id: json['id'] as int,
      userId: json['userId'] as int,
      subject: json['title'] as String,
      description: json['body'] as String,
      category: 'General',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': subject,
      'body': description,
    };
  }

  StudyGroup copyWith({
    int? id,
    int? userId,
    String? subject,
    String? description,
    String? category,
  }) {
    return StudyGroup(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }

  @override
  List<Object> get props => [id, userId, subject, description, category];
}