enum NotificationType {
  like('like'),
  reply('reply'),
  follow('follow'),
  retweet('retweet');

  final String type;
  const NotificationType(this.type);
}

extension ConvertTweet on String {
  NotificationType toNotificationTypeEnum() {
    switch (this) {
      case 'text':
        return NotificationType.retweet;
      case 'image':
        return NotificationType.follow;
      case 'reply':
        return NotificationType.reply;
      default:
        return NotificationType.like;
    }
  }
}
