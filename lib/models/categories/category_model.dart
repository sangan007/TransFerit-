import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1)
enum CategoryType{
  @HiveField(0)
  expense,

  @HiveField(1)
  income,
}
@HiveType(typeId: 0)
class CategoryModel {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isDeleted;

  @HiveField(3)
  final CategoryType type;

  CategoryModel({
    required this.id,
    required this.name,
    required this.type,
    this.isDeleted= false,});

    @override
  String toString() {
    return '{$name $type}';
  }
}