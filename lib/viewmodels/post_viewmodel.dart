import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lab/models/post.dart';
import 'package:lab/repositories/post_repository.dart';

/// ViewModel quản lý trạng thái của Posts sử dụng Riverpod AsyncNotifier
/// Tự động quản lý các trạng thái: Loading, Data, Error
class PostViewModel extends AsyncNotifier<List<Post>> {
  PostRepository get _repository => ref.read(postRepositoryProvider);

  @override
  Future<List<Post>> build() async {
    return await _repository.getPosts();
  }

  /// Tải lại danh sách (Pull-to-refresh)
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _repository.getPosts());
  }

  /// Thêm bài viết mới (POST)
  Future<Post> addPost({
    required String title,
    required String body,
    int userId = 1,
  }) async {
    final newPost = Post(userId: userId, title: title, body: body);

    // Gọi API
    final created = await _repository.createPost(newPost);

    // Cập nhật danh sách trên UI ngay lập tức
    state = state.whenData((posts) => [created, ...posts]);
    return created;
  }

  /// Sửa bài viết (PUT)
  Future<void> editPost(Post updatedPost) async {
    // Với API JSONPlaceholder, chỉ các bài có sẵn (id <= 100) mới gọi PUT lên server
    if (updatedPost.id != null && updatedPost.id! <= 100) {
      await _repository.updatePost(updatedPost);
    }

    // Cập nhật trên UI
    state = state.whenData((posts) {
      return posts
          .map((p) => p.id == updatedPost.id ? updatedPost : p)
          .toList();
    });
  }

  /// Xóa bài viết (DELETE)
  Future<void> removePost(int id) async {
    // Với API JSONPlaceholder, chỉ các bài có sẵn (id <= 100) mới gọi DELETE lên server
    if (id <= 100) {
      await _repository.deletePost(id);
    }

    // Xóa khỏi UI
    state = state.whenData((posts) {
      return posts.where((p) => p.id != id).toList();
    });
  }
}

/// Provider của PostViewModel
final postViewModelProvider = AsyncNotifierProvider<PostViewModel, List<Post>>(
  () {
    return PostViewModel();
  },
);
