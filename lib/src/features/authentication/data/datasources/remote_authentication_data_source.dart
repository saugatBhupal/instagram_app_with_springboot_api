import 'package:instagram/src/core/models/user/user_model.dart';
import 'package:instagram/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:instagram/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';

abstract class RemoteAuthenticationDatasource {
  Future<UserModel> signUp(SignUpRequestDto signupParams);
  Future<UserModel> signIn(SignInRequestDto signinParams);
}
