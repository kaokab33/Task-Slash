import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash/constant.dart';
import 'package:slash/cubit/product_cubit.dart';
import 'package:slash/models/product.dart';

// ignore: must_be_immutable
class Cart extends StatefulWidget {
  Cart({super.key, required this.id});
  String id;
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _isExpanded = false;
  int _counterValue = 1;

  @override
  Widget build(BuildContext context) {
    double high = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int genralIndex = BlocProvider.of<ProductCubit>(context).genralIndex;
    Map<String, dynamic> mytest =
        BlocProvider.of<ProductCubit>(context).allTest[genralIndex];
    Product product = BlocProvider.of<ProductCubit>(context).product;
    int indexOfSize = BlocProvider.of<ProductCubit>(context).indexOfSize;
    int indexOfMaterial = BlocProvider.of<ProductCubit>(context).indexMatrial;
    String imageBrand = product.brandLogoUrl;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: high * 0.02),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: high * 0.02, horizontal: width * 0.03),
                decoration: BoxDecoration(
                  color: const Color(0xff1d1d1f),
                  borderRadius: _isExpanded
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))
                      : BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(imageBrand),
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Order From',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          product.brandName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   width: width * 0.2,
                    // ),
                    Text(
                      'EGP ${mytest['Price'][0] * _counterValue}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(_isExpanded ? Icons.expand_less : Icons.expand_more,
                        color: Colors.white),
                  ],
                ),
              ),
            ),
            if (_isExpanded)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: high * 0.02, horizontal: width * 0.04),
                decoration: const BoxDecoration(
                    color: Color(0xff1d1d1f),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(mytest['Image'][0] as String),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name.length > 13
                                ? '${product.name.substring(0, 13)}...'
                                : product.name,
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'EGP ${mytest['Price'][0] * _counterValue}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 0.7,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                width: width * 0.3,
                                height: high * 0.06,
                                child: CounterButton(
                                  loading: false,
                                  onChange: (int val) {
                                    setState(() {
                                      _counterValue = val;
                                    });
                                  },
                                  count: _counterValue,
                                  countColor: Colors.white,
                                  buttonColor: Colors.white,
                                  progressColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    (mytest['Color'] != null)
                        ? ShowSelectedColor(
                            title: 'Selected Color',
                            value: mytest['Color'] as String,
                          )
                        : const SizedBox(),
                    (mytest['Size'] != null && mytest['Size'].length > 0)
                        ? ShowSelectedDetails(
                            title: 'Selected Size',
                            value: (mytest['Color'] != null)
                                ? mytest['Size'][indexOfSize]
                                : mytest['Size'] as String,
                          )
                        : const SizedBox(),
                    (mytest['Materials'] != null &&
                            mytest['Materials'].length > 0)
                        ? ShowSelectedDetails(
                            title: 'Selected Matreial',
                            value: (mytest['Size'] != null)
                                ? mytest['Materials'][indexOfMaterial]
                                : mytest['Materials'] as String,
                          )
                        : const SizedBox(),
                    ShowSelectedDetails(
                      title: 'variation ID',
                      value: widget.id,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ShowSelectedDetails extends StatelessWidget {
  const ShowSelectedDetails({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ShowSelectedColor extends StatelessWidget {
  const ShowSelectedColor({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Color coloredBoxes(String value) {
      value = value.replaceAll('#', '');
      if (value.length == 6) {
        String opaqueHexColor = 'FF$value';
        int colorValue = int.parse(opaqueHexColor, radix: 16);
        return Color(colorValue);
      } else {
        return Colors.transparent;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
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
                color: buttonColor,
                width: 3,
              ),
            ),
            child: ClipOval(
              child: CircleAvatar(
                radius: width * 0.05,
                backgroundColor: coloredBoxes(value),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
