class UserData {
  final String name;
  final String phone;
  final double lat;
  final double lng;

  UserData({
    required this.name,
    required this.phone,
    required this.lat,
    required this.lng,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      phone: json['phone'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'lat': lat,
      'lng': lng,
    };
  }
  UserData copyWith({
    String? name,
    String? phone,
    double? lat,
    double? lng,
  }) {
    return UserData(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}
