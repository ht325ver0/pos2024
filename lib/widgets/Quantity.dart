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
            width: 380,
            height: 25,
            margin: const EdgeInsets.all(3.0),
            color: const Color.fromARGB(248, 228, 227, 227),
            child: Center(child:Text(widget.title,selectionColor: Color.fromARGB(255, 255, 254, 254),)),
          ),
          Container(
            height: 20,
          ),
          Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 380,
            height: 125,
            child: Expanded(
              child: ListWheelScrollView(
                itemExtent: 50,
                physics: FixedExtentScrollPhysics(), 
                onSelectedItemChanged: (selectedItem) {
                  setState(() {
                    widget.index = selectedItem;
                    widget.onQuantityChange(widget.index);
                  });
                },
                controller: controller,
                children: [
                  for (var i in List.generate(1000, (i) => i))
                    Container(
                      decoration: BoxDecoration(
                        color: widget.index - 1 == i
                          ? Colors.blueAccent
                          : Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          width: 2,
                          color: widget.index - 1 == i
                            ? Colors.blueAccent 
                            : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          (i + 1).toString(),
                          style: TextStyle(
                            fontSize: widget.index-1 == i ? 24.0 : 18.0, // 選択されたアイテムのフォントサイズ
                            fontWeight: widget.index-1 == i ? FontWeight.bold : FontWeight.normal, // 選択されたアイテムのフォントの太さ
                          ),
                        ),
                      ),
                    ),  
                ],
              ),
            ),
          ),
          Center(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decrementCounter,
                  color: Colors.red,
                  iconSize: 40.0,
                ),
                Container(
                  width: 2,
                  height: 20,
                  color: Color.fromARGB(255, 193, 192, 192),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _incrementCounter,
                  color: Colors.green,
                  iconSize: 40.0,
                ),
                Container(
                  child:Text(widget.index.toString())
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}