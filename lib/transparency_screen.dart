import 'package:flutter/material.dart';
import 'donation_screen.dart';

class TransparencyScreen extends StatefulWidget {
const TransparencyScreen({Key? key}) : super(key: key);

@override
State<TransparencyScreen> createState() => _TransparencyScreenState();
}

class _TransparencyScreenState extends State<TransparencyScreen> {
@override
void initState() {
super.initState();
_loadData();
}

Future<void> _loadData() async {
await AdminDatabase.loadRecords();
setState(() {});
}

@override
Widget build(BuildContext context) {
final records = AdminDatabase.records;
double totalDonations = records.fold(0.0, (sum, item) => sum + item.amount);
double totalFees = records.fold(0.0, (sum, item) => sum + item.fee);

return Scaffold(
appBar: AppBar(
title: const Text('Live Transparency Portal'),
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Public Audit & Ledger',
style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
),
const SizedBox(height: 12),
Row(
children: [
Expanded(
child: Card(
color: Colors.teal.shade50,
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text('Total Donated', style: TextStyle(color: Colors.grey)),
const SizedBox(height: 8),
Text('₹${totalDonations.toStringAsFixed(2)}',
style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
],
),
),
),
),
Expanded(
child: Card(
color: Colors.orange.shade50,
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text('Platform Fees', style: TextStyle(color: Colors.grey)),
const SizedBox(height: 8),
Text('₹${totalFees.toStringAsFixed(2)}',
style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
],
),
),
),
),
],
),
const SizedBox(height: 20),
const Text(
'Recent Anonymous Contributions',
style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
),
const SizedBox(height: 8),
Expanded(
child: records.isEmpty
? const Center(
child: Text('No donations recorded yet. Be the first to contribute!'),
)
: ListView.builder(
itemCount: records.length,
itemBuilder: (context, index) {
final rec = records[index];
return Card(
margin: const EdgeInsets.symmetric(vertical: 6),
child: ListTile(
leading: const CircleAvatar(
backgroundColor: Colors.teal,
child: Icon(Icons.volunteer_activism, color: Colors.white),
),
title: Text(rec.anonymousId, style: const TextStyle(fontWeight: FontWeight.bold)),
subtitle: Text('Time: ${rec.timestamp}'),
trailing: Text('₹${rec.amount}',
style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 16)),
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
