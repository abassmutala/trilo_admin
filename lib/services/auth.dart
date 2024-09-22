import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:trilo_admin/locator.dart';
import 'package:trilo_admin/models/user.dart';
import 'package:trilo_admin/services/db.dart';
import 'package:trilo_admin/utils/utilities.dart';

abstract class AuthBase {
  Stream<User?> get authStateChanges;
  User? get currentUser;
  Future<User?> signInWithGoogle();
}

class AuthService extends AuthBase {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final DatabaseService db = locator<DatabaseService>();

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      email: user.email,
      dateJoined: user.metadata.creationTime!.toString(),
      phone: user.phoneNumber,
    );
  }

  @override
  Stream<User?> get authStateChanges =>
      _auth.authStateChanges().map(_userFromFirebase);

  @override
  User? get currentUser {
    final user = _auth.currentUser;
    if (user == null) return null;
    return _userFromFirebase(user);
  }

  @override
  Future<User?> signInWithGoogle() async {
    // Sign in with Google
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
      );
    }
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    if (googleSignInAuthentication.accessToken == null &&
        googleSignInAuthentication.idToken == null) {
      throw PlatformException(
        code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
      );
    }

    final auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    // Authenticate with Firebase
    final auth.UserCredential authResult =
        await _auth.signInWithCredential(credential);

    // Link the pending credential with the existing account
    // if (_pendingCredential != null) {
    //   await userCredential.user?.linkWithCredential(_pendingCredential!);
    //   _clearPendingData();
    // }

    final auth.User? user = authResult.user;

    // Check if user exists in Firestore
    final userExists = await db.checkIfUserExists(user!.uid);

    if (!userExists) {
      // Create user document in Firestore if it doesn't exist
      final List<String> names = user.displayName!.split(' ');
      final String firstname = names[0];
      final String? lastname = names.length > 1 ? names[1] : null;
      // final uniqueCode = const Uuid().v4();
      User newUser = User(
        uid: user.uid,
        firstName: firstname,
        lastName: lastname,
        email: user.email,
        phone: user.phoneNumber,
        role: "admin",
        color: Utilities.generateRandomColor(),
        dateJoined: user.metadata.creationTime.toString(),
        addedStores: [],
        // deviceInfo: deviceInfo,
        // uniqueCode: Utilities.generateUniqueCode(uniqueCode),
      );

      await db.createProfile(newUser);
    }

    return _userFromFirebase(user);
  }
}
