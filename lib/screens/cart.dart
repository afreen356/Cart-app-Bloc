import 'package:bloc_project/bloc/bloc/wishlist_bloc.dart';
import 'package:bloc_project/bloc/cart_bloc.dart';
import 'package:bloc_project/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.lightBlue,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartSuccessState) {
            if (state.cartProducts.isNotEmpty) {
              return ListView.builder(
                itemCount: state.cartProducts.length,
                itemBuilder: (context, index) {
                  final product = state.cartProducts[index];
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
                          style: TextStyle(
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
                                    context.read<WishlistBloc>().add(
                                        WishlistRemoveEvent(product: product));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '${product.title} removed from wishlist'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.favorite_border_outlined),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<CartBloc>()
                                        .add(CartRemoveEvent(product: product));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '${product.title} removed from cart'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.shopping_bag_outlined),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('Your cart is empty'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  static void add(Product clickedProduct) {}
}
