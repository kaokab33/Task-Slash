import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash/components/list_buttons.dart';
import 'package:slash/cubit/product_cubit.dart';
import 'package:slash/cubit/product_state.dart';

// ignore: must_be_immutable
class CustomSelectSize extends StatefulWidget {
  const CustomSelectSize({super.key});
  @override
  State<CustomSelectSize> createState() => _CustomSelectSizeState();
}

class _CustomSelectSizeState extends State<CustomSelectSize> {
  @override
  Widget build(BuildContext context) {
    List<String>? allSizes = BlocProvider.of<ProductCubit>(context).sizes;
    bool hasSize = BlocProvider.of<ProductCubit>(context).hasSize;
    List<String>? sizes = [];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final int index = context.read<ProductCubit>().genralIndex;
        sizes = (hasSize)
            ? allSizes
            : (BlocProvider.of<ProductCubit>(context).allTest[index]['Size']
                    as List<dynamic>?)
                ?.map((dynamic item) => item.toString())
                .toList();
        if (state is ChangeIndexColorState ||
            state is ChangeIndexSizeState ||
            state is ChangeIndexImageState ||
            state is ChangeIndeMaterialState ||
            state is SuccessState) {
          return Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.01, left: width * 0.02),
                child: const Row(
                  children: [
                    Text(
                      'Select Size',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.02, bottom: height * 0.02),
                child: ListViewSize(sizes: sizes),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
