// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

var bookingTablenew;

class TestNew extends StatefulWidget {
  TestNew({Key? key}) : super(key: key);

  @override
  State<TestNew> createState() => _TestNewState();
}

class _TestNewState extends State<TestNew> with TickerProviderStateMixin {
  @override
  var user1;
  double? load = 10.0;
  double? vol1 = 0;
  double? weight1 = 0;
  int vehcapacity = 1;
  int weightLM1 = 0;
  int weightLM2 = 0;
  int weightD = 0;
  int weightH2H = 0;
  double vehvolume = 1;
  List<bool> _isCheckedLM1 = [];
  List<bool> _isCheckedLM2 = [];
  List<bool> _isCheckedH2H = [];
  Color? color;
  final weightController = TextEditingController();
  double progressValueVLM1 = 0;
  double progressValueWLM1 = 0;
  double progressValueVLM2 = 0;
  double progressValueWLM2 = 0;
  double progressValueVH2H = 0;
  double progressValueWH2H = 0;
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   progressLM1();
    //   print("WidgetsBinding");
    // });
    vehiclesInfoLM1();
    vehiclesInfoLM2();
    vehiclesInfoH2H();
    // Status();
    // orderAssign();
    // TODO: implement initState
    super.initState();
    setState(() {
      _isCheckedLM1 = List<bool>.filled(10, false);
      _isCheckedLM2 = List<bool>.filled(10, false);
      _isCheckedH2H = List<bool>.filled(10, false);
      dateInput.addListener(() {
        getOrdersLM1();
        getOrdersLM2();
        getOrdersH2H();
        vehiclesInfoLM1();
        vehiclesInfoLM2();
        vehiclesInfoH2H();
      });
    });

