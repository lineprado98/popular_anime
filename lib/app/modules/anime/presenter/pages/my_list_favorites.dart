import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popular_anime/app/core/config/theme/app_colors.dart';
import 'package:popular_anime/app/core/utils/service_locator.dart';
import 'package:popular_anime/app/modules/anime/presenter/store/list_favorite_store.dart';
import 'package:popular_anime/app/modules/anime/presenter/widgets/item_favorite_widget.dart';

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
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
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
                    : store.response.isNotEmpty
                        ? Expanded(
                            flex: 9,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: store.response.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ItemFavoriteWidget(
                                      item: store.response[index],
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
                                const SizedBox(
                                  height: 50,
                                ),
                                const Text(
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
