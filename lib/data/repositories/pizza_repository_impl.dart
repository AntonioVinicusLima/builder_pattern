import 'package:dio/dio.dart';
import '../../domain/entities/pizza.dart';
import '../../domain/repositories/pizza_repository.dart';

class PizzaRepositoryImpl implements PizzaRepository {
  final Dio dio;

  PizzaRepositoryImpl(this.dio);

  @override
  Future<void> sendOrder(Pizza pizza) async {
    try {
      await dio.post("https://api.example.com/pizzas", data: {
        "size": pizza.size,
        "crust": pizza.crust,
        "toppings": pizza.toppings,
      });
    } catch (e) {
      throw Exception("Error sending order");
    }
  }
}
