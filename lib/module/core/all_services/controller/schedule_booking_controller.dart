import 'dart:convert';
import 'dart:developer' as developer;

import 'package:ezhandy_user/dio_client/dio_client.dart';
import 'package:ezhandy_user/module/core/all_services/model/provider_service_detail_model.dart';
import 'package:ezhandy_user/utils/api_enums.dart';
import 'package:ezhandy_user/utils/listeners.dart';
import 'package:ezhandy_user/utils/network_strings.dart';
import 'package:get/get.dart';

class ScheduleBookingController extends GetxController {
  ScheduleBookingController({required this.providerServiceId});

  final String providerServiceId;

  final RxBool isLoading = false.obs;
  final Rxn<ProviderServiceDetailModel> detail =
      Rxn<ProviderServiceDetailModel>();
  final Rxn<Map<String, dynamic>> servicePayload = Rxn<Map<String, dynamic>>();
  final RxList<DateTime> availableDates = <DateTime>[].obs;
  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final RxList<TimeSlotEnum> availableTimeSlots = <TimeSlotEnum>[].obs;
  final Rxn<TimeSlotEnum> selectedTimeSlot = Rxn<TimeSlotEnum>();

  final Map<String, List<TimeSlotEnum>> _slotsByDateKey = {};

  @override
  void onInit() {
    super.onInit();
    if (providerServiceId.isNotEmpty) {
      fetchProviderDetail();
    }
  }

  Future<void> fetchProviderDetail() async {
    if (providerServiceId.isEmpty) return;

    isLoading.value = true;

    final endpoint = NetworkStrings.providerServiceDetail(providerServiceId);
    developer.log('GET $endpoint', name: 'ScheduleBookingController');

    final response = await DioClient().getRequest(
      endPoint: endpoint,
      isHeaderRequire: true,
    );

    await DioClient().validateResponse(
      response: response,
      responseListener: CallbackResponseListener(
        onSuccessCallback: (r) {
          _logProviderDetailResponse(endpoint, r);
          final root = r is Map<String, dynamic>
              ? r
              : (r is Map ? Map<String, dynamic>.from(r) : null);
          final payload = _resolvePayload(
            root?['data'] is Map
                ? Map<String, dynamic>.from(root!['data'] as Map)
                : null,
            root,
          );

          if (payload.isNotEmpty) {
            servicePayload.value = Map<String, dynamic>.from(payload);
            detail.value = ProviderServiceDetailModel.fromJson(payload);
          } else {
            servicePayload.value = null;
            detail.value = null;
          }

          _applyAvailability(payload);
        },
        onFailureCallback: (r) {
          developer.log(
            'provider detail failed: $r',
            name: 'ScheduleBookingController',
          );
          detail.value = null;
          servicePayload.value = null;
          _clearAvailability();
        },
      ),
    );

    isLoading.value = false;
  }

  void setSelectedDate(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    if (selectedDate.value != null &&
        _dateKey(selectedDate.value!) == _dateKey(normalized)) {
      return;
    }
    selectedDate.value = normalized;
    _refreshTimeSlotsForSelectedDate();
  }

  Map<String, dynamic> _resolvePayload(
    Map<String, dynamic>? data,
    Map<String, dynamic>? root,
  ) {
    dynamic payload = data ?? root?['data'] ?? root;
    if (payload is String) {
      try {
        payload = jsonDecode(payload);
      } catch (_) {
        return {};
      }
    }
    if (payload is! Map) return {};
    var map = payload is Map<String, dynamic>
        ? payload
        : Map<String, dynamic>.from(payload);
    if (map['data'] is Map) {
      map = map['data'] is Map<String, dynamic>
          ? map['data'] as Map<String, dynamic>
          : Map<String, dynamic>.from(map['data'] as Map);
    }
    return map;
  }

  void _clearAvailability() {
    availableDates.clear();
    selectedDate.value = null;
    availableTimeSlots.clear();
    selectedTimeSlot.value = null;
    _slotsByDateKey.clear();
    servicePayload.value = null;
  }

  void _applyAvailability(Map<String, dynamic> payload) {
    _slotsByDateKey.clear();
    final dates = <DateTime>[];
    final seenDateKeys = <String>{};

    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    final globalSlots = _parseTimeSlotsList(
      payload['timeSlots'] ??
          payload['TimeSlots'] ??
          payload['time_slots'],
    );

    final calendar = payload['calendar'] ?? payload['Calendar'];
    _parseCalendarInto(
      calendar: calendar,
      dates: dates,
      seenDateKeys: seenDateKeys,
      today: today,
      globalSlots: globalSlots,
    );

    dates.sort((a, b) => a.compareTo(b));
    availableDates.assignAll(dates);

    if (dates.isEmpty) {
      availableTimeSlots.clear();
      selectedTimeSlot.value = null;
      return;
    }

    selectedDate.value = dates.first;
    _refreshTimeSlotsForSelectedDate(autoSelectFirst: true);
  }

