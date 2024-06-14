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

  @HiveField(2)
  // image Address of Fruit
  // example    http:// .... /img.png
  String imageAddress;

  Cart({required this.count, required this.fruitName,required this.imageAddress});
}
