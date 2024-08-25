import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/bloc/restaurant_bloc.dart';
import '../../../home/presentation/screens/restaurant_screen.dart';
import '../../../setting/presentation/screens/setting_screen.dart';
import '../../../wishlist/presentation/screens/wishlist_screen.dart';
import '../../../../utils/images.dart';
import '../../../../utils/styles.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  void _setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return const RestaurantScreen(); // RestaurantScreen will have access to RestaurantBloc from higher level
      case 1:
        return const WishlistScreen();
      case 2:
        return const SettingScreen();

      default:
        return const OnDevScreen();
    }
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: whiteColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: blackColor,
      currentIndex: _currentIndex,
      onTap: _setIndex,
      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(Images.iconHome)),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(Images.iconHeart)),
          label: 'WishList',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage(Images.iconSettings)),
          label: 'Setting',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RestaurantBloc(), // Providing Bloc to the widget tree
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: buildBottomNavigationBar(),
        body: _buildBody(),
      ),
    );
  }
}

class OnDevScreen extends StatelessWidget {
  const OnDevScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "ON DEV",
        style: blackTextStyle,
      ),
    );
  }
}
