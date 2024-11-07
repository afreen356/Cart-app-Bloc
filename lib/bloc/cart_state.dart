part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<Product> cartProducts; // Correct parameter name

  CartSuccessState({required this.cartProducts});
}
