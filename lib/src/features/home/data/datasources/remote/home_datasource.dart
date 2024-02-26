import 'package:instagram/src/core/models/post/post_model.dart';

abstract class HomeDatasource {
  Future<List<PostModel>> loadPosts();
}
