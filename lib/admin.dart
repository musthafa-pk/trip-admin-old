import 'package:admin_page/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool _firstValue = true;
  var _secValue = 'a';
  int _selectedIndex = 0;
  String? hub;
  List<String> hubList = ['KKD', 'PKD', 'MLP', 'WYD', 'KNN'];
  String? distance;
  List<String> distanceList = ['LH', 'SH'];
  // List<String> distance = [
  //   "",
  //   "KL11AA1111",
  //   "KL11AA1257",
  //   "KL11AA2222",
  //   "KL11AA1234"
  // ];
  List<String> suggestions = [
    "KL11AA1235",
    "KL11AA1111",
    "KL11AA1257",
    "KL11AA2222",
    "KL11AA1234"
  ];
  TextEditingController controller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        toolbarHeight: 50,
        // title: Image.asset(
        //   'assets/images/Group.png',
        //   width: 70,
        // ),
        backgroundColor: Color(0xfff012443),
      ),
      body: Scrollbar(
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            // Row(
            //   children: [
            //     NavigationRail(
            //         labelType: NavigationRailLabelType.all,
            //         selectedLabelTextStyle: const TextStyle(
            //           color: Colors.amber,
            //         ),
            //         onDestinationSelected: (int index) {
            //           setState(() {
            //             _selectedIndex = index;
            //           });
            //         },
            //         minWidth: 55.0,
            //         groupAlignment: 0.0,
            //         backgroundColor: Colors.blueGrey,
            //         destinations: [
            //           NavigationRailDestination(
            //               icon: Icon(Icons.abc), label: Text('settings')),
            //           NavigationRailDestination(
            //               icon: Icon(Icons.abc), label: Text('settings'))
            //         ],
            //         selectedIndex: 0),
            //   ],
            // ),
            LayoutBuilder(builder: (context, Constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // Center(
                  //   child: Text(
                  //     "Assign Trip",
                  //     style: TextStyle(
                  //         fontSize: 17,
                  //         fontFamily: 'ArgentumSans',
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Container(
                        //   height: 100,
                        //   width: 200,
                        //   child: DropdownButton(
                        //     items: [
                        //       DropdownMenuItem(
                        //         child: Row(
                        //           children: <Widget>[
                        //             Checkbox(
                        //               onChanged: (bool? value) {
                        //                 setState(() {
                        //                   _firstValue = value!;
                        //                 });
                        //               },
                        //               value: _firstValue,
                        //             ),
                        //             Text('First'),
                        //           ],
                        //         ),
                        //       ),
                        //       DropdownMenuItem(
                        //         child: Row(
                        //           children: <Widget>[
                        //             Checkbox(
                        //               onChanged: (bool? value) {
                        //                 setState(() {
                        //                   _firstValue = value!;
                        //                 });
                        //               },
                        //               value: _firstValue,
                        //             ),
                        //             Text('Second'),
                        //           ],
                        //         ),
                        //       )
                        //     ],
                        //     onChanged: (value) {},
                        //     hint: Text('Select value'),
                        //   ),
                        // ),
                        Container(
                          width: 200,
                          height: 100,
                          child: DropDown(
                            type: hub,
                            typeList: hubList,
                            hint: 'enter hub',
                          ),
                        ),
                        Container(
                            width: 200,
                            height: 100,
                            child: DropDown(
                              type: distance,
                              typeList: distanceList,
                              hint: 'select mile',
                            )),
                        Container(
                            width: 200,
                            height: 100,
                            child: DropDown(
                              hint: 'from location',
                              type: hub,
                              typeList: hubList,
                            )),
                        Container(
                            width: 200,
                            height: 100,
                            child: DropDown(
                              hint: 'to location',
                              type: hub,
                              typeList: hubList,
                            )),
                        Container(
                          width: 200,
                          height: 100,
                          child: DropDownTextField.multiSelection(
                            textFieldDecoration: InputDecoration(
                              hintText: 'Select orders',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xfff05acff)),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              // contentPadding: EdgeInsets.only(left: 9,right:1,bottom: 10),
                              isDense: true,
                              // contentPadding: EdgeInsets.fromLTRB(10 / 2, 10 / 2, 10 / 2, 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            // controller: _cntMulti,
                            initialValue: const [],
                            dropDownList: const [
                              DropDownValueModel(
                                  name: 'C12345  200KG', value: "value1"),
                              DropDownValueModel(
                                  name: 'C1234  1T',
                                  value: "value2",
                                  toolTipMsg:
                                      "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                              DropDownValueModel(
                                  name: 'C02883 3KG', value: "value3"),
                              DropDownValueModel(
                                  name: 'C28737 10KG',
                                  value: "value4",
                                  toolTipMsg:
                                      "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                              DropDownValueModel(
                                  name: 'C12727 100KG', value: "value5"),
                            ],
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 100,
                          child: DropDownTextField.multiSelection(
                            textFieldDecoration: InputDecoration(
                              hintText: 'Select vehicle',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xfff05acff)),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              // contentPadding: EdgeInsets.only(left: 9,right:1,bottom: 10),
                              isDense: true,
                              // contentPadding: EdgeInsets.fromLTRB(10 / 2, 10 / 2, 10 / 2, 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            // controller: _cntMulti,
                            initialValue: const [],
                            dropDownList: const [
                              DropDownValueModel(
                                  name: 'KL11AA1234 10T', value: "value1"),
                              DropDownValueModel(
                                  name: 'KL11AA1232 1T',
                                  value: "value2",
                                  toolTipMsg:
                                      "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                              DropDownValueModel(
                                  name: 'KL11AA1212 0.5T', value: "value3"),
                              DropDownValueModel(
                                  name: 'KL11AA1111',
                                  value: "value4",
                                  toolTipMsg:
                                      "DropDownButton is a widget that we can use to select one unique value from a set of values"),
                              DropDownValueModel(
                                  name: 'KL11AA1124', value: "value5"),
                            ],
                            onChanged: (val) {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'submit',
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'ArgentumSans',
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(300, 60),
                          maximumSize: Size(300, 60),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                ],
              );
            }),
            SizedBox(
              height: 20,
            ),
            Text('Copyright@Chaavie Solutions LLP'),
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatelessWidget {
  var hint;
  String? type;
  List<String> typeList;
  String? _selecttyped = 'KKD';
  List<String> _selecttypedList = ['KKD', 'PKD', 'MLP', 'WYD', 'KNN'];
  String? distance;
  List<String> distanceList = ['LH', 'SH'];

  DropDown(
      {Key? key,
      required this.hint,
      required this.type,
      required this.typeList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      iconEnabledColor: Colors.grey,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 15,
        fontFamily: 'ArgentumSans',
      ),
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xfff05acff)),
          borderRadius: BorderRadius.circular(0),
        ),
        // contentPadding: EdgeInsets.only(left: 9,right:1,bottom: 10),
        isDense: true,
        // contentPadding: EdgeInsets.fromLTRB(10 / 2, 10 / 2, 10 / 2, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
      value: type,
      onChanged: (String? newValue) {
        type = newValue ?? "";
        print('type==$type');
      },
      items: typeList.map((location) {
        return DropdownMenuItem(
          child: Text(location),
          value: location,
        );
      }).toList(),
      validator: (value) {
        if (value == null || value == 0) {
          return 'Please Choose Product Type';
        }
        return null;
      },
    );
  }
}

class Formfield extends StatelessWidget {
  var controller;
  var icon;
  var text;
  var keyboard;
  List<String> suggestions = [];
  Formfield(
      {Key? key, required this.controller, this.text, this.icon, this.keyboard})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      animationStart: 0,
      animationDuration: Duration.zero,
      textFieldConfiguration: TextFieldConfiguration(
          autofocus: true,
          style: TextStyle(fontSize: 15),
          decoration:
              InputDecoration(border: OutlineInputBorder(), hintText: text)),
      suggestionsBoxDecoration:
          SuggestionsBoxDecoration(color: Colors.lightBlue[50]),
      suggestionsCallback: (pattern) {
        List<String> matches = <String>[];
        matches.addAll(suggestions);

        matches.retainWhere((s) {
          return s.toLowerCase().contains(pattern.toLowerCase());
        });
        return matches;
      },
      itemBuilder: (context, sone) {
        return Card(
            child: Container(
          padding: EdgeInsets.all(10),
          child: Text(sone.toString()),
        ));
      },
      onSuggestionSelected: (suggestion) {
        print(suggestion);
      },
    );
  }
}

class CustomCard extends StatelessWidget {
  CustomCard({this.children});

  final children;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: children,
      ),
    );
  }
}
