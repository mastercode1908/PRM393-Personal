import 'package:flutter/material.dart';
import '../models/movie.dart';

class ResponsiveGenreScreen extends StatefulWidget {
  const ResponsiveGenreScreen({super.key});

  @override
  State<ResponsiveGenreScreen> createState() => _ResponsiveGenreScreenState();
}

class _ResponsiveGenreScreenState extends State<ResponsiveGenreScreen> {
  // State variables for filtering and sorting
  String _searchQuery = '';
  final Set<String> _selectedGenres = {};
  String _selectedSort = 'A-Z';

  final List<String> _sortOptions = ['A-Z', 'Z-A', 'Year', 'Rating'];

  // Handle Search Input
  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  // Handle Genre Chip Toggle
  void _toggleGenre(String genre, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedGenres.add(genre);
      } else {
        _selectedGenres.remove(genre);
      }
    });
  }

  // Handle Sort Dropdown
  void _onSortChanged(String? newSort) {
    if (newSort != null) {
      setState(() {
        _selectedSort = newSort;
      });
    }
  }

  // Clear all filters
  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _selectedGenres.clear();
      _selectedSort = 'A-Z';
    });
  }

  // Filter and Sort movies
  List<Movie> get _visibleMovies {
    // 1. Filter by search query
    var filtered = allMovies.where((movie) {
      return movie.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // 2. Filter by selected genres (Movie must have at least one of the selected genres)
    if (_selectedGenres.isNotEmpty) {
      filtered = filtered.where((movie) {
        return movie.genres.any((genre) => _selectedGenres.contains(genre));
      }).toList();
    }

    // 3. Sort
    filtered.sort((a, b) {
      switch (_selectedSort) {
        case 'A-Z':
          return a.title.compareTo(b.title);
        case 'Z-A':
          return b.title.compareTo(a.title);
        case 'Year':
          return b.year.compareTo(a.year); // Newest first
        case 'Rating':
          return b.rating.compareTo(a.rating); // Highest first
        default:
          return 0;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final movies = _visibleMovies;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Find a Movie'),
        actions: [
          // Optional Bonus: Clear Filters Button
          TextButton(
            onPressed: _clearFilters,
            child: const Text('Clear', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // --- SEARCH BAR ---
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search movie by title...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),

            // --- GENRE CHIPS (Responsive Wrap) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Genres',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      // Optional Bonus: Badge showing number of selected genres
                      if (_selectedGenres.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${_selectedGenres.length}',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: availableGenres.map((genre) {
                      final isSelected = _selectedGenres.contains(genre);
                      return FilterChip(
                        label: Text(genre),
                        selected: isSelected,
                        onSelected: (selected) => _toggleGenre(genre, selected),
                        selectedColor: Colors.blue.shade200,
                        checkmarkColor: Colors.blue.shade900,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // --- SORT DROPDOWN ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sort by:', style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: _selectedSort,
                    items: _sortOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: _onSortChanged,
                  ),
                ],
              ),
            ),

            const Divider(),

            // --- RESPONSIVE MOVIE LIST (ListView / GridView) ---
            // We use Expanded so the list takes up remaining vertical space
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (movies.isEmpty) {
                    return const Center(child: Text('No movies found matching your criteria.'));
                  }

                  // Breakpoint for tablet/web
                  if (constraints.maxWidth >= 800) {
                    // Use GridView for wide screens
                    return GridView.builder(
                      padding: const EdgeInsets.all(12.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 columns
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        childAspectRatio: 2.5, // Adjust item height/width ratio
                      ),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return _buildMovieCard(movies[index], isGrid: true);
                      },
                    );
                  } else {
                    // Use ListView for phones / narrow screens
                    return ListView.builder(
                      padding: const EdgeInsets.all(12.0),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return _buildMovieCard(movies[index], isGrid: false);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Movie Card widget
  Widget _buildMovieCard(Movie movie, {required bool isGrid}) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: isGrid ? 0 : 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Poster (Using LayoutBuilder optionally to resize based on parent, 
          // or just fixed sizes for simplicity)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              bottomLeft: Radius.circular(4.0),
            ),
            child: Image.network(
              movie.posterUrl,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(width: 100, height: 150, color: Colors.grey.shade300, child: const Icon(Icons.movie)),
            ),
          ),
          
          // Movie Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie.year.toString(),
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  
                  // Optional Bonus: Star rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        movie.rating.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Spacer(),
                  
                  // Show at most 2 genres to fit nicely
                  Text(
                    movie.genres.join(', '),
                    style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
