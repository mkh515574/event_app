import 'app_assets.dart';

class EventAssets {
  static String getImage(String category, bool isDark) {
    switch (category) {
      case 'Birthday':
        return isDark ? AppAssets.birthdayEventDark : AppAssets.birthdayEventLight;
      case 'Meeting':
        return isDark ? AppAssets.meetingEventDark : AppAssets.meetingEventLight;
        case 'Sports':
        return isDark ? AppAssets.sportsEventDark : AppAssets.sportsEventLight;
        case 'Gaming':
        return isDark ? AppAssets.gamingEventDark : AppAssets.gamingEventLight;
        case 'WorkShop':
        return isDark ? AppAssets.workShopDark : AppAssets.workShopLight;
        case 'Eating':
        return isDark ? AppAssets.eatingEventDark : AppAssets.eatingEventLight;
        case 'Book Club':
        return isDark ? AppAssets.bookClubEventDark : AppAssets.bookClubEventLight;
        case 'Holiday':
        return isDark ? AppAssets.holidayEventDark : AppAssets.holidayEventLight;
        case 'Exhibition':
        return isDark ? AppAssets.exhibitionEventDark : AppAssets.exhibitionEventLight;

      default:
        return AppAssets.sportsEventLight;
    }
  }
}

