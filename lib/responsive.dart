import 'package:flutter/material.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}

// import 'package:flutter/material.dart';
//
// class Respo extends StatefulWidget {
//   const Respo({Key? key}) : super(key: key);
//
//   @override
//   State<Respo> createState() => _RespoState();
// }
//
// class _RespoState extends State<Respo> {
//   int? selectedIndex=0;
//   int _selectedIndex = 0;
//   String? mOnth='DEC';
//   var dAy1=12;
//   String? dAy='TUE';
//   var yEar=2022;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container( height: MediaQuery.of(context).size.height*0.9,
//             // padding: EdgeInsets.only(right: 100,left: 100),
//             // alignment: Alignment.topCenter,
//             child: ConstrainedBox(constraints: BoxConstraints(maxWidth: 1200),
//             child:  Row(
//               children: [
//               SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Container(
//                   width: 200,
//                   height: MediaQuery.of(context).size.height*2 ,
//                   child: NavigationRail(
//                     backgroundColor: Color(0xfff01244c),
//                     trailing: Column(
//                       children: [
//                         SizedBox(
//                           height: 30,
//                         ),
//                         Icon(
//                           Icons.person_pin,
//                           size: 80,
//                           color: Colors.white,
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           'Chaavie',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         // SizedBox(
//                         //   height: 10,
//                         // ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(
//                                   Icons.settings,
//                                   color: Colors.white,
//                                 )),
//                             IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(Icons.logout, color: Colors.white))
//                           ],
//                         )
//                         // ElevatedButton(onPressed: () {}, child: Text('Trip')),
//                       ],
//                     ),
//                     indicatorColor: Colors.black12,
//                     leading: Image.asset('images/chaavie.png',width: 120,),
//                     elevation: 5,
//                     // minWidth: 70,
//                     // minExtendedWidth: 100,
//                     extended: true,
//
//                     selectedIndex: _selectedIndex,
//                     onDestinationSelected: (int index) {
//                       setState(() {
//                         _selectedIndex = index;
//                       });
//                     },
//                     labelType: NavigationRailLabelType.none,
//                     destinations: [
//                       NavigationRailDestination(
//                         icon: Icon(Icons.bookmark_border,color: Colors.white),
//                         selectedIcon: Icon(Icons.book, color: Colors.white),
//                         label: Padding(
//                           padding: const EdgeInsets.only(left:3),
//                           child: Text('Home',
//                               style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
//                       NavigationRailDestination(
//                         // padding: EdgeInsets.all(19),
//                         icon: Icon(
//                           Icons.favorite_border,
//                           color: Colors.white,
//                         ),
//                         selectedIcon: Icon(Icons.abc_outlined),
//                         label: Text(
//                           'Assign Trip',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       NavigationRailDestination(
//                         icon: Icon(Icons.bookmark_border,color: Colors.white),
//                         selectedIcon: Icon(Icons.book, color: Colors.white),
//                         label: Text('Vehicle Master',
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                       NavigationRailDestination(
//                         icon: Icon(Icons.star_border,color: Colors.white),
//                         selectedIcon: Icon(Icons.star, color: Colors.white),
//                         label:
//                         Text('Approvals', style: TextStyle(color: Colors.white)),
//                       ),
//                       NavigationRailDestination(
//                         icon: Icon(Icons.bookmark_border,color: Colors.white),
//                         selectedIcon: Icon(Icons.book, color: Colors.white),
//                         label: Text('Pricing',
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                       NavigationRailDestination(
//                         icon: Icon(Icons.bookmark_border,color: Colors.white),
//                         selectedIcon: Icon(Icons.book, color: Colors.white),
//                         label: Text('Drivers',
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                       NavigationRailDestination(
//                         icon: Icon(Icons.bookmark_border,color: Colors.white),
//                         selectedIcon: Icon(Icons.book, color: Colors.white),
//                         label: Text('Agents',
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//                 Expanded(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 10),
//                       child: Text(
//                         'Assign Trip',
//                         style: TextStyle(
//                             fontSize: 30,
//                             color: Color(0xff01244c),
//                             fontWeight: FontWeight.w900),
//                       ),
//                     ),
//                       // SizedBox(width: MediaQuery.of(context).size.width/4,),
//                       Expanded(child: Text('hello'))
//                   ],),
//                 ),
//                 // TabBar(
//                 //   indicatorSize: TabBarIndicatorSize.tab,
//                 //   indicator: BubbleTabIndicator(
//                 //     indicatorHeight: 25.0,
//                 //     indicatorColor: Colors.blueAccent,
//                 //     tabBarIndicatorSize: TabBarIndicatorSize.tab,
//                 //     // Other flags
//                 //     // indicatorRadius: 1,
//                 //     // insets: EdgeInsets.all(1),
//                 //     // padding: EdgeInsets.all(10)
//                 //   ), tabs: [
//                 //     Center(child: Tab(text:'Collection',)),
//                 //   Tab(text:'Delivery',),
//                 //   Tab(text:'Hub to Hub',),],
//                 // )
//                 // TabBar(
//                 //   controller: ,
//                 //     tabs: [Center(child: Tab(text:'Collection',)),
//                 //   Tab(text:'Delivery',),
//                 //   Tab(text:'Hub to Hub',),])
//                 // Row(
//                 //   children: [
//                 //     // SizedBox(
//                 //     //   width: 10,
//                 //     // ),
//                 //     Padding(
//                 //       padding: const EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 10),
//                 //       child: Text(
//                 //         'Assign Trip',
//                 //         style: TextStyle(
//                 //             fontSize: 30,
//                 //             color: Color(0xff01244c),
//                 //             fontWeight: FontWeight.w900),
//                 //       ),
//                 //     ),
//                 //     SizedBox(
//                 //       width: MediaQuery.of(context).size.width / 2,
//                 //     ),
//                 //     Row(
//                 //       children: [
//                 //         Padding(
//                 //           padding: const EdgeInsets.only(right: 3,),
//                 //           child: Text(dAy1.toString(),
//                 //               style: TextStyle(fontSize: 38),
//                 //               textAlign: TextAlign.end),
//                 //         ),
//                 //         Column(crossAxisAlignment: CrossAxisAlignment.start,
//                 //           children: [
//                 //             Text('${dAy?.toString().substring(0,3).toUpperCase()}'),
//                 //             Text('${mOnth?.toString().substring(0,3).toUpperCase()}-${yEar}'),
//                 //           ],)
//                 //       ],
//                 //     ),
//                 //   ],
//                 // ),
//
//             ],),),
//           ),
//         ],
//       ),
//     );
//   }
// }
