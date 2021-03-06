import 'package:flutter/material.dart';

class DropdownOption extends StatefulWidget {
  final List options;
  final Map activeOption;
  final Function updateQuery;
  DropdownOption(this.options, this.activeOption, this.updateQuery);

  @override
  State<StatefulWidget> createState() => DropdownOptionState();
}


class DropdownOptionState extends State<DropdownOption> {
  List options = [];
  Map activeOption = {};

  @override
  void initState() {
    super.initState();
    options = widget.options;
    activeOption = widget.activeOption;
  }

  @override
  Widget build(BuildContext context) {
    return new DropdownButton(
      items: options.map((option) {
        return new DropdownMenuItem(
          value: option,
          child: new Text(option["name"]),
        );
      }).toList(),
      value: activeOption,
      onChanged: (sel) {
        setState(() {
          activeOption = sel;
          widget.updateQuery(sel);
        });
      },
    );
  }
}