import 'package:flutter/material.dart';

class KeypadWidget extends StatefulWidget {
  final Function(String) onKeyPressed;
  final double width;
  final double height;

  KeypadWidget({required this.onKeyPressed, required this.width, required this.height});

  @override
  _KeypadWidgetState createState() => _KeypadWidgetState();
}

class _KeypadWidgetState extends State<KeypadWidget> {
  final List<String> _keys = [
    '1', '2', '3',
    '4', '5', '6',
    '7', '8', '9',
    'C', '0', 'OK',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3列のグリッド
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: _keys.length,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {
              widget.onKeyPressed(_keys[index]);
            },
            child: Text(
              _keys[index],
              style: TextStyle(fontSize: 24),
            ),
          );
        },
      ),
    );
  }
}
