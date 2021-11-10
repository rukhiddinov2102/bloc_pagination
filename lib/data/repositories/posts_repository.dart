import 'package:bloc_pagination/data/models/post_model.dart';
import 'package:bloc_pagination/data/repositories/services/posts_service.dart';



class PostsRepository {
  final PostsService service;
  PostsRepository(this.service);

  Future<List<Post>> fetchPosts(int page) async {
    final posts = await service.fetchPosts(page);
    return posts.map((e) => Post.fromJson(e)).toList();
  }
}
