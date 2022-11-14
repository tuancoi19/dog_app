import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final String url;

  const ItemImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null
                ? child
                : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
