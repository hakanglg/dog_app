import 'package:equatable/equatable.dart';

abstract class BreedsState extends Equatable {
  @override
  List<Object> get props => [];
}

class BreedsInitial extends BreedsState {}

class BreedsLoading extends BreedsState {}

class BreedsLoaded extends BreedsState {
  final Map<String, dynamic> breeds;

  BreedsLoaded(this.breeds);

  @override
  List<Object> get props => [breeds];
}

class BreedsError extends BreedsState {
  final String message;

  BreedsError(this.message);

  @override
  List<Object> get props => [message];
}