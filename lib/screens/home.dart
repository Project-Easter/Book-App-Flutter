import 'package:books_app/Services/database_service.dart';
import 'package:books_app/Widgets/custom_navigation_bar.dart';
import 'package:books_app/constants/routes.dart';
import 'package:books_app/models/book.dart';
import 'package:books_app/models/user.dart';
import 'package:books_app/screens/bookshelf.dart';
import 'package:books_app/screens/chat/wrapper.dart';
import 'package:books_app/screens/dashboard/dashboard.dart';
import 'package:books_app/screens/explore_nearby.dart';
import 'package:books_app/screens/profile/private_profile.dart';
import 'package:books_app/services/auth.dart';
import 'package:books_app/utils/size_config.dart';
import 'package:books_app/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final List<Widget> _screens = <Widget>[
    DashboardPage(),
    ExploreNearby(),
    const Wrapper(),
    LibraryPage(),
    PrivateProfile(),
  ];
  TextStyle name = GoogleFonts.muli(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30);
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final dynamic uID = _authService.getUID;
    print(uID);
    return MultiProvider(
      providers: <StreamProvider<dynamic>>[
        StreamProvider<UserData>.value(
          value: DatabaseService(uid: uID as String).userData,
          catchError: (_, Object e) => null,
        ),
        StreamProvider<List<Book>>.value(
            value: DatabaseService(uid: uID as String).booksData),
      ],
      child: Scaffold(
          appBar: MyAppBar(context),
          body: _screens[_selectedIndex],
          floatingActionButton: Container(
            child: _selectedIndex == 3 || _selectedIndex == 1
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          heroTag: null,
                          child: const Icon(Icons.add_box_rounded),
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.ADD_BOOK);
                          },
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: 'map',
                        child: const Icon(Icons.location_on),
                        backgroundColor: Colors.blueAccent,
                        onPressed: () async {
                          //Add users Location to DB
                          await Navigator.pushNamed(context, Routes.LOCATION);
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
          bottomNavigationBar: FloatingNavbar(
            showSelectedLabels: true,
            currentIndex: _selectedIndex,
            onTap: _selectedTab,
            showUnselectedLabels: true,
            items: <FloatingNavbarItem>[
              FloatingNavbarItem(
                icon: Icons.home_filled,
                title: 'Home',
              ),
              FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
              FloatingNavbarItem(
                  icon: Icons.chat_bubble_rounded, title: 'Chats'),
              FloatingNavbarItem(
                  icon: Icons.favorite_rounded, title: 'Library'),
              FloatingNavbarItem(
                  icon: Icons.account_circle_rounded, title: 'Profile'),
            ],
          )),
    );

    // return StreamProvider<UserData>.value(
    //   value: DatabaseService(uid: uID).userData,
    //   child: Scaffold(
    //       appBar: MyAppBar(context),
    //       body: _Screens[_selectedIndex],
    //       floatingActionButton: Container(
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           children: <Widget>[
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: FloatingActionButton(
    //                 heroTag: null,
    //                 child: Icon(Icons.add_box_rounded),
    //                 onPressed: () {
    //                   Navigator.pushNamed(context, addBook);
    //                 },
    //               ),
    //             ),
    //             FloatingActionButton(
    //               heroTag: 'map',
    //               child: Icon(Icons.location_on),
    //               backgroundColor: Colors.blueAccent,
    //               onPressed: () {
    //                 Navigator.pushNamed(context, location);
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //       bottomNavigationBar: FloatingNavbar(
    //         showSelectedLabels: true,
    //         currentIndex: _selectedIndex,
    //         onTap: _selectedTab,
    //         showUnselectedLabels: true,
    //         items: [
    //           FloatingNavbarItem(
    //             icon: Icons.home_filled,
    //             title: 'Home',
    //           ),
    //           FloatingNavbarItem(icon: Icons.explore, title: 'Explore'),
    //           FloatingNavbarItem(
    //               icon: Icons.chat_bubble_rounded, title: 'Chats'),
    //           FloatingNavbarItem(
    //               icon: Icons.favorite_rounded, title: 'Library'),
    //           FloatingNavbarItem(
    //               icon: Icons.account_circle_rounded, title: 'Profile'),
    //         ],
    //       )),
    // );
  }

  void _selectedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}