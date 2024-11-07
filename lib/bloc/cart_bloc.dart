import 'package:bloc/bloc.dart';
import 'package:bloc_project/models/models.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<Product> cartProducts = [];

  CartBloc() : super(CartInitial()) {
    on<CartAddProductEvent>((event, emit) {
      cartProducts.add(event.product);
      emit(CartSuccessState(cartProducts: cartProducts));
    });

    // Optionally, handle other events like removing a product
    on<CartRemoveEvent>((event, emit) {
      cartProducts.remove(event.product);
      emit(CartSuccessState(cartProducts: cartProducts));

      // Logic to remove product
    });
  }
}
