import 'package:popular_anime/app/modules/anime/domain/entities/anime_entity.dart';

class AnimeFavoriteEntity {
  final String image;
  final String name;
  AnimeFavoriteEntity({required this.image, required this.name});

  factory AnimeFavoriteEntity.fromAnime(AnimeEntity item) {
    return AnimeFavoriteEntity(image: item.image, name: item.title);
  }

  Map<String, dynamic> toMap() {
    return {"image": image, "name": name};
  }

  factory AnimeFavoriteEntity.fromJson(Map<String, dynamic> item) {
    return AnimeFavoriteEntity(image: item['image'], name: item['name']);
  }
}
