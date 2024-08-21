import 'package:flutter/material.dart';

class Quantity extends StatefulWidget{

  Quantity({
    Key? key, 
    required this.title,
    required this.index,
  }) : super(key: key);

  ///タイトル(String)
  final String title;

  ///注文数を代入する(int)
  int index;

  @override
  State<Quantity> createState() => _Quantity();
}

class _Quantity extends State<Quantity>{

  @override
  Widget build(BuildContext context){
    return  Container(
      width: 390,
      height: 200,
      color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 380,
            height: 25,
            margin: const EdgeInsets.all(3.0),
            color: const Color.fromARGB(248, 228, 227, 227),
            child: Center(child:Text(widget.title,selectionColor: Color.fromARGB(255, 255, 254, 254),)),
          ),
          Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 380,
            height: 100,
            child: ListWheelScrollView(
              itemExtent: 70.0,
              physics: FixedExtentScrollPhysics(), 
              onSelectedItemChanged: (selectedItem) {
                setState(() {
                  widget.index = selectedItem;
                });
              },
              children: [
                for (var i in List.generate(12, (i) => i))
                  Container(
                    color: widget.index == i
                      ? Color.fromARGB(255, 255, 183, 77)  // 選択されたアイテムの背景色
                      : Color.fromARGB(255, 111, 255, 113), // その他のアイテムの背景色
                    width: 200,
                    child: Center(
                      child: Text(
                        (i + 1).toString(),
                        style: TextStyle(
                          fontSize: widget.index == i ? 24.0 : 18.0, // 選択されたアイテムのフォントサイズ
                          fontWeight: widget.index == i ? FontWeight.bold : FontWeight.normal, // 選択されたアイテムのフォントの太さ
                          color: widget.index == i ? Colors.black : Colors.white, // 選択されたアイテムのフォントカラー
                        ),
                      ),
                    ),                    
                  ), 
              ]
            ),
          ),
        ],
      ),
    );
  }
}
        
 