import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash/components/custom_button.dart';
import 'package:slash/cubit/product_cubit.dart';

class ListViewSize extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ListViewSize({Key? key, required this.sizes});
  final List<String>? sizes;
  @override
  State<ListViewSize> createState() => _ListViewButtonState();
}

class _ListViewButtonState extends State<ListViewSize> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int index = 0; index < (widget.sizes?.length ?? 0); index++)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.01,
                ),
                child: CustomButton(
                  color: Colors.black,
                  text: widget.sizes![index],
                  onPressedCallback: () {
                    BlocProvider.of<ProductCubit>(context).changeSize(index);
                  },
                  isSelected:
                      BlocProvider.of<ProductCubit>(context).indexOfSize ==
                          index,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
