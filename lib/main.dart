import 'dart:io';

import '/Screens/Cow/cow2.dart';
import '/Screens/Cow/cow3.dart';
import '/Screens/Cow/cow4.dart';
import '/Screens/Cow/cow5.dart';
import '/Screens/Welcome/otp.dart';
import '/Screens/Welcome/register.dart';
import '/Screens/Welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'providers/auth.dart';
import 'providers/user_provider.dart';
import 'models/User.dart' as dairyuser;
import 'models/UserDairys.dart';
import 'util/shared_preference.dart';
import 'util/register_store.dart';
import 'Screens/Farm/confirm_create_farm.dart';

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpoverrides();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    Future<dairyuser.User> getUserData() => UserPreferences().getUser();
    Future<UserDairys> getUser() => UserPreferences().getUserDairy();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          Provider<RegisterStore>(create: (_) => RegisterStore()),
          Provider<AuthProvider>(create: (_) => AuthProvider()),
          ChangeNotifierProxyProvider<UserProvider, AuthProvider>(
            create: (_) => AuthProvider(),
            update:
                (_, UserProvider userProvider, AuthProvider? authProvider) =>
                    AuthProvider(),
          ),
        ],
        child: MaterialApp(
            theme: ThemeData(fontFamily: 'Mitr'),
            initialRoute: '/',
            routes: {
              ConfirmCreateFarm.routeName: (context) => ConfirmCreateFarm(),
              RegisterScreen.routeName: (context) => RegisterScreen(),
              OTP.routeName: (context) => OTP(),
              Cow2.routeName: (context) => Cow2(),
              Cow3.routeName: (context) => Cow3(),
              Cow4.routeName: (context) => Cow4(),
              Cow5.routeName: (context) => Cow5(),
            },
            home: Welcome()));
  }
}
