import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryEntry {
  final String id;
  final String emoji;
  final String title;
  final String body;

  DiaryEntry({
    this.id,
    this.emoji,
    this.title,
    this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'emoji': emoji,
      'title': title,
      'body': body,
    };
  }

  factory DiaryEntry.fromDoc(QueryDocumentSnapshot doc) {
    return DiaryEntry(
      emoji: doc['emoji'],
      title: doc['title'],
      body: doc['body'],
      id: doc.id,
    );
  }
}
