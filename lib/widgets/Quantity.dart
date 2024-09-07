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
            height: widget.height * 0.1,
            margin: const EdgeInsets.all(3.0),
            color: const Color.fromARGB(248, 228, 227, 227),
            child: Center(child:Text(widget.title,selectionColor: Color.fromARGB(255, 255, 254, 254),)),
          ),
          Container(
            height: widget.height * 0.05,
          ),
          Container(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: widget.width * 0.85,
            height: widget.height * 0.6,
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
            child: Container(
              width: widget.width * 0.9,
              height: widget.height * 0.2,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: _decrementCounter,
                    color: Colors.red,
                    iconSize: widget.width * 0.1,
                  ),
                  Container(
                    width: 2,
                    height: widget.height * 0.1,
                    color: Color.fromARGB(255, 193, 192, 192),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _incrementCounter,
                    color: Colors.green,
                    iconSize: widget.width * 0.1,
                  ),
                  Container(
                    child:Text(widget.index.toString())
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