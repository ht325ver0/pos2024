import 'package:flutter/material.dart';
import 'Product.dart';

class SelectedProduct{
  ///商品(Product)
  Product object;
  ///オプションの番号
  int optionNumber;
  ///注文数(int)
  int oderPieces;
  ///商品の価格(int)
  ///
  String memo;

  SelectedProduct({
    required this.object,
    required this.optionNumber,
    required this.oderPieces,
    required this.memo,
  });

  ///小計計算
  int calculatSubtotal(){
    int subtotal = this.object.price * this.oderPieces;
    return subtotal;
  }

  void addPieces(){
    this.oderPieces += 1;
  }

  void decPieces(){
    this.oderPieces -= 1;
  }

  String getOptionString(){
    return object.options[optionNumber];
  }
  
  

}
