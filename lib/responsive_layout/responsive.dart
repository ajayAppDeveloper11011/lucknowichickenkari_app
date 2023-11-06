import 'package:flutter/material.dart';

class ResponsiveLayout {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isMobileScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isTabletScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isWebScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }
}

/*

if (ResponsiveLayout.isMobileScreen(context)) {
// Widget for mobile screens
} else if (ResponsiveLayout.isTabletScreen(context)) {
// Widget for tablet screens
} else if (ResponsiveLayout.isWebScreen(context)) {
// Widget for web screens
}*/
