part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveEvent extends CartEvent {
  final Product product;

  CartRemoveEvent({required this.product});
}

class CartAddProductEvent extends CartEvent {
  final Product product;

  CartAddProductEvent({required this.product});
}
