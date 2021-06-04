import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_diary/diary_entry_model.dart';
import 'package:flutter_web_diary/diary_entry_page.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key key,
    this.diaryEntry,
  }) : super(key: key);
  final DiaryEntry diaryEntry;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Action>(
      elevation: 2,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: Action.edit,
            child: Text('Edit'),
          ),
          PopupMenuItem(
            value: Action.delete,
            child: Text('Delete'),
          ),
        ];
      },
      onSelected: (action) {
        switch (action) {
          case Action.delete:
            _showDeleteDialog(context, onDelete: () {
              FirebaseFirestore.instance
                  .collection('diaries')
                  .doc(diaryEntry.id)
                  .delete();
              Navigator.of(context).pop();
            });
            break;
          case Action.edit:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return DiaryEntryPage.edit(
                    diaryEntry: diaryEntry,
                  );
                },
              ),
            );
            break;

          default:
        }
      },
    );
  }
}

enum Action { delete, edit, none }

void _showDeleteDialog(BuildContext context, {Function onDelete}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete?'),
          content:
              Text('Deleted diary entries are permanent and not retrievable.'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.redAccent,
              ),
              onPressed: onDelete,
              child: Text('Delete'),
            )
          ],
        );
      });
}
