import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_grupo10/domain/entities/movie.dart';
import 'package:proyecto_grupo10/presentation/providers/actors/actors_by_movie_provider.dart';
import 'package:proyecto_grupo10/presentation/providers/movies/movie_detail_provider.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({
    super.key, 
    required this.movieId
  });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
void initState() {
  super.initState();

  ref.read(movieDetailProdiver.notifier).loadMovie(widget.movieId);
  ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  
}

  @override
  Widget build(BuildContext context) {
    //movieDetailProdiver no es una movie es propiamente la información que maneja el mapa
    final Movie? movie = ref.watch( movieDetailProdiver )[widget.movieId];

    if (movie == null ){
      return const Center( child: CircularProgressIndicator( strokeWidth: 2,),);
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie),
              childCount: 1
            )
          )
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    // final textStyles = Theme.of(context).textTheme;



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox( width: 10),
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( movie.title, style: const TextStyle( fontSize: 25, fontWeight: FontWeight.bold)),
                    // const SizedBox(height: 10),
                    // Padding(
                    //   padding: const EdgeInsets.all(8),
                    //   child: Wrap(
                    //     children: [
                    //       ...movie.genreIds.map((gender) => Container(
                    //         margin: const EdgeInsets.only(right: 10),
                    //         child: Chip(
                    //           label: Text(gender),
                    //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    //         ),
                    //       ))
                    //     ],
                    //   ),
                    // ),
                    // CircularPercentIndicator(
                    //   radius: 20,
                    //   lineWidth: 3.0,
                    //   percent: movie.voteAverage / 10,
                    //   center: Text(
                    //     "${(movie.voteAverage * 10).toStringAsFixed(0)}%",
                    //     style: const TextStyle(fontSize: 10),
                    //   ),
                    //   progressColor: Colors.green
                    // ),
                  ],

                  // Los generos de la película
                  
                ),
              )
            ],
          ),
        ),

        //Description
        Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text( 'Descripción', style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text( movie.overview),
              ],
            ),
          ),
        ),
        // Mostrar actores ListView

        // Mostrar actores ListView
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reparto', style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        _ActorsByMovie(movieId: movie.id.toString() ),
        const SizedBox(height: 50),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {

  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {

    final actorsByMovie = ref.watch( actorsByMovieProvider );

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator.adaptive(strokeWidth: 2);
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (BuildContext context, int index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // Cast Photos
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Cast names
                const SizedBox(height: 5),
                Text(actor.name, maxLines: 2, style:const TextStyle( fontSize: 15, fontWeight: FontWeight.bold),),
                Text(actor.character ?? '', 
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  color: Color.fromARGB(255, 2, 41, 73)
                ),
                ),
              ]
            ),
          );
        },
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomSliverAppBar({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      // shadowColor: Colors.red, // comentar si se ve mal 
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(
          children: [

            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black87
                    ]
                  )
                )
              ),
            ),

            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    // end: Alignment.bottomCenter,
                    stops: [0.0, 0.3],
                    colors: [
                      Colors.black87,
                      Colors.transparent
                    ]
                  )
                )
              ),
            )

          ],
        ),
      ),

    );
  }
}