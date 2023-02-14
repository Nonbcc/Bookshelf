import 'package:flutter/material.dart';
import 'package:mybookshelf/models/book.dart';
import 'package:mybookshelf/screens/bookshelf_screen.dart';
import 'package:mybookshelf/services/database_helper.dart';

class AddBookDialog {
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final publisherController = TextEditingController();
  final bookPagesController = TextEditingController();
  final bookPriceController = TextEditingController();
  final bookPictureController = TextEditingController();

//   void validate() {
//     if (formKey.currentState!.validate()) {
//       print('Validated');
//     } else {
//       print('Not Validated');
//     }
//   }

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

  void AddBookPopup(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () async {
                // validate();
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
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('No'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown[400],
              ),
            ),
          ],
          title: Text('Add Book'),
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('title', titleController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('author', authorController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('publisher', publisherController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('pages', bookPagesController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('price', bookPriceController),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: inputField('picture', bookPictureController),
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
