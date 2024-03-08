import '../either/either.dart';
import '../failures/sign_in/sign_in_failure.dart';
import '../models/user/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  
  Future<void> singOut();
  Future<Either<SignInFailure, User>> singIn(
    String username,
    String password,
  );
}
