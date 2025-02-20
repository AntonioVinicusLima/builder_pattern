import 'package:bloc/bloc.dart';
import 'pizza_event.dart';
import 'pizza_state.dart';
import '../../../domain/entities/pizza.dart';
import '../../../domain/usecases/send_pizza_usecase.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  final SendPizzaUseCase sendPizzaUseCase;

  PizzaBloc({required this.sendPizzaUseCase}) : super(PizzaState.initial()) {
    on<PizzaSizeChanged>(_handlePizzaSizeChanged);
    on<PizzaCrustChanged>(_handlePizzaCrustChanged);
    on<ToppingAdded>(_handleToppingAdded);
    on<ToppingRemoved>(_handleToppingRemoved);
    on<PizzaSubmitted>(_handlePizzaSubmitted);
  }

  Future<void> _handlePizzaSizeChanged(
    PizzaSizeChanged event,
    Emitter<PizzaState> emit,
  ) async {
    emit(state.copyWith(size: event.size));
  }

  Future<void> _handlePizzaCrustChanged(
    PizzaCrustChanged event,
    Emitter<PizzaState> emit,
  ) async {
    emit(state.copyWith(crust: event.crust));
  }

  Future<void> _handleToppingAdded(
    ToppingAdded event,
    Emitter<PizzaState> emit,
  ) async {
    final updatedToppings = List<String>.from(state.toppings);
    if (!updatedToppings.contains(event.topping)) {
      updatedToppings.add(event.topping);
      emit(state.copyWith(toppings: updatedToppings));
    }
  }

  Future<void> _handleToppingRemoved(
    ToppingRemoved event,
    Emitter<PizzaState> emit,
  ) async {
    final updatedToppings = List<String>.from(state.toppings);
    updatedToppings.remove(event.topping);
    emit(state.copyWith(toppings: updatedToppings));
  }

  Future<void> _handlePizzaSubmitted(
    PizzaSubmitted event,
    Emitter<PizzaState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final pizza = Pizza(
        size: state.size,
        crust: state.crust,
        toppings: state.toppings,
      );
      await sendPizzaUseCase(pizza);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
