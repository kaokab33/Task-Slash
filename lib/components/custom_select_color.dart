import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash/components/list_view_colors.dart';
import 'package:slash/cubit/product_cubit.dart';
import 'package:slash/models/product.dart';

// ignore: must_be_immutable
class CustomSelectColor extends StatelessWidget {
  const CustomSelectColor({super.key});
  // ignore: prefer_typing_uninitialized_variables
  @override
  Widget build(BuildContext context) {
    List<Properties> availableProperties =
        BlocProvider.of<ProductCubit>(context).product.availableProperties;
    List<String>? colors;
    for (int i = 0; i < availableProperties.length; i++) {
      if (availableProperties[i].property == 'Color') {
        colors = availableProperties[i].values;
        break;
      }
    }
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height * 0.01, left: width * 0.02),
          child: const Row(
            children: [
              Text(
                'Select Color ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.01, left: width * 0.02),
          child: ListViewColors(colors: colors!),
        ),
      ],
    );
  }
}
