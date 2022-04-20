import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:case_study/providers/auth.dart';
import 'package:case_study/theme/theme.dart';
import 'package:case_study/view/auth/log_in.dart';
import 'package:case_study/view/auth/sign_up.dart';
import 'package:case_study/view/auth/sign_up_password.dart';
import 'package:case_study/view/menu/menu.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Case Study',
        theme: ThemeSettings.myTheme,
        routes: {
          LogInScreen.route: (_) => const LogInScreen(),
          SignUpScreen.route: (_) => const SignUpScreen(),
          SignUpPasswordScreen.route: (_) => const SignUpPasswordScreen(),
          MenuScreen.route: (_) => const MenuScreen(),
        },
        home: const LogInScreen(),
      ),
    );
  }
}
