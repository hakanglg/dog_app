part of 'breeds_bloc.dart';

abstract class BreedsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAllBreeds extends BreedsEvent {}

class SearchBreeds extends BreedsEvent {
  final String query;

  SearchBreeds(this.query);

  @override
  List<Object?> get props => [query];
}

class BreedsNoResults extends BreedsState {}