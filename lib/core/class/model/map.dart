import 'package:hive/hive.dart';

part 'map.g.dart';

@HiveType(typeId: 1)
class Map extends HiveObject {
  // latitude
  @HiveField(0)
  double lat;

  // longitude
  @HiveField(1)
  double long;

  Map({required this.lat, required this.long});
}
