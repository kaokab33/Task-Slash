import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash/components/list_view_material.dart';
import 'package:slash/cubit/product_cubit.dart';
import 'package:slash/cubit/product_state.dart';

class CustomSelectMaterial extends StatelessWidget {
  const CustomSelectMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    List<String>? allMaterial = BlocProvider.of<ProductCubit>(context).matrials;
    bool hasMatrial = BlocProvider.of<ProductCubit>(context).hasMatrial;
    List<String>? materials = [];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final int index = context.read<ProductCubit>().genralIndex;
        materials = (hasMatrial)
            ? allMaterial
            : (BlocProvider.of<ProductCubit>(context).allTest[index]
                    ['Materials'] as List<dynamic>?)
                ?.map((dynamic item) => item.toString())
                .toList();
        return Column(children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.01, left: width * 0.02),
            child: const Row(
              children: [
                Text(
                  'Select Material ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.02),
            child: ListViewMaterial(material: materials),
          )
        ]);
      },
    );
  }
}
