import 'package:flutter/material.dart';
import 'package:popular_anime/app/core/config/routes/app_routes.dart';
import 'package:popular_anime/app/core/config/theme/app_colors.dart';
import 'package:popular_anime/app/modules/anime/presenter/store/list_anime_store.dart';
import 'package:popular_anime/app/core/utils/service_locator.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:popular_anime/app/modules/anime/presenter/widgets/item_anime_widget.dart';

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
          backgroundColor: AppColors.primary,
          onPressed: () async {
            await Navigator.pushNamed(context, RouteNames.favorites);

            await store.getListAnimes();
          },
          child: const Icon(Icons.star),
        ),
        backgroundColor: AppColors.black,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
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
                                return ItemAnimeWidget(
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
