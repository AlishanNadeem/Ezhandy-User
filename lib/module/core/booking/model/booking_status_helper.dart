import 'package:ezhandy_user/utils/app_strings.dart';

class BookingStatusHelper {
  static const int pending = 1;
  static const int rejected = 2;
  static const int assigned = 3;
  static const int inRoute = 4;
  static const int started = 5;
  static const int completed = 6;
  static const int userVerifiedIsDone = 7;
  static const int cancelled = 8;

  static bool isCompleted(int status) =>
      status == completed || status == userVerifiedIsDone;

  static String labelFromApi(int status, {required bool isPaid}) {
    switch (status) {
      case pending:
        return AppStrings.pending;
      case rejected:
        return AppStrings.rejected;
      case assigned:
        return AppStrings.assigned;
      case inRoute:
        return AppStrings.inRoute;
      case started:
        return AppStrings.started;
      case completed:
        return AppStrings.completed;
      case userVerifiedIsDone:
        return isPaid ? AppStrings.completedPaid : AppStrings.completedUnPaid;
      case cancelled:
        return AppStrings.cancelled;
      default:
        return '${AppStrings.status} $status';
    }
  }
}
