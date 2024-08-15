import 'package:flutter/material.dart';
import '../models/Product.dart';

class CategoryButtons extends StatelessWidget{

  final List<Product> products;

  const CategoryButtons({
    Key? key, 
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
        width: 200,
        height: 900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 190,
              height: 25,
              margin: const EdgeInsets.all(3.0),
              color: const Color.fromARGB(248, 228, 227, 227),
              child: const Center(child:Text('商品名',selectionColor: Color.fromARGB(255, 255, 254, 254),)),
            ),
            for(int i = 0; i < this.products.length; i++)...[
              ElevatedButton(                            
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 250, 233, 195),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)
                  ),
                  minimumSize: const Size(190, 100),
                ),
                onPressed: () {
                                    // ボタンが押されたときの処理をここに書く
                },
                child: Text(products[i].name),
              ),
              Container(height: 10),
            ]
          ]
        ),
              
//もも
                            Container(
                              height: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 250, 233, 195),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)
                                  ),
                                  minimumSize: const Size(190, 100),
                                ),
                                onPressed: () {
                                  // ボタンが押されたときの処理をここに書く
                                },
                                child: const Text("ボタン1"),
                            ),//かわ
                          ],
                        ),
                      );
                    
  }
}