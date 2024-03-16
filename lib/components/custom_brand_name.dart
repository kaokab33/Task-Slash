import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key, required this.brandLogoUrl, required this.brandName});
  final String brandLogoUrl;
  final String brandName;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: width * 0.02),
          child: CircleAvatar(
            radius: width * 0.07, // Adjust the radius as needed
            backgroundImage: NetworkImage(
              brandLogoUrl,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.015, right: width * 0.02),
          child: Text(
            brandName,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
