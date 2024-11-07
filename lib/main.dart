import 'package:bloc_project/bloc/bloc/wishlist_bloc.dart';
import 'package:bloc_project/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_project/bloc/cart_bloc.dart';
import 'package:bloc_project/screens/products.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider(
          create: (context) => WishlistBloc(),
        ),
        BlocProvider<ProductsBloc>(
          create: (context) => ProductsBloc()..add(productsInitialEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Products(),
      ),
    );
  }
}
