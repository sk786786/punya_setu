import 'package:flutter/material.dart';

class RoutingScreen extends StatelessWidget {
const RoutingScreen({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Direct Route Verification'),
backgroundColor: Colors.teal,
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: ListView(
children: [
const Text(
'Zero Intermediary Escrow',
style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
),
const SizedBox(height: 8),
const Text(
'PunyaSetu never holds your donation in a company pool account. Funds route directly to verified institutional accounts.',
style: TextStyle(fontSize: 14, color: Colors.grey),
),
const SizedBox(height: 20),
Card(
elevation: 3,
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
children: const [
Icon(Icons.verified, color: Colors.teal, size: 28),
SizedBox(width: 10),
Text(
'City General Hospital Trust',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
],
),
const Divider(height: 24),
const Text('Account Name: City General Medical Relief Fund'),
const SizedBox(height: 6),
const Text('Account Number: XXXX-XXXX-8921'),
const SizedBox(height: 6),
const Text('IFSC Code: HDFC0001234'),
const SizedBox(height: 6),
const Text('Bank: HDFC Bank, Main Branch'),
const SizedBox(height: 12),
Chip(
backgroundColor: Colors.teal.shade50,
label: const Text(
'Status: Verified & Active (RBI Compliant)',
style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
),
),
],
),
),
),
const SizedBox(height: 20),
const Card(
color: Color(0xFFF9F9F9),
child: Padding(
padding: EdgeInsets.all(16.0),
child: Text(
'Note: The 1% micro-fee is processed separately into the PunyaSetu server maintenance operational account to keep this platform running securely.',
style: TextStyle(fontSize: 12, color: Colors.black54),
),
),
),
],
),
),
);
}
}
