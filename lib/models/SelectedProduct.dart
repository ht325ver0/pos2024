import 'package:flutter/material.dart';

class Product{
  ///商品(Product)
  Product object;
  ///オプションの番号
  int optionNumber;
  ///注文数(int)
  int oderPieces;
  ///商品の原価(int)
  final int prise;
  ///商品のオプション名のリスト(List<int>)
  final List<String> options;

  const Product({
    required this.name,
    required this.stock,
    required this.prise,
    required this.options
  });

  void Init(){//インスタンス

  }
  
  

}
