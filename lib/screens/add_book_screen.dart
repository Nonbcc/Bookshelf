import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mybookshelf/models/book.dart';
import 'package:mybookshelf/screens/bookshelf_screen.dart';
import 'package:mybookshelf/services/database_helper.dart';
import 'package:mybookshelf/widgets/navbar.dart';

class AddBookScreen extends StatefulWidget {
  static const routeName = '/add-book-screen';

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final publisherController = TextEditingController();
  final bookPagesController = TextEditingController();
  final bookPriceController = TextEditingController();
  final bookPictureController = TextEditingController();

  void validate() {
    if (formKey.currentState!.validate()) {
      print('Validated');
    } else {
      print('Not Validated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: NavBar(AddBookScreen.routeName),
      appBar: AppBar(
        title: Center(
          child: Text(
            'Add books',
          ),
        ),
        backgroundColor: Colors.brown[400],
      ),
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Book Title',
                    border: OutlineInputBorder(),
                  ),
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a book title';
                    } else {
                      return null;
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Book Author',
                      border: OutlineInputBorder(),
                    ),
                    controller: authorController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a book author';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Book Publisher',
                      border: OutlineInputBorder(),
                    ),
                    controller: publisherController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a book publisher';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Book Page',
                      border: OutlineInputBorder(),
                    ),
                    controller: bookPagesController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a book page';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Book price',
                      border: OutlineInputBorder(),
                    ),
                    controller: bookPriceController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a book price';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Upload\'\ Book\'\s Picture',
                      border: OutlineInputBorder(),
                    ),
                    controller: bookPictureController,
                    keyboardType: TextInputType.url,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a book picture url';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: ElevatedButton(
                      onPressed: () async {
                        validate();
                        await DatabaseHelper.instance.addBook(
                          Book(
                            title: titleController.text,
                            authors: [authorController.text],
                            publisher: publisherController.text,
                            pageCount: int.parse(bookPagesController.text),
                            price: double.parse(bookPriceController.text),
                            categories: [],
                            currencyCode: '',
                            description: '',
                            googleBookId: '',
                            isCompleted: false,
                            previewLink: '',
                            publishedDate: '',
                            thumbnail: bookPictureController.text,
                            subtitle: '',
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BookShelfScreen();
                            },
                          ),
                        );
                      },
                      child: Text('Upload'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[400],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
