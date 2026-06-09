import 'package:ezhandy_user/utils/api_enums.dart';

class ServiceRoutingArgument {
  String? serviceName;
  String? type;
  /// Service type id from `/service-type/types` (e.g. Cleaning id).
  int? serviceId;

  /// Freelancer / provider user id (UUID) from `user/freelancers/{id}` list.
  String? providerId;

  /// Provider-service row id for `favourites/services/{id}` (from `providerServices[].id`).
  String? providerServiceId;

  /// Passed to `/service-type/types?isQuick=` (instant booking vs scheduled).
  bool? isQuick;

  /// Full provider-service payload from `GET provider/{id}`.
  Map<String, dynamic>? service;

  /// Selected booking date (schedule flow).
  DateTime? selectedDate;

  /// Selected time slot (schedule flow).
  TimeSlotEnum? selectedTimeSlot;

  /// Selected duration in minutes (service selection flow).
  int? durationMinutes;

  ServiceRoutingArgument({
    this.serviceName,
    this.type,
    this.serviceId,
    this.providerId,
    this.providerServiceId,
    this.isQuick,
    this.service,
    this.selectedDate,
    this.selectedTimeSlot,
    this.durationMinutes,
  });
}
