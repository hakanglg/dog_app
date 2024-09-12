part of 'breeds_bloc.dart';

abstract class BreedsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BreedsInitial extends BreedsState {}

class BreedsLoading extends BreedsState {}

class BreedsLoaded extends BreedsState {
  final List<Breed> breeds;

  BreedsLoaded({required this.breeds});

  @override
  List<Object?> get props => [breeds];
}

class BreedsError extends BreedsState {
  final String message;

  BreedsError({required this.message});

  @override
  List<Object?> get props => [message];
}