import 'package:flutter/material.dart';

void main() {
runApp(const PunyaSetuApp());
}

class PunyaSetuApp extends StatelessWidget {
const PunyaSetuApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'PunyaSetu',
theme: ThemeData(
primarySwatch: Colors.indigo,
scaffoldBackgroundColor: const Color(0xFFF8F9FA),
),
home: const MainContainer(),
);
}
}

class NeedItem {
final String id;
final String title;
final String category;
final String institution;
final double targetAmount;
double raisedAmount;
final IconData icon;

NeedItem({
required this.id,
required this.title,
required this.category,
required this.institution,
required this.targetAmount,
required this.raisedAmount,
required this.icon,
});
}

class ReceiptItem {
final String title;
final String institution;
final String amountCleared;

ReceiptItem({
required this.title,
required this.institution,
required this.amountCleared,
});
}

class MainContainer extends StatefulWidget {
const MainContainer({super.key});

@override
State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
int _selectedIndex = 0;

final List<NeedItem> _needs = [
NeedItem(
id: '1',
title: 'Help Rohan pursue higher education',
category: 'Verified Educational Need',
institution: 'Delhi Public School Account',
targetAmount: 25000,
raisedAmount: 18500,
icon: Icons.school,
),
NeedItem(
id: '2',
title: 'Medical Aid - Urgent surgery support',
category: 'Verified Medical Need',
institution: 'AIIMS Hospital Trust Account',
targetAmount: 50000,
raisedAmount: 5000,
icon: Icons.local_hospital,
),
];

final List<ReceiptItem> _receipts = [
ReceiptItem(
title: 'School Fee Receipt #4082',
institution: 'Delhi Public School',
amountCleared: '₹18,500 Direct Cleared',
),
ReceiptItem(
title: 'Hospital Bill Audit #9911',
institution: 'AIIMS New Delhi',
amountCleared: '₹5,000 Direct Cleared',
),
];

void _processDirectPayment(NeedItem item, double amount) {
setState(() {
item.raisedAmount += amount;
_receipts.insert(
0,
ReceiptItem(
title: 'Direct Contribution Receipt #${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
institution: item.institution,
amountCleared: '₹${amount.toInt()} Direct Cleared',
),
);
});
}

@override
Widget build(BuildContext context) {
final List<Widget> pages = [
HomeScreen(
needs: _needs,
onPay: _processDirectPayment,
),
const CategoryScreen(),
ImpactScreen(receipts: _receipts),
const ProfileScreen(),
];

return Scaffold(
body: pages[_selectedIndex],
bottomNavigationBar: BottomNavigationBar(
currentIndex: _selectedIndex,
selectedItemColor: const Color(0xFF102A63),
unselectedItemColor: Colors.grey,
onTap: (index) {
setState(() {
_selectedIndex = index;
});
},
items: const [
BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
BottomNavigationBarItem(icon: Icon(Icons.volunteer_activism), label: 'Impact'),
BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
],
),
);
}
}

class HomeScreen extends StatefulWidget {
final List<NeedItem> needs;
final Function(NeedItem, double) onPay;

const HomeScreen({super.key, required this.needs, required this.onPay});

@override
State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int selectedCategory = 0;
final List<String> categories = ['Education', 'Medical', 'Ration', 'All'];

@override
Widget build(BuildContext context) {
return SafeArea(
child: SingleChildScrollView(
child: Column(
children: [
Container(
padding: const EdgeInsets.all(16.0),
color: const Color(0xFF102A63),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Row(
children: const [
Icon(Icons.location_on, color: Colors.white, size: 20),
SizedBox(width: 6),
Text(
'New Delhi - 110001',
style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
),
Icon(Icons.keyboard_arrow_down, color: Colors.white),
],
),
Row(
children: const [
Icon(Icons.search, color: Colors.white),
SizedBox(width: 16),
CircleAvatar(
radius: 16,
backgroundColor: Colors.amber,
child: Icon(Icons.person, color: Colors.white, size: 20),
),
],
),
],
),
),
Container(
width: double.infinity,
padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
decoration: const BoxDecoration(
color: Color(0xFFE86012),
borderRadius: BorderRadius.only(
bottomLeft: Radius.circular(20),
bottomRight: Radius.circular(20),
),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: const [
Text(
'Welcome to PunyaSetu',
style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
),
SizedBox(height: 4),
Text(
'Your Bridge to Direct Giving',
style: TextStyle(color: Colors.white70, fontSize: 14),
),
],
),
),
const SizedBox(height: 16),
Padding(
padding: const EdgeInsets.symmetric(horizontal: 16.0),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: List.generate(categories.length, (index) {
bool isSelected = selectedCategory == index;
return GestureDetector(
onTap: () => setState(() => selectedCategory = index),
child: Container(
padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
decoration: BoxDecoration(
color: isSelected ? const Color(0xFF102A63) : Colors.white,
borderRadius: BorderRadius.circular(12),
border: Border.all(color: Colors.grey.shade300),
),
child: Text(
categories[index],
style: TextStyle(
color: isSelected ? Colors.white : Colors.black87,
fontWeight: FontWeight.bold,
),
),
),
);
}),
),
),
const SizedBox(height: 20),
Padding(
padding: const EdgeInsets.symmetric(horizontal: 16.0),
child: Column(
children: widget.needs.map((item) {
return Padding(
padding: const EdgeInsets.only(bottom: 16.0),
child: NeedCard(
item: item,
onPay: widget.onPay,
),
);
}).toList(),
),
),
],
),
),
);
}
}

