import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mybookshelf/screens/add_book_screen.dart';
import 'package:mybookshelf/screens/bookshelf_screen.dart';
import 'package:mybookshelf/screens/search_screen.dart';
import 'package:mybookshelf/widgets/add_book_dialog.dart';

class NavBar extends StatefulWidget {
  final String currentRoute;

  NavBar(this.currentRoute);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool openNav = false;
  AddBookDialog addBookDialog = AddBookDialog();

  @override
  Widget build(BuildContext context) {
    final height = min(MediaQuery.of(context).size.height * 0.09, 60.0);
    final width = min(
        openNav
            ? MediaQuery.of(context).size.width * 0.7
            : MediaQuery.of(context).size.width * 0.2,
        400.0);
    return Container(
      height: height,
      width: width,
      child: Row(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            color: Colors.white,
            elevation: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (openNav)
                  NavbarButton(Icons.book, BookShelfScreen.routeName,
                      widget.currentRoute),
                if (openNav)
                  NavbarButton(Icons.search, SearchScreen.routeName,
                      widget.currentRoute),
                if (openNav)
                  NavbarButton(Icons.qr_code, SearchScreen.routeName,
                      widget.currentRoute),
                if (openNav) ...[
                  IconButton(
                    onPressed: () {
                      addBookDialog.AddBookPopup(context);
                    },
                    icon: Icon(Icons.edit),
                    color: Colors.brown,
                  ),
                ],
              ],
            ),
          ),
          Container(
            width: 62,
            child: FloatingActionButton(
              backgroundColor: Colors.brown[400],
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                setState(() {
                  openNav = !openNav;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class NavbarButton extends StatelessWidget {
  final IconData icon;
  final String route;
  final String currentRoute;

  NavbarButton(this.icon, this.route, this.currentRoute);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      color: Colors.brown,
      onPressed: () {
        if (currentRoute == route) return;
        Navigator.of(context).pushReplacementNamed(route);
      },
    );
  }
}
