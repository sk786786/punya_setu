import 'package:flutter/material.dart';

class CertificateScreen extends StatelessWidget {
const CertificateScreen({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Impact Certificate & Social Card 🏆'),
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
),
body: Padding(
padding: const EdgeInsets.all(20.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
const Text(
'Your Verified Digital Impact Badge',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
),
const SizedBox(height: 16),
Card(
elevation: 6,
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
child: Container(
padding: const EdgeInsets.all(24.0),
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(16),
gradient: LinearGradient(
colors: [Colors.teal.shade50, Colors.white],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
),
child: Column(
children: [
const Icon(Icons.verified, size: 60, color: Colors.teal),
const SizedBox(height: 12),
const Text(
'PUNYASETU DIRECT GIVING',
style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Colors.grey),
),
const SizedBox(height: 16),
const Text(
'🏆 Gold Impact Guardian',
style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal),
),
const SizedBox(height: 8),
const Text(
'This certificate proudly verifies transparent and direct humanitarian support provided via secure cryptographic ledger.',
textAlign: TextAlign.center,
style: TextStyle(fontSize: 13, color: Colors.black87),
),
const SizedBox(height: 20),
Container(
padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
decoration: BoxDecoration(
color: Colors.teal,
borderRadius: BorderRadius.circular(20),
),
child: const Text(
'ID: PunyaDonor#7842',
style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
),
),
],
),
),
),
const SizedBox(height: 24),
ElevatedButton.icon(
style: ElevatedButton.styleFrom(
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
),
onPressed: () {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Social Impact Card copied / ready to share! 🚀')),
);
},
icon: const Icon(Icons.share),
label: const Text('Share Impact Card', style: TextStyle(fontSize: 16)),
),
],
),
),
);
}
}
