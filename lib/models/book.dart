class Book {
  final int? id;
  final String title,
      googleBookId,
      previewLink,
      publisher,
      publishedDate,
      description,
      thumbnail,
      subtitle,
      currencyCode;
  final bool isCompleted;
  final double price;
  final int pageCount;
  final List<String> authors, categories;

  Book({
    this.id,
    required this.googleBookId,
    required this.title,
    required this.subtitle,
    required this.thumbnail,
    required this.isCompleted,
    required this.previewLink,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.categories,
    required this.currencyCode,
    required this.price,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json['id'],
        googleBookId: json['googleBookId'] ?? '',
        title: json['title'],
        subtitle: json['subtitle'] ?? '',
        thumbnail: json['thumbnail'] ?? '',
        isCompleted: json['isCompleted'] == 0 ? false : true,
        previewLink: json['previewLink'] ?? '',
        authors: json['authors'] == null ? [] : json['authors'].split(', '),
        publisher: json['publisher'] ?? '',
        publishedDate: json['publishedDate'] ?? '',
        description: json['description'] ?? '',
        pageCount: json['pageCount'] ?? -1,
        categories:
            json['categories'] == null ? [] : json['categories'].split(', '),
        currencyCode: json['currencyCode'] ?? '',
        price: json['price'] ?? -1,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'googleBookId': googleBookId,
      'title': title,
      'subtitle': subtitle,
      'thumbnail': thumbnail,
      'isCompleted': isCompleted == true ? 1 : 0,
      'previewLink': previewLink,
      'authors': authors.join(', '),
      'publisher': publisher,
      'publishedDate': publishedDate,
      'description': description,
      'pageCount': pageCount,
      'categories': categories.join(', '),
      'currencyCode': currencyCode,
      'price': price,
    };
  }
}
