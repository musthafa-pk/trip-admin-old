import 'package:flutter/material.dart';

class CheckBoxList extends StatefulWidget {
  CheckBoxList({required this.children}) {
    this.values = List.generate(children.length, (index) => false);
  }
  final List<String> children;
  // final int count;
  late final List<bool> values;

  @override
  _CheckBoxListState createState() => _CheckBoxListState();
}

class _CheckBoxListState extends State<CheckBoxList> {
  var _firstValue;
  var dropdownvalue;
  var element;
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    var children = widget.children;
    var values = widget.values;
    return Scaffold(
      body: Center(
        child: Container(
          height: 70,
          width: 200,
          child: DropdownButton<String>(
            value: dropdownvalue,
            icon: Icon(Icons.keyboard_arrow_down),
            iconSize: 28,
            elevation: 20,
            onChanged: (String? newval) {
              setState(() {
                dropdownvalue = newval;
              });
            },
            items: [
              DropdownMenuItem(
                  child: Row(
                children: [
                  CheckboxListTile(
                    onChanged: ((value) {}),
                    value: _value,
                    // onChanged: (bool? newval) {
                    // setState(() {
                    //   dropdownvalue = newval;
                    // });
                    // })
                  )
                ],
              ))
            ],
            // items: <String>["Registration", "Verification", "ArenaRun"]
            //     .map<DropdownMenuItem<String>>((String value) {
            //   return DropdownMenuItem<String>(
            //     value: value,
            //     child: Row(
            //       children: [
            //         CheckboxListTile(
            //             value: _value,
            //             onChanged: (bool? value) {
            //               // _value = value!;
            //             })
            //       ],
            //     ),
            //   );
            // }).toList(),
          ),
        ),
      ),
      // body: Column(
      //     children: children.map((element) {
      //   int index = children.indexOf(element);
      //   return CheckboxListTile(
      //     activeColor: Colors.teal,
      //     title: Text(
      //       element,
      //       style: TextStyle(),
      //     ),
      //     value: values[index],
      //     onChanged: (bool? value) {
      //       setState(() {
      //         values[index] = value!;
      //       });
      //     },
      //   );
      // }).toList()),
    );
  }
}
