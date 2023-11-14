import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_app/modules/firebase/event.dart';
import 'package:tft_app/modules/firebase/state.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  FirebaseBloc() : super(FirebaseState()) {
    on<GetHomeEvent>((event, emit) async {
      emit(HomeState(isLoading: true));

      emit(HomeState());
    });
  }
}
