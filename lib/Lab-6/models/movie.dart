class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

// Sample data for Lab 6
final List<Movie> allMovies = [
  Movie(
    title: 'Inception',
    year: 2010,
    genres: ['Action', 'Sci-Fi', 'Thriller'],
    posterUrl: 'https://images.unsplash.com/photo-1626814026160-2237a95fc5a0?w=300&auto=format&fit=crop', // Reliable placeholder image
    rating: 8.8,
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Crime', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1509347528160-9a9e33742cdb?w=300&auto=format&fit=crop',
    rating: 9.0,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Adventure', 'Drama', 'Sci-Fi'],
    posterUrl: 'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=300&auto=format&fit=crop',
    rating: 8.6,
  ),
  Movie(
    title: 'The Matrix',
    year: 1999,
    genres: ['Action', 'Sci-Fi'],
    posterUrl: 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=300&auto=format&fit=crop',
    rating: 8.7,
  ),
  Movie(
    title: 'Forrest Gump',
    year: 1994,
    genres: ['Drama', 'Romance'],
    posterUrl: 'https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?w=300&auto=format&fit=crop',
    rating: 8.8,
  ),
  Movie(
    title: 'Gladiator',
    year: 2000,
    genres: ['Action', 'Adventure', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1590518386478-f73602f30748?w=300&auto=format&fit=crop',
    rating: 8.5,
  ),
];

// Available genres for filtering
final List<String> availableGenres = [
  'Action',
  'Adventure',
  'Comedy',
  'Crime',
  'Drama',
  'Romance',
  'Sci-Fi',
  'Thriller',
];
