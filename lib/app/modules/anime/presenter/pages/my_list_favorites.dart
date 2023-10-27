import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popular_anime/app/core/utils/service_locator.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_favorite_entity.dart';
import 'package:popular_anime/app/modules/anime/presenter/store/list_favorite_store.dart';

class MyListFavorites extends StatefulWidget {
  const MyListFavorites({super.key});

  @override
  State<MyListFavorites> createState() => _MyListFavoritesState();
}

class _MyListFavoritesState extends State<MyListFavorites> {
  ListFavoriteStore store = getIt<ListFavoriteStore>();
  @override
  void initState() {
    super.initState();
    store.getListFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade700,
        title: const Text('Favorite List'),
      ),
      body: Observer(builder: (_) {
        return Center(
          child: Column(children: [
            store.isLoading == true
                ? const CircularProgressIndicator(
                    strokeAlign: CircularProgressIndicator.strokeAlignCenter,
                  )
                : store.isError == true
                    ? const Text('error')
                    : store.response.length > 0
                        ? Expanded(
                            flex: 9,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: store.response.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ItemFavoriteAdicionado(
                                      item: store.response[index],
                                      store: store,
                                      index: index);
                                }),
                          )
                        : Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                      'assets/svg/no_list.svg',
                                      width: 280,
                                      height: 280,
                                      semanticsLabel: 'Acme Logo'),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  'Você não possui lista de favoritos.',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
          ]),
        );
      }),
    );
  }
}

class ItemFavoriteAdicionado extends StatefulWidget {
  final AnimeFavoriteEntity item;
  final ListFavoriteStore store;
  final int index;
  const ItemFavoriteAdicionado(
      {super.key,
      required this.item,
      required this.store,
      required this.index});
  @override
  State<ItemFavoriteAdicionado> createState() => _ItemFavoriteAdicionadoState();
}

class _ItemFavoriteAdicionadoState extends State<ItemFavoriteAdicionado> {
  @override
  Widget build(BuildContext context) {
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
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      IconButton(
          onPressed: () {
            alertDelete(context, widget.item, widget.store, widget.index);
          },
          icon: const Icon(Icons.delete),
          iconSize: 36,
          color: Colors.deepOrangeAccent,
          padding: const EdgeInsetsDirectional.all(0),
          alignment: AlignmentDirectional.centerStart),
    ]);
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
                        store.getListFavorites();
                        Navigator.pop(context);
                      },
                      child: const Text('Sim'))
                ],
              )
            ],
          );
        });
