enum SubscriptionType { Classic, Silver, Gold, Platinum }

enum SubscriptionPeriod { Monthly, Annually, Quarterly, Weekly, Custom }

enum SubscriptionCategory {
  Entertainment,
  Productivity,
  Education,
  CloudStorage,
  Finance,
  HealthFitness,
  Gaming,
  NewsMedia,
  Utilities,
  Other,
}

class Subscriptions {
  final String title;
  final String imageUrl;
  final String? description;
  final double price;
  final DateTime startDate;
  final DateTime endDate;
  final SubscriptionType type;
  final SubscriptionPeriod period;
  final SubscriptionCategory category;
  final DateTime? customDate;

  Subscriptions({
    required this.title,
    required this.imageUrl,
    this.description,
    required this.price,
    required this.startDate,
    required this.type,
    required this.category,
    this.period = SubscriptionPeriod.Monthly,
    this.customDate,
  }) : endDate = calculateEndDate(startDate, period, customDate);

  static DateTime calculateEndDate(
    DateTime startDate,
    SubscriptionPeriod period,
    DateTime? customDate,
  ) {
    switch (period) {
      case SubscriptionPeriod.Monthly:
        return _addMonths(startDate, 1);
      case SubscriptionPeriod.Quarterly:
        return _addMonths(startDate, 3);
      case SubscriptionPeriod.Annually:
        return DateTime(startDate.year + 1, startDate.month, startDate.day);
      case SubscriptionPeriod.Weekly:
        return startDate.add(const Duration(days: 7));
      case SubscriptionPeriod.Custom:
        if (customDate == null) {
          throw ArgumentError(
            'customDate must be provided when period is Custom',
          );
        }
        return customDate;
    }
  }

  static DateTime _addMonths(DateTime date, int monthsToAdd) {
    int year = date.year + ((date.month + monthsToAdd - 1) ~/ 12);
    int month = (date.month + monthsToAdd - 1) % 12 + 1;
    int day = date.day;

    int lastDayOfMonth = DateTime(year, month + 1, 0).day;
    return DateTime(year, month, day > lastDayOfMonth ? lastDayOfMonth : day);
  }

  static final List<Subscriptions> dummySubs = [
    Subscriptions(
      title: "Spotify",
      imageUrl: "assets/images/spotify_logo.png",
      price: 5.99,
      description: "Music App",
      startDate: DateTime(2025, 6, 1),
      type: SubscriptionType.Gold,
      category: SubscriptionCategory.Entertainment,
      period: SubscriptionPeriod.Monthly,
    ),
    Subscriptions(
      title: "YouTube Premium",
      imageUrl: "assets/images/youtube_logo.png",
      price: 18.99,
      description: "Ad-free streaming",
      startDate: DateTime(2025, 5, 20),
      type: SubscriptionType.Gold,
      category: SubscriptionCategory.Entertainment,
      period: SubscriptionPeriod.Monthly,
    ),
    Subscriptions(
      title: "Netflix",
      imageUrl: "assets/images/netflix_logo.png",
      price: 149.99,
      description: "Streaming App",
      startDate: DateTime(2025, 1, 15),
      type: SubscriptionType.Platinum,
      category: SubscriptionCategory.Entertainment,
      period: SubscriptionPeriod.Annually,
    ),
  ];
}

extension SubscriptionUtils on Subscriptions {
  DateTime getNextBillingDate() {
    DateTime now = DateTime.now();
    DateTime next = startDate;

    while (next.isBefore(now)) {
      switch (period) {
        case SubscriptionPeriod.Monthly:
          next = Subscriptions._addMonths(next, 1);
          break;
        case SubscriptionPeriod.Quarterly:
          next = Subscriptions._addMonths(next, 3);
          break;
        case SubscriptionPeriod.Annually:
          next = DateTime(next.year + 1, next.month, next.day);
          break;
        case SubscriptionPeriod.Weekly:
          next = next.add(const Duration(days: 7));
          break;
        case SubscriptionPeriod.Custom:
          return customDate!;
      }
    }

    return next;
  }
}
