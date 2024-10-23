import 'package:flutter/material.dart';
import 'package:pos2024/models/SelectedProduct.dart';
import 'package:pos2024/models/Product.dart';

class CartWidget extends StatefulWidget {
  

  CartWidget({ 
    Key? key,
    required this.selectedProducts, 
    required this.totalPrice,
    required this.onPush,
    }) : super(key: key);

  final List<SelectedProduct> selectedProducts;
  int totalPrice;
  Function onPush;

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  List getCartList(){
    return widget.selectedProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 450,
      height: 500,
      child: ListView.builder(
        itemCount: widget.selectedProducts.length,
        itemBuilder: (context, index) {
          final product = widget.selectedProducts[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0), // 間を開ける
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 246, 239, 210),
                borderRadius: BorderRadius.circular(10), // 角丸にする
              ),
              child: ListTile(
                title: Text('${product.object.name} (${product.object.options[product.optionNumber]})'),
                subtitle: Text('個数: ${product.oderPieces}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${product.calculatSubtotal()}円'),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          product.addPieces(); // 個数を1増やす
                          widget.onPush();
                        });
                        
                      },
                      iconSize: 30,
                    ),
                    SizedBox(width: 5,),
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (product.oderPieces > 1) {
                            product.decPieces(); // 個数を1減らす
                            widget.onPush();
                          }
                        });
                      },
                      iconSize: 40,
                    ),
                    SizedBox(width: 10,),
                    IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("確認"),
                            content: Text("この商品を本当に削除しますか？\n${product.object.name}"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // キャンセルした場合の処理
                                  Navigator.of(context).pop(); // ダイアログを閉じる
                                },
                                child: Text("キャンセル"),
                              ),
                              TextButton(
                                onPressed: () {
                                  // OKを押した場合の処理
                                  setState(() {
                                      widget.selectedProducts.remove(product);
                                      widget.onPush();
                                  });
                                  Navigator.of(context).pop(); // ダイアログを閉じる
                                },
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    iconSize: 40,
                  ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
