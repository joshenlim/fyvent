import 'package:flutter/material.dart';

class DropdownOption extends StatefulWidget {
  final List<String> options;
  DropdownOption({Key key, @required this.options}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DropdownOptionState();
}

class DropdownOptionState extends State<DropdownOption> {
  List<String> options = [];
  String activeOption = "";

  @override
  void initState() {
    super.initState();
    options = widget.options;
    activeOption = widget.options[0];
  }

  @override
  Widget build(BuildContext context) {
    return new DropdownButton<String>(
      items: options.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      value: activeOption,
      onChanged: (sel) {
        setState(() {
          activeOption = sel;
        });
      },
    );
  }
}