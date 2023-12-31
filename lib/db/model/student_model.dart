import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String profile;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String age;

  @HiveField(4)
  final String address;

  @HiveField(5)
  final String number;

  StudentModel({
    required this.profile,
    required this.name,
    required this.age,
    required this.address,
    required this.number,
    this.id,
  });
}
