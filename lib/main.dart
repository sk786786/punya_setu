import 'package:flutter/material.dart';
import 'donation_screen.dart';
import 'map_screen.dart';
import 'voice_wall_screen.dart';
import 'certificate_screen.dart';
import 'roundup_screen.dart';
import 'admin_dashboard_screen.dart';
import 'ai_impact_screen.dart';
import 'package:flutter/gestures.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await AdminDatabase.loadRecords();
runApp(const PunyaSetuApp());
}

class SmoothScrollBehavior extends MaterialScrollBehavior {
@override
Set<PointerDeviceKind> get dragDevices => {
PointerDeviceKind.touch,
PointerDeviceKind.mouse,
PointerDeviceKind.trackpad,
};
}

class PunyaSetuApp extends StatefulWidget {
const PunyaSetuApp({Key? key}) : super(key: key);

@override
State<PunyaSetuApp> createState() => _PunyaSetuAppState();
}

class _PunyaSetuAppState extends State<PunyaSetuApp> {
bool _isDarkMode = false;

void _toggleTheme() {
setState(() {
_isDarkMode = !_isDarkMode;
});
}

@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'PunyaSetu',
scrollBehavior: SmoothScrollBehavior(),
theme: _isDarkMode ? ThemeData.dark() : ThemeData(
primarySwatch: Colors.teal,
scaffoldBackgroundColor: Colors.grey.shade50,
),
home: DashboardScreen(onToggleTheme: _toggleTheme, isDarkMode: _isDarkMode),
debugShowCheckedModeBanner: false,
);
}
}

class DashboardScreen extends StatelessWidget {
final VoidCallback onToggleTheme;
final bool isDarkMode;

const DashboardScreen({Key? key, required this.onToggleTheme, required this.isDarkMode}) : super(key: key);

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('PunyaSetu Enterprise Dashboard'),
backgroundColor: Colors.teal,
foregroundColor: Colors.white,
actions: [
IconButton(
icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
onPressed: onToggleTheme,
),
],
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: GridView.count(
crossAxisCount: 2,
crossAxisSpacing: 16,
mainAxisSpacing: 16,
children: [
_DashboardCard(
title: 'Secure Donation',
icon: Icons.volunteer_activism,
color: Colors.teal,
onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => const DonationScreen()));
},
),
_DashboardCard(
title: 'Live Impact Map',
icon: Icons.map,
color: Colors.blue,
onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen()));
},
),
_DashboardCard(
title: 'Voice Wall',
icon: Icons.mic,
color: Colors.orange,
onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => const VoiceWallScreen()));
},
),
_DashboardCard(
title: 'Impact Certificate',
icon: Icons.card_membership,
color: Colors.purple,
onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => const CertificateScreen()));
},
),
_DashboardCard(
title: 'Micro-Roundup',
icon: Icons.savings,
color: Colors.green,
onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => const RoundupScreen()));
},
),
_DashboardCard(
title: 'AI Impact Story',
icon: Icons.psychology,
color: Colors.deepOrange,
onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => const AIImpactScreen()));
},
),
_DashboardCard(
title: 'Admin Audit Panel',
icon: Icons.admin_panel_settings,
color: Colors.indigo,
onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDashboardScreen()));
},
),
],
),
),
);
}
}

class _DashboardCard extends StatelessWidget {
final String title;
final IconData icon;
final Color color;
final VoidCallback onTap;

const _DashboardCard({
required this.title,
required this.icon,
required this.color,
required this.onTap,
});

@override
Widget build(BuildContext context) {
return InkWell(
onTap: onTap,
borderRadius: BorderRadius.circular(16),
child: Card(
elevation: 4,
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
child: Container(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(16),
gradient: LinearGradient(
colors: [color.withOpacity(0.1), color.withOpacity(0.02)],
begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Icon(icon, size: 48, color: color),
const SizedBox(height: 12),
Text(
title,
textAlign: TextAlign.center,
style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
),
],
),
),
),
);
}
}
