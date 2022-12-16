import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'money_state.dart';
part 'money_cubit.freezed.dart';

class MoneyCubit extends Cubit<MoneyState> {
  MoneyCubit() : super(const MoneyState.selected(0));

  void getSelectedMoney(newMoney) {
    emit(MoneyState.selected(newMoney));
  }

  int get selectedMoney {
    return state.when(selected: (money) => money);
  }
}