class NeedCard extends StatelessWidget {
final NeedItem item;
final Function(NeedItem, double) onPay;

const NeedCard({
super.key,
required this.item,
required this.onPay,
});

void _showPaymentModal(BuildContext context) {
final TextEditingController amountController = TextEditingController(text: '1000');

showModalBottomSheet(
context: context,
shape: const RoundedRectangleBorder(
borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
),
builder: (ctx) {
return Padding(
padding: const EdgeInsets.all(20.0),
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Direct Institution Payment',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF102A63)),
),
const SizedBox(height: 8),
Text('Beneficiary: ${item.institution}', style: const TextStyle(fontWeight: FontWeight.w600)),
const SizedBox(height: 12),
TextField(
controller: amountController,
keyboardType: TextInputType.number,
decoration: const InputDecoration(
labelText: 'Amount (₹)',
border: OutlineInputBorder(),
),
),
const SizedBox(height: 16),
ElevatedButton.icon(
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFFE86012),
minimumSize: const Size(double.infinity, 45),
),
icon: const Icon(Icons.qr_code, color: Colors.white),
label: const Text('Simulate UPI Direct Transfer', style: TextStyle(color: Colors.white)),
onPressed: () {
final amount = double.tryParse(amountController.text) ?? 1000;
onPay(item, amount);
Navigator.pop(ctx);
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text('Payment of ₹${amount.toInt()} directly cleared to ${item.institution}!')),
);
},
),
],
),
);
},
);
}

@override
Widget build(BuildContext context) {
return Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(16),
boxShadow: [
BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
],
),
child: Row(
children: [
Container(
width: 70,
height: 70,
decoration: BoxDecoration(
color: Colors.blue.shade50,
borderRadius: BorderRadius.circular(12),
),
child: Icon(item.icon, color: const Color(0xFF102A63), size: 36),
),
const SizedBox(width: 12),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
const SizedBox(height: 4),
Row(
children: [
const Icon(Icons.check_circle, color: Colors.green, size: 14),
const SizedBox(width: 4),
Text(item.category, style: const TextStyle(color: Colors.grey, fontSize: 11)),
],
),
const SizedBox(height: 8),
Text(
'Target: ₹${item.targetAmount.toInt()} | Raised: ₹${item.raisedAmount.toInt()}',
style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
),
const SizedBox(height: 8),
SizedBox(
width: double.infinity,
height: 32,
child: ElevatedButton(
style: ElevatedButton.styleFrom(
backgroundColor: const Color(0xFFE86012),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
),
onPressed: () => _showPaymentModal(context),
child: const Text('Direct Pay', style: TextStyle(color: Colors.white, fontSize: 12)),
),
),
],
),
),
],
),
);
}
}

class CategoryScreen extends StatelessWidget {
const CategoryScreen({super.key});

@override
Widget build(BuildContext context) {
return SafeArea(
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text('Categories Overview', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF102A63))),
const SizedBox(height: 16),
_buildCategoryTile(Icons.school, 'Education Support', 'Direct school & college fee transfers'),
_buildCategoryTile(Icons.local_hospital, 'Medical Emergency', 'Hospital bill clearance'),
_buildCategoryTile(Icons.shopping_bag, 'Ration & Essentials', 'Direct vendor food supply'),
],
),
),
);
}

Widget _buildCategoryTile(IconData icon, String title, String subtitle) {
return Card(
margin: const EdgeInsets.only(bottom: 12),
child: ListTile(
leading: Icon(icon, color: const Color(0xFFE86012), size: 30),
title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
subtitle: Text(subtitle),
trailing: const Icon(Icons.chevron_right),
),
);
}
}

class ImpactScreen extends StatelessWidget {
final List<ReceiptItem> receipts;

const ImpactScreen({super.key, required this.receipts});

@override
Widget build(BuildContext context) {
return SafeArea(
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Proof of Direct Settlement',
style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF102A63)),
),
const SizedBox(height: 6),
const Text(
'Real-time verified receipts uploaded directly by partner institutions.',
style: TextStyle(color: Colors.grey, fontSize: 12),
),
const SizedBox(height: 20),
Expanded(
child: ListView.builder(
itemCount: receipts.length,
itemBuilder: (context, index) {
final receipt = receipts[index];
return Padding(
padding: const EdgeInsets.only(bottom: 12.0),
child: Container(
padding: const EdgeInsets.all(14),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(12),
border: Border.all(color: Colors.green.shade200),
),
child: Row(
children: [
const Icon(Icons.verified, color: Colors.green, size: 30),
const SizedBox(width: 12),
Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(receipt.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
Text(receipt.institution, style: const TextStyle(color: Colors.grey, fontSize: 12)),
const SizedBox(height: 4),
Text(
receipt.amountCleared,
style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 12),
),
],
),
),
const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
],
),
),
);
},
),
)
],
),
),
);
}
}

class ProfileScreen extends StatelessWidget {
const ProfileScreen({super.key});

@override
Widget build(BuildContext context) {
return SafeArea(
child: SingleChildScrollView(
padding: const EdgeInsets.all(16.0),
child: Column(
children: [
const CircleAvatar(
radius: 40,
backgroundColor: Color(0xFF102A63),
child: Icon(Icons.security, color: Colors.white, size: 40),
),
const SizedBox(height: 12),
const Text('Anonymous Donor Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
const Text('Identity Protection Active', style: TextStyle(color: Colors.green, fontSize: 12)),
const SizedBox(height: 20),
Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(12),
border: Border.all(color: Colors.grey.shade300),
),
child: Column(
children: const [
ListTile(
leading: Icon(Icons.monetization_on, color: Colors.indigo),
title: Text('0% Platform Commission'),
subtitle: Text('100% direct route to institution'),
),
Divider(),
ListTile(
leading: Icon(Icons.verified_user, color: Colors.indigo),
title: Text('Verification Engine'),
subtitle: Text('School/Hospital bank account direct binding'),
),
],
),
)
],
),
),
);
}
}
