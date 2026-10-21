import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:lab/Screens/post_page.dart';
import 'package:lab/models/post.dart';
import 'package:lab/repositories/post_repository.dart';

void main() {
  test('Post model preserves JSON fields and copyWith values', () {
    const post = Post(id: 1, userId: 2, title: 'Title', body: 'Body');
    expect(Post.fromJson(post.toJson()).toJson(), post.toJson());
    expect(post.copyWith(title: 'Changed').body, 'Body');
  });

  test('Post repository maps GET, POST, PUT, and DELETE responses', () async {
    final repository = _mockPostRepository();

    expect((await repository.getPosts()).single.title, 'One');
    expect((await repository.getPostById(1)).id, 1);
    expect(
      (await repository.createPost(
        const Post(userId: 2, title: 'New', body: 'Created'),
      )).id,
      101,
    );
    expect(
      (await repository.updatePost(
        const Post(id: 1, userId: 2, title: 'Updated', body: 'First'),
      )).title,
      'Updated',
    );
    expect(await repository.deletePost(1), isTrue);
  });

  testWidgets('Post page uses a monochrome theme', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          postRepositoryProvider.overrideWithValue(_mockPostRepository()),
        ],
        child: const MaterialApp(home: PostPage()),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      tester.widget<AppBar>(find.byType(AppBar)).backgroundColor,
      Colors.black,
    );
    expect(
      tester
          .widget<FloatingActionButton>(find.byType(FloatingActionButton))
          .backgroundColor,
      Colors.black,
    );
    expect(find.text('One'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

PostRepository _mockPostRepository() {
  return PostRepository(
    client: MockClient((request) async {
      if (request.method == 'GET' && request.url.path == '/posts') {
        return http.Response(
          jsonEncode([
            {'id': 1, 'userId': 2, 'title': 'One', 'body': 'First'},
          ]),
          200,
        );
      }
      if (request.method == 'GET') {
        return http.Response(
          jsonEncode({'id': 1, 'userId': 2, 'title': 'One', 'body': 'First'}),
          200,
        );
      }
      if (request.method == 'POST') {
        return http.Response(
          jsonEncode({'id': 101, ...jsonDecode(request.body)}),
          201,
        );
      }
      if (request.method == 'PUT') {
        return http.Response(request.body, 200);
      }
      if (request.method == 'DELETE') {
        return http.Response('{}', 200);
      }
      return http.Response('Not found', 404);
    }),
  );
}
