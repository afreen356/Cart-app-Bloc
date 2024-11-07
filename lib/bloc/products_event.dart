part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class ProductWishListButtonClickedEvent extends ProductsEvent {
  final Product clickedProduct;

  ProductWishListButtonClickedEvent({required this.clickedProduct});
}

class ProductCartListButtonClickedEvent extends ProductsEvent {
  final Product clickedProduct;

  ProductCartListButtonClickedEvent({required this.clickedProduct});
}

class productWishListNavigateButton extends ProductsEvent {}

class productCartButtonNavigateEvent extends ProductsEvent {}
