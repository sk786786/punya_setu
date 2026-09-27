import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
const MapScreen({Key? key}) : super(key: key);

final List<Map<String, dynamic>> impactHubs = const [
{'title': 'City General Hospital', 'city': 'Chandigarh', 'cause': 'Medical Surgery Aid', 'status': '100% Funded', 'lat': 30.73, 'lng': 76.77},
{'title': 'Rural Shiksha Trust', 'city': 'Ludhiana', 'cause': 'Child Education', 'status': 'Active (80%)', 'lat': 30.90, 'lng': 75.85},
{'title': 'Community Food Shelter', 'city': 'Patiala', 'cause': 'Daily Meal Drive', 'status': 'Fully Distributed', 'lat': 30.33, 'lng': 76.38},
];

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Live Impact & Geo-Routing Map'),
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Real-Time Beneficiary Hubs',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
),
const SizedBox(height: 6),
const Text(
'Track exactly where direct micro-grants and resources are being deployed.',
style: TextStyle(fontSize: 13, color: Colors.grey),
),
const SizedBox(height: 16),
Expanded(
child: ListView.builder(
itemCount: impactHubs.length,
itemBuilder: (context, index) {
final hub = impactHubs[index];
return Card(
elevation: 3,
margin: const EdgeInsets.symmetric(vertical: 8),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
child: ListTile(
leading: const CircleAvatar(
backgroundColor: Colors.teal,
child: Icon(Icons.location_on, color: Colors.white),
),
title: Text(hub['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
subtitle: Text('City: ${hub['city']} | Cause: ${hub['cause']}'),
trailing: Container(
padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
decoration: BoxDecoration(
color: Colors.teal.shade50,
borderRadius: BorderRadius.circular(20),
),
child: Text(
hub['status'],
style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 12),
),
),
),
);
},
),
),
],
),
),
);
}
}
