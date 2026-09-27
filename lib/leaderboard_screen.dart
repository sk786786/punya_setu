import 'package:flutter/material.dart';
import 'donation_screen.dart';

class LeaderboardScreen extends StatelessWidget {
const LeaderboardScreen({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
final sortedRecords = List<DonationRecord>.from(AdminDatabase.records)
..sort((a, b) => b.amount.compareTo(a.amount));

return Scaffold(
appBar: AppBar(
title: const Text('Live Impact Wall & Leaderboard'),
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
),
body: sortedRecords.isEmpty
? const Center(
child: Text(
'No donations recorded yet. Be the first to donate!',
style: TextStyle(fontSize: 16, color: Colors.grey),
),
)
: Padding(
padding: const EdgeInsets.all(16.0),
child: ListView.builder(
itemCount: sortedRecords.length,
itemBuilder: (context, index) {
final r = sortedRecords[index];
return Card(
elevation: 2,
margin: const EdgeInsets.symmetric(vertical: 6),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
child: ListTile(
leading: CircleAvatar(
backgroundColor: Colors.teal.shade100,
child: Text(
'#${index + 1}',
style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
),
),
title: Text(
r.anonymousId,
style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
),
subtitle: Text('Donated on: ${r.timestamp}'),
trailing: Text(
'₹${r.amount.toStringAsFixed(2)}',
style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green),
),
),
);
},
),
),
);
}
}
