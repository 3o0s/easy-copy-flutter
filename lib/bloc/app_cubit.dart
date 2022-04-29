import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easycopy/bloc/app_states.dart';
import 'package:easycopy/shared/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());
  static AppCubit appCubit(BuildContext context) =>
      BlocProvider.of<AppCubit>(context);
  TextEditingController textcontroller = TextEditingController(text: '');

//firebase
  List<String> list = [];
  List<String> idList = [];

  CollectionReference<Map<String, dynamic>> instance =
      FirebaseFirestore.instance.collection('messages');
  void getMessages() async {
    emit(MessagesLoading());
    list.clear();
    instance.get().then((value) {
      for (var element in value.docs) {
        list.add(element['text']);
        idList.add(element.id);
      }
      emit(MessagesRefreshed());
    });
  }

  void removeAll() {
    for (String id in idList) {
      instance.doc(id).delete().then((value) {
        emit(RemovedState());
      });
    }
    idList.clear();
    list.clear();
  }

  void remove({required int index, required BuildContext context}) async {
    instance.doc(idList[index]).delete().then((value) {
      list.removeAt(index);
      showSnack(context: context, message: 'Deleted');
      emit(RemovedState());
    });
  }

  void send() async {
    if (textcontroller.text != '') {
      instance.doc().set({
        'text': textcontroller.text,
        'index': list.length,
      }).then((value) {
        list.add(textcontroller.text);
        textcontroller.clear();

        emit(SentState());
      });
    }
  }

  void launchUrl(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(
        url,
      );
    }
  }
}
