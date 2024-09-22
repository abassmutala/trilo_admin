import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trilo_admin/constants/ui_constants.dart';
import 'package:trilo_admin/locator.dart';
import 'package:trilo_admin/models/user.dart';
import 'package:trilo_admin/services/auth.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late bool isLoading;
  final AuthService _auth = locator<AuthService>();

  Future<User?> _signInWithGoogle() async {
    try {
      setState(() {
        isLoading = true;
      });
      return await _auth.signInWithGoogle();
    } on PlatformException catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint(e.message);
      // PlatformExceptionAlertDialog(
      //   label: "Sign in failed",
      //   primaryActionLabel: "OK",
      //   exception: e,
      // ).show(context);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "images/DeWatermark.ai_1716681469712.png",
          fit: BoxFit.cover,
        ),
        const ModalBarrier(
          color: Colors.black45,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 96.0),
            width: ScreenSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Trilo Admin",
                  style: theme.textTheme.headlineLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 54,
                  width: ScreenSize.width,
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: OutlinedButton(
                    onPressed: isLoading ? null : () => _signInWithGoogle(),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 18.0,
                          width: 18.0,
                          child: Image.asset(
                            "images/google_logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "Continue with Google",
                          style: theme.textTheme.headlineSmall!
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 18.0,
                          width: 18.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Spacing.verticalSpacingXl,
              ],
            ),
          ),
        ),
        Positioned(
          bottom: Sizes.sm,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: Sizes.base),
            child: RichText(
              text: TextSpan(
                text: "Powered by ",
                children: [
                  TextSpan(
                    text: "Crescendo",
                    style: TextStyle(color: theme.colorScheme.secondary),
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "MarkApp",
                    style: TextStyle(color: theme.colorScheme.secondary),
                  )
                ],
                style: theme.textTheme.labelMedium,
              ),
            ),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: Container(
            color: Colors.black54,
            child: Center(
              child: Material(
                type: MaterialType.transparency,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Authenticating...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.lg,
                      ),
                    ),
                    Spacing.verticalSpacingLg,
                    const CircularProgressIndicator.adaptive()
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
