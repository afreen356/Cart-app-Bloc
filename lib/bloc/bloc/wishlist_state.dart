part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistSuccessState extends WishlistState {
  final List<Product> wishlistProducts;

  WishlistSuccessState({required this.wishlistProducts});
}
