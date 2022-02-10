import 'dart:async';
import 'dart:convert';

import 'serialization_util.dart';
import '../backend.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../splash_screen_welcome/splash_screen_welcome_widget.dart';
import '../../splash_screen_login/splash_screen_login_widget.dart';
import '../../post_details/post_details_widget.dart';
import '../../post_create/post_create_widget.dart';
import '../../event_details/event_details_widget.dart';
import '../../create_event/create_event_widget.dart';
import '../../messge_details/messge_details_widget.dart';
import '../../guest_list/guest_list_widget.dart';
import '../../transportation_page/transportation_page_widget.dart';
import '../../ceremony_program/ceremony_program_widget.dart';
import '../../our_story/our_story_widget.dart';
import '../../wedding_party/wedding_party_widget.dart';
import '../../main_map/main_map_widget.dart';
import '../../create_event_page/create_event_page_widget.dart';

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler(
      {Key key, this.handlePushNotification, this.child})
      : super(key: key);

  final Function(BuildContext) handlePushNotification;
  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    setState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final pageBuilder = pageBuilderMap[initialPageName];
      if (pageBuilder != null) {
        final page = await pageBuilder(initialParameterData);
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    handleOpenedPushNotification();
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Colors.transparent,
          child: Builder(
            builder: (context) => Image.asset(
              'assets/images/caleb-de-marco-iovfeiUiMjo-unsplash.jpg',
              fit: BoxFit.cover,
            ),
          ),
        )
      : widget.child;
}

final pageBuilderMap = <String, Future<Widget> Function(Map<String, dynamic>)>{
  'splashScreenWelcome': (data) async => SplashScreenWelcomeWidget(),
  'splashScreenLogin': (data) async => SplashScreenLoginWidget(),
  'socialFeed': (data) async => NavBarPage(initialPage: 'SocialFeedWidget'),
  'postDetails': (data) async => PostDetailsWidget(
        postDetails: await getDocumentParameter(
            data, 'postDetails', SocialPostsRecord.serializer),
      ),
  'postCreate': (data) async => PostCreateWidget(),
  'eventsPage': (data) async => NavBarPage(initialPage: 'EventsPageWidget'),
  'eventDetails': (data) async => EventDetailsWidget(
        eventDetails: await getDocumentParameter(
            data, 'eventDetails', EventsRecord.serializer),
      ),
  'createEvent': (data) async => CreateEventWidget(),
  'messagesPage': (data) async => NavBarPage(initialPage: 'MessagesPageWidget'),
  'messgeDetails': (data) async => MessgeDetailsWidget(
        chatUser: await getDocumentParameter(
            data, 'chatUser', GuestsRecord.serializer),
        chatRef: getParameter(data, 'chatRef'),
      ),
  'guestList': (data) async => GuestListWidget(),
  'transportationPage': (data) async => TransportationPageWidget(),
  'ceremonyProgram': (data) async => CeremonyProgramWidget(),
  'ourStory': (data) async => OurStoryWidget(),
  'weddingParty': (data) async => WeddingPartyWidget(),
  'profilePage': (data) async => NavBarPage(initialPage: 'ProfilePageWidget'),
  'MainMap': (data) async => MainMapWidget(
        city: await getDocumentParameter(data, 'city', CityRecord.serializer),
      ),
  'createEventPage': (data) async => CreateEventPageWidget(),
};

bool hasMatchingParameters(Map<String, dynamic> data, Set<String> params) =>
    params.any((param) => getParameter(data, param) != null);

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
