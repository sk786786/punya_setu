import 'package:flutter/material.dart';

class AppLocalization {
static Map<String, Map<String, String>> localizedValues = {
'en': {
'dashboard': 'PunyaSetu Dashboard',
'secure_donation': 'Secure Donation',
'live_map': 'Live Impact Map',
'voice_wall': 'Voice Wall',
'certificate': 'Impact Certificate',
'roundup': 'Micro-Roundup',
'admin_panel': 'Admin Panel',
},
'hi': {
'dashboard': 'पुण्यसेतु डैशबोर्ड',
'secure_donation': 'सुरक्षित दान',
'live_map': 'लाइव इम्पैक्ट मैप',
'voice_wall': 'वॉइस वॉल',
'certificate': 'प्रभाव प्रमाणपत्र',
'roundup': 'माइक्रो-राउंडअप',
'admin_panel': 'एडमिन पैनल',
}
};

static String get(String langCode, String key) {
return localizedValues[langCode]?[key] ?? localizedValues['en']![key]!;
}
}
