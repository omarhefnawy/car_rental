import 'package:car_rental/features/cars/data/repo_imp/car_repo_imp.dart';
import 'package:car_rental/features/cars/domain/carRepo/carRepo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_rental/features/auth/data/auth_repo_impl/auth_repo_impl.dart';
import 'package:car_rental/features/auth/domain/authrepo/auth_repo.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  //STORAGE
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  // Firebase
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Repos
  sl.registerLazySingleton<AuthRepo>(() => AuthRepImp(firebaseAuth: sl<FirebaseAuth>()));
  sl.registerLazySingleton<CarRepo>(() => CarRepoImpl(firebaseFirestore: sl<FirebaseFirestore>(),firebaseStorage: sl<FirebaseStorage>()));
}
