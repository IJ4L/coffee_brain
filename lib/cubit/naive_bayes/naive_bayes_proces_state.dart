part of 'naive_bayes_proces_cubit.dart';

abstract class NaiveBayesProcesState extends Equatable {
  const NaiveBayesProcesState();

  @override
  List<Object> get props => [];
}

class NaiveBayesProcesInitial extends NaiveBayesProcesState {}

class NaiveBayesProcesLoading extends NaiveBayesProcesState {}

class NaiveBayesProcesLoaded extends NaiveBayesProcesState {
  final PredictionModel prediction;
  final List<String> gejala;
  const NaiveBayesProcesLoaded(this.prediction, this.gejala);

  @override
  List<Object> get props => [prediction];
}

class NaiveBayesProcesFailure extends NaiveBayesProcesState {
  final String message;
  const NaiveBayesProcesFailure(this.message);

  @override
  List<Object> get props => [message];
}
