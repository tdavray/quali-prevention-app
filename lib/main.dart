import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sdm_academy_app/common/style.dart';
import 'package:sdm_academy_app/services/auth_service.dart';
import 'package:sdm_academy_app/ui/auth/sign_in_widget.dart';
import 'package:sdm_academy_app/ui/auth/sign_up_widget.dart';
import 'package:sdm_academy_app/ui/main/2_commissions/commission_detail_page.dart';
import 'package:sdm_academy_app/ui/main/4_news/news_detail_page.dart';
import 'package:sdm_academy_app/ui/main/5_products/product_detail_page.dart';
import 'package:sdm_academy_app/ui/main/navigation_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Vérifier l'authentification
  AuthService authService = AuthService();
  String? token = await authService.getSavedToken();

  String initialRoute = (token != null) ? '/home' : '/sign_in';

  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.Debug.setLogLevel(OSLogLevel.error);

  OneSignal.initialize("f68e91f0-4642-4087-8e25-5097f7ddef63");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  runApp(SDMAcademyApp(initialRoute: initialRoute));
}

class SDMAcademyApp extends StatelessWidget {
  final String initialRoute;

  const SDMAcademyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: kTheme,
      title: 'SDM Academy',
      initialRoute: initialRoute,
      routes: {
        '/sign_in': (context) => const SignInWidget(),
        '/sign_up': (context) => const SignUpWidget(),
        '/home': (context) => const NavigationPage(),
        '/commission_detail': (context) => const CommissionDetailPage(),
        '/news_detail': (context) => const NewsDetailPage(),
        '/product_detail': (context) => const ProductDetailPage(),
      },
    );
  }
}
