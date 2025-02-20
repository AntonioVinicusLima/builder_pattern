import '../entities/pizza.dart';

abstract class PizzaRepository {
  Future<void> sendOrder(Pizza pizza);
}
