import 'package:hive/hive.dart';
part 'traning.g.dart';

@HiveType(typeId: 2)
class Traning {
  @HiveField(0)
  String? nameGroup;
  @HiveField(1)
  String? category;
  @HiveField(2)
  List<String>? description;
  Traning({this.nameGroup, this.category, this.description});
}
