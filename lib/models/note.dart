import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? imageUrl;
  @HiveField(3)
  String? description;

  Note({
    this.id,
    this.title,
    this.imageUrl,
    this.description,
  });
}
