import 'package:bloc/bloc.dart';
import 'package:car_rental/features/auth/data/fail.dart';
import 'package:car_rental/features/auth/domain/authrepo/auth_repo.dart';
import 'package:car_rental/features/auth/presentation/auth_bloc/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await authRepo.login(email: email, password: password);
    result.fold(
          (l) => emit(AuthFail(l.message)),
          (r) => emit(AuthSuccess(r)),
    );
  }

  Future<void> signUp({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await authRepo.signUp(email: email, password: password);
    result.fold(
          (l) => emit(AuthFail(l.message)),
          (r) => emit(SignUpSuccess()),
    );
  }

  Future<void> logOut() async {
    emit(AuthLoading());
    final result = await authRepo.signOut();
    result.fold(
          (l) => emit(AuthFail(l.message)),
          (r) => emit(SignOutSuccess()),
    );
  }
}