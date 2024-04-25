import 'package:hive/hive.dart';

part 'cart.g.dart';

@HiveType(typeId: 2)
class Cart extends HiveObject {
  @HiveField(0)
  // Count OF Fruit
  double count;

  @HiveField(1)
  // FruitName
  String fruitName;

  Cart({required this.count, required this.fruitName});
}
