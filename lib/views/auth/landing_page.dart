import 'package:flutter/material.dart';
import 'package:trilo_admin/locator.dart';
import 'package:trilo_admin/models/user.dart';
import 'package:trilo_admin/services/auth.dart';
import 'package:trilo_admin/views/auth/welcome.dart';
import 'package:trilo_admin/views/dashboard/dashboard.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final AuthService _authService = locator<AuthService>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: _authService.authStateChanges,
        builder: (context, snapshot) {
          User? user = snapshot.data;
          // if (user == null) {
          //   return const Welcome();
          // }
          return const Dashboard();
        });
  }
}
