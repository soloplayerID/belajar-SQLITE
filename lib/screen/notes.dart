import 'package:belajar_sqlite/screen/fragment/loading.dart';
import 'package:belajar_sqlite/src/model/note_model.dart';
import 'package:belajar_sqlite/src/presenter/note_presenter.dart';
import 'package:belajar_sqlite/src/resources/local_notif_service.dart';
import 'package:belajar_sqlite/src/state/note_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../src/db/note_database.dart';
import '../src/model/note.dart';
import 'add_note.dart';
import 'contoh.dart';
import 'fragment/note/note_card.dart';
import 'note_detail.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> implements NoteState {
  late NotePresenter _notePresenter;
  late NoteModel _noteModel;
  late final NotificationService notificationService;

  List<Note>? notes;
  bool isLoading = false;

  _NoteScreenState() {
    _notePresenter = NotePresenter();
  }

  @override
  void initState() {
    super.initState();
    _notePresenter.view = this;
    notificationService = NotificationService();
    listenToNotificationStream();
    notificationService.initializePlatformNotifications();

    refreshNotes();
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
  void dispose() {
    super.dispose();
    NotesDatabase.instance.close();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _noteModel.isloading
          ? const Loading()
          : SafeArea(
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : notes!.isEmpty
                        ? const Text(
                            'No Notes',
                            style: TextStyle(color: Colors.grey, fontSize: 24),
                          )
                        : buildNotes(),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddEditNotePage()),
          );

          refreshNotes();
        },
      ),
    );
  }

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes!.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes![index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );

  @override
  void onError(String error) {}

  @override
  void onSuccess(String success) {}

  @override
  void refreshData(NoteModel noteModel) {
    setState(() {
      _noteModel = noteModel;
    });
  }
}
