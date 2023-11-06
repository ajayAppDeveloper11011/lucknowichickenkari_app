import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucknowichickenkari_app/Utils/colors.dart';





Future<bool> isNetworkAvailable() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

back() {
  return const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.primary,AppColors.secondary],
        stops: [0, 1]),
  );
}

shadow() {
  return const BoxDecoration(
    boxShadow: [
      BoxShadow(color: Color(0x1a0400ff), offset: Offset(0, 0), blurRadius: 30)
    ],
  );
}

placeHolder(double height) {
  return const AssetImage(
    'assets/images/placeholder.png',
  );
}

erroWidget(double size) {
  return Image.asset(
    'assets/images/placeholder.png',
    height: size,
    width: size,
  );
}

errorWidget(double size) {
  return Icon(
    Icons.account_circle,
    color: Colors.grey,
    size: size,
  );
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyBehavior1 extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

getSimpleAppBar(
    String title,
    BuildContext context,
    ) {
  return AppBar(
    titleSpacing: 0,
    backgroundColor: AppColors.primary,
    leading: Builder(builder: (BuildContext context) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: () => Navigator.of(context).pop(),
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.whit,
            ),
          ),
        ),
      );
    }),
    title: Text(
      title,
      style: const TextStyle(color:AppColors.whit, fontWeight: FontWeight.normal),
    ),
  );
}



noIntImage() {
  return SvgPicture.asset(
    'assets/images/no_internet.svg',
    fit: BoxFit.contain,
    color: AppColors.primary,
  );
}

setSnackbar(String msg, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
    content:Text(
      msg,
      textAlign: TextAlign.center,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
    ),
    backgroundColor:AppColors.whit,
    elevation: 1.0,
  ));
}

String imagePath = 'assets/images/';

noIntText(BuildContext context) {
  return Container(
      child: Text('NO INTERNET',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color:AppColors.primary, fontWeight: FontWeight.normal)));
}

noIntDec(BuildContext context) {
  return Container(
    padding: EdgeInsetsDirectional.only(top: 30.0, start: 30.0, end: 30.0),
    child: Text('NO INTERNET',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline6!.copyWith(
              color:Colors.black12,
              fontWeight: FontWeight.normal,
            )),
  );
}

Widget showCircularProgress(bool _isProgress, Color color) {
  if (_isProgress) {
    return Center(
        child: CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(color),
    ));
  }
  return Container(
    height: 0.0,
    width: 0.0,
  );
}

imagePlaceHolder(double size, BuildContext context) {
  return Container(
    height: size,
    width: size,
    child: Icon(
      Icons.account_circle,
      color:AppColors.whit,
      size: size,
    ),
  );
}

String? validateUserName(String value, String? msg1, String? msg2) {
  if (value.isEmpty) {
    return msg1;
  }
  if (value.length <= 1) {
    return msg2;
  }
  return null;
}

String? validateMob(String value, String? msg1, String? msg2) {
  if (value.isEmpty) {
    return msg1;
  }
  if (value.length < 10) {
    return msg2;
  }
  return null;
}

String? validateCountryCode(String value, String msg1, String msg2) {
  if (value.isEmpty) {
    return msg1;
  }
  if (value.length <= 0) {
    return msg2;
  }
  return null;
}

String? validatePass(String value, String? msg1, String? msg2) {
  if (value.length == 0)
    return msg1;
  else if (value.length <= 5)
    return msg2;
  else
    return null;
}

String? validateAltMob(String value, String? msg) {
  if (value.isNotEmpty) if (value.length < 9) {
    return msg;
  }
  return null;
}

String? validateField(String value, String? msg) {
  if (value.length == 0)
    return msg;
  else
    return null;
}

String? validatePincode(String value, String? msg1) {
  if (value.length == 0)
    return msg1;
  else
    return null;
}

String? validateEmail(String value, String? msg1, String? msg2) {
  if (value.length == 0) {
    return msg1;
  } else if (!RegExp(
          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
          r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+"
          r"[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
      .hasMatch(value)) {
    return msg2;
  } else {
    return null;
  }
}

Widget getProgress() {
  return Center(child: CircularProgressIndicator());
}

Widget getNoItem(BuildContext context) {
  return Center(child: Text('noItem'));
}
//
// Widget shimmer(BuildContext context) {
//   return Container(
//     width: double.infinity,
//     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//     child: Shimmer.fromColors(
//       baseColor: Theme.of(context).colorScheme.simmerBase,
//       highlightColor: Theme.of(context).colorScheme.simmerHigh,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
//               .map((_) => Padding(
//                     padding: const EdgeInsetsDirectional.only(bottom: 8.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: 80.0,
//                           height: 80.0,
//                           color: Theme.of(context).colorScheme.white,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: double.infinity,
//                                 height: 18.0,
//                                 color: Theme.of(context).colorScheme.white,
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 5.0),
//                               ),
//                               Container(
//                                 width: double.infinity,
//                                 height: 8.0,
//                                 color: Theme.of(context).colorScheme.white,
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 5.0),
//                               ),
//                               Container(
//                                 width: 100.0,
//                                 height: 8.0,
//                                 color: Theme.of(context).colorScheme.white,
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 5.0),
//                               ),
//                               Container(
//                                 width: 20.0,
//                                 height: 8.0,
//                                 color: Theme.of(context).colorScheme.white,
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ))
//               .toList(),
//         ),
//       ),
//     ),
//   );
// }

// Widget singleItemSimmer(BuildContext context) {
//   return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Shimmer.fromColors(
//           baseColor: Theme.of(context).colorScheme.simmerBase,
//           highlightColor: Theme.of(context).colorScheme.simmerHigh,
//           child: Padding(
//             padding: const EdgeInsetsDirectional.only(bottom: 8.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: 80.0,
//                   height: 80.0,
//                   color: Theme.of(context).colorScheme.white,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         height: 18.0,
//                         color: Theme.of(context).colorScheme.white,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5.0),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: 8.0,
//                         color: Theme.of(context).colorScheme.white,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5.0),
//                       ),
//                       Container(
//                         width: 100.0,
//                         height: 8.0,
//                         color: Theme.of(context).colorScheme.white,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 5.0),
//                       ),
//                       Container(
//                         width: 20.0,
//                         height: 8.0,
//                         color: Theme.of(context).colorScheme.white,
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           )));
// }


dialogAnimate(BuildContext context, Widget dialge) {
  return showGeneralDialog(
      barrierColor:Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(opacity: a1.value, child: dialge),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      // pageBuilder: null
      pageBuilder: (context, animation1, animation2) {
        return Container();
      } //as Widget Function(BuildContext, Animation<double>, Animation<double>)
      );
}



