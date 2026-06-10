class PastWorkRoutingArgument {
  final String? providerId;

  /// Provider-service row id for `bookings/past-work/.../service/{serviceId}`.
  final String? serviceId;

  PastWorkRoutingArgument({
    this.providerId,
    this.serviceId,
  });
}
