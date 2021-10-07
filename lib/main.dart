import '/Screens/Welcome/otp.dart';
import '/Screens/Welcome/register.dart';
import '/Screens/Welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'providers/auth.dart';
import 'providers/user_provider.dart';
import 'models/User.dart' as DairyUser;
import 'models/UserDairys.dart';
import 'util/shared_preference.dart';
import 'util/register_store.dart';
import 'Screens/Farm/confirm_create_farm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    Future<DairyUser.User> getUserData() => UserPreferences().getUser();
    Future<UserDairys> getUser() => UserPreferences().getUserDairy();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          Provider<RegisterStore>(create: (_) => RegisterStore()),
          Provider<AuthProvider>(create: (_) => AuthProvider()),
         // Provider<ProfileProvider>(create: (_) => ProfileProvider()),
          ChangeNotifierProxyProvider<UserProvider, AuthProvider>(
            create: (_) => AuthProvider(),
            update:
                (_, UserProvider userProvider, AuthProvider? authProvider) =>
                    AuthProvider(),
          ),
        ],
        child: MaterialApp(
            theme: ThemeData(fontFamily: 'Mitr'),
            routes: {
              ConfirmCreateFarm.routeName: (context) => ConfirmCreateFarm(),
              RegisterScreen.routeName: (context) => RegisterScreen(),
              OTP.routeName: (context) => OTP(),
            },
            home: Welcome()));
  }
}
