import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:slash/components/custom_brand_name.dart';
import 'package:slash/components/custom_button.dart';
import 'package:slash/components/custom_description.dart';
import 'package:slash/components/custom_price.dart';
import 'package:slash/components/custom_select%20_size.dart';
import 'package:slash/components/custom_select_color.dart';
import 'package:slash/components/custom_select_material.dart';
import 'package:slash/components/list_view_images.dart';
import 'package:slash/components/scroll_image.dart';
import 'package:slash/cubit/product_cubit.dart';
import 'package:slash/cubit/product_state.dart';
import 'package:slash/models/product.dart';
import 'package:slash/views/cart_value.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,
  });
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var pageController = PageController(initialPage: 0, viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<String> properties = BlocProvider.of<ProductCubit>(context).properties;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0c0c0c),
        title: const Center(
          child: Text(
            'Product Details',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            BlocProvider.of<ProductCubit>(context).ChangeToInitialState();
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: LoadingAnimationWidget.dotsTriangle(
                color: const Color(0xFF1A1A3F),
                size: 100,
              ),
            );
          } else if (state is FailedState) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is SuccessState ||
              state is ChangeIndexColorState ||
              state is ChangeIndexImageState ||
              state is ChangeIndeMaterialState ||
              state is ChangeIndexSizeState) {
            Product product = context.read<ProductCubit>().product;
            List<Map<String, dynamic>> allTest =
                context.read<ProductCubit>().allTest;
            int ind = context.read<ProductCubit>().genralIndex;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.09,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: PageView.builder(
                      onPageChanged: (value) {
                        BlocProvider.of<ProductCubit>(context)
                            .changeImage(value);
                      },
                      itemCount: allTest[ind]['Image'].length,
                      physics: const ClampingScrollPhysics(),
                      controller: pageController,
                      itemBuilder: (context, index) {
                        return ScrollImage(
                          pageController: pageController,
                          image: allTest[ind]['Image'][index],
                          index: index,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  ListViewImage(
                    pageController: pageController,
                    images: (allTest[ind]['Image'] as List<dynamic>)
                        .map((e) => e.toString())
                        .toList(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name.length > 29
                                    ? '${product.name.substring(0, 29)}...'
                                    : product.name,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const CustomPrice(),
                            ],
                          ),
                        ),
                        CustomLogo(
                            brandLogoUrl: product.brandLogoUrl,
                            brandName: product.brandName)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  (properties.contains('Color'))
                      ? const CustomSelectColor()
                      : const SizedBox(),
                  (properties.contains('Size'))
                      ? const CustomSelectSize()
                      : const SizedBox(),
                  (properties.contains('Materials'))
                      ? const CustomSelectMaterial()
                      : const SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.03),
                    child: CustomDescription(
                      description: product.description,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.07,
                    child: CustomButton(
                        color: Colors.black,
                        text: 'Add To Cart',
                        onPressedCallback: () {
                          int id = BlocProvider.of<ProductCubit>(context)
                              .AddToCart();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Cart(id: '$id');
                          }));
                        },
                        isSelected: true),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Error'),
            );
          }
        },
      ),
    );
  }
}
