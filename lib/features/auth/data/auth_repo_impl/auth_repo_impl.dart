import 'package:car_rental/features/auth/domain/authrepo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../fail.dart';

class AuthRepImp implements AuthRepo {
  final FirebaseAuth firebaseAuth;

  AuthRepImp({required this.firebaseAuth});

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return Left(Failure("Email and password cannot be empty."));
      }

      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        return Left(Failure("No user found for this email."));
      }

      if (!user.emailVerified) {
        return Left(Failure("Please verify your email to log in."));
      }

      return Right(user);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = "No account found for this email.";
          break;
        case 'wrong-password':
          message = "Incorrect password. Please try again.";
          break;
        case 'invalid-email':
          message = "Invalid email format.";
          break;
        default:
          message = "Failed to log in: ${e.message}";
      }
      return Left(Failure(message));
    } catch (e) {
      return Left(Failure("Unexpected error during login: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return Left(Failure("Email and password cannot be empty."));
      }

      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = result.user;

      if (user == null) {
        return Left(Failure("Failed to create user."));
      }

      await user.sendEmailVerification();
      return Right(user);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = "This email is already registered.";
          break;
        case 'invalid-email':
          message = "Invalid email format.";
          break;
        case 'weak-password':
          message = "Password is too weak. Please use a stronger password.";
          break;
        default:
          message = "Failed to sign up: ${e.message}";
      }
      return Left(Failure(message));
    } catch (e) {
      return Left(Failure("Unexpected error during sign up: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      if (firebaseAuth.currentUser == null) {
        return Left(Failure("No user is currently signed in."));
      }
      await firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Failure("Failed to sign out: ${e.toString()}"));
    }
  }
}