import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:popular_anime/app/core/config/theme/app_colors.dart';
import 'package:popular_anime/app/core/utils/service_locator.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_entity.dart';
import 'package:popular_anime/app/modules/anime/presenter/store/list_anime_store.dart';

class ItemAnimeWidget extends StatefulWidget {
  final AnimeEntity item;
  final List<AnimeEntity> list;
  final int index;

  const ItemAnimeWidget(
      {super.key, required this.item, required this.index, required this.list});

  @override
  State<ItemAnimeWidget> createState() => _ItemAnimeWidgetState();
}

class _ItemAnimeWidgetState extends State<ItemAnimeWidget> {
  ListAnimeStore store = getIt<ListAnimeStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 136,
              height: 110,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    widget.item.image.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ),
                const Text(
                  '100 + Views',
                  style: TextStyle(color: AppColors.white),
                ),
                IconButton(
                  padding: const EdgeInsetsDirectional.all(0),
                  alignment: AlignmentDirectional.centerStart,
                  onPressed: () async {
                    if (store.response[widget.index].isFavorite != true) {
                      store.save(value: widget.item);

                      store.setAsFavorite(
                          widget.index, !widget.item.isFavorite);
                    } else {
                      store.remove(value: widget.item);
                      store.setAsFavorite(widget.index, false);
                    }

                    setState(() {});
                  },
                  icon: widget.item.isFavorite == true
                      ? const Icon(Icons.star, color: AppColors.yellow)
                      : const Icon(Icons.star, color: AppColors.white),
                  iconSize: 25,
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 0, 42),
            child: Icon(Icons.arrow_forward_ios_outlined,
                size: 42, color: AppColors.white),
          ),
        ],
      );
    });
  }
}
