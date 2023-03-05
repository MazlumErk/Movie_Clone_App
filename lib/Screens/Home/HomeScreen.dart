import 'package:flutter/material.dart';
import 'package:movie_app_clone/Data/hiveboxs.dart';
import 'package:movie_app_clone/Models/MovieModel.dart';
import 'package:movie_app_clone/Styles/ContainerDecorations.dart';
import 'package:movie_app_clone/Styles/TextStyles.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=afcc193b5c56a07cbb67b8b11409b9a8&language=en-US&page=1');
  int Movielenght = 0;
  late var MovieResults;
  var StatusCode;

  @override
  Widget build(BuildContext context) {
    print(url);
    return Scaffold(
      appBar: AppBar(
        title: Text('MOVIES', style: TextStyles.appbarTitleTextStyle),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.red,
                child: SafeArea(
                  child: Center(
                    child: Text(hiveboxs.userBox.get('name')),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            hiveboxs.userBox.put('isUserLogin', false);
                            Navigator.of(context)
                                .pushReplacementNamed('/login');
                          },
                          child: Text('Logout'),
                        ),
                        Column(
                          children: [
                            Divider(),
                            Text('Movie Clone App v1.0'),
                            Divider(),
                            Text('Mazlum Erkek'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: Future(() async {
          try {
            final response = await http.get(url);
            if (response.statusCode == 200) {
              var result = movieDatasFromJson(response.body);
              if (mounted)
                setState(() {
                  Movielenght = result.results.length;
                  MovieResults = result;
                });
              return result;
            } else {
              StatusCode = response.statusCode;
            }
          } catch (e) {
            print(e.toString());
          }
        }),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: Movielenght,
            itemBuilder: (context, index) {
              return MovieCard(
                MovieResults.results[index].backdropPath,
                MovieResults.results[index].originalTitle,
                MovieResults.results[index].overview,
                MovieResults.results[index].voteAverage.toString(),
                MovieResults.results[index].voteCount.toString(),
                MovieResults.results[index].releaseDate.toString(),
              );
            },
          );
        },
      ),
    );
  }

  Padding MovieCard(String MovieImage, String MovieName, String MovieOverview,
      String MovieVoteAverage, String MovieVoteCount, String MovieReleaseDate) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        // height: 300,
        decoration: ContainerDecorations.MovieCardDecoration,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500' + MovieImage),
                      fit: BoxFit.fitWidth),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(1000),
                      child: Text(
                        MovieName,
                        style: TextStyle(
                          fontSize: 1000,
                          backgroundColor: Color.fromARGB(138, 0, 0, 0),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Vote:' + MovieVoteAverage),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Text('Vote Count:' + MovieVoteCount),
                    VerticalDivider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Text('Release Date:' + MovieReleaseDate),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                MovieOverview,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
