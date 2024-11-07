import 'package:bloc_project/bloc/bloc/wishlist_bloc.dart';

import 'package:bloc_project/bloc/cart_bloc.dart';
import 'package:bloc_project/bloc/products_bloc.dart';
import 'package:bloc_project/screens/cart.dart';
import 'package:bloc_project/screens/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsBloc = context.read<ProductsBloc>();
    final cartBloc = context.read<CartBloc>();
    final wishlistBloc = context.read<WishlistBloc>();

    return BlocConsumer<ProductsBloc, ProductsState>(
      listenWhen: (previous, current) => current is productActionState,
      buildWhen: (previous, current) => current is! productActionState,
      listener: (context, state) {
        if (state is productNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is ProductNavigatateToWishListPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is productCartlistedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item added to cart')));
        } else if (state is productWishlistedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item added to wishlist')));
        }
      },
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is ProductLoadedSuccessState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Products'),
              backgroundColor: Colors.lightBlue,
              actions: [
                IconButton(
                  onPressed: () {
                    productsBloc.add(productWishListNavigateButton());
                  },
                  icon: const Icon(Icons.favorite_outline_outlined),
                ),
                IconButton(
                  onPressed: () {
                    productsBloc.add(productCartButtonNavigateEvent());
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                )
              ],
            ),
            body: ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200, // Adjust height as needed
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover, // Adjust based on your needs
                            image: NetworkImage(product.image),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  productsBloc.add(
                                      ProductWishListButtonClickedEvent(
                                          clickedProduct: product));
                                  wishlistBloc.add(
                                      WishAddProductEvent(product: product));
                                },
                                icon: const Icon(Icons.favorite_border_outlined),
                              ),
                              IconButton(
                                onPressed: () {
                                  productsBloc.add(
                                      ProductCartListButtonClickedEvent(
                                          clickedProduct: product));
                                  cartBloc.add(CartAddProductEvent(
                                      product: product)); // Use CartBloc
                                },
                                icon: const Icon(Icons.shopping_bag_outlined),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is ProductErrorState) {
          return const Scaffold(
            body: Center(
              child: Text('Failed to load products'),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
