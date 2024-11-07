import 'package:bloc/bloc.dart';

import 'package:bloc_project/models/models.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  List<Product> wishlistProducts = [];

  WishlistBloc() : super(WishlistInitial()) {
    on<WishAddProductEvent>((event, emit) {
      wishlistProducts.add(event.product);
      emit(WishlistSuccessState(wishlistProducts: wishlistProducts));
    });

    on<WishlistRemoveEvent>((event, emit) {
      wishlistProducts.remove(event.product);
      emit(WishlistSuccessState(wishlistProducts: wishlistProducts));
      // wishlistProducts.remove(event.pr);
      // emit(wishlistSuccessState(WishlistProducts: wishlistProducts));
    });

    on<WishlistInitialEvent>((event, emit) {
      emit(WishlistInitial());
    });
  }
}
