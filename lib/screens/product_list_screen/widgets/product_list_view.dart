import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  final bool isLoading;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const ProductListView({
    super.key,
    required this.isLoading,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
