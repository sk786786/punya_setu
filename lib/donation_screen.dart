import 'package:flutter/material.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DonationRecord {
final String anonymousId;
final double amount;
final double fee;
final String fullName;
final String contact;
final String address;
final String timestamp;
final String txHash;
final String badge;
final String aiStory;

DonationRecord({
required this.anonymousId,
required this.amount,
required this.fee,
required this.fullName,
required this.contact,
required this.address,
required this.timestamp,
required this.txHash,
required this.badge,
required this.aiStory,
});

Map<String, dynamic> toJson() => {
'anonymousId': anonymousId,
'amount': amount,
'fee': fee,
'fullName': fullName,
'contact': contact,
'address': address,
'timestamp': timestamp,
'txHash': txHash,
'badge': badge,
'aiStory': aiStory,
};

factory DonationRecord.fromJson(Map<String, dynamic> json) => DonationRecord(
anonymousId: json['anonymousId'] ?? 'PunyaDonor#0000',
amount: json['amount'] ?? 0.0,
fee: json['fee'] ?? 0.0,
fullName: json['fullName'] ?? '',
contact: json['contact'] ?? '',
address: json['address'] ?? '',
timestamp: json['timestamp'] ?? '',
txHash: json['txHash'] ?? '0x000...000',
badge: json['badge'] ?? 'Kind Heart',
aiStory: json['aiStory'] ?? 'A noble contribution towards community welfare.',
);
}

class AdminDatabase {
static List<DonationRecord> records = [];

static Future<void> saveRecord(DonationRecord record) async {
records.add(record);
final prefs = await SharedPreferences.getInstance();
final String encoded = jsonEncode(records.map((e) => e.toJson()).toList());
await prefs.setString('donation_records', encoded);
}

static Future<void> loadRecords() async {
final prefs = await SharedPreferences.getInstance();
final String? encoded = prefs.getString('donation_records');
if (encoded != null) {
final List decoded = jsonDecode(encoded);
records = decoded.map((e) => DonationRecord.fromJson(e)).toList();
}
}
}

