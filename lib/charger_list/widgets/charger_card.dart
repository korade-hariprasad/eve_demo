import 'package:eve_demo/charger_list/model/charger_model.dart';
import 'package:flutter/material.dart';

Widget chargerCard(ChargerModel charger) {
  return Card(
    color: Colors.white,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Image with rounded corners and elevation
              Container(
                width: 80,
                height: 80,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    charger.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              ),
              // Charger information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      charger.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      charger.location,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          "${charger.rating} • ${charger.distance} kms away",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Details row with vertical dividers
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.lightBlue[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blueAccent),
            ),
            child: SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoColumn("Connection", charger.type),
                  _verticalDivider(),
                  _infoColumn("Per kWh", "\$${charger.costPerKWh}"),
                  _verticalDivider(),
                  _infoColumn("Parking Fee", "\$${charger.parkingFees}"),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper function to create info columns
Widget _infoColumn(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 5),
      Text(
        label,
        style: const TextStyle(
          color: Colors.blueAccent,
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

// Helper function for vertical divider
Widget _verticalDivider() {
  return Container(
    height: 40,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: VerticalDivider(
      color: Colors.grey[400],
      thickness: 1,
    ),
  );
}