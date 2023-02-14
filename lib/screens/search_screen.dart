import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mybookshelf/models/book.dart';
import 'package:mybookshelf/models/google_book.dart';
import 'package:mybookshelf/screens/google_book_detail_screen.dart';
import 'package:mybookshelf/services/database_helper.dart';
import 'package:mybookshelf/services/google_book_api.dart';
import 'package:mybookshelf/widgets/navbar.dart';
import 'package:mybookshelf/widgets/search_book_card_widget.dart';
import 'package:mybookshelf/widgets/search_widget.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<GoogleBook> books = [];
  List<String> idList = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    getIds();
    super.initState();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void getIds() async {
    List<String> googleBookIdList =
        await DatabaseHelper.instance.getGoogleBookIds();
    setState(() {
      idList = googleBookIdList;
    });
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: NavBar(SearchScreen.routeName),
      appBar: AppBar(
        title: const Center(
          child: Text('Search Books'),
        ),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: <Widget>[
          buildSearch(),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return GoogleBookSearchCard(
                  book: book,
                  imageHeight: 100.0,
                  imageWidth: 64.0,
                  idList: idList,
                  onTap: (GoogleBook gBook) async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleBookDetailScreen(
                          googleBookId: gBook.googleBookId,
                        ),
                      ),
                    );
                  },
                  onPressed: (GoogleBook gBook) async {
                    if (idList.contains(gBook.googleBookId)) {
                      await DatabaseHelper.instance
                          .removeByGoogleBookId(gBook.googleBookId);
                      setState(() {
                        idList.removeWhere((id) => id == gBook.googleBookId);
                      });
                    } else {
                      await DatabaseHelper.instance.addBook(
                        Book(
                            googleBookId: gBook.googleBookId,
                            title: gBook.volumeInfo.title,
                            subtitle: gBook.volumeInfo.subtitle,
                            thumbnail: gBook.volumeInfo.thumbnail,
                            isCompleted: false,
                            previewLink: gBook.volumeInfo.previewLink,
                            authors: gBook.volumeInfo.authors,
                            publisher: gBook.volumeInfo.publisher,
                            publishedDate: gBook.volumeInfo.publishedDate,
                            description: gBook.volumeInfo.description,
                            pageCount: gBook.volumeInfo.pageCount,
                            categories: gBook.volumeInfo.categories,
                            currencyCode: gBook.saleInfo.currencyCode,
                            price: gBook.saleInfo.price),
                      );
                      setState(() {
                        idList.add(gBook.googleBookId);
                      });
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        if (query.trim() != '') {
          final books = await FetchGoogleBook.getBookList(query);

          if (!mounted) return;

          setState(() {
            this.query = query;
            this.books = books;
          });
        }
      });
}