  void _parseCalendarInto({
    required dynamic calendar,
    required List<DateTime> dates,
    required Set<String> seenDateKeys,
    required DateTime today,
    required List<TimeSlotEnum> globalSlots,
  }) {
    void addDateWithSlots(DateTime dt, List<TimeSlotEnum> daySlots) {
      final local = dt.toLocal();
      final normalized = DateTime(local.year, local.month, local.day);
      if (normalized.isBefore(today)) return;
      final key = _dateKey(normalized);
      if (!seenDateKeys.add(key)) return;
      dates.add(normalized);
      final slots = daySlots.isNotEmpty ? daySlots : globalSlots;
      if (slots.isNotEmpty) {
        _slotsByDateKey[key] = slots;
      }
    }

    if (calendar is List) {
      for (final item in calendar) {
        if (item is Map) {
          final m = item is Map<String, dynamic>
              ? item
              : Map<String, dynamic>.from(item);
          final dt = _parseDateFromMap(m);
          if (dt == null) continue;
          final daySlots = _parseTimeSlotsList(
            m['timeSlots'] ?? m['TimeSlots'] ?? m['time_slots'],
          );
          addDateWithSlots(dt, daySlots);
        } else {
          final dt = DateTime.tryParse(item.toString());
          if (dt != null) addDateWithSlots(dt, globalSlots);
        }
      }
      return;
    }

    if (calendar is Map) {
      final m = calendar is Map<String, dynamic>
          ? calendar
          : Map<String, dynamic>.from(calendar);

      final mapSlots = _parseTimeSlotsList(
        m['timeSlots'] ?? m['TimeSlots'] ?? m['time_slots'],
      );
      final slotsForNested = mapSlots.isNotEmpty ? mapSlots : globalSlots;

      final nested = m['dates'] ??
          m['availableDates'] ??
          m['days'] ??
          m['data'] ??
          m['items'];
      if (nested is List) {
        for (final item in nested) {
          if (item is Map) {
            final im = Map<String, dynamic>.from(item);
            final dt = _parseDateFromMap(im);
            if (dt == null) continue;
            final daySlots = _parseTimeSlotsList(
              im['timeSlots'] ?? im['TimeSlots'] ?? im['time_slots'],
            );
            addDateWithSlots(dt, daySlots);
          } else {
            final dt = DateTime.tryParse(item.toString());
            if (dt != null) addDateWithSlots(dt, slotsForNested);
          }
        }
      }
    }
  }

  void _refreshTimeSlotsForSelectedDate({bool autoSelectFirst = false}) {
    final d = selectedDate.value;
    if (d == null) {
      availableTimeSlots.clear();
      selectedTimeSlot.value = null;
      return;
    }
    final slots = List<TimeSlotEnum>.from(
      _slotsByDateKey[_dateKey(d)] ?? const [],
    );
    final previous = selectedTimeSlot.value;
    availableTimeSlots.assignAll(slots);

    if (slots.isEmpty) {
      selectedTimeSlot.value = null;
      return;
    }
    if (previous != null && slots.contains(previous)) {
      selectedTimeSlot.value = previous;
      return;
    }
    selectedTimeSlot.value = autoSelectFirst ? slots.first : null;
  }

  static String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static DateTime? _parseDateFromMap(Map<String, dynamic> m) {
    for (final key in [
      'date',
      'bookingDate',
      'availableDate',
      'day',
      'startDate',
    ]) {
      final dt = DateTime.tryParse(m[key]?.toString() ?? '');
      if (dt != null) {
        final local = dt.toLocal();
        return DateTime(local.year, local.month, local.day);
      }
    }
    return null;
  }

  List<TimeSlotEnum> _parseTimeSlotsList(dynamic raw) {
    if (raw is! List) return [];

    final slots = <TimeSlotEnum>[];
    final seen = <String>{};

    for (final item in raw) {
      final slot = _parseSlotItem(item);
      if (slot != null && seen.add(slot.apiValue)) {
        slots.add(slot);
      }
    }

    const order = [
      TimeSlotEnum.morning,
      TimeSlotEnum.afternoon,
      TimeSlotEnum.evening,
    ];
    slots.sort((a, b) => order.indexOf(a).compareTo(order.indexOf(b)));
    return slots;
  }

  TimeSlotEnum? _parseSlotItem(dynamic item) {
    if (item == null) return null;

    final fromApi = TimeSlotEnum.fromApiValue(item.toString());
    if (fromApi != null) return fromApi;

    final fromLabel = TimeSlotEnum.fromDisplayLabel(item.toString());
    if (fromLabel != null) return fromLabel;

    if (item is int) {
      switch (item) {
        case 1:
          return TimeSlotEnum.morning;
        case 2:
          return TimeSlotEnum.afternoon;
        case 3:
          return TimeSlotEnum.evening;
      }
    }
    return null;
  }

  void _logProviderDetailResponse(String endpoint, dynamic response) {
    try {
      final body = const JsonEncoder.withIndent('  ').convert(response);
      developer.log(
        'GET $endpoint — full response:\n$body',
        name: 'ScheduleBookingController',
      );
    } catch (_) {
      developer.log(
        'GET $endpoint — full response:\n$response',
        name: 'ScheduleBookingController',
      );
    }
  }
}
