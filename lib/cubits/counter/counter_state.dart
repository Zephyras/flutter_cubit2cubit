part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counter;
  const CounterState({required this.counter});

  factory CounterState.initial() {
    return CounterState(counter: 0);
  }
  @override
  List<Object> get props => [counter];

  @override
  String toString() => 'ColorState(color: $counter)';

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  } 
}
