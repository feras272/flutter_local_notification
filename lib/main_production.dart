import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notification/local_notification_service.dart';
import 'package:flutter_local_notification/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.init();
  runApp(const MyApp(title: "Production Flavor",));
}