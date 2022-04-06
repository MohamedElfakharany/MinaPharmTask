import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapharm/layout/cubit/cubit.dart';
import 'package:minapharm/layout/cubit/states.dart';
import 'package:minapharm/layout/home_layout.dart';
import 'package:minapharm/modules/register/register_screen.dart';
import 'package:minapharm/shared/components/components.dart';
import 'package:minapharm/shared/network/local/cache_helper.dart';
import 'package:minapharm/shared/network/local/const_shared.dart';
import 'package:minapharm/shared/styles/colors.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocConsumer<MovieCubit, MovieStates>(
      listener: (context, state) {
        if (state is MovieLoginSuccessState) {
          if (state.loginModel.status == true) {
            CacheHelper.saveData(
              key: 'name',
              value: state.loginModel.data?.name,
            ).then((value) {
              name = state.loginModel.data?.name;
            });
            CacheHelper.saveData(
              key: 'token',
              value: state.loginModel.data?.token,
            ).then((value) {
              token = state.loginModel.data?.token;
              navigateAndFinish(
                context,
                const HomeLayout(),
              );
            });
          } else {
            if (kDebugMode) {
              print('from listener ${state.loginModel.message}');
            }
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error...!'),
                  content: Text('${state.loginModel.message}'),
                );
              },
            );
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: DefaultAppBar(),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline3?.copyWith(
                              color: defaultColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    defaultFormField(
                      textController: emailController,
                      textType: TextInputType.emailAddress,
                      preficon: Icons.email_outlined,
                      labelText: 'Email',
                      validatedText: 'Email Address',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                      textController: passwordController,
                      textType: TextInputType.visiblePassword,
                      preficon: Icons.lock,
                      labelText: 'Password',
                      validatedText: 'Password',
                      security: MovieCubit.get(context).isPassword,
                      sofIcon: MovieCubit.get(context).suffix,
                      onPressedSofix: ()
                      {
                        MovieCubit.get(context).changePasswordVisibility();
                      },
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ConditionalBuilder(
                      condition: state is! MovieLoginLoadingState,
                      builder: (context) => defaultButton(
                        function: () {
                          try {
                            if (formKey.currentState!.validate()) {
                              MovieCubit.get(context).login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          } catch (error) {
                            if (kDebugMode) {
                              print(error.toString());
                            }
                          }
                        },
                        text: 'Login',
                        isUpperCase: true,
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account..?!',
                        ),
                        defaultTextButton(
                          function: () {
                            navigateTo(context, RegisterScreen());
                          },
                          data: 'register',
                          color: defaultColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
