class GoogleBook {
  final String googleBookId;
  final VolumeInfo volumeInfo;
  final SaleInfo saleInfo;

  const GoogleBook({
    required this.googleBookId,
    required this.volumeInfo,
    required this.saleInfo,
  });

  factory GoogleBook.fromJson(json) => GoogleBook(
        googleBookId: json['id'],
        volumeInfo: VolumeInfo.fromJson(json['volumeInfo']),
        saleInfo: SaleInfo.fromJson(json['saleInfo']['listPrice']),
      );

  Map<String, dynamic> toJson() => {
        'googleBookId': googleBookId,
        'volumeInfo': volumeInfo,
        'saleInfo': saleInfo,
      };
}

class VolumeInfo {
  final String title,
      previewLink,
      publisher,
      publishedDate,
      description,
      thumbnail,
      subtitle;
  final int pageCount;
  final List<String> authors, categories;

  const VolumeInfo(
      {required this.title,
      required this.subtitle,
      required this.thumbnail,
      required this.previewLink,
      required this.authors,
      required this.publisher,
      required this.publishedDate,
      required this.description,
      required this.pageCount,
      required this.categories});

  factory VolumeInfo.fromJson(volumeInfo) {
    return VolumeInfo(
      title: volumeInfo['title'] ?? 'No Title Recorded',
      previewLink: volumeInfo['previewLink'] ?? '',
      publisher: volumeInfo['publisher'] ?? '',
      publishedDate: volumeInfo['publishedDate'] ?? '',
      description: volumeInfo['description'] ?? '',
      subtitle: volumeInfo['subtitle'] ?? '',
      pageCount: volumeInfo['pageCount'] ?? -1,
      thumbnail: volumeInfo['imageLinks'] == null
          ? ''
          : volumeInfo['imageLinks']['thumbnail'],
      authors: volumeInfo['authors'] == null
          ? []
          : List<String>.from(volumeInfo['authors'].map((author) => author)),
      categories: volumeInfo['categories'] == null
          ? []
          : List<String>.from(
              volumeInfo['categories'].map((category) => category)),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'thumbnail': thumbnail,
        'previewLink': previewLink,
        'authors': authors,
        'publisher': publisher,
        'publishedDate': publishedDate,
        'description': description,
        'pageCount': pageCount,
        'categories': categories,
      };
}

class SaleInfo {
  final String currencyCode;
  final double price;

  const SaleInfo({
    required this.currencyCode,
    required this.price,
  });

  factory SaleInfo.fromJson(saleInfoListPrice) => SaleInfo(
        currencyCode:
            saleInfoListPrice == null ? '' : saleInfoListPrice['currencyCode'],
        price: saleInfoListPrice == null
            ? -1.0
            : saleInfoListPrice['amount'].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'currencyCode': currencyCode,
        'price': price,
      };
}
