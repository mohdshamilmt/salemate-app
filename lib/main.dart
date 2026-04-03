import 'package:flutter/material.dart';
import 'package:post_data_to_api_sample/controller/home_screen_controller.dart';
import 'package:post_data_to_api_sample/controller/profile_screen_controller.dart';
import 'package:post_data_to_api_sample/controller/sales_screen_contoller.dart';
import 'package:post_data_to_api_sample/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenController()),
        ChangeNotifierProvider(create: (context) => SalesScreenContoller()),
        ChangeNotifierProvider(create: (context) => ProfileScreenController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
