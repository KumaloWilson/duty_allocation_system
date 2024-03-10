import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static Future<void> login({required String emailAddress, required String password,}) async {
    try {
      final loginResponse = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      // Handle successful login (optional, remove if not needed)
      print('Login successful: ${loginResponse.user!.email}');
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      switch (e.code) {
        case 'invalid-email':
          throw AuthException('Invalid email address format.');
        case 'user-disabled':
          throw AuthException('User account is disabled.');
        case 'user-not-found':
          throw AuthException('No user found for that email.');
        case 'wrong-password':
          throw AuthException('Incorrect password provided.');
        default:
          throw AuthException('Unknown Firebase authentication error: ${e.message}');
      }
    } catch (e) {
      // Handle other unforeseen errors
      rethrow; // Rethrow the original error for broader handling
    }
  }

  // sign up with email and password
  static Future<void> signUpWithVerification({required String emailAddress,String? profilePic,required String gender,required String password,required String userName,required String fullName,required String phoneNumber,required String userRole,required String dob,}) async {
    try {
      // Step 1: Create user with email and password
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      // Step 2: Send verification email
      await userCredential.user!.sendEmailVerification();

      // After user registration is successful, update the user's profile
      await userCredential.user!.updateDisplayName(userName);


      // Step 4: Set custom claim for user role
      final String? userToken = await userCredential.user!.getIdToken();

      await sendUserRoleAndToken(userToken!.toString().trim(), userRole);

      // Custom claims set successfully
      print('Custom claims set successfully');


    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication errors
      switch (e.code) {
        case 'email-already-in-use':
          throw AuthException('The email address is already in use.');
        case 'weak-password':
          throw AuthException('The password provided is too weak.');
        default:
          throw AuthException('Unknown Firebase authentication error: ${e.message}');
      }
    } catch (e) {
      // Handle other unforeseen errors
      rethrow; // Rethrow the original error for broader handling
    }
  }


  // Function to send user role and token to server
  static Future<void> sendUserRoleAndToken(String userToken, String userRole) async {
    try {
      const String apiUrl = 'https://set-custom-claim.onrender.com/setCustomClaims';

      final body = {
        'token': userToken,
        'roles': [userRole],
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print('Custom Claims set successfully');
      } else {
        throw Exception('Failed to set custom claims: ${response.body}');
      }
    } catch (e) {
      // Handle errors
      throw Exception('Failed to set custom claims: $e');
    }
  }



  // sign in with google
  static Future<UserCredential> signInWithGoogle() async {
    // begin interactive sign in process
    final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
    );

    // finally sign in the user
    return FirebaseAuth.instance.signInWithCredential(credential);
  }


  static Future<void>signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> sendPasswordResetEmail({required String email}) async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }


}

// Custom AuthException class for better error handling
class AuthException implements Exception {
  final String message;

  const AuthException(this.message);

  @override
  String toString() => message;
}
