import 'package:flutter/material.dart';

class RoundupScreen extends StatefulWidget {
const RoundupScreen({Key? key}) : super(key: key);

@override
State<RoundupScreen> createState() => _RoundupScreenState();
}

class _RoundupScreenState extends State<RoundupScreen> {
bool _isEnabled = true;
double _totalSaved = 142.50;

final List<Map<String, dynamic>> recentTransactions = [
{'title': 'Grocery Store Bill', 'amount': 430.0, 'roundup': 7.0},
{'title': 'Cafe Coffee', 'amount': 185.0, 'roundup': 15.0},
{'title': 'Cab Ride', 'amount': 223.0, 'roundup': 7.0},
];

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Micro-Roundup Spare Change 🪙'),
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Card(
elevation: 4,
color: Colors.teal.shade50,
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Spare Change Fund', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal)),
SizedBox(height: 4),
Text('Automatically pooling spare change', style: TextStyle(fontSize: 12, color: Colors.grey)),
],
),
Text(
'₹${_totalSaved.toStringAsFixed(2)}',
style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
),
],
),
),
),
const SizedBox(height: 20),
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Text('Auto-Roundup Enabled', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
Switch(
value: _isEnabled,
activeColor: Colors.teal,
onChanged: (val) {
setState(() {
_isEnabled = val;
});
},
),
],
),
const Divider(),
const SizedBox(height: 10),
const Text('Recent Auto-Roundup Logs', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.teal)),
const SizedBox(height: 10),
Expanded(
child: ListView.builder(
itemCount: recentTransactions.length,
itemBuilder: (context, index) {
final tx = recentTransactions[index];
return ListTile(
leading: const CircleAvatar(
backgroundColor: Colors.teal,
child: Icon(Icons.savings, color: Colors.white, size: 18),
),
title: Text(tx['title']),
subtitle: Text('Spent: ₹${tx['amount']}'),
trailing: Text(
'+₹${tx['roundup']} saved',
style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
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
