import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash/constant.dart';
import 'package:slash/cubit/product_cubit.dart';
import 'package:slash/cubit/product_state.dart';

class ListViewColors extends StatefulWidget {
  ListViewColors({
    Key? key,
    required this.colors,
  }) : super(key: key);

  final List<String> colors;

  @override
  State<ListViewColors> createState() => _ListViewColorsState();
}

class _ListViewColorsState extends State<ListViewColors> {
  @override
  Widget build(BuildContext context) {
    List<Color> coloredBoxes = widget.colors
        .map((hexColor) {
          hexColor = hexColor.replaceAll('#', '');
          if (hexColor.length == 6) {
            String opaqueHexColor = 'FF$hexColor';
            int colorValue = int.parse(opaqueHexColor, radix: 16);
            return Color(colorValue);
          } else {
            return Colors.transparent;
          }
        })
        .toSet()
        .toList();

    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: width * 0.03,
              children: coloredBoxes.asMap().entries.map((entry) {
                final index = entry.key;
                final color = entry.value;
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<ProductCubit>(context).changeColor(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      border: Border.all(
                        color: (BlocProvider.of<ProductCubit>(context).state
                                        is ChangeIndexColorState ||
                                    BlocProvider.of<ProductCubit>(context).state
                                        is SuccessState ||
                                    BlocProvider.of<ProductCubit>(context).state
                                        is ChangeIndexImageState ||
                                    BlocProvider.of<ProductCubit>(context).state
                                        is ChangeIndexSizeState ||
                                    BlocProvider.of<ProductCubit>(context).state
                                        is ChangeIndeMaterialState) &&
                                BlocProvider.of<ProductCubit>(context).index ==
                                    index
                            ? buttonColor
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: ClipOval(
                      child: CircleAvatar(
                        radius: width * 0.05,
                        backgroundColor: color,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
