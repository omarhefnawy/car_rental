import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_rental/features/auth/data/auth_repo_impl/auth_repo_impl.dart';
import 'package:car_rental/features/auth/domain/authrepo/auth_repo.dart';

final sl = GetIt.instance;

void initServiceLocator() {
  // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Repos
  sl.registerLazySingleton<AuthRepo>(() => AuthRepImp(firebaseAuth: sl<FirebaseAuth>()));
}
