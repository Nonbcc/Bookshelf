import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mybookshelf/models/book.dart';
import 'package:mybookshelf/screens/book_detail_screen.dart';
import 'package:mybookshelf/screens/google_book_detail_screen.dart';
import 'package:mybookshelf/screens/search_screen.dart';
import 'package:mybookshelf/services/database_helper.dart';
import 'package:http/http.dart' as http;
import 'package:mybookshelf/widgets/navbar.dart';
import 'package:path_provider/path_provider.dart';

class BookShelfScreen extends StatefulWidget {
  static const routeName = '/bookshelf-screen';

  @override
  State<BookShelfScreen> createState() => _BookShelfScreenState();
}

class _BookShelfScreenState extends State<BookShelfScreen> {
  late List<Book> books;
  late Book book;
  bool isLoading = false;
  List<String> items = ['Incomplete', 'Complete'];
  String selectedItem = 'Incomplete';

  @override
  void initState() {
    books = [];
    super.initState();

    refreshBooks();
  }

  Future refreshBooks() async {
    setState(() => isLoading = true);
    books = await DatabaseHelper.instance.getBooks();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: NavBar(BookShelfScreen.routeName),
      appBar: AppBar(
        title: const Center(
          child: Text('Bookshelf'),
        ),
        backgroundColor: Colors.brown[400],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? Center(child: CircularProgressIndicator())
                    : books.length <= 0
                        ? EmptyBookshelfWidget()
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              final book = books[index];
                              return Card(
                                child: ListTile(
                                  leading: Image.network(
                                    book.thumbnail,
                                    height: 100,
                                    width: 64,
                                  ),
                                  title: Text(book.title),
                                  subtitle: Row(
                                    children: [
                                      if (book.authors[0].length == 0) ...[
                                        Text('No author details')
                                      ] else ...[
                                        Text('by ${book.authors.join(' | ')}'),
                                      ],
                                      SizedBox(width: 5),
                                      DropdownButton<String>(
                                        value: selectedItem,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.brown),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.brown,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() async {
                                            selectedItem = newValue!;
                                            print(book.id);
                                            print(selectedItem);
                                            if (selectedItem == 'Complete') {
                                              await DatabaseHelper.instance
                                                  .updateBook(Book(
                                                      googleBookId: '',
                                                      title: book.title,
                                                      subtitle: '',
                                                      thumbnail: book.thumbnail,
                                                      isCompleted: true,
                                                      previewLink: '',
                                                      authors: book.authors,
                                                      publisher: book.publisher,
                                                      publishedDate: '',
                                                      description: '',
                                                      pageCount: book.pageCount,
                                                      categories: [],
                                                      currencyCode: '',
                                                      price: book.price));
                                              print(book.isCompleted);
                                            } else if (selectedItem ==
                                                'Incomplete') {
                                              await DatabaseHelper.instance
                                                  .updateBook(Book(
                                                      googleBookId:
                                                          book.googleBookId,
                                                      title: book.title,
                                                      subtitle: book.subtitle,
                                                      thumbnail: book.thumbnail,
                                                      isCompleted: false,
                                                      previewLink:
                                                          book.previewLink,
                                                      authors: book.authors,
                                                      publisher: book.publisher,
                                                      publishedDate:
                                                          book.publishedDate,
                                                      description:
                                                          book.description,
                                                      pageCount: book.pageCount,
                                                      categories:
                                                          book.categories,
                                                      currencyCode:
                                                          book.currencyCode,
                                                      price: book.price));
                                              print(book.isCompleted);
                                            }
                                          });
                                        },
                                        items: items
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.timer),
                                      ),
                                    ],
                                  ),
                                  onLongPress: () async {
                                    await DatabaseHelper.instance
                                        .removeById(book.id);

                                    refreshBooks();
                                  },
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BookDetailScreen(
                                            id: book.id,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyBookshelfWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Click ",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            WidgetSpan(
              child: Icon(
                Icons.bookmark_border,
                size: 18,
              ),
            ),
            TextSpan(
              text: " to add books to the bookshelf",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
