import 'package:bloc/bloc.dart';
import 'package:coffe_brain/services/ml_service.dart';
import 'package:equatable/equatable.dart';

part 'naive_bayes_proces_state.dart';

class NaiveBayesProcesCubit extends Cubit<NaiveBayesProcesState> {
  NaiveBayesProcesCubit() : super(NaiveBayesProcesInitial());

  void onPredict(List<String> selectedGejala) async {
    emit(NaiveBayesProcesLoading());

    final result = await procesNaiveBayes(selectedGejala);
    result.fold(
      (message) => emit(NaiveBayesProcesFailure(message)),
      (value) => emit(NaiveBayesProcesLoaded(value)),
    );
  }
}