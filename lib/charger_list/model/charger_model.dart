// models/charge_station.dart
import 'dart:ffi';

class ChargerModel {
  final String name;
  final String type;
  final double costPerKWh;
  final double parkingFees;
  final double distance;
  final double rating;
  final String imageUrl;
  final String location;

  ChargerModel({
    required this.name,
    required this.type,
    required this.costPerKWh,
    required this.parkingFees,
    required this.distance,
    required this.rating,
    required this.imageUrl,
    required this.location,
  });

  // Factory method to create an instance from JSON
  factory ChargerModel.fromJson(Map<String, dynamic> json) {
    return ChargerModel(
      name: json['name'],
      type: json['type'],
      costPerKWh: ((json['cost_per_kWh'] as num?)?.toDouble() ?? 0.0),
      parkingFees: ((json['parking_fees'] as num?)?.toDouble() ?? 0.0),
      distance: ((json['distance'] as num?)?.toDouble() ?? 0.0),
      rating: ((json['rating'] as num?)?.toDouble() ?? 0.0),
      imageUrl: json['image_url'],
      location: json['location']
    );
  }
}
