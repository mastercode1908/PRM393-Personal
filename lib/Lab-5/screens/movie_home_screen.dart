import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'movie_detail_screen.dart';

class MovieHomeScreen extends StatefulWidget {
  const MovieHomeScreen({super.key});

  @override
  State<MovieHomeScreen> createState() => _MovieHomeScreenState();
}

class _MovieHomeScreenState extends State<MovieHomeScreen> {
  // We keep a local list to handle filtering
  List<Movie> _displayedMovies = [];

  @override
  void initState() {
    super.initState();
    // Initialize with all sample movies
    _displayedMovies = sampleMovies;
  }

  // Handle Search Input
  void _filterMovies(String query) {
    setState(() {
      if (query.isEmpty) {
        _displayedMovies = sampleMovies;
      } else {
        _displayedMovies = sampleMovies
            .where((movie) =>
                movie.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterMovies,
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0), // Center text
              ),
            ),
          ),
          
          // Movie List
          Expanded(
            child: _displayedMovies.isEmpty
                ? const Center(child: Text('No movies found'))
                : ListView.builder(
                    itemCount: _displayedMovies.length,
                    itemBuilder: (context, index) {
                      final movie = _displayedMovies[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        child: ListTile(
                          // Hero widget for seamless transition of poster
                          leading: Hero(
                            tag: 'movie_poster_${movie.id}',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4.0),
                              child: Image.network(
                                movie.posterUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.movie, size: 50),
                              ),
                            ),
                          ),
                          title: Text(movie.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('Rating: ${movie.rating}'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () async {
                            // Navigate to detail screen
                            // Using await to catch any state changes (like favoriting) when returning
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(movie: movie),
                              ),
                            );
                            
                            // Rebuild to reflect any changes to the movie object (e.g. favorite toggle)
                            setState(() {}); 
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
