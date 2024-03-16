import 'package:flutter/material.dart';
import 'package:slash/constant.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.color,
    required this.text,
    required this.onPressedCallback,
    required this.isSelected,
  });
  String text;
  Color color;
  Function? onPressedCallback;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        onPressed: onPressedCallback as void Function()?,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? buttonColor
              : const Color.fromARGB(255, 31, 30, 30),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
          ),
        ),
        child: SizedBox(
          child: Text(
            text,
            style: TextStyle(
                color: isSelected ? color : Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 21),
          ),
        ),
      ),
    );
  }
}
