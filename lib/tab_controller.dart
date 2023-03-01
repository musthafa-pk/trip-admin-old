import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  List<bool> _isChecked=[];
  int weight=0;
  int volume=0;
  void initState() {
    bookingTables();
    // getOrders();
    // TODO: implement initState
    super.initState();
    setState((){
      // bool _isSelected;
      // _isSelected = widget.isSelected;
      // if (_isSelected == true) {
      //   color = Colors.lightBlueAccent;
      // } else {
      //   color = Colors.transparent;
      // }
      _isChecked = List<bool>.filled(10
          // bookingTable.length==null?10:bookingTable.length
          , false);
    });

    // _controller = TabController(length: 2, vsync: this );
  }
  var bookingTablenew;
bool?  isLoading=false;
  List<String> userChecked = [];
  int? selectedIndex=0;
  List<int> _selectedItems = <int>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Material Indicator: position bottom"),
                ),
                Material(
                  child: TabBar(
                    indicatorColor: Colors.green,
                    tabs: [
                      Tab(
                        text: "Home",
                      ),
                      Tab(
                        text: "Work",
                      ),
                      Tab(
                        text: "Play",
                      ),
                    ],
                    labelColor: Colors.black,
                    indicator: MaterialIndicator(
                      height: 5,
                      topLeftRadius: 8,
                      topRightRadius: 8,
                      horizontalPadding: 50,
                      tabPosition: TabPosition.bottom,
                    ),
                  ),
                ),
                Container(width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: TabBarView(children: [
                  Row(
                  children: [
                  Padding(
                  padding: const EdgeInsets.only(left: 20, right: 40,top: 20),
                  child: Container(
                    width: 300,
                    height: 400,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        color: Color(0XFFF2F0FF)),
                    child: Column(
                      children: [
                        Text(
                          'Orders',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),
                        ),
                        isLoading==false? Center(child: CircularProgressIndicator(),):
                        bookingTablenew==null? Center(child: CircularProgressIndicator()):
                        bookingTablenew.length == null ?
                        Center(child: Text('No orders'))
                            :
                        Container(
                          height: MediaQuery.of(context).size.height*0.4,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                              separatorBuilder: (BuildContext context, index) => Divider(
                                color: Colors.grey,thickness: 1,
                              ),
                              itemCount: bookingTablenew.length,
                              itemBuilder: (BuildContext context, index) {
                                return Column(
                                  children: [

                                    ListTile(
                                      title: Text(
                                        '${bookingTablenew[index]['order_id']}',
                                        style: GoogleFonts.barlow(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    CheckboxListTile(
                                      selectedTileColor: Colors.blue,
                                      tileColor: selectedIndex == index ? Colors.red : null,
                                      value: _isChecked[index],
                                      onChanged: (bool? newValue){
                                        setState((){
                                          _isChecked[index] = newValue!;
                                          print(_isChecked[index]);
                                          if(_selectedItems.contains(_isChecked[index])){
                                            setState(() {
                                              _selectedItems.add(index);
                                            });
                                          }

                                          selectedIndex =index;
                                          print(_selectedItems);

                                        });

                                        // return check;
                                      },
                                      // subtitle: Checkbox(
                                      // value:userChecked.contains(bookingTable[index]) ,
                                      // onChanged:(value){
                                      //   setState(() {
                                      //     _onSelected(value!,bookingTable[index]);
                                      //   });
                                      //  },),
                                      title:Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Order Id : ${bookingTablenew[index]['order_id']}',
                                            style: GoogleFonts.barlow(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom:4),
                                            child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'From: ',
                                                  style: GoogleFonts.barlow(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    '${bookingTablenew[index]['from_location']}',
                                                    style: GoogleFonts.barlow(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Table(
                                              defaultColumnWidth: FixedColumnWidth(72),
                                              border: TableBorder.all(color: Colors.black,width: 0.5,
                                                  borderRadius: BorderRadius.circular(10)),
                                              children: [
                                                TableRow(children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(4.0),
                                                    child: Center(child: Text('Product',
                                                      style:TextStyle(
                                                          fontFamily: 'ArgentumSans',
                                                          color: Colors.black
                                                        // (0XFFF01244C),
                                                      ),)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(4.0),
                                                    child: Center(child: Text('Count',
                                                      style:TextStyle(
                                                          fontFamily: 'ArgentumSans',
                                                          color: Colors.black
                                                        // (0XFFF01244C),
                                                      ),)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(4.0),
                                                    child: Center(child: Text('Volume',
                                                      style:TextStyle(
                                                          fontFamily: 'ArgentumSans',
                                                          color: Colors.black
                                                        // (0XFFF01244C),
                                                      ),)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(4.0),
                                                    child: Center(child: Text('Weight',
                                                      style:TextStyle(
                                                          fontFamily: 'ArgentumSans',
                                                          color: Colors.black
                                                        // (0XFFF01244C),
                                                      ),)),
                                                  ),

                                                ]),
                                                TableRow(children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(4.0),
                                                    child: Center(child: Text("${bookingTablenew[index]['booking_weight']}",
                                                      style:TextStyle(
                                                          fontFamily: 'ArgentumSans',
                                                          color: Colors.black
                                                        // (0XFFF01244C),
                                                      ),)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(4.0),
                                                    child: Center(child: Text("${bookingTablenew[index]['booking_weight']}",
                                                      style:TextStyle(
                                                          fontFamily: 'ArgentumSans',
                                                          color: Colors.black
                                                        // (0XFFF01244C),
                                                      ),)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(4.0),
                                                    child: Center(child: Text("${bookingTablenew[index]['booking_weight']}",
                                                      style:TextStyle(
                                                          fontFamily: 'ArgentumSans',
                                                          color: Colors.black
                                                        // (0XFFF01244C),
                                                      ),)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.all(4.0),
                                                    child: Center(child: Text("${bookingTablenew[index]['cost']}",
                                                      style:TextStyle(
                                                          fontFamily: 'ArgentumSans',
                                                          color: Colors.black
                                                        // (0XFFF01244C),
                                                      ),)),
                                                  ),

                                                ]),])

                                        ],
                                      ),
                                    ),

                                    // ElevatedButton(onPressed: (){
                                    //   bookingTables();
                                    // }, child: Text('try'))
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 40,top: 20),
                  child: Container(
                    width: 300,
                    height: 400,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),

                        color: Color(0XFFF2F0FF)),
                    child: Column(
                      children: [
                        Text(
                          'Vehicles',
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),
                        ),
                        // isLoading==false? Center(child: CircularProgressIndicator(),):
                        // Order==null? Center(child: CircularProgressIndicator()):
                        // Order.length == null ?
                        // Center(child: Text('No orders'))
                        //     :
                        // Container(
                        //   height: MediaQuery.of(context).size.height*0.4,
                        //   width: MediaQuery.of(context).size.width,
                        //   child: ListView.separated(
                        //       separatorBuilder: (BuildContext context, index) => Divider(
                        //         color: Colors.grey,thickness: 1,
                        //       ),
                        //       itemCount: Order.length,
                        //       itemBuilder: (BuildContext context, index) {
                        //         return Column(
                        //           children: [
                        //             Container(
                        //               color: (_selectedItems.contains(index))? Colors.blue.withOpacity(0.5) : Colors.transparent,
                        //               child: ListTile(
                        //                 onTap: (){
                        //                   // if(_selectedItems.contains(index)){
                        //                   //   setState(() {
                        //                   //     _selectedItems.removeWhere((val) => val == index);
                        //                   //     weight=0;
                        //                   //     for(var Items in _selectedItems ){
                        //                   //       int sum1 = Order[Items]['vehicle_number'];
                        //                   //
                        //                   //       // sum=sum+sum1[];
                        //                   //       weight += bookingTable[Items]['cost'] as int;
                        //                   //
                        //                   //       // sum==sum;
                        //                   //       print('ok1:$weight');
                        //                   //       // sum=0;
                        //                   //       // print('sum1:$ADD1');
                        //                   //       // ADD1 = sum+ADD1;
                        //                   //       // sum=0;
                        //                   //       // print('ok:$sum');
                        //                   //       // print('sum:$ADD1');
                        //                   //       // sum.clear();
                        //                   //       setState(() {
                        //                   //         // void erase() {
                        //                   //         //   sum.clear();
                        //                   //         //   print('ok');
                        //                   //         //   erase();
                        //                   //         // }
                        //                   //       });
                        //                   //       // erase();
                        //                   //       // print(sum);
                        //                   //       print("Items:$Items");
                        //                   //
                        //                   //     }
                        //                   //     // sum = _selectedItems.reduce((value, element) => value + element);
                        //                   //     print('ok:$weight');
                        //                   //     // for(int i=0;i<_selectedItems.length;i++){
                        //                   //     //   setState(() {
                        //                   //     //     var sum = bookingTable[i]['cost'];
                        //                   //     //     ADD1 = sum-ADD1;
                        //                   //     //     print(ADD1);
                        //                   //     //   });
                        //                   //     //
                        //                   //     // }
                        //                   //     print(_selectedItems);
                        //                   //   });
                        //                   // }
                        //                 },
                        //                 onLongPress: (){
                        //                   // if(! _selectedItems.contains(index)){
                        //                   //   // var add = bookingTable.map<int>((m) => int.parse(m["cost"])).reduce((a,b )=>a+b);
                        //                   //   // print(add);
                        //                   //   setState(() {
                        //                   //     _selectedItems.add(index);
                        //                   //     weight=0;
                        //                   //     for(var Items in _selectedItems ){
                        //                   //       int sum1 = bookingTable[Items]['cost'];
                        //                   //
                        //                   //       // sum=sum+sum1[];
                        //                   //       weight += bookingTable[Items]['cost'] as int;
                        //                   //
                        //                   //       // sum==sum;
                        //                   //       print('ok1:$weight');
                        //                   //       // sum=0;
                        //                   //       // print('sum1:$ADD1');
                        //                   //       // ADD1 = sum+ADD1;
                        //                   //       // sum=0;
                        //                   //       // print('ok:$sum');
                        //                   //       // print('sum:$ADD1');
                        //                   //       // sum.clear();
                        //                   //       setState(() {
                        //                   //         // void erase() {
                        //                   //         //   sum.clear();
                        //                   //         //   print('ok');
                        //                   //         //   erase();
                        //                   //         // }
                        //                   //       });
                        //                   //       // erase();
                        //                   //       // print(sum);
                        //                   //       print("Items:$Items");
                        //                   //
                        //                   //     }
                        //                   //     // sum = _selectedItems.reduce((value, element) => value + element);
                        //                   //     print('ok:$weight');
                        //                   //     // for(int i=0;i<_selectedItems.length;i++){
                        //                   //     //   setState(() {
                        //                   //     //   var sum = bookingTable[i]['cost'];
                        //                   //     //   ADD1 = sum+ADD1;
                        //                   //
                        //                   //     //   });
                        //                   //     //
                        //                   //     // }
                        //                   //
                        //                   //     print(_selectedItems);
                        //                   //   });
                        //                   // }
                        //                 },
                        //                 title: Text(
                        //                   '${Order[index]['max_load_kg']} kg',
                        //                   style: GoogleFonts.barlow(
                        //                       fontSize: 17,
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //                 leading:Text(
                        //                   '${Order[index]['vehicle_number']}',
                        //                   style: GoogleFonts.barlow(
                        //                       fontSize: 17,
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //                 trailing:Text(
                        //                   '${Order[index]['max_load_vol']} m³',
                        //                   style: GoogleFonts.barlow(
                        //                       fontSize: 17,
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //                 subtitle:Text(
                        //                   '${Order[index]['service_days']}',
                        //                   style: GoogleFonts.barlow(
                        //                       fontSize: 15,
                        //                       fontWeight: FontWeight.bold),
                        //                 ),
                        //               ),
                        //             ),
                        //             // ListTile(
                        //             //   title: Text(
                        //             //     '${bookingTable[index]['order_id']}',
                        //             //     style: GoogleFonts.barlow(
                        //             //         fontSize: 17,
                        //             //         fontWeight: FontWeight.bold),
                        //             //   ),
                        //             // ),
                        //             //   CheckboxListTile(
                        //             //     selectedTileColor: Colors.blue,
                        //             //     tileColor: selectedIndex == index ? Colors.red : null,
                        //             //       value: _isChecked[index],
                        //             //       onChanged: (bool? newValue){
                        //             //         setState((){
                        //             //           _isChecked[index] = newValue!;
                        //             //           if(_selectedItems.contains(_isChecked[index])){
                        //             //             setState(() {
                        //             //               _selectedItems.add(index);
                        //             //             });
                        //             //           }
                        //             //
                        //             //           selectedIndex =index;
                        //             //           print(_selectedItems);
                        //             //
                        //             //         });
                        //             //
                        //             //         // return check;
                        //             //   },
                        //             //     // subtitle: Checkbox(
                        //             //     // value:userChecked.contains(bookingTable[index]) ,
                        //             //     // onChanged:(value){
                        //             //     //   setState(() {
                        //             //     //     _onSelected(value!,bookingTable[index]);
                        //             //     //   });
                        //             //     //  },),
                        //             //     title:Column(crossAxisAlignment: CrossAxisAlignment.start,
                        //             //       children: [
                        //             //         Text(
                        //             //           'Order Id : ${bookingTable[index]['order_id']}',
                        //             //           style: GoogleFonts.barlow(
                        //             //               fontSize: 15,
                        //             //               fontWeight: FontWeight.bold),
                        //             //         ),
                        //             //         Padding(
                        //             //           padding: const EdgeInsets.only(bottom:4),
                        //             //           child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                        //             //             children: [
                        //             //               Text(
                        //             //                 'From: ',
                        //             //                 style: GoogleFonts.barlow(
                        //             //                     fontSize: 15,
                        //             //                     fontWeight: FontWeight.bold),
                        //             //               ),
                        //             //               Flexible(
                        //             //                 child: Text(
                        //             //                   '${bookingTable[index]['from_location']}',
                        //             //                   style: GoogleFonts.barlow(
                        //             //                       fontSize: 15,
                        //             //                       fontWeight: FontWeight.bold),
                        //             //                 ),
                        //             //               ),
                        //             //             ],
                        //             //           ),
                        //             //         ),
                        //             //         Table(
                        //             //             defaultColumnWidth: FixedColumnWidth(72),
                        //             // border: TableBorder.all(color: Colors.black,width: 0.5,
                        //             //     borderRadius: BorderRadius.circular(10)),
                        //             // children: [
                        //             //   TableRow(children: [
                        //             //     Padding(
                        //             //       padding: EdgeInsets.all(4.0),
                        //             //       child: Center(child: Text('Product',
                        //             //         style:TextStyle(
                        //             //             fontFamily: 'ArgentumSans',
                        //             //             color: Colors.black
                        //             //           // (0XFFF01244C),
                        //             //         ),)),
                        //             //     ),
                        //             //     Padding(
                        //             //       padding: EdgeInsets.all(4.0),
                        //             //       child: Center(child: Text('Count',
                        //             //         style:TextStyle(
                        //             //             fontFamily: 'ArgentumSans',
                        //             //             color: Colors.black
                        //             //           // (0XFFF01244C),
                        //             //         ),)),
                        //             //     ),
                        //             //     Padding(
                        //             //       padding: EdgeInsets.all(4.0),
                        //             //       child: Center(child: Text('Volume',
                        //             //         style:TextStyle(
                        //             //             fontFamily: 'ArgentumSans',
                        //             //             color: Colors.black
                        //             //           // (0XFFF01244C),
                        //             //         ),)),
                        //             //     ),
                        //             //     Padding(
                        //             //       padding: EdgeInsets.all(4.0),
                        //             //       child: Center(child: Text('Weight',
                        //             //         style:TextStyle(
                        //             //             fontFamily: 'ArgentumSans',
                        //             //             color: Colors.black
                        //             //           // (0XFFF01244C),
                        //             //         ),)),
                        //             //     ),
                        //             //
                        //             //   ]),
                        //             //   TableRow(children: [
                        //             //     Padding(
                        //             //       padding: EdgeInsets.all(4.0),
                        //             //       child: Center(child: Text("${bookingTable[index]['booking_weight']}",
                        //             //         style:TextStyle(
                        //             //             fontFamily: 'ArgentumSans',
                        //             //             color: Colors.black
                        //             //           // (0XFFF01244C),
                        //             //         ),)),
                        //             //     ),
                        //             //     Padding(
                        //             //       padding: EdgeInsets.all(4.0),
                        //             //       child: Center(child: Text("${bookingTable[index]['booking_weight']}",
                        //             //         style:TextStyle(
                        //             //             fontFamily: 'ArgentumSans',
                        //             //             color: Colors.black
                        //             //           // (0XFFF01244C),
                        //             //         ),)),
                        //             //     ),
                        //             //     Padding(
                        //             //       padding: EdgeInsets.all(4.0),
                        //             //       child: Center(child: Text("${bookingTable[index]['booking_weight']}",
                        //             //         style:TextStyle(
                        //             //             fontFamily: 'ArgentumSans',
                        //             //             color: Colors.black
                        //             //           // (0XFFF01244C),
                        //             //         ),)),
                        //             //     ),
                        //             //     Padding(
                        //             //       padding: EdgeInsets.all(4.0),
                        //             //       child: Center(child: Text("${bookingTable[index]['cost']}",
                        //             //         style:TextStyle(
                        //             //             fontFamily: 'ArgentumSans',
                        //             //             color: Colors.black
                        //             //           // (0XFFF01244C),
                        //             //         ),)),
                        //             //     ),
                        //             //
                        //             //   ]),])
                        //             //
                        //             //       ],
                        //             //     ),
                        //             //   ),
                        //
                        //             // ElevatedButton(onPressed: (){
                        //             //   bookingTables();
                        //             // }, child: Text('try'))
                        //           ],
                        //         );
                        //       }),
                        // )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 40,top:20),
                  child: Container(
                    width: 300,
                    height: 400,
                    padding: EdgeInsets.only(left: 10, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xfffcee2dc)),child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:10,left: 70,right: 70,bottom: 10),
                        child: Container(
                          height:MediaQuery.of(context).size.height/16,
                          width:MediaQuery.of(context).size.width/12 ,
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.yellowAccent) ,
                          child: Container(
                            height:MediaQuery.of(context).size.height/16,
                            width:MediaQuery.of(context).size.width/12 ,
                            decoration:BoxDecoration(border: Border.all(width: 2,color: Colors.black),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Center(child:
                            Text('KL11 AA 1234',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700))),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height:MediaQuery.of(context).size.height/7,
                          width:MediaQuery.of(context).size.width/5 ,
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white) ,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          //   Column(
                          //   children: [
                          //     Container(width: 100,
                          //       height: 100,
                          //       child:slider ,),
                          //     // Text('Weight')
                          //   ],
                          // ),
                          //
                          //   Column(
                          //     children: [
                          //       Container(width: 100,
                          //         height: 100,
                          //         child:slider ,),
                          //       // Text('Volume')
                          //     ],
                          //   ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ),
                )
              ],
            ),
                    Text('data'),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 40),
                    child: Container(
                      width: 300,
                      height: 400,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),

                          color: Color(0XFFF2F0FF)),
                      child: Column(
                        children: [
                          Text(
                            'Orders',
                            style: TextStyle(color: Colors.black),
                          ),
                          isLoading==false? Center(child: CircularProgressIndicator(),):
                          bookingTablenew==null? Center(child: CircularProgressIndicator()):
                          bookingTablenew.length == null ?
                          Center(child: Text('No orders'))
                              :
                          Container(
                            height: MediaQuery.of(context).size.height*0.4,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                                separatorBuilder: (BuildContext context, index) => Divider(
                                  color: Colors.grey,thickness: 1,
                                ),
                                itemCount: bookingTablenew.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        color: (_selectedItems.contains(index)) ? Colors.blue.withOpacity(0.5) : Colors.transparent,
                                        child: ListTile(
                                          onTap: (){
                                            if(_selectedItems.contains(index)){
                                              setState(() {
                                                _selectedItems.removeWhere((val) => val == index);
                                                weight=0;
                                                for(var Items in _selectedItems ){
                                                  // int sum1 = bookingTable[Items]['cost'];

                                                  // sum=sum+sum1[];
                                                  weight += bookingTablenew[Items]['cost'] as int;

                                                  // sum==sum;
                                                  print('ok1:$weight');
                                                  // sum=0;
                                                  // print('sum1:$ADD1');
                                                  // ADD1 = sum+ADD1;
                                                  // sum=0;
                                                  // print('ok:$sum');
                                                  // print('sum:$ADD1');
                                                  // sum.clear();
                                                  setState(() {
                                                    // void erase() {
                                                    //   sum.clear();
                                                    //   print('ok');
                                                    //   erase();
                                                    // }
                                                  });
                                                  // erase();
                                                  // print(sum);
                                                  print("Items:$Items");

                                                }
                                                // sum = _selectedItems.reduce((value, element) => value + element);
                                                print('ok:$weight');
                                                // for(int i=0;i<_selectedItems.length;i++){
                                                //   setState(() {
                                                //     var sum = bookingTable[i]['cost'];
                                                //     ADD1 = sum-ADD1;
                                                //     print(ADD1);
                                                //   });
                                                //
                                                // }
                                                print(_selectedItems);
                                              });
                                            }
                                          },
                                          onLongPress: (){
                                            if(! _selectedItems.contains(index)){
                                              // var add = bookingTable.map<int>((m) => int.parse(m["cost"])).reduce((a,b )=>a+b);
                                              // print(add);
                                              setState(() {
                                                _selectedItems.add(index);
                                                weight=0;
                                                for(var Items in _selectedItems ){
                                                  int sum1 = bookingTablenew[Items]['cost'];

                                                  // sum=sum+sum1[];
                                                  weight += bookingTablenew[Items]['cost'] as int;

                                                  // sum==sum;
                                                  print('ok1:$weight');
                                                  // sum=0;
                                                  // print('sum1:$ADD1');
                                                  // ADD1 = sum+ADD1;
                                                  // sum=0;
                                                  // print('ok:$sum');
                                                  // print('sum:$ADD1');
                                                  // sum.clear();
                                                  setState(() {
                                                    // void erase() {
                                                    //   sum.clear();
                                                    //   print('ok');
                                                    //   erase();
                                                    // }
                                                  });
                                                  // erase();
                                                  // print(sum);
                                                  print("Items:$Items");

                                                }
                                                // sum = _selectedItems.reduce((value, element) => value + element);
                                                print('ok:$weight');
                                                // for(int i=0;i<_selectedItems.length;i++){
                                                //   setState(() {
                                                //   var sum = bookingTable[i]['cost'];
                                                //   ADD1 = sum+ADD1;

                                                //   });
                                                //
                                                // }

                                                print(_selectedItems);
                                              });
                                            }
                                          },
                                          title: Text(
                                            '${bookingTablenew[index]['cost']} kg',
                                            style: GoogleFonts.barlow(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          leading:Text(
                                            '${bookingTablenew[index]['booking_weight']}',
                                            style: GoogleFonts.barlow(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing:Text(
                                            '${bookingTablenew[index]['booking_weight']} m³',
                                            style: GoogleFonts.barlow(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle:Text(
                                            '${bookingTablenew[index]['booking_weight']}',
                                            style: GoogleFonts.barlow(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      // ListTile(
                                      //   title: Text(
                                      //     '${bookingTable[index]['order_id']}',
                                      //     style: GoogleFonts.barlow(
                                      //         fontSize: 17,
                                      //         fontWeight: FontWeight.bold),
                                      //   ),
                                      // ),
                                      //   CheckboxListTile(
                                      //     selectedTileColor: Colors.blue,
                                      //     tileColor: selectedIndex == index ? Colors.red : null,
                                      //       value: _isChecked[index],
                                      //       onChanged: (bool? newValue){
                                      //         setState((){
                                      //           _isChecked[index] = newValue!;
                                      //           if(_selectedItems.contains(_isChecked[index])){
                                      //             setState(() {
                                      //               _selectedItems.add(index);
                                      //             });
                                      //           }
                                      //
                                      //           selectedIndex =index;
                                      //           print(_selectedItems);
                                      //
                                      //         });
                                      //
                                      //         // return check;
                                      //   },
                                      //     // subtitle: Checkbox(
                                      //     // value:userChecked.contains(bookingTable[index]) ,
                                      //     // onChanged:(value){
                                      //     //   setState(() {
                                      //     //     _onSelected(value!,bookingTable[index]);
                                      //     //   });
                                      //     //  },),
                                      //     title:Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      //       children: [
                                      //         Text(
                                      //           'Order Id : ${bookingTable[index]['order_id']}',
                                      //           style: GoogleFonts.barlow(
                                      //               fontSize: 15,
                                      //               fontWeight: FontWeight.bold),
                                      //         ),
                                      //         Padding(
                                      //           padding: const EdgeInsets.only(bottom:4),
                                      //           child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                      //             children: [
                                      //               Text(
                                      //                 'From: ',
                                      //                 style: GoogleFonts.barlow(
                                      //                     fontSize: 15,
                                      //                     fontWeight: FontWeight.bold),
                                      //               ),
                                      //               Flexible(
                                      //                 child: Text(
                                      //                   '${bookingTable[index]['from_location']}',
                                      //                   style: GoogleFonts.barlow(
                                      //                       fontSize: 15,
                                      //                       fontWeight: FontWeight.bold),
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //         Table(
                                      //             defaultColumnWidth: FixedColumnWidth(72),
                                      // border: TableBorder.all(color: Colors.black,width: 0.5,
                                      //     borderRadius: BorderRadius.circular(10)),
                                      // children: [
                                      //   TableRow(children: [
                                      //     Padding(
                                      //       padding: EdgeInsets.all(4.0),
                                      //       child: Center(child: Text('Product',
                                      //         style:TextStyle(
                                      //             fontFamily: 'ArgentumSans',
                                      //             color: Colors.black
                                      //           // (0XFFF01244C),
                                      //         ),)),
                                      //     ),
                                      //     Padding(
                                      //       padding: EdgeInsets.all(4.0),
                                      //       child: Center(child: Text('Count',
                                      //         style:TextStyle(
                                      //             fontFamily: 'ArgentumSans',
                                      //             color: Colors.black
                                      //           // (0XFFF01244C),
                                      //         ),)),
                                      //     ),
                                      //     Padding(
                                      //       padding: EdgeInsets.all(4.0),
                                      //       child: Center(child: Text('Volume',
                                      //         style:TextStyle(
                                      //             fontFamily: 'ArgentumSans',
                                      //             color: Colors.black
                                      //           // (0XFFF01244C),
                                      //         ),)),
                                      //     ),
                                      //     Padding(
                                      //       padding: EdgeInsets.all(4.0),
                                      //       child: Center(child: Text('Weight',
                                      //         style:TextStyle(
                                      //             fontFamily: 'ArgentumSans',
                                      //             color: Colors.black
                                      //           // (0XFFF01244C),
                                      //         ),)),
                                      //     ),
                                      //
                                      //   ]),
                                      //   TableRow(children: [
                                      //     Padding(
                                      //       padding: EdgeInsets.all(4.0),
                                      //       child: Center(child: Text("${bookingTable[index]['booking_weight']}",
                                      //         style:TextStyle(
                                      //             fontFamily: 'ArgentumSans',
                                      //             color: Colors.black
                                      //           // (0XFFF01244C),
                                      //         ),)),
                                      //     ),
                                      //     Padding(
                                      //       padding: EdgeInsets.all(4.0),
                                      //       child: Center(child: Text("${bookingTable[index]['booking_weight']}",
                                      //         style:TextStyle(
                                      //             fontFamily: 'ArgentumSans',
                                      //             color: Colors.black
                                      //           // (0XFFF01244C),
                                      //         ),)),
                                      //     ),
                                      //     Padding(
                                      //       padding: EdgeInsets.all(4.0),
                                      //       child: Center(child: Text("${bookingTable[index]['booking_weight']}",
                                      //         style:TextStyle(
                                      //             fontFamily: 'ArgentumSans',
                                      //             color: Colors.black
                                      //           // (0XFFF01244C),
                                      //         ),)),
                                      //     ),
                                      //     Padding(
                                      //       padding: EdgeInsets.all(4.0),
                                      //       child: Center(child: Text("${bookingTable[index]['cost']}",
                                      //         style:TextStyle(
                                      //             fontFamily: 'ArgentumSans',
                                      //             color: Colors.black
                                      //           // (0XFFF01244C),
                                      //         ),)),
                                      //     ),
                                      //
                                      //   ]),])
                                      //
                                      //       ],
                                      //     ),
                                      //   ),

                                      // ElevatedButton(onPressed: (){
                                      //   bookingTables();
                                      // }, child: Text('try'))
                                    ],
                                  );
                                }),
                          )

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 40,top: 20),
                    child: Container(
                      width: 300,
                      height: 400,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),

                          color: Color(0XFFF2F0FF)),
                      child: Column(
                        children: [
                          Text(
                            'Orders',
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),
                          ),
                          isLoading==false? Center(child: CircularProgressIndicator(),):
                          bookingTablenew==null? Center(child: CircularProgressIndicator()):
                          bookingTablenew.length == null ?
                          Center(child: Text('No orders'))
                              :
                          Container(
                            height: MediaQuery.of(context).size.height*0.4,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                                separatorBuilder: (BuildContext context, index) => Divider(
                                  color: Colors.grey,thickness: 1,
                                ),
                                itemCount: bookingTablenew.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Column(
                                    children: [

                                      ListTile(
                                        title: Text(
                                          '${bookingTablenew[index]['order_id']}',
                                          style: GoogleFonts.barlow(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      CheckboxListTile(
                                        selectedTileColor: Colors.blue,
                                        tileColor: selectedIndex == index ? Colors.red : null,
                                        value: _isChecked[index],
                                        onChanged: (bool? newValue){
                                          setState((){
                                            _isChecked[index] = newValue!;
                                            print(_isChecked[index]);
                                            if(_selectedItems.contains(_isChecked[index])){
                                              setState(() {
                                                _selectedItems.add(index);
                                              });
                                            }

                                            selectedIndex =index;
                                            print(_selectedItems);

                                          });

                                          // return check;
                                        },
                                        // subtitle: Checkbox(
                                        // value:userChecked.contains(bookingTable[index]) ,
                                        // onChanged:(value){
                                        //   setState(() {
                                        //     _onSelected(value!,bookingTable[index]);
                                        //   });
                                        //  },),
                                        title:Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Order Id : ${bookingTablenew[index]['order_id']}',
                                              style: GoogleFonts.barlow(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom:4),
                                              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'From: ',
                                                    style: GoogleFonts.barlow(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      '${bookingTablenew[index]['from_location']}',
                                                      style: GoogleFonts.barlow(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Table(
                                                defaultColumnWidth: FixedColumnWidth(72),
                                                border: TableBorder.all(color: Colors.black,width: 0.5,
                                                    borderRadius: BorderRadius.circular(10)),
                                                children: [
                                                  TableRow(children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Center(child: Text('Product',
                                                        style:TextStyle(
                                                            fontFamily: 'ArgentumSans',
                                                            color: Colors.black
                                                          // (0XFFF01244C),
                                                        ),)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Center(child: Text('Count',
                                                        style:TextStyle(
                                                            fontFamily: 'ArgentumSans',
                                                            color: Colors.black
                                                          // (0XFFF01244C),
                                                        ),)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Center(child: Text('Volume',
                                                        style:TextStyle(
                                                            fontFamily: 'ArgentumSans',
                                                            color: Colors.black
                                                          // (0XFFF01244C),
                                                        ),)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Center(child: Text('Weight',
                                                        style:TextStyle(
                                                            fontFamily: 'ArgentumSans',
                                                            color: Colors.black
                                                          // (0XFFF01244C),
                                                        ),)),
                                                    ),

                                                  ]),
                                                  TableRow(children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Center(child: Text("${bookingTablenew[index]['booking_weight']}",
                                                        style:TextStyle(
                                                            fontFamily: 'ArgentumSans',
                                                            color: Colors.black
                                                          // (0XFFF01244C),
                                                        ),)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Center(child: Text("${bookingTablenew[index]['booking_weight']}",
                                                        style:TextStyle(
                                                            fontFamily: 'ArgentumSans',
                                                            color: Colors.black
                                                          // (0XFFF01244C),
                                                        ),)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Center(child: Text("${bookingTablenew[index]['booking_weight']}",
                                                        style:TextStyle(
                                                            fontFamily: 'ArgentumSans',
                                                            color: Colors.black
                                                          // (0XFFF01244C),
                                                        ),)),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(4.0),
                                                      child: Center(child: Text("${bookingTablenew[index]['cost']}",
                                                        style:TextStyle(
                                                            fontFamily: 'ArgentumSans',
                                                            color: Colors.black
                                                          // (0XFFF01244C),
                                                        ),)),
                                                    ),

                                                  ]),])

                                          ],
                                        ),
                                      ),

                                      // ElevatedButton(onPressed: (){
                                      //   bookingTables();
                                      // }, child: Text('try'))
                                    ],
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 40),
                    child: Container(
                      width: 300,
                      height: 300,
                      padding: EdgeInsets.only(left: 10, right: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xfffcee2dc)),child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:10,left: 70,right: 70,bottom: 10),
                          child: Container(
                            height:MediaQuery.of(context).size.height/16,
                            width:MediaQuery.of(context).size.width/12 ,
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.yellowAccent) ,
                            child: Container(
                              height:MediaQuery.of(context).size.height/16,
                              width:MediaQuery.of(context).size.width/12 ,
                              decoration:BoxDecoration(border: Border.all(width: 2,color: Colors.black),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Center(child:
                              Text('KL11 AA 1234',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700))),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            height:MediaQuery.of(context).size.height/7,
                            width:MediaQuery.of(context).size.width/5 ,
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white) ,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            //   Column(
                            //   children: [
                            //     Container(width: 90,
                            //       height: 90,
                            //       child:slider ,),
                            //     Text('Weight')
                            //   ],
                            // ),
                            //
                            //   Column(
                            //     children: [
                            //       Container(width: 90,
                            //         height: 90,
                            //         child:slider ,),
                            //       Text('Volume')
                            //     ],
                            //   ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    ),
                  )
                ],
              ),


                  ]),
                )
                // SizedBox(
                //   height: 16,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text("Dot Indicator"),
                // ),
                // Material(
                //   child: TabBar(
                //     indicatorColor: Colors.green,
                //     tabs: [
                //       Tab(
                //         text: "Home",
                //       ),
                //       Tab(
                //         text: "Work",
                //       ),
                //       Tab(
                //         text: "Play",
                //       ),
                //     ],
                //     labelColor: Colors.black,
                //     indicator: DotIndicator(
                //       color: Colors.black,
                //       distanceFromCenter: 16,
                //       radius: 3,
                //       paintingStyle: PaintingStyle.fill,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 16,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text("Material Indicator: position top"),
                // ),
                // Material(
                //   child: TabBar(
                //     indicatorColor: Colors.green,
                //     tabs: [
                //       Tab(
                //         text: "Home",
                //       ),
                //       Tab(
                //         text: "Work",
                //       ),
                //       Tab(
                //         text: "Play",
                //       ),
                //     ],
                //     labelColor: Colors.black,
                //     indicatorSize: TabBarIndicatorSize.label,
                //     indicator: MaterialIndicator(
                //       height: 5,
                //       topLeftRadius: 0,
                //       topRightRadius: 0,
                //       bottomLeftRadius: 5,
                //       bottomRightRadius: 5,
                //       tabPosition: TabPosition.top,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 16,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text("RectangularIndicator Indicator: fill"),
                // ),
                // Material(
                //   child: TabBar(
                //     indicatorColor: Colors.green,
                //     tabs: [
                //       Tab(
                //         text: "Home",
                //       ),
                //       Tab(
                //         text: "Work",
                //       ),
                //       Tab(
                //         text: "Play",
                //       ),
                //     ],
                //     labelColor: Colors.white,
                //     unselectedLabelColor: Colors.black,
                //     indicator: RectangularIndicator(
                //       bottomLeftRadius: 100,
                //       bottomRightRadius: 100,
                //       topLeftRadius: 100,
                //       topRightRadius: 100,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 16,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text("RectangularIndicator Indicator: stroke"),
                // ),
                // TabBar(
                //   indicatorColor: Colors.green,
                //   tabs: [
                //     Tab(
                //       text: "Home",
                //     ),
                //     Tab(
                //       text: "Work",
                //     ),
                //     Tab(
                //       text: "Play",
                //     ),
                //   ],
                //   labelColor: Colors.black,
                //   indicator: RectangularIndicator(
                //     bottomLeftRadius: 100,
                //     bottomRightRadius: 100,
                //     topLeftRadius: 100,
                //     topRightRadius: 100,
                //     paintingStyle: PaintingStyle.stroke,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future bookingTables() async {
    isLoading=true;
    // print('working');
    var bookingTablesUri =
        'http://ec2-3-108-73-102.ap-south-1.compute.amazonaws.com:3000/userorder';

    http.Response resp = await http.post(Uri.parse(bookingTablesUri),
        body: {"email": "deepoosh@gmail.com",
          "status": "Order fulfilled"
        }
    );

    if (resp.statusCode == 200) {

      setState(() {
        bookingTablenew = jsonDecode(resp.body);
        // var bookingTable1=bookingTable[0]['order_id'];
        print("bookingTable:${bookingTablenew}");
      });
    }
  }
}
