import 'package:flutter/material.dart';

class Quantity extends StatefulWidget{

  Quantity({
    Key? key, 
    required this.height,
    required this.width,
    required this.title,
    required this.index,
    required this.onQuantityChange,
  }) : super(key: key);

  final double height;

  final double width;

  ///タイトル(String)
  final String title;

  ///注文数を代入する(int)
  int index;

  final Function(int) onQuantityChange;

  @override
  State<Quantity> createState() => _Quantity();
}

class _Quantity extends State<Quantity>{


  void _incrementCounter() {
    setState(() {
      widget.index++;
      widget.onQuantityChange(widget.index);
    });
  }

  void _decrementCounter() {
    setState(() {
      if (widget.index > 1) {
        widget.index--;
        widget.onQuantityChange(widget.index);
      }
    });
  }

  FixedExtentScrollController controller = FixedExtentScrollController(initialItem:  0);

  @override
  Widget build(BuildContext context){
    return  Container(
      width: widget.width,
      height: widget.height,
      color: Color.fromARGB(255, 255, 255, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: widget.width * 0.9,
            height: widget.height * 0.15,
            margin: const EdgeInsets.all(3.0),
            color: const Color.fromARGB(248, 228, 227, 227),
            child: Center(child:Text(widget.title,selectionColor: Color.fromARGB(255, 255, 254, 254),style: TextStyle(fontSize: 18))),
          ),
          Container(
            height: widget.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:[
              Container(width: widget.width * 0.05,),
              Text(widget.index.toString(),style: TextStyle(fontSize: 40)),
              Text('個',style: TextStyle(fontSize: 40)),
              Container(width: widget.width * 0.05)
            ]
          ),
          Center(
            child: Container(
              width: widget.width,
              height: widget.height * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // 中央に揃える
                crossAxisAlignment: CrossAxisAlignment.center, // 縦方向も中央に揃える
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: _decrementCounter,
                    color: Colors.red,
                    iconSize: widget.width * 0.3,
                    padding: EdgeInsets.all(0), // パディングをゼロに
                    constraints: BoxConstraints(
                      minWidth: widget.width * 0.3, // アイコンと一致させる
                      minHeight: widget.width * 0.3, 
                    ),
                  ),
                  SizedBox(width: widget.width * 0.05), // アイコンの間隔を設定
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _incrementCounter,
                    color: Colors.green,
                    iconSize: widget.width * 0.3,
                    padding: EdgeInsets.all(0), // パディングをゼロに
                    constraints: BoxConstraints(
                      minWidth: widget.width * 0.3, // アイコンと一致させる
                      minHeight: widget.width * 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),


        ],
      ),
    );
  }
}