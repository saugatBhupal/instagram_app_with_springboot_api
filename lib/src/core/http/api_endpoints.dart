class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // For Andriod
  static const String baseUrl = "http://10.0.2.2:8080/";
  // For iOS
  // static const String baseUrl = "http://localhost:8080/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "$baseUrl/auth";
  static const String register = "$baseUrl/auth";

  // ====================== User Routes ======================
  static const String fetchUserByID = "$baseUrl/user/";
  static const String updateStatus = "$baseUrl/user/status/";
  static const String follow = "$baseUrl/user/follow/";
  static const String unfollow = "$baseUrl/user/unfollow/";
  static const String followers = "$baseUrl/user/followers/";
  static const String followings = "$baseUrl/user/unfollowers/";

  // ====================== Post Routes ======================
  static const String loadPosts = "$baseUrl/post";
  static const String getPost = "$baseUrl/post/";
  static const String forumPost = "$baseUrl/post/forum/";
  static const String userPost = "$baseUrl/post/user/";

  // ====================== Comment Routes ======================
  static const String getCommentById = "$baseUrl/comment/";
  static const String addComment = "$baseUrl/comment/new";
  static const String addReply = "$baseUrl/comment/reply";

  // ====================== Likes Routes ======================
  static const String likes = "$baseUrl/post/like";
  static const String likeComment = "$baseUrl/comment/like";
  static const String downvoteComment = "$baseUrl/comment/downvote";
}
