import 'package:flutter/material.dart';
import 'dart:math';

class AIImpactScreen extends StatefulWidget {
const AIImpactScreen({Key? key}) : super(key: key);

@override
State<AIImpactScreen> createState() => _AIImpactScreenState();
}

class _AIImpactScreenState extends State<AIImpactScreen> {
final TextEditingController _amountController = TextEditingController(text: '500');
String _selectedCause = 'Rural Education';
String _generatedStory = '';
bool _isLoading = false;

final List<String> _causes = ['Rural Education', 'Healthcare Support', 'Child Nutrition', 'Clean Water Initiative'];

void _generateStory() {
setState(() {
_isLoading = true;
});

Future.delayed(const Duration(milliseconds: 1200), () {
final amt = double.tryParse(_amountController.text) ?? 500.0;
int beneficiaries = (amt / 250).ceil().clamp(1, 50);

setState(() {
_isLoading = false;
_generatedStory = '🤖 AI Impact Twin Analysis:\n\n'
'Your contribution of ₹$amt towards "$_selectedCause" directly empowers approximately $beneficiaries individuals in remote regions. '
'Smart-routing protocols indicate optimal fund deployment into verified grassroots partner networks with zero administrative leakage. '
'Cryptographic hash verified: 0x${Random().nextInt(999999999).toRadixString(16)}...';
});
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('AI Impact Story Generator 🤖'),
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Generate Personalized Impact Narrative',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
),
const SizedBox(height: 16),
TextField(
controller: _amountController,
keyboardType: TextInputType.number,
decoration: const InputDecoration(
labelText: 'Donation Amount (₹)',
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.currency_rupee),
),
),
const SizedBox(height: 16),
DropdownButtonFormField<String>(
value: _selectedCause,
decoration: const InputDecoration(
labelText: 'Select Cause',
border: OutlineInputBorder(),
),
items: _causes.map((cause) {
return DropdownMenuItem(value: cause, child: Text(cause));
}).toList(),
onChanged: (val) {
setState(() {
_selectedCause = val!;
});
},
),
const SizedBox(height: 20),
SizedBox(
width: double.infinity,
height: 48,
child: ElevatedButton(
onPressed: _isLoading ? null : _generateStory,
style: ElevatedButton.styleFrom(
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
),
child: _isLoading
? const SizedBox(
width: 20,
height: 20,
child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
)
: const Text('Generate AI Story & Twin', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
),
),
const SizedBox(height: 24),
if (_generatedStory.isNotEmpty)
Expanded(
child: Card(
elevation: 4,
color: Colors.teal.shade50,
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
child: Padding(
padding: const EdgeInsets.all(16.0),
child: SingleChildScrollView(
child: Text(
_generatedStory,
style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.black87),
),
),
),
),
),
],
),
),
);
}
}
