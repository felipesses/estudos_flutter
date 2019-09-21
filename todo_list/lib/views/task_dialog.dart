import 'package:flutter/material.dart';
import 'package:todo_list/models/task.dart';

class TaskDialog extends StatefulWidget {
  final Task task;

  TaskDialog({this.task});

  @override
  _TaskDialogState createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Task _currentTask = Task();

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _currentTask = Task.fromMap(widget.task.toMap());
    }

    _titleController.text = _currentTask.title;
    _descriptionController.text = _currentTask.description;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.clear();
    _descriptionController.clear();
  }

  // alert dialog de add tarefa
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(10),
      title: Text(widget.task == null ? 'Nova tarefa' : 'Editar tarefas'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Título'),
            autofocus: true,
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Descrição'),
            maxLengthEnforced: false,
            maxLines: null,
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Salvar'),
          onPressed: () {
            _currentTask.title = _titleController.value.text;
            _currentTask.description = _descriptionController.text;

            Navigator.of(context).pop(_currentTask);
          },
        ),
      ],
    );
  }
}
