import 'package:flutter/material.dart';

class ItemBreed extends StatelessWidget {
  final Function() onPressed;
  final bool isSelected;
  final String name;

  const ItemBreed(
      {super.key,
      required this.onPressed,
      required this.isSelected,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? Colors.blue : null,
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 5, right: 5),
          child: Text(
            name,
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontStyle: FontStyle.normal,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
