import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bloc_project/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  List<Product> wishlists = [];

  ProductsBloc() : super(ProductsInitial()) {
    on<productsInitialEvent>(ProductsInitialEvent);
    on<ProductWishListButtonClickedEvent>(productWishListButtonClickedEvent);
    on<ProductCartListButtonClickedEvent>(productCartListButtonClickedEvent);
    on<productCartButtonNavigateEvent>(ProductCartButtonNavigateEvent);
    on<productWishListNavigateButton>(ProductWishListNavigateButton);
  }

  FutureOr<void> ProductsInitialEvent(
      productsInitialEvent event, Emitter<ProductsState> emit) async {
    emit(ProductLoadingState());

    await Future.delayed(Duration(seconds: 3));
    final products = await fetchProducts();
    emit(ProductLoadedSuccessState(products: products, wishlists: wishlists));
  }

  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  FutureOr<void> productWishListButtonClickedEvent(
      ProductWishListButtonClickedEvent event, Emitter<ProductsState> emit) {
    wishlists.add(event.clickedProduct);
    emit(ProductLoadedSuccessState(
        products: (state as ProductLoadedSuccessState).products,
        wishlists: wishlists));
    emit(productWishlistedActionState());
  }

  FutureOr<void> productCartListButtonClickedEvent(
      ProductCartListButtonClickedEvent event, Emitter<ProductsState> emit) {
    // Assuming you have a Cart class to manage cart items
    cartProducts.add(event.clickedProduct);
    emit(productCartlistedActionState());
  }

  FutureOr<void> ProductCartButtonNavigateEvent(
      productCartButtonNavigateEvent event, Emitter<ProductsState> emit) {
    emit(productNavigateToCartPageActionState());
  }

  FutureOr<void> ProductWishListNavigateButton(
      productWishListNavigateButton event, Emitter<ProductsState> emit) {
    emit(ProductNavigatateToWishListPageActionState());
  }
}
