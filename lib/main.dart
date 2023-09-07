import 'dart:io';

import 'package:cbz_generator/app/presentation/controllers/snackbar_controller.dart';
import 'package:cbz_generator/app/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('CBZ Generator');
    setWindowMaxSize(const Size(double.infinity, double.infinity));
    setWindowMinSize(const Size(384, 300));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: snackbarProvider,
      builder: (_, controller) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          scaffoldMessengerKey: controller.key,
          home: const HomePage(),
        );
      },
    );
  }
}
