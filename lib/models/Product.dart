import 'package:flutter/material.dart';

class Product{
  ///商品名(String)
  final String name;
  ///商品の在庫(int)
  final int stock;
  ///商品の原価(int)
  final int prise;
  ///商品のオプション名をキー、それに対応して+-する価格(Map<String, int>)
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
