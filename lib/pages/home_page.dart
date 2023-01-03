import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubit/movies_cubit.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/widgets/category_card.dart';
import 'package:movie_app/services/movie_services.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/widgets/loading_spinner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff1C1C27),
        iconSize: 28,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          switch (value) {
            case 0:
              context.goNamed('home');
              break;
            case 1:
              context.goNamed('history');
              break;
            case 2:
              context.goNamed('profile');
              break;
            case 3:
              FirebaseAuth.instance
                  .signOut()
                  .then((_) => context.goNamed('login'));

              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.logout_outlined), label: "Logout"),
        ],
      ),
      body: BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          return SafeArea(
              child: ListView(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<DocumentSnapshot>(
                              future: users.doc(user?.uid).get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final data = snapshot.data!.data()
                                      as Map<String, dynamic>;

                                  return Text(
                                    data['name'] == null
                                        ? 'Welcome back'
                                        : 'Welcome ${data['name'].split(' ')[0]}',
                                    style: const TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  );
                                } else {
                                  return const Text(
                                    "Welcome back",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  );
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Let's relax and buy movie ticket !",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                      const Spacer(),
                      FutureBuilder<DocumentSnapshot>(
                          future: users.doc(user?.uid).get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final data =
                                  snapshot.data!.data() as Map<String, dynamic>;

                              if (data['image_url'] == null ||
                                  data['image_url'] == '') {
                                return const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('./assets/img/profile.jpg'),
                                  radius: 24,
                                );
                              }

                              return CircleAvatar(
                                backgroundImage:
                                    NetworkImage(data['image_url']),
                                radius: 24,
                              );
                            } else {
                              return const CircleAvatar(
                                backgroundImage:
                                    AssetImage('./assets/img/profile.jpg'),
                                radius: 24,
                              );
                            }
                          }),
                    ]),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 26, vertical: 20),
                            filled: true,
                            fillColor: Color(0xff31313B),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100)),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            label: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.search,
                                    color: Colors.white30,
                                    size: 22,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text("Search")
                                ]),
                            labelStyle: const TextStyle(
                                color: Colors.white30, fontSize: 16),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100))),
                        style: const TextStyle(color: Colors.white70)),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "See All",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      letterSpacing: 0.3,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  color: Theme.of(context).primaryColor,
                                  size: 22,
                                )
                              ],
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CategoryCard(emoji: '🥰', text: 'Romance'),
                        CategoryCard(emoji: '😨', text: 'Horror'),
                        CategoryCard(emoji: '😆', text: 'Comedy'),
                        CategoryCard(emoji: '👽', text: 'Sci-fi'),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Now Playing",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 300,
                child: FutureBuilder(
                    future: MovieServices().getListMovieData(1),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Movie> listMovies = snapshot.data as List<Movie>;
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 24),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 200,
                              height: 300,
                              margin: const EdgeInsets.only(right: 24),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: () {
                                  BlocProvider.of<MoviesCubit>(context)
                                      .getSelectedMovie(listMovies[index]);

                                  context.goNamed('detail', params: {
                                    'id': '${listMovies[index].id}'
                                  });
                                },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                        'https://image.tmdb.org/t/p/w200${listMovies[index].poster_path}')),
                              ),
                            );
                          },
                        );
                      } else {
                        return const LoadingSpinner();
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(height: 50),
                      Text(
                        "Coming Soon",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
              ),
              FutureBuilder(
                future: MovieServices().getComingSoonMovie(1),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Movie> listMovies = snapshot.data as List<Movie>;

                    // return CarouselSlider(
                    //     items: listMovies.map((e) {
                    //       return Builder(
                    //         builder: (context) {
                    //           return Container(
                    //             width: MediaQuery.of(context).size.width,
                    //             margin:
                    //                 const EdgeInsets.symmetric(horizontal: 5),
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(16),
                    //                 image: DecorationImage(
                    //                     image: NetworkImage(
                    //                         'https://image.tmdb.org/t/p/w400${e.backdrop_path}'),
                    //                     fit: BoxFit.cover)),
                    //           );
                    //         },
                    //       );
                    //     }).toList(),
                    //     options: CarouselOptions(
                    //       height: 300,
                    //       aspectRatio: 16 / 9,
                    //       viewportFraction: 0.8,
                    //       enlargeCenterPage: true,
                    //       enlargeFactor: 0.2,
                    //     ));

                    return CarouselSlider.builder(
                        itemCount: listMovies.length,
                        itemBuilder: (context, index, realIndex) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w400${listMovies[index].backdrop_path}'),
                                    fit: BoxFit.cover)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4)),
                                  child: Text(
                                    listMovies[index].title,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                const SizedBox(height: 10)
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 300,
                          initialPage: 0,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.2,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1000),
                          autoPlayCurve: Curves.fastOutSlowIn,
                        ));
                  } else {
                    return const LoadingSpinner();
                  }
                },
              ),
              const SizedBox(height: 50),
              // ElevatedButton(
              //     onPressed: () async {
              //       print(user);
              //       // await users.add({'uid': "test", 'name': "test1"});
              //       await users.doc(user!.uid).set({'name': user.displayName});
              //     },
              //     child: Text("Test")),
              // FutureBuilder<QuerySnapshot>(
              //   future: users.get(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return Column(
              //           children: snapshot.data!.docs.map((e) {
              //         final data = e.data() as Map<String, dynamic>;
              //         return Container(child: Text('${data['name']}'));
              //       }).toList());
              //     } else {
              //       return Column(
              //         children: [
              //           CircularProgressIndicator(
              //             color: Theme.of(context).primaryColor,
              //           )
              //         ],
              //       );
              //     }
              //   },
              // ),
              // StreamBuilder<QuerySnapshot>(
              //   // stream: users.orderBy('name').snapshots(),
              //   stream: users.snapshots(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return Column(
              //           children: snapshot.data!.docs.map((e) {
              //         final data = e.data() as Map<String, dynamic>;
              //         return Container(child: Text('${data['name']}'));
              //       }).toList());
              //     } else {
              //       return Column(
              //         children: [
              //           CircularProgressIndicator(
              //             color: Theme.of(context).primaryColor,
              //           )
              //         ],
              //       );
              //     }
              //   },
              // )
            ],
          ));
        },
      ),
    );
  }
}
