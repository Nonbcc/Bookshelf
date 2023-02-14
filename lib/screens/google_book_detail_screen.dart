import 'package:flutter/material.dart';
import 'package:mybookshelf/models/book.dart';
import 'package:mybookshelf/models/google_book.dart';
import 'package:mybookshelf/services/database_helper.dart';
import 'package:mybookshelf/services/google_book_api.dart';

class GoogleBookDetailScreen extends StatefulWidget {
  static const routeName = '/search-screen/id';

  final String googleBookId;

  GoogleBookDetailScreen({required this.googleBookId});

  @override
  State<GoogleBookDetailScreen> createState() => _GoogleBookDetailScreenState();
}

class _GoogleBookDetailScreenState extends State<GoogleBookDetailScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Book Detail'),
        ),
        backgroundColor: Colors.brown[400],
      ),
      body: FutureBuilder<GoogleBook>(
        future: FetchGoogleBook.getGoogleBookDetail(widget.googleBookId),
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
                            snapshot.data!.volumeInfo.thumbnail,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(snapshot.data!.volumeInfo.title),
                        SizedBox(height: 10),
                        Text('by ${snapshot.data!.volumeInfo.authors[0]}'),
                        SizedBox(height: 50),
                        if (snapshot.data!.volumeInfo.publisher == '') ...[
                          Text('Publisher: No publisher details')
                        ] else ...[
                          Text(
                              'Publisher: ${snapshot.data!.volumeInfo.publisher}'),
                        ],
                        SizedBox(height: 10),
                        if (snapshot.data!.saleInfo.price < 0) ...[
                          Text('Price: No price details')
                        ] else ...[
                          Text(
                              'Price: ${snapshot.data!.saleInfo.price.toString()}'),
                        ],
                        SizedBox(height: 10),
                        Text(
                            'Book Page: ${snapshot.data!.volumeInfo.pageCount.toString()}'),
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
