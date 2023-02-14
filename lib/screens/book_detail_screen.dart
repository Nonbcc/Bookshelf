import 'package:flutter/material.dart';
import 'package:mybookshelf/models/book.dart';
import 'package:mybookshelf/services/database_helper.dart';
import 'package:mybookshelf/widgets/edit_book_dialog.dart';

class BookDetailScreen extends StatefulWidget {
  static const routeName = '/bookshelf-screen/id';

  final int? id;

  BookDetailScreen({required this.id});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EditBookDialog editBookDialog = EditBookDialog();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Book Detail'),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              editBookDialog.EditBookPopup(context, widget.id);
            },
            icon: Icon(Icons.edit),
          ),
        ],
        backgroundColor: Colors.brown[400],
      ),
      body: FutureBuilder<Book>(
        future: DatabaseHelper.instance.getBookById(widget.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : !snapshot.hasData
                  ? NotFoundBookDetail()
                  : Column(
                      children: [
                        SizedBox(height: 50),
                        Container(
                          alignment: Alignment.center,
                          child: Image.network(
                            snapshot.data!.thumbnail,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(snapshot.data!.title),
                        SizedBox(height: 10),
                        if (snapshot.data!.authors[0].length == 0) ...[
                          Text('No author details')
                        ] else ...[
                          Text('by ${snapshot.data!.authors[0]}'),
                        ],
                        SizedBox(height: 50),
                        if (snapshot.data!.publisher == '') ...[
                          Text('Publisher: No publisher details')
                        ] else ...[
                          Text('Publisher: ${snapshot.data!.publisher}'),
                        ],
                        SizedBox(height: 10),
                        if (snapshot.data!.price < 0) ...[
                          Text('Price: No price details')
                        ] else ...[
                          Text('Price: ${snapshot.data!.price.toString()}'),
                        ],
                        SizedBox(height: 10),
                        Text(
                            'Book Page: ${snapshot.data!.pageCount.toString()}'),
                      ],
                    );
        },
      ),
    );
  }
}

class NotFoundBookDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Page Not Found",
        style: TextStyle(
            fontSize: 20, color: Colors.black, decoration: TextDecoration.none),
      ),
    );
  }
}
