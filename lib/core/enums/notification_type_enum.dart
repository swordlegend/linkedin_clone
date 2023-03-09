enum NotificationType {
  like('like'),
  reply('reply'),
  connect('connect'),
  reshare('reshare');

  final String type;
  const NotificationType(this.type);
}

extension ConvertTweet on String {
  NotificationType toNotificationTypeEnum() {
    switch (this) {
      case 'reshare':
        return NotificationType.reshare;
      case 'connect':
        return NotificationType.connect;
      case 'reply':
        return NotificationType.reply;
      default:
        return NotificationType.like;
    }
  }
}