class DonationScreen extends StatefulWidget {
const DonationScreen({Key? key}) : super(key: key);

@override
State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
final _formKey = GlobalKey<FormState>();
final TextEditingController _amountController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _contactController = TextEditingController();
final TextEditingController _addressController = TextEditingController();

double _donationAmount = 0.0;
double _microFee = 0.0;
double _totalPayable = 0.0;
String _anonymousId = '';

@override
void initState() {
super.initState();
_anonymousId = 'PunyaDonor#${1000 + Random().nextInt(9000)}';
_amountController.addListener(_calculateFee);
}

void _calculateFee() {
final val = double.tryParse(_amountController.text) ?? 0.0;
setState(() {
_donationAmount = val;
_microFee = val * 0.01;
_totalPayable = _donationAmount + _microFee;
});
}

@override
void dispose() {
_amountController.dispose();
_nameController.dispose();
_contactController.dispose();
_addressController.dispose();
super.dispose();
}

String _generateTxHash() {
const chars = 'abcdef0123456789';
Random rnd = Random();
String part1 = List.generate(8, (index) => chars[rnd.nextInt(chars.length)]).join();
String part2 = List.generate(8, (index) => chars[rnd.nextInt(chars.length)]).join();
return '0x$part1...$part2';
}

String _calculateBadge(double amt) {
if (amt >= 2000) return '🏆 Gold Impact Guardian';
if (amt >= 500) return '🥈 Silver Benefactor';
return '⭐ Silent Supporter';
}

String _generateAiStory(double amt) {
if (amt >= 2000) {
return '✨ AI Impact Twin Story: Your generous contribution of ₹$amt directly sponsors complete medical support and hospital care for an underprivileged patient for an entire week. You are a true lifesaver!';
} else if (amt >= 500) {
return '✨ AI Impact Twin Story: With your ₹$amt donation, a rural child receives notebooks, stationary, and uniform essentials for 30 days. Education changes destinies!';
} else {
return '✨ AI Impact Twin Story: Your thoughtful contribution of ₹$amt helps provide daily nutritious meals and clean drinking water support to community shelter homes.';
}
}

void _startPaymentSimulation() {
if (_formKey.currentState!.validate()) {
showDialog(
context: context,
barrierDismissible: false,
builder: (context) => AlertDialog(
title: const Text('Secure UPI & Escrow Gateway'),
content: Column(
mainAxisSize: MainAxisSize.min,
children: [
const Icon(Icons.qr_code_2, size: 100, color: Colors.teal),
const SizedBox(height: 12),
const Text('Synthesizing AI Impact Twin & Ledger Hash...'),
const SizedBox(height: 16),
const CircularProgressIndicator(color: Colors.teal),
const SizedBox(height: 12),
Text('Total Amount: ₹${_totalPayable.toStringAsFixed(2)}',
style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
],
),
),
);

Future.delayed(const Duration(seconds: 3), () {
Navigator.pop(context);
_processSuccessfulDonation();
});
}
}

void _processSuccessfulDonation() async {
final tx = _generateTxHash();
final badgeEarned = _calculateBadge(_donationAmount);
final aiStoryText = _generateAiStory(_donationAmount);

final newRecord = DonationRecord(
anonymousId: _anonymousId,
amount: _donationAmount,
fee: _microFee,
fullName: _nameController.text,
contact: _contactController.text,
address: _addressController.text,
timestamp: DateTime.now().toString().substring(0, 19),
txHash: tx,
badge: badgeEarned,
aiStory: aiStoryText,
);

await AdminDatabase.saveRecord(newRecord);

showDialog(
context: context,
builder: (context) => AlertDialog(
title: const Text('Donation Secured & AI Story Generated! 🎉', style: TextStyle(color: Colors.teal)),
content: SingleChildScrollView(
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Assigned ID: $_anonymousId', style: const TextStyle(fontWeight: FontWeight.bold)),
const SizedBox(height: 4),
Text('Earned Badge: $badgeEarned', style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
const SizedBox(height: 8),
Container(
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: Colors.teal.shade50,
borderRadius: BorderRadius.circular(8),
),
child: Text(aiStoryText, style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.teal)),
),
const SizedBox(height: 8),
Text('Tx Hash: $tx', style: const TextStyle(fontSize: 10, color: Colors.grey)),
],
),
),
actions: [
ElevatedButton(
style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
onPressed: () {
Navigator.pop(context);
Navigator.pop(context);
},
child: const Text('Awesome, Back to Home'),
),
],
),
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Secure Donation Checkout'),
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Form(
key: _formKey,
child: ListView(
children: [
Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: Colors.teal.shade50,
borderRadius: BorderRadius.circular(8),
),
child: Row(
children: [
const Icon(Icons.auto_awesome, color: Colors.teal),
const SizedBox(width: 12),
Expanded(
child: Text(
'Public Donor ID: $_anonymousId\n(Generates AI Impact Story & Ledger Hash)',
style: const TextStyle(fontSize: 13, color: Colors.teal),
),
),
],
),
),
const SizedBox(height: 20),
TextFormField(
controller: _amountController,
keyboardType: TextInputType.number,
decoration: const InputDecoration(
labelText: 'Donation Amount (₹)',
border: OutlineInputBorder(),
prefixIcon: Icon(Icons.currency_rupee),
),
validator: (val) {
if (val == null || double.tryParse(val) == null || double.parse(val) <= 0) {
return 'Please enter a valid amount';
}
return null;
},
),
const SizedBox(height: 12),
if (_donationAmount > 0)
Card(
color: Colors.grey.shade100,
child: Padding(
padding: const EdgeInsets.all(12.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Base Donation: ₹$_donationAmount'),
Text('1% Maintenance Fee: ₹${_microFee.toStringAsFixed(2)}'),
const Divider(),
Text('Estimated Badge: ${_calculateBadge(_donationAmount)}',
style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
const SizedBox(height: 6),
Text(_generateAiStory(_donationAmount),
style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.teal)),
const Divider(),
Text('Total Payable: ₹${_totalPayable.toStringAsFixed(2)}',
style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
],
),
),
),
const SizedBox(height: 16),
const Text('Legal & Compliance Info (Admin Log Only)', style: TextStyle(fontWeight: FontWeight.bold)),
const SizedBox(height: 8),
TextFormField(
controller: _nameController,
decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
validator: (val) => val == null || val.isEmpty ? 'Required for compliance' : null,
),
const SizedBox(height: 12),
TextFormField(
controller: _contactController,
keyboardType: TextInputType.phone,
decoration: const InputDecoration(labelText: 'Contact Number', border: OutlineInputBorder()),
validator: (val) => val == null || val.isEmpty ? 'Required for compliance' : null,
),
const SizedBox(height: 12),
TextFormField(
controller: _addressController,
maxLines: 2,
decoration: const InputDecoration(labelText: 'Full Address', border: OutlineInputBorder()),
validator: (val) => val == null || val.isEmpty ? 'Required for compliance' : null,
),
const SizedBox(height: 24),
ElevatedButton.icon(
style: ElevatedButton.styleFrom(
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
padding: const EdgeInsets.symmetric(vertical: 14),
),
onPressed: _startPaymentSimulation,
icon: const Icon(Icons.auto_awesome),
label: const Text('Proceed via Secure UPI & Generate AI Story', style: TextStyle(fontSize: 16)),
),
],
),
),
),
);
}
}
