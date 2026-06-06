import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  // Toggle favorite state
  void _toggleFavorite() {
    setState(() {
      widget.movie.isFavorite = !widget.movie.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true, // Allow banner to go behind AppBar
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner: Stack with Image and Gradient
            Stack(
              children: [
                Hero(
                  tag: 'movie_poster_${widget.movie.id}',
                  child: Image.network(
                    widget.movie.posterUrl,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(height: 300, child: Center(child: Text('Image failed to load'))),
                  ),
                ),
                // Gradient overlay for better text visibility (if we put text over it)
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black54, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.movie.title,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            widget.movie.rating.toString(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Genres Display using Wrap and Chip
                  Wrap(
                    spacing: 8.0,
                    children: widget.movie.genres
                        .map((genre) => Chip(
                              label: Text(genre),
                              backgroundColor: Colors.blue.shade100,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),

                  // Action Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          widget.movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: widget.movie.isFavorite ? Colors.red : null,
                        ),
                        onPressed: _toggleFavorite,
                        tooltip: 'Favorite',
                      ),
                      IconButton(
                        icon: const Icon(Icons.star_border),
                        onPressed: () {
                          // Placeholder for rate action
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Rate button tapped!')),
                          );
                        },
                        tooltip: 'Rate',
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          // Placeholder for share action
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Share button tapped!')),
                          );
                        },
                        tooltip: 'Share',
                      ),
                    ],
                  ),
                  const Divider(),

                  // Overview Text
                  const Text(
                    'Overview',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.movie.overview,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 20),

                  // Trailer List
                  const Text(
                    'Trailers',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Use shrinkWrap: true so ListView.builder can be inside a ScrollView
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
                    itemCount: widget.movie.trailers.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ListTile(
                          leading: const Icon(Icons.play_circle_fill, color: Colors.redAccent),
                          title: Text(widget.movie.trailers[index]),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Playing ${widget.movie.trailers[index]}')),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
