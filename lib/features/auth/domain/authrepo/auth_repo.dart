import 'package:car_rental/features/auth/data/fail.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo{
 Future<Either<Failure,User>> login({required String email,required String password});
 Future<Either<Failure,User>> signUp({required String email,required String password});
 Future<Either<Failure, void>>  signOut();
}