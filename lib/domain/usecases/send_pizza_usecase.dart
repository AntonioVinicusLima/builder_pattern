import '../entities/pizza.dart';
import '../repositories/pizza_repository.dart';

class SendPizzaUseCase {
  final PizzaRepository repository;

  SendPizzaUseCase(this.repository);

  Future<void> call(Pizza pizza) async {
    return repository.sendOrder(pizza);
  }
}
