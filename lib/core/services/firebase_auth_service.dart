import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  FirebaseAuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Use the singleton instance
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  /// 🔹 Current user
  static User? get currentUser => _auth.currentUser;

  /// 🔹 Auth state stream
  static Stream<User?> authStateChanges() => _auth.authStateChanges();

  /// 🔹 Google Sign-In 🎯 NEW
  static Future<UserCredential?> signInWithGoogle() async {
    // 1️⃣ Initialize Google Sign-In
    await _googleSignIn.initialize();

    // 2️⃣ Trigger sign in UI
    final GoogleSignInAccount? googleUser =
    await _googleSignIn.authenticate();

    if (googleUser == null) {
      // User cancelled the sign-in flow
      return null;
    }

    // 3️⃣ Get authentication tokens
    final auth = await googleUser.authentication;

    // NOTE: `auth.idToken` might be null if no serverClientId is provided.
    final idToken = auth.idToken;
    if (idToken == null) {
      throw Exception('Google ID token is null');
    }

    // 4️⃣ Create a Firebase credential
    final credential = GoogleAuthProvider.credential(
      idToken: idToken,
    );

    // 5️⃣ Sign in with credential
    return await _auth.signInWithCredential(credential);
  }

  /// 🔹 Logout
  static Future<void> signOut() async {
    // Sign out from Google
    await _googleSignIn.disconnect();
    // Sign out from Firebase
    await _auth.signOut();
  }
}
