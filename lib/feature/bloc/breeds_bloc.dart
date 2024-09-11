import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'breeds_event.dart';
import 'breeds_state.dart';

class BreedsBloc extends Bloc<BreedsEvent, BreedsState> {
  final Dio dio;

  BreedsBloc(this.dio) : super(BreedsInitial());

  @override
  Stream<BreedsState> mapEventToState(BreedsEvent event) async* {
    if (event is FetchBreeds) {
      yield BreedsLoading();
      try {
        final response = await dio.get('/breeds/list/all');
        if (response.statusCode == 200) {
          yield BreedsLoaded(response.data['message']);
        } else {
          yield BreedsError('Failed to load breeds');
        }
      } catch (e) {
        yield BreedsError('An error occurred: $e');
      }
    }
  }
}