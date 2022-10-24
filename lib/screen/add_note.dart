import 'dart:io';

import 'package:belajar_sqlite/src/model/add_note_model.dart';
import 'package:belajar_sqlite/src/presenter/add_note_presenter.dart';
import 'package:belajar_sqlite/src/state/add_note_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

import '../src/db/note_database.dart';
import '../src/model/note.dart';
import '../src/resources/local_notif_service.dart';
import 'contoh.dart';
import 'fragment/note/note_form.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage>
    implements AddNoteState {
  late AddNotePresenter _addNotePresenter;
  late AddNoteModel _addNoteModel;
  late final NotificationService notificationService;

  File? imageFile;

  _AddEditNotePageState() {
    _addNotePresenter = AddNotePresenter();
  }

  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;
  late String image;

  @override
  void initState() {
    super.initState();
    _addNotePresenter.view = this;
    notificationService = NotificationService();
    listenToNotificationStream();
    notificationService.initializePlatformNotifications();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
    image = widget.note?.image ?? '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  void listenToNotificationStream() =>
      notificationService.behaviorSubject.listen((payload) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MySecondScreen(payload: payload)));
      });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 39, 199, 124),
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            turnOn: isImportant,
            number: number,
            title: title,
            description: description,
            image: image,
            onChangedImportant: (isImportant) {
              setState(() => this.isImportant = isImportant);
              Fluttertoast.showToast(
                  msg: 'alarm akan berdering dalam 1 jam 🔔',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 15);
            },
            onChangedNumber: (number) => setState(() => this.number = number),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          InkWell(
              onTap: () async {
                try {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile == null) return;
                  //supaya tidak fotonya temporary
                  Directory appDirectory =
                      await getApplicationDocumentsDirectory();
                  final imageTemp = File(pickedFile.path);

// copy the file to a new path
                  String dir = path.dirname(pickedFile.path);
                  String newPath = path.join(dir, '$title.jpg');
                  File images = imageTemp.renameSync(newPath);
                  print(images);
                  File newImage =
                      await images.copy('${appDirectory.path}/$title.jpg');
                  setState(() {
                    image = newImage.path;
                  });
                } on PlatformException catch (e) {
                  print('Failed to pick image: $e');
                }
              },
              child: const Icon(
                Icons.attach_file,
                color: Colors.white,
              )),
          const SizedBox(
            width: 25,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: isFormValid ? null : Colors.grey.shade700,
            ),
            onPressed: addOrUpdateNote,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    switch (number) {
      case 0:
        if (isImportant) {
          final note = Note(
            title: title,
            isImportant: true,
            number: number,
            description: description,
            image: image,
            createdTime: DateTime.now(),
          );
          await NotesDatabase.instance.create(note);
          await notificationService.showScheduledLocalNotification(
              id: 1,
              title: title,
              body: description,
              payload: description,
              seconds: 10);
        }
        final note = Note(
          title: title,
          isImportant: true,
          number: number,
          description: description,
          image: image,
          createdTime: DateTime.now(),
        );
        await NotesDatabase.instance.create(note);
        break;

      case 1:
        final note = Note(
          title: title,
          isImportant: true,
          number: number,
          description: description,
          image: image,
          createdTime: DateTime.now(),
        );
        await NotesDatabase.instance.create(note);
        await notificationService.showScheduledLocalNotification(
            id: 1,
            title: title,
            body: description,
            payload: description,
            seconds: 20);
        break;

      case 2:
        final note = Note(
          title: title,
          isImportant: true,
          number: number,
          description: description,
          image: image,
          createdTime: DateTime.now(),
        );
        await NotesDatabase.instance.create(note);
        await notificationService.showScheduledLocalNotification(
            id: 1,
            title: title,
            body: description,
            payload: description,
            seconds: 30);
        break;
      default:
        print('default');
        final note = Note(
          title: title,
          isImportant: true,
          number: number,
          description: description,
          image: image,
          createdTime: DateTime.now(),
        );
        await NotesDatabase.instance.create(note);
        break;
    }
  }

  @override
  void onError(String error) {}

  @override
  void onSuccess(String success) {}

  @override
  void refreshData(AddNoteModel addNoteModel) {
    setState(() {
      _addNoteModel = addNoteModel;
    });
  }
}
