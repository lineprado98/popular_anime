import 'package:flutter/material.dart';
import 'package:popular_anime/app/modules/anime/domain/entities/anime_entity.dart';
import 'package:popular_anime/app/modules/anime/presenter/pages/my_list_favorites.dart';
import 'package:popular_anime/app/modules/anime/presenter/store/list_anime_store.dart';
import 'package:popular_anime/app/core/utils/service_locator.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ListAnimeStore store = getIt<ListAnimeStore>();

  @override
  void initState() {
    super.initState();
    store.getListAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.star),
            backgroundColor: const Color(0xFF00C853),
            onPressed: () async {
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const MyListFavorites();
              }));
              await store.getListAnimes();
            }),
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.greenAccent.shade700,
          leadingWidth: 110,
          title: const Text('Animes'),
        ),
        body: Observer(builder: (_) {
          return Center(
            child: Column(children: [
              store.isLoading == true
                  ? const Expanded(
                      flex: 9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ))
                  : store.isError == true
                      ? const Text('error')
                      : Expanded(
                          flex: 9,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: store.response.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ItemAnime(
                                    list: store.response,
                                    item: store.response[index],
                                    index: index);
                              }),
                        ),
            ]),
          );
        }),
      );
    });
  }
}

class ItemAnime extends StatefulWidget {
  final AnimeEntity item;
  final List<AnimeEntity> list;
  final int index;

  const ItemAnime(
      {super.key, required this.item, required this.index, required this.list});

  @override
  State<ItemAnime> createState() => _ItemAnimeState();
}

class _ItemAnimeState extends State<ItemAnime> {
  ListAnimeStore store = getIt<ListAnimeStore>();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
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
                  widget.item.title,
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
                      ? const Icon(Icons.star, color: Colors.yellow)
                      : const Icon(Icons.star, color: Colors.white),
                  iconSize: 25,
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 0, 42),
            child: Icon(Icons.arrow_forward_ios_outlined,
                size: 42, color: Colors.white),
          ),
        ],
      );
    });
  }
}
