import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapharm/layout/cubit/states.dart';
import 'package:minapharm/models/movie_data_model.dart';
import 'package:minapharm/models/user_model.dart';
import 'package:minapharm/modules/login/login_screen.dart';
import 'package:minapharm/shared/components/components.dart';
import 'package:minapharm/shared/network/end_points.dart';
import 'package:minapharm/shared/network/local/cache_helper.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit() : super(MovieInitialState());

  static MovieCubit get(context) => BlocProvider.of(context);

  LoginModel? userModel;

  Future login({
    required String email,
    required String password,
    String lang = 'en',
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'lang': lang,
    };
    var formData = FormData.fromMap({
      'email': email,
      'password': password,
    });
    try {
      emit(MovieLoginLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        loginURL,
        data: formData,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      var responseJson2 = response.data;
      var convertedResponse = utf8.decode(responseJson2);
      var responseJson = json.decode(convertedResponse);
      userModel = LoginModel.fromJSON(responseJson);
      emit(MovieLoginSuccessState(userModel!));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(MovieLoginErrorState(e.toString()));
    }
  }

  Future register({
    required String name,
    required String phone,
    required String email,
    required String password,
    String lang = 'en',
  }) async {
    var headers = {
      'Content-Type': 'application/json',
      'lang': lang,
    };
    var formData = FormData.fromMap({
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    });
    try {
      emit(MovieRegisterLoadingState());
      Dio dio = Dio();
      var response = await dio.post(
        registerURL,
        data: formData,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      var responseJson2 = response.data;
      var convertedResponse = utf8.decode(responseJson2);
      var responseJson = json.decode(convertedResponse);
      userModel = LoginModel.fromJSON(responseJson);
      if (kDebugMode) {
        print(userModel?.message.toString());
      }
      emit(MovieRegisterSuccessState(userModel!));
    } catch (e) {
      emit(MovieRegisterErrorState(e.toString()));
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  MovieDataModel? model;

  Future getMovies() async {
    var headers = {
      'X-RapidAPI-Host': 'mdblist.p.rapidapi.com',
      'X-RapidAPI-Key': '4d69f2a1famsh00e59bf81ebdbb1p191c24jsne56522130749'
    };
    var paramaters = {
      'i': 'tt0073195',
    };
    try {
      emit(MovieGetMovieDataLoadingState());
      Dio dio = Dio();
      var response = await dio.get(
        getDataURL,
        queryParameters:paramaters,
        options: Options(
          followRedirects: false,
          responseType: ResponseType.bytes,
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      var responseJson2 = response.data;
      var convertedResponse = utf8.decode(responseJson2);
      var responseJson = json.decode(convertedResponse);
      model = MovieDataModel.fromJson(responseJson);
      if (kDebugMode) {
        print (model?.title);
        print (model?.poster);
      }
      emit(MovieGetMovieDataSuccessState());
    } catch (error)
    {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(MovieGetMovieDataErrorState());
    }
  }

  IconData suffix = Icons.visibility_off_outlined;

  bool isPassword = true;

  void changePasswordVisibility() {
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    isPassword = !isPassword;
    emit(MovieChangePasswordVisibilityState());
  }

  void signOut(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      navigateAndFinish(context, LoginScreen());
      emit(MovieLogoutSuccessState());
    });
  }
}
