import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash/constant.dart';
import 'package:slash/cubit/product_cubit.dart';
import 'package:slash/models/all_products.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  final AllProudcts product;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: height * 0.01, left: width * 0.02),
      child: GestureDetector(
        onTap: () async {
          BlocProvider.of<ProductCubit>(context).getProduct(product.id);
          Navigator.pushNamed(context, kProductDetails);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: width * 0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(
                      product.image,
                      scale: 1,
                    ),
                    fit: BoxFit.contain,
                    onError: (_, __) {
                      Image.asset('assets/placeholder_image.png');
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: height * 0.02, bottom: height * 0.005),
              child: Text(
                product.brand,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.005),
              child: Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'EGP ${product.price}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 25,
                ),
                const Icon(
                  Icons.shopping_cart,
                  color: Colors.grey,
                  size: 25,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
