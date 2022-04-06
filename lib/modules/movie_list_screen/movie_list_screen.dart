import 'package:flutter/material.dart';
import 'package:minapharm/models/movie_data_model.dart';
import 'package:minapharm/shared/components/components.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: DefaultAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30.0,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
