import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash/components/custom_button.dart';
import 'package:slash/cubit/product_cubit.dart';
import 'package:slash/cubit/product_state.dart';

class ListViewMaterial extends StatefulWidget {
  const ListViewMaterial({Key? key, required this.material}) : super(key: key);
  final List<String>? material;

  @override
  State<ListViewMaterial> createState() => _ListViewMaterialState();
}

class _ListViewMaterialState extends State<ListViewMaterial> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int index = 0;
                  index < (widget.material?.length ?? 0);
                  index++)
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.01),
                  child: CustomButton(
                    color: Colors.black,
                    text: widget.material![index],
                    onPressedCallback: () {
                      BlocProvider.of<ProductCubit>(context)
                          .changeMaterial(index);
                    },
                    isSelected:
                        BlocProvider.of<ProductCubit>(context).indexMatrial ==
                            index,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
