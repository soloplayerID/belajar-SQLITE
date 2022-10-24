import '../model/add_note_model.dart';

abstract class AddNoteState {
  void refreshData(AddNoteModel addNoteModel);
  void onSuccess(String success);
  void onError(String error);
}
