import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab/models/post.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  final http.Client _client;
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  PostRepository({http.Client? client}) : _client = client ?? http.Client();

  /// 1. Lấy danh sách tất cả các bài viết (GET /posts)
  Future<List<Post>> getPosts() async {
    final response = await _client.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList
          .map((item) => Post.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Lỗi khi tải danh sách posts: ${response.statusCode}');
    }
  }

  /// 2. Lấy chi tiết 1 bài viết theo ID (GET /posts/{id})
  Future<Post> getPostById(int id) async {
    final response = await _client.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Post.fromJson(jsonMap);
    } else {
      throw Exception('Không tìm thấy post với id $id: ${response.statusCode}');
    }
  }

  /// 3. Lấy danh sách bài viết theo userId (GET /posts?userId={userId})
  Future<List<Post>> getPostsByUserId(int userId) async {
    final url = Uri.parse('$_baseUrl?userId=$userId');
    final response = await _client.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList
          .map((item) => Post.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Lỗi khi tải posts của user $userId: ${response.statusCode}',
      );
    }
  }

  /// 4. Tạo bài viết mới (POST /posts)
  Future<Post> createPost(Post post) async {
    final response = await _client.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> jsonMap =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Post.fromJson(jsonMap);
    } else {
      throw Exception('Lỗi khi tạo post mới: ${response.statusCode}');
    }
  }

  /// 5. Cập nhật bài viết (PUT /posts/{id})
  Future<Post> updatePost(Post post) async {
    if (post.id == null) {
      throw ArgumentError('Post id không được để trống khi cập nhật');
    }

    final response = await _client.put(
      Uri.parse('$_baseUrl/${post.id}'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap =
          jsonDecode(response.body) as Map<String, dynamic>;
      return Post.fromJson(jsonMap);
    } else {
      throw Exception(
        'Lỗi khi cập nhật post ${post.id}: ${response.statusCode}',
      );
    }
  }

  /// 6. Xóa bài viết (DELETE /posts/{id})
  Future<bool> deletePost(int id) async {
    final response = await _client.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Lỗi khi xóa post $id: ${response.statusCode}');
    }
  }
}

/// Riverpod Provider để tái sử dụng PostRepository trong toàn ứng dụng
final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository();
});
