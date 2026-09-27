import 'package:flutter/material.dart';

class VoiceWallScreen extends StatefulWidget {
const VoiceWallScreen({Key? key}) : super(key: key);

@override
State<VoiceWallScreen> createState() => _VoiceWallScreenState();
}

class _VoiceWallScreenState extends State<VoiceWallScreen> {
final List<Map<String, String>> voiceNotes = [
{
'donor': 'PunyaDonor#4812',
'beneficiary': 'Aarav (Student Scholar)',
'message': '"Thank you so much for the notebook and uniform support! Now I can attend school regularly without worry."',
'duration': '0:12 sec',
},
{
'donor': 'PunyaDonor#9103',
'beneficiary': 'City General Ward Patient',
'message': '"Your direct medical aid covered my emergency medicines. Blessings to you and your family!"',
'duration': '0:18 sec',
},
{
'donor': 'PunyaDonor#2245',
'beneficiary': 'Community Elder Care Shelter',
'message': '"We received warm winter blankets on time thanks to your anonymous contribution."',
'duration': '0:15 sec',
},
];

bool _isPlaying = false;
int? _activeIndex;

void _togglePlay(int index) {
setState(() {
if (_activeIndex == index && _isPlaying) {
_isPlaying = false;
_activeIndex = null;
} else {
_activeIndex = index;
_isPlaying = true;
}
});
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Voice Note Gratitude Wall 🎙️'),
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'Direct Audio Messages from Beneficiaries',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
),
const SizedBox(height: 6),
const Text(
'Listen to heartfelt, anonymous voice notes sent straight from the ground.',
style: TextStyle(fontSize: 13, color: Colors.grey),
),
const SizedBox(height: 16),
Expanded(
child: ListView.builder(
itemCount: voiceNotes.length,
itemBuilder: (context, index) {
final note = voiceNotes[index];
final isCurrentPlaying = _activeIndex == index && _isPlaying;
return Card(
elevation: 3,
margin: const EdgeInsets.symmetric(vertical: 8),
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text(
note['beneficiary']!,
style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.teal),
),
Container(
padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
decoration: BoxDecoration(
color: Colors.orange.shade50,
borderRadius: BorderRadius.circular(10),
),
child: Text(
'For: ${note['donor']}',
style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.orange),
),
),
],
),
const SizedBox(height: 8),
Text(
note['message']!,
style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 13, color: Colors.black87),
),
const SizedBox(height: 12),
Row(
children: [
IconButton(
icon: Icon(
isCurrentPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
color: Colors.teal,
size: 36,
),
onPressed: () => _togglePlay(index),
),
const SizedBox(width: 8),
Expanded(
child: LinearProgressIndicator(
value: isCurrentPlaying ? 0.7 : 0.0,
backgroundColor: Colors.teal.shade50,
valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
),
),
const SizedBox(width: 12),
Text(
note['duration']!,
style: const TextStyle(fontSize: 12, color: Colors.grey),
),
],
),
],
),
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
