
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class AuthLoading extends AuthStates {}

class AuthSuccess extends AuthStates {
  final User user;

  AuthSuccess(this.user);
}

class AuthFail extends AuthStates {
  final String message;

  AuthFail(this.message);

}

class SignUpSuccess extends AuthStates {}

class SignOutSuccess extends AuthStates {}

class VerificationEmailSent extends AuthStates {}