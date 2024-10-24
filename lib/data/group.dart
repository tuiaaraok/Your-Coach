import 'package:hive/hive.dart';
part 'group.g.dart';

@HiveType(typeId: 1)
class Group {
  @HiveField(0)
  String? nameGroup;
  @HiveField(1)
  String? category;
  @HiveField(2)
  List<String>? humans;
  Group({this.nameGroup, this.category, this.humans});
}
