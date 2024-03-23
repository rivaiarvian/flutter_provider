import 'package:d_method/d_method.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider_testing/model/game.dart';
import 'package:provider_testing/provider/game_provider.dart';
import 'package:provider_testing/provider/genre_provide.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> genres = [
    'Shooter',
    'MMORPG',
    'ARPG',
    'Strategy',
    'Fighting',
  ];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().fetchLiveGames();
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Live Games'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Consumer<GameProvider>(
              builder: (context, gameProvider, child) {
                String genreSelected = gameProvider.genre;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: genres.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ActionChip(
                            label: Text(e),
                            onPressed: () {
                              context.read<GameProvider>().setGenre(e);
                            },
                            backgroundColor: genreSelected == e
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 8),
            Expanded(
              child: Consumer<GameProvider>(
                builder: (context, gameProvider, child) {
                  if (gameProvider.status == GameStatus.loading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (gameProvider.status == GameStatus.failure) {
                    return Center(child: Text('Something went wrong'));
                  }
                  if (gameProvider.status == GameStatus.loaded) {
                    List<Game> list = gameProvider.games;
                    String genreSelected = gameProvider.genre;
                    List<Game> games =
                        list.where((e) => e.genre == genreSelected).toList();
                    return GridView.builder(
                      itemCount: games.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        Game game = games[index];
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: ExtendedImage.network(
                                game.thumbnail ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: AspectRatio(
                                aspectRatio: 4,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black,
                                        Colors.transparent
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  context
                                      .read<GameProvider>()
                                      .setIsSaved(game, !game.isSaved);
                                },
                                icon: game.isSaved
                                    ? Icon(
                                        Icons.bookmark,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        Icons.bookmark_border,
                                        color: Colors.white70,
                                      ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ));
  }
}
