part of 'dogs_bloc.dart';

@immutable
abstract class DogsState {}

class DogsInitial extends DogsState {}

class DogsLoadingState extends DogsState {}

class DogsSuccessState extends DogsState {
  final DogsModel model;
  DogsSuccessState({required this.model});
}

class DogsErrorState extends DogsState {
  final String errorText;
  DogsErrorState({required this.errorText});
}
