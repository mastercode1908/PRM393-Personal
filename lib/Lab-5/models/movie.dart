class Movie {
  final String id;
  final String title;
  final String posterUrl;
  final String overview;
  final List<String> genres;
  final double rating;
  final List<String> trailers;
  bool isFavorite; // Optional toggle property

  Movie({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.overview,
    required this.genres,
    required this.rating,
    required this.trailers,
    this.isFavorite = false,
  });
}

// Static sample data to be used in the app
final List<Movie> sampleMovies = [
  Movie(
    id: '1',
    title: 'Inception',
    posterUrl:
        'https://nhamoi.net/wp-content/uploads/2026/05/gai-xinh-viet-nam-10-1.jpg', // Fallback flutter logo for demo if real image fails
    overview:
        'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
    genres: ['Action', 'Sci-Fi', 'Thriller'],
    rating: 8.8,
    trailers: ['Trailer 1: Official Teaser', 'Trailer 2: Final Trailer'],
  ),
  Movie(
    id: '2',
    title: 'The Dark Knight',
    posterUrl:
        'https://storage.googleapis.com/cms-storage-bucket/0dbfcc7a59cd1cf16282.png',
    overview:
        'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
    genres: ['Action', 'Crime', 'Drama'],
    rating: 9.0,
    trailers: ['Trailer 1: IMAX Teaser', 'Trailer 2: Theatrical Trailer'],
  ),
  Movie(
    id: '3',
    title: 'Interstellar',
    posterUrl:
        'https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png',
    overview:
        'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
    genres: ['Adventure', 'Drama', 'Sci-Fi'],
    rating: 8.6,
    trailers: [
      'Trailer 1: Official Teaser',
      'Trailer 2: Main Trailer',
      'Featurette: Behind the Scenes',
    ],
  ),
];
