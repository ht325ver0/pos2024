import 'package:flutter/material.dart';

class Product{
  final String name;//商品名
  final int stock;//商品の在庫
  final int prise;//商品の原価
  final Map<String, int> options;//商品のオプション名をキー、それに対応して+-する価格

  const Product({
    required this.name,
    required this.stock,
    required this.prise,
    required this.options
  });

  void Init(){//インスタンス

  }
  
  Map getPrise(){//optionごとの小計を出すメソッド
    Map <String, int> subprise = {};

    this.options.forEach((key, value) {
      subprise[key] = value + this.prise;
    });

    return subprise;
  }

}
