import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit2cubit/cubits/color/color_cubit.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  int incrementSize = 1;
  final ColorCubit colorCubit;
  late final StreamSubscription colorSubscription;

  CounterCubit({required this.colorCubit}) : super(CounterState.initial()) {
    //ColorCubit 을 인스턴스하여 Stream을 리슨하여 Subscribe 해준다.
    //listen은 void타입 콜백을 할수 리턴받아서 등록을 하는데 아큐먼트에 ColorState 를 넣어 상태가 변할때마다 실행 한다.
    //stream 은 State를 통해 받아오면 Dispose를 자동으로 해주지 않기떄문에 메모리누수가 심하다. 그래서 캔슬을 해줘야한다.
    colorSubscription = colorCubit.stream.listen((ColorState colorState) {
      if (colorState.color == Colors.red) {
        incrementSize = 1;
      } else if (colorState.color == Colors.green) {
        incrementSize = 10;
      } else if (colorState.color == Colors.blue) {
        incrementSize = 100;
      } else if (colorState.color == Colors.black) {
        //칼라가 100이 되는순간 기존값에서 -100을 해주고
        //initial Color 값을 읽지 않기 떄문에 읽기를 원하면 생성자에서 전달 처리하거나 다른 방법을 사용해야한다.
        emit(state.copyWith(counter: state.counter - 100));
        incrementSize = -100;
      }
    });
  }
  void changeCounter() {
    emit(state.copyWith(counter: state.counter + incrementSize));
  }

  @override
  Future<void> close() {
    colorSubscription.cancel();
    return super.close();
  }
}
