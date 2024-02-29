
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'Route_managements/all_pages.dart';
import 'Route_managements/routes.dart';
import 'Route_managements/screen_bindings.dart';


void main() {
  runApp(const MyApp());
}

// void main() => runApp(
//   DevicePreview(
//     enabled: !kReleaseMode,
//     builder: (context) => MyApp(), // Wrap your app
//   ),
// );


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: splashScreen,
      getPages: AllPages.getPages(),
      initialBinding: ScreenBindings(),
      title: 'Lucknowichikankari ',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.white,
      ),

    );
  }
}

