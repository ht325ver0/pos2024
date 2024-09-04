import 'package:flutter/material.dart';
import 'package:pos2024/models/SelectedProduct.dart';
import 'package:pos2024/models/Product.dart';

class CartWidget extends StatelessWidget {
  final List<SelectedProduct> selectedProducts;

  CartWidget({required this.selectedProducts});

  List getCartList(){
    return selectedProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 450,
      height: 500,
      child: ListView.builder(
        itemCount: selectedProducts.length,
        itemBuilder: (context, index) {
          final product = selectedProducts[index];
          return ListTile(
            title: Text('${product.object.name} (${product.object.options[product.optionNumber]})'),
            subtitle: Text('個数: ${product.oderPieces}'),
            trailing: Text('${product.calculatSubtotal()}円'),
          );
        },
      ),
    );
  }
}
