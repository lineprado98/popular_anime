import 'package:flutter/material.dart';
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
    print('inciando tela ');
    super.initState();
    store.getListAnimes();
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   print('executa apos montar o context');
    // });

    // Future() => store.getListAnimes();

    // scheduleMicrotask(() {
    //   print('roda em paralelo ');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade700,
        leadingWidth: 110,
      ),
      body: Observer(builder: (_) {
        return Center(
            child: store.isLoading == true
                ? CircularProgressIndicator()
                : store.isError == true
                    ? Text('error')
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: store.response.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemAnime(item: store.response[index]);
                        }));
      }),
    );
  }
}

class ItemAnime extends StatefulWidget {
  final item;
  const ItemAnime({super.key, required this.item});

  @override
  State<ItemAnime> createState() => _ItemAnimeState();
}

class _ItemAnimeState extends State<ItemAnime> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {
                  setState(() {
                    if (isFavorite) {
                      isFavorite = false;
                    } else {
                      isFavorite = true;
                    }
                  });
                },
                icon: Icon(Icons.star,
                    color: isFavorite ? Colors.yellow : Colors.white),
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
  }
}
