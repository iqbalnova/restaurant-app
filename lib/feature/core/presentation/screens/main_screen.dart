// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   int _currentIndex = 0;

//   void _setIndex(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   Widget _buildBody() {
//     switch (_currentIndex) {
//       case 0:
//         return const HomeScreen();
//       case 1:
//         return const OnDevScreen();
//       case 2:
//         return const ShopScreen();
//       case 3:
//         return const OnDevScreen();
//       case 4:
//         return const OnDevScreen();
//       default:
//         return const OnDevScreen();
//     }
//   }

//   BottomNavigationBar buildBottomNavigationBar() {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: whiteColor,
//       selectedItemColor: primaryColor,
//       unselectedItemColor: blackColor,
//       currentIndex: _currentIndex,
//       onTap: _setIndex,
//       items: _bottomNavigationBarItems(),
//     );
//   }

//   List<BottomNavigationBarItem> _bottomNavigationBarItems() {
//     return [
//       const BottomNavigationBarItem(
//         icon: ImageIcon(
//           AssetImage(Images.iconHome),
//         ),
//         label: 'Home',
//       ),
//       const BottomNavigationBarItem(
//         icon: ImageIcon(
//           AssetImage(Images.iconHeart),
//         ),
//         label: 'WishList',
//       ),
//       const BottomNavigationBarItem(
//         icon: ImageIcon(
//           AssetImage(Images.iconSearch),
//           size: 1, // Hide icon
//         ),
//         label: '',
//       ),
//       const BottomNavigationBarItem(
//         icon: ImageIcon(
//           AssetImage(Images.iconSearch),
//         ),
//         label: 'Search',
//       ),
//       const BottomNavigationBarItem(
//         icon: ImageIcon(
//           AssetImage(Images.iconSettings),
//         ),
//         label: 'Setting',
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: _buildFloatingActionButton(),
//       bottomNavigationBar: buildBottomNavigationBar(),
//       body: _buildBody(),
//       appBar: AppBar(
//         leading: IconButton(
//           icon: ClipOval(
//             child: Image.asset(
//               Images.iconHamburger,
//               fit: BoxFit.cover,
//               height: 60.sp,
//               width: 60.sp,
//             ),
//           ),
//           onPressed: () {
//             _scaffoldKey.currentState?.openDrawer();
//           },
//         ),
//         title: Image.asset(
//           Images.splashLogo,
//           fit: BoxFit.cover,
//           height: 34.sp,
//         ),
//         centerTitle: true,
//         actions: [
//           Container(
//             margin: const EdgeInsets.only(right: 14),
//             child: IconButton(
//               icon: ClipOval(
//                 child: Container(
//                   color: Colors.grey,
//                   child: Image.asset(
//                     Images.iconDummyProfile,
//                     fit: BoxFit.contain,
//                     height: 36.sp,
//                     width: 36.sp,
//                   ),
//                 ),
//               ),
//               onPressed: () {
//                 // Add your onPressed code here!
//               },
//             ),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: primaryColor,
//               ),
//               child: Center(
//                 child: Text(
//                   'John Doe',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24.sp,
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: const ListTile(
//                 leading: Icon(Icons.account_circle),
//                 title: Text('Profile'),
//               ),
//             ),
//             InkWell(
//               onTap: () {},
//               child: const ListTile(
//                 leading: Icon(Icons.settings),
//                 title: Text('Settings'),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Navigator.pushReplacementNamed(context, AppRoutes.login);
//               },
//               child: ListTile(
//                 leading: Icon(
//                   Icons.message,
//                   color: redColor,
//                 ),
//                 title: Text(
//                   'Logout',
//                   style: TextStyle(
//                     color: redColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFloatingActionButton() {
//     Color fabBgColor = _currentIndex == 2 ? primaryColor : whiteColor;
//     Color fabColor = _currentIndex == 2 ? whiteColor : blackColor;

//     return FloatingActionButton(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(1000),
//       ),
//       onPressed: () {
//         setState(() {
//           _currentIndex = 2;
//         });
//       },
//       backgroundColor: fabBgColor,
//       child: ImageIcon(
//         const AssetImage(Images.iconShopping),
//         size: 30,
//         color: fabColor,
//       ),
//     );
//   }
// }

// class OnDevScreen extends StatelessWidget {
//   const OnDevScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         "ON DEV",
//         style: blackTextStyle,
//       ),
//     );
//   }
// }

// class ShopScreen extends StatelessWidget {
//   const ShopScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         "ON SHOP",
//         style: blackTextStyle,
//       ),
//     );
//   }
// }
