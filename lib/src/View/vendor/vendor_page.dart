import 'package:flutter/material.dart';

import '../../constant/color.dart';
import '../../model/product_model.dart';
import '../../widget/pages_widget/vendor/vendor_widget.dart';

class VendorPage extends StatefulWidget {
  const VendorPage({required this.product, Key? key}) : super(key: key);
  final Product product;
  @override
  State<VendorPage> createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.mainScaffoldBackgroundColor,
        body: VendorWidget(
          product: widget.product,
        ),
      ),
    );
  }
}