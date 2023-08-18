class AppwriteConstants {
  static const String databaseId = '642b388063d96bbf9148';
  static const String projectId = '642b380bae81205b1fd1';
  static const String endPoint = 'http://localhost:80/v1';

  static const String userCollection = '6431d10c8f3e4adcd254';
  static const String tweetsCollection = '6453d655583c4e2c8d35';
  static const String notificationsCollection = '646ba492c36598c9a58a';

  static const String imagesBucket = '6453e06702d174eb5d1e';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
