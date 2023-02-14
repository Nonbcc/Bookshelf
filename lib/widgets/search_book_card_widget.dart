import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mybookshelf/models/google_book.dart';

class GoogleBookSearchCard extends StatefulWidget {
  final GoogleBook book;
  final double imageHeight;
  final double imageWidth;
  final List<String> idList;
  final Function(GoogleBook) onPressed;
  final Function(GoogleBook) onTap;

  const GoogleBookSearchCard({
    super.key,
    required this.book,
    required this.imageHeight,
    required this.imageWidth,
    required this.idList,
    required this.onTap,
    required this.onPressed,
  });

  @override
  State<GoogleBookSearchCard> createState() => _GoogleBookSearchCardState();
}

class _GoogleBookSearchCardState extends State<GoogleBookSearchCard> {
  final String noTitleBookName = 'No Title Recorded';

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => {
          widget.onTap(widget.book),
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.network(
                    widget.book.volumeInfo.thumbnail,
                    fit: BoxFit.cover,
                    width: widget.imageWidth,
                    height: widget.imageHeight,
                    errorBuilder: ((context, error, stackTrace) =>
                        Image.asset('assets/images/default_book_cover.png')),
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.book.volumeInfo.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: widget.book.volumeInfo.title ==
                                    noTitleBookName
                                ? const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)
                                : const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.book.volumeInfo.authors.isEmpty
                                ? ''
                                : widget.book.volumeInfo.authors.join(' | '),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.book.volumeInfo.categories.isEmpty
                                ? ''
                                : widget.book.volumeInfo.categories[0],
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            widget.book.volumeInfo.categories.isNotEmpty &&
                                    widget.book.volumeInfo.pageCount != -1
                                ? ' — '
                                : '',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          Text(
                            widget.book.volumeInfo.pageCount == -1
                                ? ''
                                : '${widget.book.volumeInfo.pageCount} Pages',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => {
                    widget.onPressed(widget.book),
                  },
                  color: Colors.brown[400],
                  iconSize: 50,
                  icon: Icon(
                    widget.idList.contains(widget.book.googleBookId)
                        ? Icons.check_circle
                        : Icons.add_circle,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
