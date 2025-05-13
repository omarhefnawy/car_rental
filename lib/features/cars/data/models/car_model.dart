import 'package:car_rental/features/cars/data/models/userData.dart';

class Cars {
  final String name;
  final double pricePerDay;
  final int speed;
  final String transition;
  final String img;
  final UserData owner;

  Cars({
    required this.name,
    required this.pricePerDay,
    required this.speed,
    required this.transition,
    required this.img,
    required this.owner,
  });

  factory Cars.fromJson(Map<String, dynamic> json) {
    return Cars(
      name: json['name'],
      pricePerDay: json['pricePerDay'],
      speed: json['speed'],
      transition: json['transition'],
      img: json['img'],
      owner: UserData.fromJson(json['owner']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pricePerDay': pricePerDay,
      'speed': speed,
      'transition': transition,
      'img': img,
      'owner': owner.toJson(),
    };
  }
  Cars copyWith({
    String? name,
    double? pricePerDay,
    int? speed,
    String? transition,
    String? img,
    UserData? owner,
  }) {
    return Cars(
      name: name ?? this.name,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      speed: speed ?? this.speed,
      transition: transition ?? this.transition,
      img: img ?? this.img,
      owner: owner ?? this.owner,
    );
  }
}
