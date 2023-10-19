class Anime {
  final String title;
  final String image;
  const Anime({required this.title, required this.image});

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
        title: json['entry']['title'],
        image: json['entry']['images']['jpg']['image_url']);
  }
}
