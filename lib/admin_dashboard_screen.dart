import 'package:flutter/material.dart';
import 'donation_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
const AdminDashboardScreen({Key? key}) : super(key: key);

@override
State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
@override
Widget build(BuildContext context) {
final records = AdminDatabase.records;
double totalFunds = records.fold(0.0, (sum, item) => sum + item.amount);
double totalFees = records.fold(0.0, (sum, item) => sum + item.fee);

return Scaffold(
appBar: AppBar(
title: const Text('Admin Financial Audit Panel 📊'),
backgroundColor: Colors.indigo,
foregroundColor: Colors.white,
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
children: [
Expanded(
child: Card(
color: Colors.indigo.shade50,
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text('Total Direct Funds', style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
const SizedBox(height: 8),
Text('₹${totalFunds.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
],
),
),
),
),
Expanded(
child: Card(
color: Colors.teal.shade50,
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text('Maintenance Fees (1%)', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold)),
const SizedBox(height: 8),
Text('₹${totalFees.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
],
),
),
),
),
],
),
const SizedBox(height: 20),
const Text('Encrypted Compliance Audit Logs', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo)),
const SizedBox(height: 10),
Expanded(
child: records.isEmpty
? const Center(child: Text('No donation records found yet. Make a donation first!'))
: ListView.builder(
physics: const BouncingScrollPhysics(), // Smooth scrolling enabled
itemCount: records.length,
itemBuilder: (context, index) {
final rec = records[index];
return Card(
margin: const EdgeInsets.symmetric(vertical: 6),
child: ListTile(
leading: const CircleAvatar(
backgroundColor: Colors.indigo,
child: Icon(Icons.security, color: Colors.white, size: 18),
),
title: Text('${rec.anonymousId} (₹${rec.amount})'),
subtitle: Text('Name: ${rec.fullName} | Ph: ${rec.contact}\nTx: ${rec.txHash}'),
isThreeLine: true,
trailing: Text(rec.timestamp, style: const TextStyle(fontSize: 11, color: Colors.grey)),
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
