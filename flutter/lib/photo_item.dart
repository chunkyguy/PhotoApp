class PhotoItem {
  PhotoItem({
    required this.title,
    required this.thumbUrl,
    required this.url,
  });

  factory PhotoItem.fromJson({required Map<String, dynamic> json}) {
    return PhotoItem(
      thumbUrl: json['thumbnailUrl'],
      title: json['title'],
      url: json['url'],
    );
  }

  final String title;
  final String url;
  final String thumbUrl;
}
