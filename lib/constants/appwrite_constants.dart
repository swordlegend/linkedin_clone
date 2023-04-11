class AppwriteConstants {
  // static const String databaseId = '640992f30bcfe0cf8af7';
  static const String databaseId = '6435d0daba8851e426f1';
  // static const String projectId = '640991b1cad129e5eb08';
  static const String projectId = '6435cfe5498c80983bcf';
  // static const String endPoint = 'http://localhost:80/v1';
  static const String endPoint = 'https://cloud.appwrite.io/v1';
  // static const String endPoint = 'http://192.168.14.71:80/v1';
  // static const String endPoint = 'http://192.168.217.194:80/v1';

  // static const String usersCollection = '640993094ddf196ac2a0';
  static const String usersCollection = '6435d119cd3b02d56f2a';
  // static const String postCollection = '6409931ce47c1289ba8e';
  static const String postCollection = '6435d1246819cfdd8e83';
  // static const String notificationsCollection = '640f4c9fda16b3a96192';
  static const String notificationsCollection = '6435d1406ff419c08df5';
  // static const String jobsCollection = '64106ffac99f2d699da0';
  static const String jobsCollection = '6435d12d225e063e1e54';

  // static const String imageBucket = '64099366f01915e2f5cd';
  static const String imageBucket = '6435d4d5d172abeb9cd0';
  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imageBucket/files/$imageId/view?project=$projectId&mode=admin';
}
