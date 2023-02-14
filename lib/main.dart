import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mybookshelf/screens/add_book_screen.dart';
import 'package:mybookshelf/screens/book_detail_screen.dart';
import 'package:mybookshelf/screens/google_book_detail_screen.dart';
import 'package:mybookshelf/screens/bookshelf_screen.dart';
import 'package:mybookshelf/screens/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyBookShelf());
}

class MyBookShelf extends StatelessWidget {
  const MyBookShelf({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Books App',
      initialRoute: BookShelfScreen.routeName,
      routes: {
        SearchScreen.routeName: (context) => SearchScreen(),
        BookShelfScreen.routeName: (context) => BookShelfScreen(),
        GoogleBookDetailScreen.routeName: (context) => GoogleBookDetailScreen(
              googleBookId: '',
            ),
        BookDetailScreen.routeName: (context) => BookDetailScreen(id: null),
        AddBookScreen.routeName: (context) => AddBookScreen(),
      },
    );
  }
}
