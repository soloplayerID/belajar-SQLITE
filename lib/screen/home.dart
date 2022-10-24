// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:belajar_sqlite/screen/notes.dart';
import 'package:belajar_sqlite/screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:localstorage/localstorage.dart';

import '../src/resources/local_notif_service.dart';
import 'contoh.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalStorage storage = LocalStorage('register.json');
  final LocalStorage storageLogin = LocalStorage('islogin.json');
  late final NotificationService notificationService;

  @override
  void initState() {
    super.initState();
    // if (storage.getItem('data_regis') != null) {
    //   Map<String, dynamic> info = json.decode(storage.getItem('data_regis'));
    //   print(info);
    // };
    notificationService = NotificationService();
    listenToNotificationStream();
    notificationService.initializePlatformNotifications();
  }

  void listenToNotificationStream() =>
      notificationService.behaviorSubject.listen((payload) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MySecondScreen(payload: payload)));
        print('testttt');
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2EBE9),
      body: SafeArea(
        child: Column(
          children: [
            //app bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      //name
                      Text(
                        'Notes Deptech',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),

                  //Profile Picture
                  InkWell(
                    onTap: () async {
                      // storageLogin.setItem('isLogin', false);
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, '/', (Route<dynamic> route) => false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Profile()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: const Color(0XFF4CACBC),
                          borderRadius: BorderRadius.circular(12)),
                      child: const InkWell(
                          child: Icon(
                        Icons.person,
                        color: Colors.white,
                      )),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                height: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                  color: Color(0xffecedf2),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //card -> hhow do you feel?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: const Color(0XFFFAC213),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              //animation or picture
                              Container(
                                padding: const EdgeInsets.all(12),
                                height: 100,
                                width: 100,
                                child: Lottie.asset('assets/notes.json'),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              // how do you feel + get started button
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Selamat datang',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      'aplikasi notes, keperluan test deptech',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NoteScreen()),
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0XFF4CACBC),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          'buka note',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffF9F9F9),
                                              fontSize: 14),
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      //search bar
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //   child: Container(
                      //     padding: const EdgeInsets.all(8),
                      //     decoration: BoxDecoration(
                      //       color: const Color.fromARGB(255, 203, 204, 235),
                      //       borderRadius: BorderRadius.circular(12),
                      //     ),
                      //     child: const TextField(
                      //       decoration: InputDecoration(
                      //         prefixIcon: Icon(Icons.search),
                      //         border: InputBorder.none,
                      //         hintText: 'How can we help you?',
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
