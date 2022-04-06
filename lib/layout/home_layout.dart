import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minapharm/layout/cubit/cubit.dart';
import 'package:minapharm/layout/cubit/states.dart';
import 'package:minapharm/shared/components/components.dart';
import 'package:minapharm/shared/network/local/const_shared.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieCubit, MovieStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: DefaultAppBar(
            actions: [
              defaultTextButton(
                function: () {
                  MovieCubit.get(context).signOut(context);
                },
                data: 'logout',
                color: Colors.white,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      'Welcome $name ...!',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 2.0,
                    childAspectRatio: 1 / 1.3,
                    children: List.generate(
                      15,
                          (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: homeGridProductsBuilder(
                          context: context,
                          model: MovieCubit.get(context).model,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
