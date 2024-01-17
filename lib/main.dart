import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ifind/controller/category_controller.dart';
import 'package:ifind/controller/client/home_controller.dart';
import 'package:ifind/controller/reg_mark_map_controller.dart';
import 'package:ifind/firebase_options.dart';
import 'package:ifind/routes.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'controller/client/services_view_controller.dart';
import 'controller/establishment/product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox("session");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryController(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegMapController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductController(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ServicesViewController(),
        )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'iFind',
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        routerConfig: router,
      ),
    );
  }
}
