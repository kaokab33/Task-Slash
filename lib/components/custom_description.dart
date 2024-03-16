import 'package:flutter/material.dart';

class CustomDescription extends StatefulWidget {
  const CustomDescription({super.key, required this.description});
  final String description;
  @override
  State<CustomDescription> createState() => _CustomDescriptionState();
}

class _CustomDescriptionState extends State<CustomDescription> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    double high = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: high * 0.02, horizontal: width * 0.04),
            decoration: BoxDecoration(
              color: const Color(0xff303030),
              borderRadius: _isExpanded
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))
                  : BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
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
                color: Color(0xff303030),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            child: Center(
              child: Text(
                widget.description,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 1,
                    wordSpacing: 1.3),
              ),
            ),
          )
      ],
    );
  }
}
