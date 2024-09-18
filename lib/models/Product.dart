import 'package:flutter/material.dart';

class Product{
  ///商品名(String)
  final String name;
  ///商品の在庫(int)
  final int stock;
  ///商品の原価(int)
  final int price;
  ///商品のオプション名のリスト(List<int>)
  final List<String> options;

  const Product({
    required this.name,
    required this.stock,
    required this.price,
    required this.options
  });

  factory Product.fromFirestore(Map<String, dynamic> data) {

    return Product(
      name: data['name'] ?? 'Unknow', 
      stock: data['stock'] ?? 0,
      price: data['price'] ?? 0,
      options: data['options'] != null ? List<String>.from(data['options']) : [] // optionsをList<String>に変換
    );
  }

  void Init(){//インスタンス

  }

}
