import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/cubit/movies_cubit.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/movie_services.dart';
import 'package:movie_app/widgets/loading_spinner.dart';
import 'package:movie_app/widgets/small_box.dart';

class DetailPage extends StatelessWidget {
  final int id;

  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(size: 26, color: Colors.white),
        elevation: 0,
        title: const Text(
          "Movie Detail",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: FutureBuilder(
            future: MovieServices().getMovieData(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Movie movie = snapshot.data as Movie;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 200,
                          height: 300,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                  'https://image.tmdb.org/t/p/w300${movie.poster_path}')),
                        ),
                        Column(
                          children: [
                            SmallBox(
                                icon: Icons.movie,
                                header: 'Genre',
                                content: '${movie.genres![0]["name"]}'),
                            SmallBox(
                                icon: Icons.timer,
                                header: 'Duration',
                                content: '${movie.runtime} min'),
                            SmallBox(
                                icon: Icons.star,
                                header: 'Rating',
                                content:
                                    '${(movie.vote_average).toStringAsFixed(1)} / 10.0'),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.white12,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Synopsis",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      movie.overview,
                      style: const TextStyle(
                          color: Colors.white60, fontSize: 15, height: 1.8),
                      softWrap: true,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shadowColor: Colors.white70,
                                elevation: 100,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 20)),
                            onPressed: () {
                              context.pushNamed('seats',
                                  params: {'id': id.toString()});
                            },
                            child: const Text(
                              "Get Reservation",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87),
                            )),
                      ],
                    ),
                  ],
                );
              } else {
                return const LoadingSpinner();
              }
            },
          ),
        )
      ])),
    );
  }
}