    // _controller = TabController(length: 2, vsync: this );
  }

  void didChangeDependencies() {
    setState(() {
      // vehiclesInfo();
      formattedDate;
      // getOrdersLM2();
      // getOrdersH2H();
      load;
      mOnth;
      dAy;
      yEar;
      dAy1;
      orderStatus;
      status;
      progressLM1();
      progressLM2();
      progressH2H();
      weightLM1;
      vehcapacity;
      idsLengthLM1;
      vol;
      vol1;
      progressValueVLM1;
      weight1;
      vehvolume;
      volumeLM1;
      tripType;
      ids;
      statusCode;
      // Status();
    });
  }

  void StaTus() {
    if (status == 201) {
      statusCode = 'Order Assigned';
      didChangeDependencies();
    } else if (status == 200) {
      statusCode = 'Load Exceeds Capacity';
    } else {
      statusCode = '';
    }
  }

  void progressLM1() {
    weight1 = (weightLM1 / vehcapacity) * 100;
    vol1 = (volumeLM1 / vehvolume) * 100;
    progressValueVLM1 = vol1!;
    progressValueWLM1 = weight1!;
    print("percentage wei:$weight1");
    print("percentage vol:$vol1");
  }

  void progressLM2() {
    weight1 = (weightLM2 / vehcapacity) * 100;
    vol1 = (volumeLM2 / vehvolume) * 100;
    progressValueVLM2 = vol1!;
    progressValueWLM2 = weight1!;
    print("percentage wei:$weight1");
    print("percentage vol:$vol1");
  }

  void progressH2H() {
    weight1 = (weightH2H / vehcapacity) * 100;
    vol1 = (volumeH2H / vehvolume) * 100;
    progressValueVH2H = vol1!;
    progressValueWH2H = weight1!;
    print("percentage wei:$weight1");
    print("percentage vol:$vol1");
  }

  var oRderLM1;
  var oRderLM2;
  var oRderH2H;
  var vehiclesINFOLM1;
  var vehiclesINFOLM2;
  var vehiclesINFOH2H;
  var Order;
  var status;
  double volumeLM1 = 0;
  double volumeLM2 = 0;
  double volumeH2H = 0;
  int volume1 = 0;
  TextEditingController dateInput = TextEditingController();
  String? formattedDate;
  String? mOnth = 'DEC';
  var yEar = 2022;
  var dAy1 = 12;
  String? dAy = 'TUE';
  int _selectedIndex = 0;
  String? hub;
  List<String> hubList = ['KKD', 'PKD', 'MLP', 'WYD', 'KNN'];
  String? distance;
  List<String> distanceList = ['LH', 'SH'];
  bool? check = false;
  bool? isLoading = false;
  bool? isLoadingVeh = false;
  bool? isLoadingLM1 = false;
  bool? isLoadingLM2 = false;
  bool? isLoadingH2H = false;
  bool? val = true;
  List<String> userChecked = [];
  int? selectedIndexLM1 = 0;
  int? selectedIndexLM2 = 0;
  int? selectedIndexH2H = 0;
  final List<int> _selectedItems1 = <int>[];
  final List<int> _selectedOrderLM1 = <int>[];
  final List<int> _selectedOrderLM2 = <int>[];
  final List<int> _selectedOrderH2H = <int>[];
  final List<int> _selectedBookingIdLM1 = <int>[];
  final List<int> _selectedbookingIdLM2 = <int>[];
  final List<int> _selectedbookingIdH2H = <int>[];
  var vehicleNum = 'KL11AA1234';
  var idsLM1 = '0';
  var idsLM2 = '0';
  var idsH2H = '0';
  var orderStatus = '';
  double vol = 0;
  int idsLengthLM1 = 0;
  int idsLengthLM2 = 0;
  int idsLengthH2H = 0;
  var tripType = '';
  var ids = '';
  var statusCode = '';

  @override
  Widget build(BuildContext context) {
    TabController? _controller = TabController(length: 1, vsync: this);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: 900,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    child: NavigationRail(
                      backgroundColor: const Color(0xfff01244c),
                      trailing: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Icon(
                            Icons.person_pin,
                            size: 80,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Chaavie2',
                            style: TextStyle(color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.logout,
                                      color: Colors.white))
                            ],
                          )
                          // ElevatedButton(onPressed: () {}, child: Text('Trip')),
                        ],
                      ),
                      indicatorColor: Colors.black12,
                      leading: Image.asset(
                        'assets/images/chaavie.png',
                        width: 120,
                      ),
                      elevation: 5,
                      // minWidth: 70,
                      // minExtendedWidth: 100,
                      extended: true,

                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      labelType: NavigationRailLabelType.none,
                      // ignore: prefer_const_literals_to_create_immutables
                      destinations: [
                        const NavigationRailDestination(
                          icon:
                              Icon(Icons.bookmark_border, color: Colors.white),
                          selectedIcon: Icon(Icons.book, color: Colors.white),
                          label: Padding(
                            padding: EdgeInsets.only(left: 3),
                            child: Text('Home',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const NavigationRailDestination(
                          // padding: EdgeInsets.all(19),
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                          selectedIcon: Icon(Icons.abc_outlined),
                          label: Text(
                            'Assign Trip',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const NavigationRailDestination(
                          icon:
                              Icon(Icons.bookmark_border, color: Colors.white),
                          selectedIcon: Icon(Icons.book, color: Colors.white),
                          label: Text('Vehicle Master',
                              style: TextStyle(color: Colors.white)),
                        ),
                        const NavigationRailDestination(
                          icon: Icon(Icons.star_border, color: Colors.white),
                          selectedIcon: Icon(Icons.star, color: Colors.white),
                          label: Text('Approvals',
                              style: TextStyle(color: Colors.white)),
                        ),
                        const NavigationRailDestination(
                          icon:
                              Icon(Icons.bookmark_border, color: Colors.white),
                          selectedIcon: Icon(Icons.book, color: Colors.white),
                          label: Text('Pricing',
                              style: TextStyle(color: Colors.white)),
                        ),
                        const NavigationRailDestination(
                          icon:
                              Icon(Icons.bookmark_border, color: Colors.white),
                          selectedIcon: Icon(Icons.book, color: Colors.white),
                          label: Text('Drivers',
                              style: TextStyle(color: Colors.white)),
                        ),
                        const NavigationRailDestination(
                          icon:
                              Icon(Icons.bookmark_border, color: Colors.white),
                          selectedIcon: Icon(Icons.book, color: Colors.white),
                          label: Text('Agents',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 1,
                    width: 1,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Image.network(
                                  'https://firebasestorage.googleapis.com/v0/b/chaavie-3e1a9.'
                                  'appspot.com/o/image_picker4734343491446806500.jpg?alt=media&token='
                                  '31790b18-5636-48e0-b72a-67f9c782a26e',
                                  fit: BoxFit.fitWidth,
                                  width: 50),
                              Text('image\n$user1')
                            ],
                          ),

                          // SizedBox(
                          //   width: 10,
                          // ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 30, bottom: 10),
                            child: Text(
                              'Assign Trip1',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Color(0xff01244c),
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 3,
                                ),
                                child: Text(dAy1.toString(),
                                    style: const TextStyle(fontSize: 38),
                                    textAlign: TextAlign.end),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${dAy?.toString().substring(0, 3).toUpperCase()}'),
                                  Text(
                                      '${mOnth?.toString().substring(0, 3).toUpperCase()}-$yEar'),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 40),
                              child: Column(
                                children: [
                                  const Text('Select District'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      width: 200,
                                      // height: 100/2,
                                      decoration: const BoxDecoration(
                                          // color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: DropDown(
                                        hint: 'district',
                                        type: hub,
                                        typeList: hubList,
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: Column(
                                children: [
                                  const Text('Select Hub'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      width: 200,
                                      // height: 100,
                                      child: DropdownButtonFormField(
                                        borderRadius: BorderRadius.circular(20),
                                        focusColor: Colors.white,
                                        iconEnabledColor: Colors.white,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontFamily: 'ArgentumSans',
                                        ),
                                        decoration: InputDecoration(
                                          focusColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xfff05acff)),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          hoverColor: Colors.white,
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  10, 5, 5, 19),
                                          hintText: 'hub',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xfff05acff)),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          // contentPadding: EdgeInsets.only(left: 9,right:1,bottom: 10),
                                          isDense: true,
                                          // contentPadding: EdgeInsets.fromLTRB(10 / 2, 10 / 2, 10 / 2, 0),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xfff05acff)),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        value: hub,
                                        onChanged: (String? newValue) {
                                          hub = newValue ?? "";
                                          print('type==$hub');
                                        },
                                        items: hubList.map((location) {
                                          return DropdownMenuItem(
                                            value: location,
                                            child: Text(location),
                                          );
                                        }).toList(),
                                        validator: (value) {
                                          if (value == null || value == 0) {
                                            return 'Please Choose Product Type';
                                          }
                                          return null;
                                        },
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40, right: 40),
                              child: Column(
                                children: [
                                  const Text('Select Date'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    // height: 100,
                                    child: TextFormField(
                                      style: const TextStyle(
                                        fontFamily: 'ArgentumSans',
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                      controller: dateInput,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide: const BorderSide(
                                                color: Color(0xfff05acff),
                                                width: 1)),
                                        suffixIcon: const Icon(
                                          Icons.calendar_today,
                                          color: Color(0xfff05acff),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xfff05acff)),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xfff05acff)),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xfff05acff)),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      readOnly: true,
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate:
                                                    DateTime.utc(
                                                        2022, DateTime.august),
                                                firstDate: DateTime.utc(
                                                    2022, DateTime.august),
                                                lastDate: DateTime(2100));

                                        if (pickedDate != null) {
                                          formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(pickedDate);
                                          setState(() {
                                            dateInput.text = formattedDate!;
                                            dAy1 = pickedDate.day;
                                            mOnth = DateFormat('yMMMMd')
                                                .format(pickedDate);
                                            dAy = DateFormat('EEEE')
                                                .format(pickedDate);
                                            yEar = pickedDate.year;
                                            print("date:$formattedDate");
                                          });
                                        } else {}
                                      },
                                      // onFieldSubmitted: (value){
                                      //   print('ok');
                                      //   didChangeDependencies();
                                      // },
                                      validator: (value) =>
                                          value!.isEmpty ? 'Select Date' : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 600,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: DefaultTabController(
                          length: 3,
                          initialIndex: 0,
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Material(
                                    textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    borderRadius: BorderRadius.circular(30),
                                    color: const Color(0xfff01244c),
                                    child: TabBar(
                                      indicatorColor: Colors.green,
                                      tabs: const [
                                        Tab(
                                          text: "Collection",
                                        ),
                                        Tab(
                                          text: "Delivery",
                                        ),
                                        Tab(
                                          text: "Hub to Hub",
                                        ),
                                      ],
                                      labelColor: Colors.white,
                                      indicator: MaterialIndicator(
                                        color: const Color(0xfff05acff),
                                        height: 7,
                                        topLeftRadius: 0,
                                        topRightRadius: 0,
                                        horizontalPadding: 150,
                                        tabPosition: TabPosition.bottom,
                                      ),
                                      labelStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      unselectedLabelColor: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 520,
                                    child: TabBarView(children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 40,
                                                    top: 20),
                                                child: Container(
                                                  width: 330,
                                                  height: 420,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: const Color(
                                                          0XFFF2F0FF)),
                                                  child: Column(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                        child: Text(
                                                          'Orders',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                      isLoadingLM1 == false
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : oRderLM1 == null
                                                              ? const Center(
                                                                  child:
                                                                      CircularProgressIndicator())
                                                              : oRderLM1.length ==
                                                                      0
                                                                  ? const Center(
                                                                      child: Text(
                                                                          'No orders'))
                                                                  : SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.5,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child: ListView.separated(
                                                                          padding: const EdgeInsets.all(0),
                                                                          physics: const AlwaysScrollableScrollPhysics(),
                                                                          shrinkWrap: true,
                                                                          separatorBuilder: (BuildContext context, index) => const Divider(
                                                                                color: Color(0XFFF2F0FF),
                                                                                thickness: 1,
                                                                              ),
                                                                          itemCount: oRderLM1.length,
                                                                          itemBuilder: (BuildContext context, index) {
                                                                            return Container(
                                                                              decoration: BoxDecoration(color: (_selectedOrderLM1.contains(index)) ? Colors.blue.withOpacity(0.5) : Colors.white, borderRadius: BorderRadius.circular(20)),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  CheckboxListTile(
                                                                                    value: _isCheckedLM1[index],
                                                                                    onChanged: (bool? newValue) {
                                                                                      setState(() {
                                                                                        _isCheckedLM1[index] = newValue!;
                                                                                        print(_isCheckedLM1[index]);
                                                                                        if (_isCheckedLM1[index] == true) {
                                                                                          setState(() {
                                                                                            _selectedOrderLM1.add(index);
                                                                                            _selectedBookingIdLM1.add(oRderLM1[index]['bookingid']);
                                                                                            weightLM1 = 0;
                                                                                            volumeLM1 = 0;
                                                                                            for (var Items in _selectedOrderLM1) {
                                                                                              weightLM1 += oRderLM1[Items]['weight'] as int;
                                                                                              volumeLM1 += oRderLM1[Items]['volume'] as double;
                                                                                              print('ok1:$weightLM1');
                                                                                              setState(() {});
                                                                                              print("Items:$Items");
                                                                                            }
                                                                                            print('ok:$weightLM1');
                                                                                            print('bookingid:$_selectedBookingIdLM1');
                                                                                            idsLM1 = _selectedBookingIdLM1.join(",");
                                                                                            idsLengthLM1 = _selectedBookingIdLM1.length;
                                                                                            print("ids:$idsLM1");

                                                                                            print(_selectedOrderLM1);
                                                                                            weightController.text = weightLM1.toString();
                                                                                          });
                                                                                        } else {
                                                                                          setState(() {
                                                                                            _selectedOrderLM1.removeWhere((val) => val == index);
                                                                                            _selectedBookingIdLM1.removeWhere((val) => val == oRderLM1[index]['bookingid']);
                                                                                            weightLM1 = 0;
                                                                                            volumeLM1 = 0;
                                                                                            for (var Items in _selectedOrderLM1) {
                                                                                              weightLM1 += oRderLM1[Items]['weight'] as int;
                                                                                              volumeLM1 += oRderLM1[Items]['volume'] as double;
                                                                                            }
                                                                                            idsLM1 = _selectedBookingIdLM1.join(",");
                                                                                            idsLengthLM1 = _selectedBookingIdLM1.length;
                                                                                          });
                                                                                        }

                                                                                        selectedIndexLM1 = index;
                                                                                        print("selecteditems:$_selectedItems1");
                                                                                        print("selectedIndex:$selectedIndexLM1");
                                                                                      });

                                                                                      // return check;
                                                                                    },
                                                                                    title: Column(
                                                                                      children: [
                                                                                        const SizedBox(height: 10),
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.only(right: 70),
                                                                                              child: Text('$index'),
                                                                                            ),
                                                                                            Text('Booking Id: ${oRderLM1[index]['bookingid']}'),
                                                                                          ],
                                                                                        ),
                                                                                        const SizedBox(height: 10),
                                                                                        // ignore: prefer_const_literals_to_create_immutables
                                                                                        Table(defaultColumnWidth: const FixedColumnWidth(72), border: TableBorder.all(color: Colors.black, width: 0.5, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))), children: [
                                                                                          const TableRow(children: [
                                                                                            Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                'Type',
                                                                                                style: TextStyle(color: Colors.black
                                                                                                    // (0XFFF01244C),
                                                                                                    ),
                                                                                              )),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                'Count',
                                                                                                style: TextStyle(color: Colors.black
                                                                                                    // (0XFFF01244C),
                                                                                                    ),
                                                                                              )),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                'Volume',
                                                                                                style: TextStyle(color: Colors.black
                                                                                                    // (0XFFF01244C),
                                                                                                    ),
                                                                                              )),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                'Weight',
                                                                                                style: TextStyle(color: Colors.black
                                                                                                    // (0XFFF01244C),
                                                                                                    ),
                                                                                              )),
                                                                                            ),
                                                                                          ]),
                                                                                        ]),
                                                                                        ListView.builder(
                                                                                          padding: const EdgeInsets.only(left: 0, right: 0),
                                                                                          physics: const AlwaysScrollableScrollPhysics(),
                                                                                          shrinkWrap: true,
                                                                                          itemCount: oRderLM1[index]['shipment'].length,
                                                                                          itemBuilder: (BuildContext context, i) {
                                                                                            return Container(
                                                                                              child: Table(
                                                                                                defaultColumnWidth: const FixedColumnWidth(72),
                                                                                                border: TableBorder.all(color: Colors.black, width: 0.5, borderRadius: BorderRadius.circular(0)),
                                                                                                children: [
                                                                                                  TableRow(children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "${oRderLM1[index]['shipment'][i]['package_type']}",
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "${oRderLM1[index]['shipment'][i]['count']}",
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "${oRderLM1[index]['shipment'][i]['total_volume']}",
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "${oRderLM1[index]['shipment'][i]['total_weight']}",
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ]),
                                                                                                ],
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(4.0),
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            'From: ${oRderLM1[index]['shipment'][0]['from_loc']}'.capitalizeEach(),
                                                                                            style: const TextStyle(color: Colors.black
                                                                                                // (0XFFF01244C),
                                                                                                ),
                                                                                          )),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                    )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 40,
                                                  top: 20,
                                                ),
                                                child: Container(
                                                  width: 300,
                                                  height: 400,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: const Color(
                                                          0XFFF2F0FF)),
                                                  child: Column(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                        child: Text(
                                                          'Vehicles',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      isLoadingVeh == false
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : vehiclesINFOLM1 ==
                                                                  null
                                                              ? const Center(
                                                                  child:
                                                                      CircularProgressIndicator())
                                                              : vehiclesINFOLM1
                                                                          .length ==
                                                                      1
                                                                  ? const Center(
                                                                      child: Text(
                                                                          'No Vehicles'))
                                                                  : SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.46,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child: ListView.separated(
                                                                          separatorBuilder: (BuildContext context, index) => const Divider(
                                                                                color: Colors.transparent,
                                                                                thickness: 1,
                                                                              ),
                                                                          itemCount: vehiclesINFOLM1.length,
                                                                          itemBuilder: (BuildContext context, index) {
                                                                            return Container(
                                                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Table(
                                                                                    defaultColumnWidth: const FixedColumnWidth(270),
                                                                                    border: TableBorder.all(color: Colors.white, width: 0.5, borderRadius: BorderRadius.circular(20)),
                                                                                    children: [
                                                                                      TableRow(children: [
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                          children: [
                                                                                            Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Vehicle No.: ${vehiclesINFOLM1[index]['vehicle_number']}',
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Vehicle Make: ${vehiclesINFOLM1[index]['vehicle_make']}'.capitalizeEach(),
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Capacity: ${vehiclesINFOLM1[index]['max_load_kg']}',
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Volume : ${vehiclesINFOLM1[index]['max_load_vol']}',
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Service Days : ${vehiclesINFOLM1[index]['service_days']}',
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            ElevatedButton(
                                                                                              onPressed: () {
                                                                                                tripType = 'LM1';
                                                                                                ids = idsLM1;
                                                                                                vehicleNum = vehiclesINFOLM1[index]['vehicle_number'];
                                                                                                vehcapacity = vehiclesINFOLM1[index]['max_load_kg'];
                                                                                                vehvolume = vehiclesINFOLM1[index]['max_load_vol'];
                                                                                                print(vehicleNum);
                                                                                                print(weightLM1);
                                                                                                print(vehcapacity);
                                                                                                // print('$vol1');
                                                                                                progressLM1();
                                                                                                orderAssign();
                                                                                                StaTus();
                                                                                                didChangeDependencies();
                                                                                              },
                                                                                              style: ElevatedButton.styleFrom(
                                                                                                backgroundColor: const Color(0xfff01244c),
                                                                                                maximumSize: const Size(80, 40),
                                                                                                minimumSize: const Size(80, 40),
                                                                                              ),
                                                                                              child: const Text('Assign'),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ]),
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                    )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 20),
                                                child: Container(
                                                  width: 300,
                                                  height: 400,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: const Color(
                                                          0xfffcee2dc)),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            child: Center(
                                                                child: Text(
                                                                    '$idsLengthLM1',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black))),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10,
                                                                    left: 50,
                                                                    right: 20,
                                                                    bottom: 10),
                                                            child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  16,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  12,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0),
                                                                  color: Colors
                                                                      .yellowAccent),
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    16,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    12,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      width: 2,
                                                                      color: Colors
                                                                          .black),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                        vehicleNum,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w700))),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 0),
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  _selectedBookingIdLM1
                                                                      .join(
                                                                          ", "),
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Text(
                                                                statusCode,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            20),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                SizedBox(
                                                                    width: 130,
                                                                    height: 130,
                                                                    child: SfRadialGauge(
                                                                        axes: <
                                                                            RadialAxis>[
                                                                          RadialAxis(
                                                                              showLabels: false,
                                                                              showTicks: true,
                                                                              startAngle: 360,
                                                                              endAngle: 360,
                                                                              radiusFactor: 0.7,
                                                                              axisLineStyle: const AxisLineStyle(
                                                                                thickness: 0.2,
                                                                                color: Color.fromARGB(80, 1, 169, 181),
                                                                                thicknessUnit: GaugeSizeUnit.factor,
                                                                              ),
                                                                              pointers: <GaugePointer>[
                                                                                RangePointer(value: progressValueWLM1, width: 0.2, sizeUnit: GaugeSizeUnit.factor, enableAnimation: true, animationDuration: 75, animationType: AnimationType.linear, gradient: const SweepGradient(colors: <Color>[Colors.red, Color(0xFF00a9b5)], stops: <double>[0.25, 0.75])),
                                                                              ],
                                                                              annotations: <GaugeAnnotation>[
                                                                                GaugeAnnotation(positionFactor: 0.1, widget: Text('${progressValueWLM1.toStringAsFixed(0)}%'))
                                                                              ]),
                                                                        ])),
                                                                const Text(
                                                                    'Weight')
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                SizedBox(
                                                                    width: 130,
                                                                    height: 130,
                                                                    child: SfRadialGauge(
                                                                        axes: <
                                                                            RadialAxis>[
                                                                          RadialAxis(
                                                                              showLabels: false,
                                                                              showTicks: true,
                                                                              startAngle: 360,
                                                                              endAngle: 360,
                                                                              radiusFactor: 0.7,
                                                                              axisLineStyle: const AxisLineStyle(
                                                                                thickness: 0.2,
                                                                                color: Color.fromARGB(80, 1, 169, 181),
                                                                                thicknessUnit: GaugeSizeUnit.factor,
                                                                              ),
                                                                              pointers: <GaugePointer>[
                                                                                RangePointer(
                                                                                    onValueChanged: (double? vol1) {
                                                                                      setState(() {
                                                                                        didChangeDependencies();
                                                                                        progressLM1();
                                                                                        progressValueVLM1 = vol1!;
                                                                                      });
                                                                                    },
                                                                                    value: progressValueVLM1,
                                                                                    width: 0.2,
                                                                                    sizeUnit: GaugeSizeUnit.factor,
                                                                                    enableAnimation: true,
                                                                                    animationDuration: 75,
                                                                                    animationType: AnimationType.linear,
                                                                                    gradient: const SweepGradient(colors: <Color>[Colors.red, Color(0xFF00a9b5)], stops: <double>[0.25, 0.75])),
                                                                              ],
                                                                              annotations: <GaugeAnnotation>[
                                                                                GaugeAnnotation(positionFactor: 0.1, widget: Text('${progressValueVLM1.toStringAsFixed(0)}%'))
                                                                              ]),
                                                                        ])),
                                                                const Text(
                                                                    'Volume')
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            // mainAxisSize: MainAxisSize.max,
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30, right: 40),
                                                child: Container(
                                                  height: 50,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: const Color(
                                                          0xfff01244c)),
                                                  child: Center(
                                                      child: Text(
                                                          ' Total weight: $weightLM1 kg',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 40, right: 30),
                                                child: Container(
                                                  height: 50,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: const Color(
                                                          0xfff01244c)),
                                                  child: Center(
                                                      child: Text(
                                                          ' Total Volume: ${volumeLM1.toStringAsFixed(0)} m³',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 40,
                                                    top: 20),
                                                child: Container(
                                                  width: 330,
                                                  height: 420,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: const Color(
                                                          0XFFF2F0FF)),
                                                  child: Column(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                        child: Text(
                                                          'Orders',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                      isLoadingLM2 == false
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : oRderLM2 == null
                                                              ? const Center(
                                                                  child:
                                                                      CircularProgressIndicator())
                                                              : oRderLM2.length ==
                                                                      0
                                                                  ? const Center(
                                                                      child: Text(
                                                                          'No orders'))
                                                                  : SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.5,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child: ListView.separated(
                                                                          padding: const EdgeInsets.all(0),
                                                                          physics: const AlwaysScrollableScrollPhysics(),
                                                                          shrinkWrap: true,
                                                                          separatorBuilder: (BuildContext context, index) => const Divider(
                                                                                color: Color(0XFFF2F0FF),
                                                                                thickness: 1,
                                                                              ),
                                                                          itemCount: oRderLM2.length,
                                                                          itemBuilder: (BuildContext context, index) {
                                                                            return Container(
                                                                              decoration: BoxDecoration(color: (_selectedOrderLM2.contains(index)) ? Colors.blue.withOpacity(0.5) : Colors.white, borderRadius: BorderRadius.circular(20)),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  CheckboxListTile(
                                                                                    value: _isCheckedLM2[index],
                                                                                    onChanged: (bool? newValue) {
                                                                                      setState(() {
                                                                                        _isCheckedLM2[index] = newValue!;

                                                                                        if (_isCheckedLM2[index] == true) {
                                                                                          setState(() {
                                                                                            _selectedOrderLM2.add(index);
                                                                                            _selectedbookingIdLM2.add(oRderLM2[index]['bookingid']);
                                                                                            weightLM2 = 0;
                                                                                            volumeLM2 = 0;
                                                                                            for (var Items in _selectedOrderLM2) {
                                                                                              weightLM2 += oRderLM2[Items]['weight'] as int;
                                                                                              volumeLM2 += oRderLM2[Items]['volume'] as double;
                                                                                            }

                                                                                            idsLM2 = _selectedbookingIdLM2.join(",");
                                                                                            idsLengthLM2 = _selectedbookingIdLM2.length;
                                                                                          });
                                                                                        } else {
                                                                                          setState(() {
                                                                                            _selectedOrderLM2.removeWhere((val) => val == index);
                                                                                            _selectedbookingIdLM2.removeWhere((val) => val == oRderLM2[index]['bookingid']);
                                                                                            weightLM2 = 0;
                                                                                            volumeLM2 = 0;
                                                                                            for (var Items in _selectedOrderLM2) {
                                                                                              weightLM2 += oRderLM2[Items]['weight'] as int;
                                                                                              volumeLM2 += oRderLM2[Items]['volume'] as double;
                                                                                            }

                                                                                            idsLM2 = _selectedbookingIdLM2.join(",");
                                                                                            idsLengthLM2 = _selectedbookingIdLM2.length;
                                                                                          });
                                                                                        }
                                                                                        selectedIndexLM2 = index;
                                                                                      });
                                                                                    },
                                                                                    title: Column(
                                                                                      children: [
                                                                                        const SizedBox(height: 10),
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.only(right: 70),
                                                                                              child: Text('$index'),
                                                                                            ),
                                                                                            Text('Booking Id: ${oRderLM2[index]['bookingid']}'),
                                                                                          ],
                                                                                        ),
                                                                                        const SizedBox(height: 10),
                                                                                        Table(defaultColumnWidth: const FixedColumnWidth(72), border: TableBorder.all(color: Colors.black, width: 0.5, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))), children: const [
                                                                                          TableRow(children: [
                                                                                            Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                'Type',
                                                                                                style: TextStyle(color: Colors.black
                                                                                                    // (0XFFF01244C),
                                                                                                    ),
                                                                                              )),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                'Count',
                                                                                                style: TextStyle(color: Colors.black
                                                                                                    // (0XFFF01244C),
                                                                                                    ),
                                                                                              )),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                'Volume',
                                                                                                style: TextStyle(color: Colors.black
                                                                                                    // (0XFFF01244C),
                                                                                                    ),
                                                                                              )),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                'Weight',
                                                                                                style: TextStyle(color: Colors.black
                                                                                                    // (0XFFF01244C),
                                                                                                    ),
                                                                                              )),
                                                                                            ),
                                                                                          ]),
                                                                                        ]),
                                                                                        ListView.builder(
                                                                                          padding: const EdgeInsets.only(left: 0, right: 0),
                                                                                          physics: const AlwaysScrollableScrollPhysics(),
                                                                                          shrinkWrap: true,
                                                                                          itemCount: oRderLM2[index]['shipment'].length,
                                                                                          itemBuilder: (BuildContext context, i) {
                                                                                            return Container(
                                                                                              child: Table(
                                                                                                defaultColumnWidth: const FixedColumnWidth(72),
                                                                                                border: TableBorder.all(color: Colors.black, width: 0.5, borderRadius: BorderRadius.circular(0)),
                                                                                                children: [
                                                                                                  TableRow(children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "${oRderLM2[index]['shipment'][i]['package_type']}",
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "${oRderLM2[index]['shipment'][i]['count']}",
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "${oRderLM2[index]['shipment'][i]['total_volume']}",
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "${oRderLM2[index]['shipment'][i]['total_weight']}",
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ]),
                                                                                                ],
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(4.0),
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            'From: ${oRderLM2[index]['shipment'][0]['from_loc']}'.capitalizeEach(),
                                                                                            style: const TextStyle(color: Colors.black
                                                                                                // (0XFFF01244C),
                                                                                                ),
                                                                                          )),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                    )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 40,
                                                  top: 20,
                                                ),
                                                child: Container(
                                                  width: 300,
                                                  height: 400,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: const Color(
                                                          0XFFF2F0FF)),
                                                  child: Column(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                        child: Text(
                                                          'Vehicles',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      isLoadingVeh == false
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : vehiclesINFOLM2 ==
                                                                  null
                                                              ? const Center(
                                                                  child:
                                                                      CircularProgressIndicator())
                                                              : vehiclesINFOLM2
                                                                          .length ==
                                                                      0
                                                                  ? const Center(
                                                                      child: Text(
                                                                          'No Vehicles'))
                                                                  : SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.46,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child: ListView.separated(
                                                                          separatorBuilder: (BuildContext context, index) => const Divider(
                                                                                color: Colors.transparent,
                                                                                thickness: 1,
                                                                              ),
                                                                          itemCount: vehiclesINFOLM2.length,
                                                                          itemBuilder: (BuildContext context, index) {
                                                                            return Container(
                                                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Table(
                                                                                    defaultColumnWidth: const FixedColumnWidth(270),
                                                                                    border: TableBorder.all(color: Colors.white, width: 0.5, borderRadius: BorderRadius.circular(20)),
                                                                                    children: [
                                                                                      TableRow(children: [
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                          children: [
                                                                                            Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Vehicle No.: ${vehiclesINFOLM2[index]['vehicle_number']}',
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Vehicle Make: ${vehiclesINFOLM2[index]['vehicle_make']}'.capitalizeEach(),
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Capacity: ${vehiclesINFOLM2[index]['max_load_kg']}',
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Volume : ${vehiclesINFOLM2[index]['max_load_vol']}',
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Service Days : ${vehiclesINFOLM2[index]['service_days']}',
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            ElevatedButton(
                                                                                              onPressed: () {
                                                                                                tripType = 'LM2';
                                                                                                ids = idsLM2;
                                                                                                vehicleNum = vehiclesINFOLM2[index]['vehicle_number'];
                                                                                                vehcapacity = vehiclesINFOLM2[index]['max_load_kg'];
                                                                                                vehvolume = vehiclesINFOLM2[index]['max_load_vol'];
                                                                                                didChangeDependencies();

                                                                                                progressLM2();
                                                                                                orderAssign();
                                                                                              },
                                                                                              style: ElevatedButton.styleFrom(
                                                                                                backgroundColor: const Color(0xfff01244c),
                                                                                                maximumSize: const Size(80, 40),
                                                                                                minimumSize: const Size(80, 40),
                                                                                              ),
                                                                                              child: const Text('Assign'),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ]),
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                    )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 20),
                                                child: Container(
                                                  width: 300,
                                                  height: 400,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: const Color(
                                                          0xfffcee2dc)),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            child: Center(
                                                                child: Text(
                                                                    '$idsLengthLM2',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black))),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10,
                                                                    left: 50,
                                                                    right: 20,
                                                                    bottom: 10),
                                                            child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  16,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  12,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0),
                                                                  color: Colors
                                                                      .yellowAccent),
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    16,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    12,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      width: 2,
                                                                      color: Colors
                                                                          .black),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                        vehicleNum,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w700))),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 0),
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  _selectedbookingIdLM2
                                                                      .join(
                                                                          ", "),
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              // SizedBox(height: 10,),
                                                              Text(
                                                                statusCode,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            20),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                SizedBox(
                                                                    width: 130,
                                                                    height: 130,
                                                                    child: SfRadialGauge(
                                                                        axes: <
                                                                            RadialAxis>[
                                                                          RadialAxis(
                                                                              showLabels: false,
                                                                              showTicks: true,
                                                                              startAngle: 360,
                                                                              endAngle: 360,
                                                                              radiusFactor: 0.7,
                                                                              axisLineStyle: const AxisLineStyle(
                                                                                thickness: 0.2,
                                                                                color: Color.fromARGB(80, 1, 169, 181),
                                                                                thicknessUnit: GaugeSizeUnit.factor,
                                                                              ),
                                                                              pointers: <GaugePointer>[
                                                                                RangePointer(value: progressValueWLM2, width: 0.2, sizeUnit: GaugeSizeUnit.factor, enableAnimation: true, animationDuration: 75, animationType: AnimationType.linear, gradient: const SweepGradient(colors: <Color>[Colors.red, Color(0xFF00a9b5)], stops: <double>[0.25, 0.75])),
                                                                              ],
                                                                              annotations: <GaugeAnnotation>[
                                                                                GaugeAnnotation(positionFactor: 0.1, widget: Text('${progressValueWLM2.toStringAsFixed(0)}%'))
                                                                              ]),
                                                                        ])),
                                                                const Text(
                                                                    'Weight')
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                SizedBox(
                                                                    width: 130,
                                                                    height: 130,
                                                                    child: SfRadialGauge(
                                                                        axes: <
                                                                            RadialAxis>[
                                                                          RadialAxis(
                                                                              showLabels: false,
                                                                              showTicks: true,
                                                                              startAngle: 360,
                                                                              endAngle: 360,
                                                                              radiusFactor: 0.7,
                                                                              axisLineStyle: const AxisLineStyle(
                                                                                thickness: 0.2,
                                                                                color: Color.fromARGB(80, 1, 169, 181),
                                                                                thicknessUnit: GaugeSizeUnit.factor,
                                                                              ),
                                                                              pointers: <GaugePointer>[
                                                                                RangePointer(value: progressValueVLM2, width: 0.2, sizeUnit: GaugeSizeUnit.factor, enableAnimation: true, animationDuration: 75, animationType: AnimationType.linear, gradient: const SweepGradient(colors: <Color>[Colors.red, Color(0xFF00a9b5)], stops: <double>[0.25, 0.75])),
                                                                              ],
                                                                              annotations: <GaugeAnnotation>[
                                                                                GaugeAnnotation(positionFactor: 0.1, widget: Text('${progressValueVLM2.toStringAsFixed(0)}%'))
                                                                              ]),
                                                                        ])),
                                                                const Text(
                                                                    'Volume')
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            // mainAxisSize: MainAxisSize.max,
                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30, right: 40),
                                                child: Container(
                                                  height: 50,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: const Color(
                                                          0xfff01244c)),
                                                  child: Center(
                                                      child: Text(
                                                          ' Total weight: $weightLM2 kg',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 40, right: 30),
                                                child: Container(
                                                  height: 50,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: const Color(
                                                          0xfff01244c)),
                                                  child: Center(
                                                      child: Text(
                                                          ' Total Volume: ${volumeLM2.toStringAsFixed(0)} m³',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 40,
                                                    top: 20),
                                                child: Container(
                                                  width: 330,
                                                  height: 420,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: const Color(
                                                          0XFFF2F0FF)),
                                                  child: Column(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                        child: Text(
                                                          'Orders',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ),
                                                      isLoadingH2H == false
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : oRderH2H == null
                                                              ? const Center(
                                                                  child:
                                                                      CircularProgressIndicator())
                                                              : oRderH2H.length ==
                                                                      0
                                                                  ? const Center(
                                                                      child: Text(
                                                                          'No orders'))
                                                                  : SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.5,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child: ListView.separated(
                                                                          padding: const EdgeInsets.all(0),
                                                                          physics: const AlwaysScrollableScrollPhysics(),
                                                                          shrinkWrap: true,
                                                                          separatorBuilder: (BuildContext context, index) => const Divider(
                                                                                color: Color(0XFFF2F0FF),
                                                                                thickness: 1,
                                                                              ),
                                                                          itemCount: oRderH2H.length,
                                                                          itemBuilder: (BuildContext context, index) {
                                                                            return Container(
                                                                              decoration: BoxDecoration(color: (_selectedOrderH2H.contains(index)) ? Colors.blue.withOpacity(0.5) : Colors.white, borderRadius: BorderRadius.circular(20)),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  CheckboxListTile(
                                                                                    value: _isCheckedH2H[index],
                                                                                    onChanged: (bool? newValue) {
                                                                                      setState(() {
                                                                                        _isCheckedH2H[index] = newValue!;
                                                                                        print(_isCheckedH2H[index]);
                                                                                        if (_isCheckedH2H[index] == true) {
                                                                                          setState(() {
                                                                                            _selectedOrderH2H.add(index);
                                                                                            _selectedbookingIdH2H.add(oRderH2H[index]['bookingid']);
                                                                                            weightH2H = 0;
                                                                                            volumeH2H = 0;
                                                                                            for (var Items in _selectedOrderH2H) {
                                                                                              weightH2H += oRderH2H[Items]['weight'] as int;
                                                                                              volumeH2H += oRderH2H[Items]['volume'] as double;
                                                                                            }

                                                                                            idsH2H = _selectedbookingIdH2H.join(",");
                                                                                            idsLengthH2H = _selectedbookingIdH2H.length;
                                                                                          });
                                                                                        } else {
                                                                                          setState(() {
                                                                                            _selectedOrderH2H.removeWhere((val) => val == index);
                                                                                            _selectedbookingIdH2H.removeWhere((val) => val == oRderH2H[index]['bookingid']);
                                                                                            weightH2H = 0;
                                                                                            volumeH2H = 0;
                                                                                            for (var Items in _selectedOrderH2H) {
                                                                                              weightH2H += oRderH2H[Items]['weight'] as int;
                                                                                              volumeH2H += oRderH2H[Items]['volume'] as double;

                                                                                              setState(() {});
                                                                                            }

                                                                                            idsH2H = _selectedbookingIdH2H.join(",");
                                                                                            idsLengthH2H = _selectedbookingIdH2H.length;
                                                                                          });
                                                                                        }
                                                                                        selectedIndexH2H = index;
                                                                                      });
                                                                                    },
                                                                                    title: Column(
                                                                                      children: [
                                                                                        const SizedBox(height: 10),
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.only(right: 70),
                                                                                              child: Text('$index'),
                                                                                            ),
                                                                                            Text('Booking Id: ${oRderH2H[index]['bookingid']}'),
                                                                                          ],
                                                                                        ),
                                                                                        const SizedBox(height: 10),
                                                                                        Table(defaultColumnWidth: const FixedColumnWidth(72), border: TableBorder.all(color: Colors.black, width: 0.5, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))), children: const [
                                                                                          TableRow(children: [
                                                                                            Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                'Type',
                                                                                                style: TextStyle(color: Colors.black
                                                                                                    // (0XFFF01244C),
                                                                                                    ),
                                                                                              )),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                'Count',
                                                                                                style: TextStyle(color: Colors.black
                                                                                                    // (0XFFF01244C),
                                                                                                    ),
                                                                                              )),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                'Volume',
                                                                                                style: TextStyle(fontFamily: 'ArgentumSans', color: Colors.black
                                                                                                    // (0XFFF01244C),
                                                                                                    ),
                                                                                              )),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsets.all(4.0),
                                                                                              child: Center(
                                                                                                  child: Text(
                                                                                                'Weight',
                                                                                                style: TextStyle(color: Colors.black
                                                                                                    // (0XFFF01244C),
                                                                                                    ),
                                                                                              )),
                                                                                            ),
                                                                                          ]),
                                                                                        ]),
                                                                                        ListView.builder(
                                                                                          padding: const EdgeInsets.only(left: 0, right: 0),
                                                                                          physics: const AlwaysScrollableScrollPhysics(),
                                                                                          shrinkWrap: true,
                                                                                          itemCount: oRderH2H[index]['shipment'].length,
                                                                                          itemBuilder: (BuildContext context, i) {
                                                                                            return Container(
                                                                                              child: Table(
                                                                                                defaultColumnWidth: const FixedColumnWidth(72),
                                                                                                border: TableBorder.all(color: Colors.black, width: 0.5, borderRadius: BorderRadius.circular(0)),
                                                                                                children: [
                                                                                                  TableRow(children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "${oRderH2H[index]['shipment'][i]['package_type']}",
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "${oRderH2H[index]['shipment'][i]['count']}",
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "${oRderH2H[index]['shipment'][i]['total_volume']}",
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        "${oRderH2H[index]['shipment'][i]['total_weight']}",
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ]),
                                                                                                ],
                                                                                              ),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(4.0),
                                                                                          child: Center(
                                                                                              child: Text(
                                                                                            'From: ${oRderH2H[index]['shipment'][0]['from_loc']}'.capitalizeEach(),
                                                                                            style: const TextStyle(color: Colors.black
                                                                                                // (0XFFF01244C),
                                                                                                ),
                                                                                          )),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                    )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 40,
                                                  top: 20,
                                                ),
                                                child: Container(
                                                  width: 300,
                                                  height: 400,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: const Color(
                                                          0XFFF2F0FF)),
                                                  child: Column(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                        child: Text(
                                                          'Vehicles',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      isLoadingVeh == false
                                                          ? const Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            )
                                                          : vehiclesINFOH2H ==
                                                                  null
                                                              ? const Center(
                                                                  child:
                                                                      CircularProgressIndicator())
                                                              : vehiclesINFOH2H
                                                                          .length ==
                                                                      0
                                                                  ? const Center(
                                                                      child: Text(
                                                                          'No Vehicles'))
                                                                  : SizedBox(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.46,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child: ListView.separated(
                                                                          separatorBuilder: (BuildContext context, index) => const Divider(
                                                                                color: Colors.transparent,
                                                                                thickness: 1,
                                                                              ),
                                                                          itemCount: vehiclesINFOH2H.length,
                                                                          itemBuilder: (BuildContext context, index) {
                                                                            return Container(
                                                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  ),
                                                                                  Table(
                                                                                    defaultColumnWidth: const FixedColumnWidth(270),
                                                                                    border: TableBorder.all(color: Colors.white, width: 0.5, borderRadius: BorderRadius.circular(20)),
                                                                                    children: [
                                                                                      TableRow(children: [
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                          children: [
                                                                                            Column(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Vehicle No.: ${vehiclesINFOH2H[index]['vehicle_number']}',
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Vehicle Make: ${vehiclesINFOH2H[index]['vehicle_make']}'.capitalizeEach(),
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Capacity: ${vehiclesINFOH2H[index]['max_load_kg']}',
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Volume : ${vehiclesINFOH2H[index]['max_load_vol']}',
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                                Row(
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.all(4.0),
                                                                                                      child: Center(
                                                                                                          child: Text(
                                                                                                        'Service Days : ${vehiclesINFOH2H[index]['service_days']}',
                                                                                                        style: const TextStyle(color: Colors.black
                                                                                                            // (0XFFF01244C),
                                                                                                            ),
                                                                                                      )),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            ElevatedButton(
                                                                                              onPressed: () {
                                                                                                tripType = 'H2H';
                                                                                                ids = idsH2H;
                                                                                                vehicleNum = vehiclesINFOH2H[index]['vehicle_number'];
                                                                                                vehcapacity = vehiclesINFOH2H[index]['max_load_kg'];
                                                                                                vehvolume = vehiclesINFOH2H[index]['max_load_vol'];
                                                                                                didChangeDependencies();

                                                                                                progressH2H();
                                                                                                orderAssign();
                                                                                              },
                                                                                              style: ElevatedButton.styleFrom(
                                                                                                backgroundColor: const Color(0xfff01244c),
                                                                                                maximumSize: const Size(80, 40),
                                                                                                minimumSize: const Size(80, 40),
                                                                                              ),
                                                                                              child: const Text('Assign'),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ]),
                                                                                    ],
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    height: 5,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                    )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    top: 20),
                                                child: Container(
                                                  width: 300,
                                                  height: 400,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: const Color(
                                                          0xfffcee2dc)),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            child: Center(
                                                                child: Text(
                                                                    '$idsLengthH2H',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black))),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10,
                                                                    left: 50,
                                                                    right: 20,
                                                                    bottom: 10),
                                                            child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  16,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  12,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0),
                                                                  color: Colors
                                                                      .yellowAccent),
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    16,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    12,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      width: 2,
                                                                      color: Colors
                                                                          .black),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              0),
                                                                ),
                                                                child: Center(
                                                                    child: Text(
                                                                        vehicleNum,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.w700))),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 0),
                                                        child: Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              5,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Colors.white),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  _selectedbookingIdH2H
                                                                      .join(
                                                                          ", "),
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              // SizedBox(height: 10,),
                                                              Text(
                                                                statusCode,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            20),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                SizedBox(
                                                                    width: 130,
                                                                    height: 130,
                                                                    child: SfRadialGauge(
                                                                        axes: <
                                                                            RadialAxis>[
                                                                          RadialAxis(
                                                                              showLabels: false,
                                                                              showTicks: true,
                                                                              startAngle: 360,
                                                                              endAngle: 360,
                                                                              radiusFactor: 0.7,
                                                                              axisLineStyle: const AxisLineStyle(
                                                                                thickness: 0.2,
                                                                                color: Color.fromARGB(80, 1, 169, 181),
                                                                                thicknessUnit: GaugeSizeUnit.factor,
                                                                              ),
                                                                              pointers: <GaugePointer>[
                                                                                RangePointer(value: progressValueWH2H, width: 0.2, sizeUnit: GaugeSizeUnit.factor, enableAnimation: true, animationDuration: 75, animationType: AnimationType.linear, gradient: const SweepGradient(colors: <Color>[Colors.red, Color(0xFF00a9b5)], stops: <double>[0.25, 0.75])),
                                                                              ],
                                                                              annotations: <GaugeAnnotation>[
                                                                                GaugeAnnotation(positionFactor: 0.1, widget: Text('${progressValueWH2H.toStringAsFixed(0)}%'))
                                                                              ]),
                                                                        ])),
                                                                const Text(
                                                                    'Weight')
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                SizedBox(
                                                                    width: 130,
                                                                    height: 130,
                                                                    child: SfRadialGauge(
                                                                        axes: <
                                                                            RadialAxis>[
                                                                          RadialAxis(
                                                                              showLabels: false,
                                                                              showTicks: true,
                                                                              startAngle: 360,
                                                                              endAngle: 360,
                                                                              radiusFactor: 0.7,
                                                                              axisLineStyle: const AxisLineStyle(
                                                                                thickness: 0.2,
                                                                                color: Color.fromARGB(80, 1, 169, 181),
                                                                                thicknessUnit: GaugeSizeUnit.factor,
                                                                              ),
                                                                              pointers: <GaugePointer>[
                                                                                RangePointer(
                                                                                    onValueChanged: (double? vol1) {
                                                                                      setState(() {
                                                                                        didChangeDependencies();
                                                                                        progressLM1();
                                                                                        progressValueVH2H = vol1!;
                                                                                        print("progressValue:$progressValueVH2H");
                                                                                      });
                                                                                    },
                                                                                    value: progressValueVH2H,
                                                                                    width: 0.2,
                                                                                    sizeUnit: GaugeSizeUnit.factor,
                                                                                    enableAnimation: true,
                                                                                    animationDuration: 75,
                                                                                    animationType: AnimationType.linear,
                                                                                    gradient: const SweepGradient(colors: <Color>[Colors.red, Color(0xFF00a9b5)], stops: <double>[0.25, 0.75])),
                                                                              ],
                                                                              annotations: <GaugeAnnotation>[
                                                                                GaugeAnnotation(positionFactor: 0.1, widget: Text('${progressValueVH2H.toStringAsFixed(0)}%'))
                                                                              ]),
                                                                        ])),
                                                                const Text(
                                                                    'Volume')
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30, right: 40),
                                                child: Container(
                                                  height: 50,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: const Color(
                                                          0xfff01244c)),
                                                  child: Center(
                                                      child: Text(
                                                          ' Total weight: $weightH2H kg',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 40, right: 30),
                                                child: Container(
                                                  height: 50,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: const Color(
                                                          0xfff01244c)),
                                                  child: Center(
                                                      child: Text(
                                                          ' Total Volume: ${volumeH2H.toStringAsFixed(0)} m³',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getOrdersLM1() async {
    isLoadingLM1 = true;
    print('$hub');
    var getOrder =
        "http://ec2-3-108-73-102.ap-south-1.compute.amazonaws.com:3000/multishipment";
    http.Response response = await http.put(Uri.parse(getOrder), body: {
      "hub": hub!.toLowerCase(),
      "date": "$formattedDate",
      "type": "LM1"
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        oRderLM1 = jsonDecode(response.body);
        print("Order:${oRderLM1.length}");
        // print("no:$test");
      });
    }
  }

  Future getOrdersLM2() async {
    isLoadingLM2 = true;
    var getOrder =
        "http://ec2-3-108-73-102.ap-south-1.compute.amazonaws.com:3000/multishipment";
    http.Response response = await http.put(Uri.parse(getOrder), body: {
      "hub": hub!.toLowerCase(),
      "date": "$formattedDate",
      "type": "LM2"
    });
    // print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        oRderLM2 = jsonDecode(response.body);
        // print("Order:$oRderLM2");
      });
    }
  }

  Future getOrdersH2H() async {
    isLoadingH2H = true;
    var getOrder =
        "http://ec2-3-108-73-102.ap-south-1.compute.amazonaws.com:3000/multishipment";
    http.Response response = await http.put(Uri.parse(getOrder), body: {
      "hub": hub!.toLowerCase(),
      "date": "$formattedDate",
      "type": "H2H"
    });
    if (response.statusCode == 200) {
      setState(() {
        oRderH2H = jsonDecode(response.body);
        // print("Order:$oRderH2H");
      });
    }
  }

  Future vehiclesInfoLM1() async {
    isLoadingVeh = true;
    print('working');
    var getOrder =
        "http://ec2-3-108-73-102.ap-south-1.compute.amazonaws.com:3000/vehicles";
    http.Response response = await http.put(Uri.parse(getOrder), body: {
      "triptype": "FTL",
      "hub": "kkd",
      "load": "1000",
      // "day": "4",
      // "dhub": "kkd"
      // "hub": "${hub!.toLowerCase()}",
    });
    if (response.statusCode == 200) {
      setState(() {
        vehiclesINFOLM1 = jsonDecode(response.body);
        // print("vehicles:${vehiclesINFOLM1.length}");
      });
    }
    print('ok');
    var getdetails = 'https://reqres.in/api/users/2';
    http.Response responseget = await http.get(Uri.parse(getdetails));
    print(response.statusCode);
    if (responseget.statusCode == 200) {
      var user = jsonDecode(responseget.body);
      user1 = user['data']["email"];
      print(user1);
    }
  }

  Future vehiclesInfoLM2() async {
    isLoadingVeh = true;
    print('working');
    var getOrder =
        "http://ec2-3-108-73-102.ap-south-1.compute.amazonaws.com:3000/vehicles";
    http.Response response = await http.put(Uri.parse(getOrder), body: {
      "triptype": "FTL",
      "hub": "kkd",
      // "hub": "${hub!.toLowerCase()}",
      "load": "1000",
      // "day": "4",
      // "dhub": "kkd"
    });
    if (response.statusCode == 200) {
      setState(() {
        vehiclesINFOLM2 = jsonDecode(response.body);
        // print("vehicles:$vehiclesINFOLM2");
      });
    }
  }

  Future vehiclesInfoH2H() async {
    isLoadingVeh = true;
    print('working');
    var getOrder =
        "http://ec2-3-108-73-102.ap-south-1.compute.amazonaws.com:3000/vehicles";
    http.Response response = await http.put(Uri.parse(getOrder), body: {
      "triptype": "FTL",
      "hub": "kkd",
      // "hub": "${hub!.toLowerCase()}",
      "load": "1000",
      // "day": "4",
      // "dhub": "kkd"
    });
    if (response.statusCode == 200) {
      setState(() {
        vehiclesINFOH2H = jsonDecode(response.body);
        // print("vehicles:$vehiclesINFOH2H");
      });
    }
  }

  Future orderAssign() async {
    print('working');
    print('ids:$ids');
    print('tripType:$tripType');
    // var assignOrder = "http://ec2-3-108-73-102.ap-south-1.compute.amazonaws.com:3000/assignsingletrip";
    var assignOrder = Uri.parse(
        'http://ec2-3-108-73-102.ap-south-1.compute.amazonaws.com:3000/assigntrip');
    http.Response response = await http.post(
      assignOrder,
      body: {"bookingid": "$ids", "type": "$tripType", "vehnum": vehicleNum},
    );
    status = response.statusCode;
    StaTus();
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        orderStatus = jsonDecode(response.body);
        print("vehicles:$orderStatus");
      });
    }
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
      borderRadius: BorderRadius.circular(20),
      focusColor: Colors.white,
      iconEnabledColor: Colors.white,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 15,
        fontFamily: 'ArgentumSans',
      ),
      decoration: InputDecoration(
        focusColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xfff05acff)),
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 19),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xfff05acff)),
          borderRadius: BorderRadius.circular(20),
        ),
        // contentPadding: EdgeInsets.only(left: 9,right:1,bottom: 10),
        isDense: true,
        // contentPadding: EdgeInsets.fromLTRB(10 / 2, 10 / 2, 10 / 2, 0),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xfff05acff)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      value: type,
      onChanged: (String? newValue) {
        type = newValue ?? "";
        print('type==$type');
      },
      items: typeList.map((location) {
        return DropdownMenuItem(
          value: location,
          child: Text(location),
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
// Widget getGradientProgressStyle() {
//   return SizedBox(
//       height: 150,
//       width: 150,
//       child: SfRadialGauge(axes: <RadialAxis>[
//         RadialAxis(
//             showLabels: false,
//             showTicks: false,
//             startAngle: 360,
//             endAngle: 360,
//             radiusFactor: 0.7,
//             axisLineStyle: const AxisLineStyle(
//               thickness: 0.2,
//               color: Color.fromARGB(80, 1, 169, 181),
//               thicknessUnit: GaugeSizeUnit.factor,
//             ),
//             pointers: <GaugePointer>[
//               RangePointer(
//                   value: progressValue,
//                   width: 0.2,
//                   sizeUnit: GaugeSizeUnit.factor,
//                   enableAnimation: true,
//                   animationDuration: 75,
//                   animationType: AnimationType.linear,
//                   gradient: const SweepGradient(
//                       colors: <Color>[Colors.red, Color(0xFF00a9b5)],
//                       stops: <double>[0.25, 0.75])),
//             ],
//             annotations: <GaugeAnnotation>[
//               GaugeAnnotation(
//                   positionFactor: 0.1,
//                   widget: Text(progressValue.toStringAsFixed(0) + '%'))
//             ]),
//       ]));
// }
// Container(
//     width: 100,
//     height: 100,
//     child:
//         SleekCircularSlider(
//       appearance:
//           CircularSliderAppearance(
//         spinnerMode:
//             false,
//         customColors: CustomSliderColors(
//             progressBarColor:
//                 Colors.green,
//             trackColor:
//                 Colors.red),
//         angleRange:
//             180 * 2,
//         infoProperties: InfoProperties(
//             topLabelStyle: TextStyle(color: Colors.blueGrey),
//             bottomLabelText: 'full',
//             // topLabelText: 'Volume',
//             bottomLabelStyle: TextStyle(color: Colors.black)),
//         customWidths: CustomSliderWidths(
//             progressBarWidth:
//                 8,
//             trackWidth:
//                 8,
//             handlerSize:
//                 2),
//       ),
//       min: weight1!,
//       max: 100,
//       initialValue:
//       weight1!+1,
//       // onChange: (){
//       //   load;
//       // },
//       // innerWidget: (percentage) {
//       //   return Text('');
//       // },
//     )),
