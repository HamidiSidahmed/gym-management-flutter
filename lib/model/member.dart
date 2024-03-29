import 'package:hive/hive.dart';
part "member.g.dart";

@HiveType(typeId: 1)
class Member {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  DateTime end_date;

  @HiveField(3)
  String? image;

  @HiveField(4)
  bool state;

  @HiveField(5)
  DateTime start_date;

  @HiveField(6)
  String plan;

  @HiveField(7)
  String paid;

  @HiveField(8)
  bool blocked;
  
  @HiveField(9)
  DateTime blocked_date;
  
  Member(this.name, this.phone, this.end_date, this.image, this.state,
      this.start_date, this.plan, this.paid, this.blocked, this.blocked_date);
}
