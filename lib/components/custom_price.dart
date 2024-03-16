import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash/cubit/product_cubit.dart';
import 'package:slash/cubit/product_state.dart';

class CustomPrice extends StatelessWidget {
  const CustomPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final int index = context.read<ProductCubit>().genralIndex;
        final allTest = context.read<ProductCubit>().allTest;
        return Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
          child: Text(
            'EGP ${allTest[index]['Price'][0]}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        );
      },
    );
  }
}
