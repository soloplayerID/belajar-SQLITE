// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:localstorage/localstorage.dart';
import 'package:rxdart/rxdart.dart';

import '../db/note_database.dart';
import '../model/add_note_model.dart';
import '../model/note.dart';
import '../resources/local_notif_service.dart';
import '../state/add_note_state.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

abstract class AddNotePresenterAbstract {
  set view(AddNoteState view) {}
  void scheduledNotification(Note note, String title, desc, int number) {}
}

class AddNotePresenter implements AddNotePresenterAbstract {
  final AddNoteModel _addNoteModel = AddNoteModel();
  late AddNoteState _addNoteState;
  final LocalStorage storage = LocalStorage('register.json');
  final BehaviorSubject<String> behaviorSubject = BehaviorSubject();
  NotificationService? notificationService;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  @override
  set view(AddNoteState view) {
    _addNoteState = view;
    _addNoteState.refreshData(_addNoteModel);
  }

  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'channel id',
      'channel name',
      groupKey: 'com.example.flutter_push_notifications',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      color: Color(0xff2196f3),
    );

    IOSNotificationDetails iosNotificationDetails =
        const IOSNotificationDetails(
      threadIdentifier: "thread1",
    );

    final details = await _localNotifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      behaviorSubject.add(details.payload!);
    }

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);

    return platformChannelSpecifics;
  }

  @override
  void scheduledNotification(Note note, String title, desc, int number) async {
    _addNoteModel.isloading = true;
    _addNoteState.refreshData(_addNoteModel);
    try {
      print('test');
      final platformChannelSpecifics = await _notificationDetails();
      await _localNotifications.zonedSchedule(
        1,
        title,
        desc,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: number)),
        platformChannelSpecifics,
        payload: desc,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      );

      await NotesDatabase.instance.create(note);
      print('note Berhasil di buat');
    } catch (e) {
      print(e.toString());
      print('gagal');
    }

    _addNoteModel.isloading = false;
    _addNoteState.refreshData(_addNoteModel);
  }
}
