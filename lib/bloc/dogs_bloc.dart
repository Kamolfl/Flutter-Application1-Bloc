import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/models/dogs_model.dart';
import 'package:flutter_application_1/repositories/get_dogs_repository.dart';
import 'package:meta/meta.dart';

part 'dogs_event.dart';
part 'dogs_state.dart';

class DogsBloc extends Bloc<DogsEvent, DogsState> {
  DogsBloc({required this.repository}) : super(DogsInitial()) {
    on<GetDogsEvent>((event, emit) async {
      try{
        emit(DogsLoadingState());
        final model = await repository.getDogs();
        emit(DogsSuccessState(model: model));
      } catch(e) {
        emit(DogsErrorState(errorText: e.toString()));
      }
    });
  }

  final GetDogRepository repository;
}
