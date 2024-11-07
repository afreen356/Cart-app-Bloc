part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

class productsInitialEvent extends ProductsEvent {}

abstract class productActionState extends ProductsState {}

final class ProductsInitial extends ProductsState {}

class ProductLoadingState extends ProductsState {}

class ProductLoadedSuccessState extends ProductsState {
  final List<Product> products;
  final List<Product> wishlists;

  ProductLoadedSuccessState({required this.products, required this.wishlists});
}

class ProductErrorState extends ProductsState {}

class ProductNavigatateToWishListPageActionState extends productActionState {}

class productNavigateToCartPageActionState extends productActionState {}

class productWishlistedActionState extends productActionState {}

class productCartlistedActionState extends productActionState {}

class productRemovedFromWishlistedActionState extends productActionState {}
