import 'package:duty_allocation_system/api_services/employee_methods/employee.dart';
import 'package:duty_allocation_system/providers/duty_provider.dart';
import 'package:duty_allocation_system/providers/employee_provider.dart';
import 'package:duty_allocation_system/providers/user_provider.dart';
import 'package:duty_allocation_system/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  await EmployeeServices.enableOfflinePersistence();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft
  ]);



  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DutyProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => EmployeeProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
