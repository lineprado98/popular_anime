import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:popular_anime/app/core/config/theme/app_colors.dart';
import 'package:popular_anime/app/core/utils/service_locator.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_favorite_entity.dart';
import 'package:popular_anime/app/modules/anime/presenter/store/list_favorite_store.dart';

class ItemFavoriteWidget extends StatefulWidget {
  final AnimeFavoriteEntity item;
  final int index;
  const ItemFavoriteWidget(
      {super.key, required this.item, required this.index});
  @override
  State<ItemFavoriteWidget> createState() => _ItemFavoriteWidgetState();
}

class _ItemFavoriteWidgetState extends State<ItemFavoriteWidget> {
  ListFavoriteStore store = getIt<ListFavoriteStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Row(children: [
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
                  widget.item.image
                      .toString(), // Certifique-se de que item.image contenha a URL da imagem
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
                widget.item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                '100 + Views',
                style: TextStyle(color: AppColors.white),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              alertDelete(context, widget.item, store, widget.index);
            },
            icon: const Icon(Icons.delete),
            iconSize: 36,
            color: Colors.deepOrangeAccent,
            padding: const EdgeInsetsDirectional.all(0),
            alignment: AlignmentDirectional.centerStart),
      ]);
    });
  }
}

void alertDelete(BuildContext context, AnimeFavoriteEntity item,
        ListFavoriteStore store, int index) =>
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Atenção!!'),
            content: const Text(
                'Você realmente deseja remover esse item dos favoritos?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Não')),
                  TextButton(
                      onPressed: () async {
                        await store.remove(item);
                        store
                            .getListFavorites()
                            .then((_) => Navigator.pop(context));
                      },
                      child: const Text('Sim'))
                ],
              )
            ],
          );
        });
