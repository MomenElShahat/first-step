import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherService extends GetxService {
  static PusherService get to => Get.find();

  late final PusherChannelsFlutter _pusher;
  final _channels = <String>{};
  final _listeners = <String, Map<String, Function(dynamic data)>>{};
  final _subscriptions = <_PusherSubscription>[];

  Future<PusherService> init() async {
    _pusher = PusherChannelsFlutter.getInstance();

    await _pusher.init(
      apiKey: "d96caeb137f6e3295d24",
      cluster: "ap2",
      onSubscriptionSucceeded: (channelName, data) {
        print("✅ Subscribed to $channelName");
      },
      onConnectionStateChange: (currentState, previousState) {
        print("🔁 Connection: $previousState → $currentState");
      },
      onEvent: (event) {
        final channel = event.channelName;
        final eventName = event.eventName;
        final data = event.data;

        if (channel != null && eventName != null) {
          final eventMap = _listeners[channel];
          final handler = eventMap?[eventName];
          if (handler != null) {
            handler(data);
          }
          print("event.eventName ${event.eventName}");
        }
      },
      onError: (message, code, e) {
        print("❌ Pusher error: $message | code: $code");
      },
    );

    await _pusher.connect();
    return this;
  }

  Future<void> subscribe({
    required String channelName,
    required String eventName,
    required Function(dynamic data) onEvent,
  }) async {
    if (!_channels.contains(channelName)) {
      await _pusher.subscribe(channelName: channelName);
      _channels.add(channelName);
    }

    _listeners[channelName] ??= {};
    _listeners[channelName]![eventName] = onEvent;

    _subscriptions.add(_PusherSubscription(
      channelName: channelName,
      eventName: eventName,
      callback: onEvent,
    ));
  }

  Future<void> reconnectAll() async {
    print("🔄 Reconnecting all subscriptions...");
    for (var sub in _subscriptions) {
      await subscribe(
        channelName: sub.channelName,
        eventName: sub.eventName,
        onEvent: sub.callback,
      );
    }
  }

  Future<void> unsubscribe(String channelName) async {
    if (_channels.contains(channelName)) {
      await _pusher.unsubscribe(channelName: channelName);
      _channels.remove(channelName);
      _listeners.remove(channelName);
    }

    _subscriptions.removeWhere((sub) => sub.channelName == channelName);
  }

  Future<void> disconnect() async {
    await _pusher.disconnect();
    _channels.clear();
    _listeners.clear();
    _subscriptions.clear();
  }
}

class _PusherSubscription {
  final String channelName;
  final String eventName;
  final Function(dynamic data) callback;

  _PusherSubscription({
    required this.channelName,
    required this.eventName,
    required this.callback,
  });
}
