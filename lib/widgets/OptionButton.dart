import 'package:flutter/material.dart';
import '../models/Product.dart';

class OptionButton extends StatefulWidget{

  OptionButton({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
  }) : super(key: key);

  final double height;

  final double width;

  /// Gridのタイトル
  final String title;
  
  /// オプション名のリスト
  final List<String> options;
  
  /// 現在選択されているオプション
  int? selectedOption;
  
  /// オプションが選択されたときのコールバック関数
  final Function onOptionSelected;

  @override
  State<OptionButton> createState() => _OptionButton();
}

class _OptionButton extends State<OptionButton>{

  void onButtonPressed(int optionName) {
    int? selected = optionName;
    setState(() {
      if (optionName == widget.selectedOption) {
        selected = null;
      }
      widget.selectedOption = selected;
    });
    widget.onOptionSelected(widget.selectedOption);
  }


  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      width: widget.width,
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 190,
            height: 25,
            margin: const EdgeInsets.all(3.0),
            color: const Color.fromARGB(248, 228, 227, 227),
            child: Center(
              child: Text(
                widget.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          for (int i = 0; i < widget.options.length; i++) ...[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: i == widget.selectedOption
                    ? const Color.fromARGB(255, 165, 154, 129)
                    : const Color.fromARGB(255, 250, 233, 195),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                minimumSize: const Size(190, 100),
              ),
              onPressed: () => onButtonPressed(i),
              child: Text(widget.options[i]),
            ),
            const SizedBox(height: 10),
          ]
        ],
      ),
    );
  }
}