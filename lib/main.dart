import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/dogs_bloc.dart';
import 'package:flutter_application_1/repositories/dio_settings.dart';
import 'package:flutter_application_1/repositories/get_dogs_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => DioSettings(),
        ),
        RepositoryProvider(
          create: (context) => GetDogRepository(
            dio: RepositoryProvider.of<DioSettings>(context).dio,
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => DogsBloc(
          repository: RepositoryProvider.of<GetDogRepository>(context),
        ),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              BlocProvider.of<DogsBloc>(context).add(GetDogsEvent());
            },
            icon: const Icon(Icons.ad_units)),
      ),
      body: BlocConsumer<DogsBloc, DogsState>(
        listener: (context, state) {
          if (state is DogsErrorState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(state.errorText),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DogsSuccessState) {
            return Center(child: Image.network(state.model.message ?? ''));
          } else if (state is DogsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox();
        },
      ),
    );
  }
}
