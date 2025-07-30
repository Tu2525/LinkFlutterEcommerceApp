class Review {
  final String author;
  final String avatarUrl;
  final double rating;
  final String comment;
  final String date;

  Review({
    required this.author,
    required this.avatarUrl,
    required this.rating,
    required this.comment,
    required this.date,
  });

  // Factory to create a Review from a JSON object
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['author'] ?? 'Unknown Author',
      avatarUrl: json['avatarUrl'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      comment: json['comment'] ?? '',
      date: json['date'] ?? '',
    );
  }

  // Method to convert a Review instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'avatarUrl': avatarUrl,
      'rating': rating,
      'comment': comment,
      'date': date,
    };
  }
}