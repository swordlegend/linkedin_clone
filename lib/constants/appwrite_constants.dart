class AppwriteConstants {
  static const String databaseId = '640992f30bcfe0cf8af7';
  static const String projectId = '640991b1cad129e5eb08';
  static const String endPoint = 'http://localhost:80/v1';
  // static const String endPoint = 'http://192.168.173.71:80/v1';
  // static const String endPoint = 'http://192.168.217.194:80/v1';

  static const String usersCollection = '640993094ddf196ac2a0';
  static const String postCollection = '6409931ce47c1289ba8e';
  static const String notificationsCollection = '640f4c9fda16b3a96192';

  static const String imageBucket = '64099366f01915e2f5cd';
  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imageBucket/files/$imageId/view?project=$projectId&mode=admin';
}
