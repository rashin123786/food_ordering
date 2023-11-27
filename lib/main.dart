import 'package:flutter/material.dart';
import 'package:food_ordering/core/provider/home_provider.dart';
import 'package:food_ordering/core/provider/loading_provider.dart';
import 'package:food_ordering/view/screen/splash%20Screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoadingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
