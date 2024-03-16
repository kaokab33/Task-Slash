import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash/constant.dart';
import 'package:slash/cubit/product_cubit.dart';

class ListViewImage extends StatefulWidget {
  const ListViewImage({
    Key? key,
    required this.images,
    required this.pageController,
  }) : super(key: key);

  final List<dynamic> images;
  final PageController pageController;

  @override
  State<ListViewImage> createState() => _ListViewImageState();
}

class _ListViewImageState extends State<ListViewImage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(_updateSelectedIndex);
  }

  void _updateSelectedIndex() {
    setState(() {
      selectedIndex = widget.pageController.page?.toInt() ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.08,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(widget.images.length, (index) {
            return GestureDetector(
              onTap: () {
                widget.pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeIn,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                width: width * 0.15,
                margin: EdgeInsets.only(right: width * 0.03),
                decoration: BoxDecoration(
                  border: BlocProvider.of<ProductCubit>(context).indexOfImage !=
                          index
                      ? null
                      : Border.all(
                          color: buttonColor,
                          width: 5,
                        ),
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.images[index] as String),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
