import 'package:flutter/material.dart';

class NotificationService {
static void showMilestoneAlert(BuildContext context, String title, String body) {
showDialog(
context: context,
builder: (context) => AlertDialog(
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
title: Row(
children: [
const Icon(Icons.notifications_active, color: Colors.amber),
const SizedBox(width: 8),
Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
],
),
content: Text(body),
actions: [
ElevatedButton(
style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white),
onPressed: () => Navigator.pop(context),
child: const Text('Awesome!'),
),
],
),
);
}
}
