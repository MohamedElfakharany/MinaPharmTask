import 'package:minapharm/models/user_model.dart';

abstract class MovieStates{}

class MovieInitialState extends MovieStates{}

class MovieLoginLoadingState extends MovieStates{}

class MovieLoginSuccessState extends MovieStates{
  final LoginModel loginModel;
  MovieLoginSuccessState(this.loginModel);
}

class MovieLoginErrorState extends MovieStates{
  final String error;
  MovieLoginErrorState(this.error);
}

class MovieRegisterLoadingState extends MovieStates{}

class MovieRegisterSuccessState extends MovieStates{
  final LoginModel loginModel;
  MovieRegisterSuccessState(this.loginModel);
}

class MovieRegisterErrorState extends MovieStates{
  final String error;
  MovieRegisterErrorState(this.error);
}

class MovieChangePasswordVisibilityState extends MovieStates{}

class MovieLogoutSuccessState extends MovieStates{}

class MovieGetMovieDataLoadingState extends MovieStates{}

class MovieGetMovieDataSuccessState extends MovieStates{}

class MovieGetMovieDataErrorState extends MovieStates{}
