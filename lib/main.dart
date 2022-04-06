import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapharm/layout/cubit/cubit.dart';
import 'package:minapharm/layout/home_layout.dart';
import 'package:minapharm/modules/login/login_screen.dart';
import 'package:minapharm/shared/bloc_observer.dart';
import 'package:minapharm/shared/network/local/cache_helper.dart';
import 'package:minapharm/shared/network/local/const_shared.dart';
import 'package:minapharm/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  DioHelper.init();

  Widget widget;
  token = CacheHelper.getData(key: 'token');
  name = CacheHelper.getData(key: 'name');

  var appToken = token;

  if (appToken != null) {
    widget = const HomeLayout();
  } else {
    widget = LoginScreen();
  }

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  // ignore: use_key_in_widget_constructors
  const MyApp({
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => MovieCubit()..getMovies(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
