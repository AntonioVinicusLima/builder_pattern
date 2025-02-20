import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/pizza_bloc.dart';
import '../bloc/pizza_event.dart';
import '../bloc/pizza_state.dart';

class PizzaPage extends StatelessWidget {
  final PizzaBloc bloc;
  const PizzaPage({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Build Your Pizza")),
      body: BlocConsumer<PizzaBloc, PizzaState>(
        bloc: bloc,
        listener: (context, state) {
          if (bloc.state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Order sent successfully!")),
            );
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.errorMessage}")),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: state.size,
                  items: ["Small", "Medium", "Large"]
                      .map((size) => DropdownMenuItem(
                            value: size,
                            child: Text(size),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      bloc.add(PizzaSizeChanged(size: value));
                    }
                  },
                ),
                DropdownButton<String>(
                  value: state.crust,
                  items: ["Normal", "Stuffed", "Thin"]
                      .map((crust) => DropdownMenuItem(
                            value: crust,
                            child: Text(crust),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      bloc.add(PizzaCrustChanged(crust: value));
                    }
                  },
                ),
                Wrap(
                  spacing: 8.0,
                  children: ["Cheese", "Pepperoni", "Bacon", "Tomato"]
                      .map((topping) {
                    final isSelected = state.toppings.contains(topping);
                    return ChoiceChip(
                      label: Text(topping),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          bloc.add(ToppingAdded(topping: topping));
                        } else {
                          bloc.add(ToppingRemoved(topping: topping));
                        }
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                          bloc.add(const PizzaSubmitted());
                        },
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Submit Order"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
