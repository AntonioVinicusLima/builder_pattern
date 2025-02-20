class PizzaState {
  final String size;
  final String crust;
  final List<String> toppings;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  PizzaState({
    required this.size,
    required this.crust,
    required this.toppings,
    required this.isLoading,
    required this.isSuccess,
    this.errorMessage,
  });

  factory PizzaState.initial() {
    return PizzaState(
      size: "Medium",
      crust: "Normal",
      toppings: [],
      isLoading: false,
      isSuccess: false,
      errorMessage: null,
    );
  }

  PizzaState copyWith({
    String? size,
    String? crust,
    List<String>? toppings,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return PizzaState(
      size: size ?? this.size,
      crust: crust ?? this.crust,
      toppings: toppings ?? this.toppings,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
