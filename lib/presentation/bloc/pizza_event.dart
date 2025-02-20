abstract class PizzaEvent {
  const PizzaEvent._();
}

final class PizzaSizeChanged extends PizzaEvent {
  final String size;
  const PizzaSizeChanged({required this.size}) : super._();
}

final class PizzaCrustChanged extends PizzaEvent {
  final String crust;
  const PizzaCrustChanged({required this.crust}) : super._();
}

final class ToppingAdded extends PizzaEvent {
  final String topping;
  const ToppingAdded({required this.topping}) : super._();
}

final class ToppingRemoved extends PizzaEvent {
  final String topping;
  const ToppingRemoved({required this.topping}) : super._();
}

final class PizzaSubmitted extends PizzaEvent {
  const PizzaSubmitted() : super._();
}
