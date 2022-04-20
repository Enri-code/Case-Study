import 'package:case_study/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  static const route = '/menu';
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hello,', style: TextStyle(fontSize: 32)),
              Text(context.watch<AuthProvider>().user.email,
                  style: const TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
