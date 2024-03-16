import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash/constant.dart';
import 'package:slash/cubit/cubit_observer.dart';
import 'package:slash/cubit/product_cubit.dart';
import 'package:slash/views/product_details.dart';
import 'package:slash/views/proudcts_view.dart';

void main() {
  Bloc.observer = CubitObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Slash.',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
        ),
        routes: {
          kProductDetails: (context) => const ProductDetails(),
          kProductView: (context) => const Proudcts(),
        },
        initialRoute: kProductView,
        // home:  Cart(),
      ),
    );
  }
}
