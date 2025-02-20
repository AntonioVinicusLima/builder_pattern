import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'presentation/pages/pizza_page.dart';
import 'presentation/bloc/pizza_bloc.dart';
import 'domain/usecases/send_pizza_usecase.dart';
import 'data/repositories/pizza_repository_impl.dart';

void main() {
  final dio = Dio();
  final repository = PizzaRepositoryImpl(dio);
  final sendPizzaUseCase = SendPizzaUseCase(repository);
  final bloc = PizzaBloc(sendPizzaUseCase: sendPizzaUseCase);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => PizzaBloc(sendPizzaUseCase: sendPizzaUseCase),
        child: PizzaPage(
          bloc: bloc,
        ),
      ),
    ),
  );
}
