part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent {}

class WishlistRemoveEvent extends WishlistEvent {
  final Product product;

  WishlistRemoveEvent({required this.product});
}

class WishAddProductEvent extends WishlistEvent {
  final Product product;

  WishAddProductEvent({required this.product});
}
