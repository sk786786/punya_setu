import 'package:flutter/material.dart';

class TransparencyScreen extends StatelessWidget {
const TransparencyScreen({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('PunyaSetu Transparency'),
backgroundColor: Colors.teal,
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: ListView(
children: const [
Card(
elevation: 4,
child: Padding(
padding: EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Platform Fee: 0%',
style: TextStyle(
fontSize: 20,
fontWeight: FontWeight.bold,
color: Colors.teal,
),
),
SizedBox(height: 8),
Text(
'100% of your anonymous direct-giving amount routes directly to verified institutional accounts with complete settlement tracking.',
style: TextStyle(fontSize: 14, color: Colors.black87),
),
],
),
),
),
SizedBox(height: 16),
Text(
'Recent Verified Settlements',
style: TextStyle(fontSize: 18, FontWeight: FontWeight.bold),
),
SizedBox(height: 8),
ListTile(
leading: Icon(Icons.verified, color: Colors.teal),
title: Text('Verified Institution #104'),
subtitle: Text('Status: Settled Successfully (0% Fee)'),
trailing: Text('₹5,000'),
),
ListTile(
leading: Icon(Icons.verified, color: Colors.teal),
title: Text('Verified Institution #109'),
subtitle: Text('Status: Direct Route Active'),
trailing: Text('₹12,500'),
),
],
),
),
);
}
}
