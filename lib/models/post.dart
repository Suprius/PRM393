class Post {
  final int? id;
  final int userId;
  final String title;
  final String body;

  const Post({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  /// Chuyển đổi từ JSON (Map) sang đối tượng Post
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int?,
      userId: json['userId'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }

  /// Chuyển đổi đối tượng Post sang JSON (Map) để gửi lên API
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }

  /// Tạo bản sao với các thuộc tính thay đổi
  Post copyWith({int? id, int? userId, String? title, String? body}) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  @override
  String toString() => 'Post(id: $id, userId: $userId, title: $title)';
}
