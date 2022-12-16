part of 'money_cubit.dart';

@freezed
class MoneyState with _$MoneyState {
  const factory MoneyState.selected(int money) = _Selected;
}
