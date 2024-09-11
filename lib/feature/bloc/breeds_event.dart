import 'package:equatable/equatable.dart';

abstract class BreedsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchBreeds extends BreedsEvent {}