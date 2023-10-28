class AnimeEntity {
  final String title;
  final String image;
  bool isFavorite = false;
  AnimeEntity(
      {required this.title, required this.image, required this.isFavorite});

  factory AnimeEntity.fromJson(Map<String, dynamic> json) {
    return AnimeEntity(
        isFavorite: false,
        title: json['entry']['title'],
        image: json['entry']['images']['jpg']['image_url']);
  }
}
