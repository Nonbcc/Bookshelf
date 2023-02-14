import 'package:flutter/material.dart';
import 'package:mybookshelf/models/book.dart';
import 'package:mybookshelf/screens/book_detail_screen.dart';
import 'package:mybookshelf/services/database_helper.dart';

class EditBookDialog {
  final edit_titleController = TextEditingController();
  final edit_authorController = TextEditingController();
  final edit_publisherController = TextEditingController();
  final edit_bookPagesController = TextEditingController();
  final edit_bookPriceController = TextEditingController();
  final edit_bookPictureController = TextEditingController();

  Widget inputField(String label, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Book ${label}',
        border: OutlineInputBorder(),
      ),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a book ${label}';
        } else {
          return null;
        }
      },
    );
  }

  void EditBookPopup(BuildContext context, int? id) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper.instance.updateBook(
                  Book(
                    id: id,
                    googleBookId: '',
                    title: edit_titleController.text,
                    subtitle: '',
                    thumbnail: edit_bookPictureController.text,
                    isCompleted: false,
                    previewLink: '',
                    authors: [edit_authorController.text],
                    publisher: edit_publisherController.text,
                    publishedDate: '',
                    description: '',
                    pageCount: int.parse(edit_bookPagesController.text),
                    categories: [],
                    currencyCode: '',
                    price: double.parse(edit_bookPriceController.text),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BookDetailScreen(
                        id: id,
                      );
                    },
                  ),
                );
              },
              child: Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
          title: Text('Edit Book'),
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('title', edit_titleController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('author', edit_authorController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('publisher', edit_publisherController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('pages', edit_bookPagesController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('price', edit_bookPriceController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('picture', edit_bookPictureController),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
