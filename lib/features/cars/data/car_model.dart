import 'package:flutter/foundation.dart';

class Cars {
  final String name;
  final double pricePerDay;
  final int speed;
  final String transition;

  Cars({
    required this.name,
    required this.pricePerDay,
    required this.speed,
    required this.transition,
  });

  // fromJson
  factory Cars.fromJson(Map<String, dynamic> json) {
    return Cars(
      name: json['name'],
      pricePerDay: (json['pricePerDay'] ),
      speed: json['speed'],
      transition: json['transition'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pricePerDay': pricePerDay,
      'speed': speed,
      'transition': transition,
    };
  }

  // copyWith
  Cars copyWith({
    String? name,
    double? pricePerDay,
    int? speed,
    String? transition,
  }) {
    return Cars(
      name: name ?? this.name,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      speed: speed ?? this.speed,
      transition: transition ?? this.transition,
    );
  }
}
