import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/models.dart';
import 'package:todo/services/repository.dart';

class EditTodo extends StatefulWidget {
  final TodoModel todo;
  EditTodo({Key key, this.todo}) : super(key: key);

  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  final Repository _repository = Repository();
  final format = DateFormat("dd-MM-yyyy HH:mm");
  bool showDateTimeFiled = false;

  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _descriptionCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleCtrl.text = widget.todo.title;
    _descriptionCtrl.text = widget.todo.description;
  }

  void _updateTitle() {
    widget.todo.title = _titleCtrl.text;
  }

  void _updateDescription() {
    widget.todo.description = _descriptionCtrl.text;
  }

  void _updatePriority(String priority) {
    if (priority == 'Low') {
      widget.todo.priority = 0;
    } else if (priority == 'Medium') {
      widget.todo.priority = 1;
    } else if (priority == 'High') {
      widget.todo.priority = 2;
    }
  }

  void _updateDateTime(DateTime date, TimeOfDay time) {
    if (date != null && time != null) {
      widget.todo.deadline = DateTimeField.combine(date, time);
    }
  }

  Widget _buildTitleTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Title'),
        SizedBox(height: 5),
        TextField(
          keyboardType: TextInputType.text,
          controller: _titleCtrl,
          onChanged: (value) => _updateTitle(),
          decoration: InputDecoration(
            hintText: 'What you want to do?',
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Description'),
        SizedBox(height: 5),
        TextField(
          keyboardType: TextInputType.multiline,
          controller: _descriptionCtrl,
          onChanged: (value) => _updateDescription(),
          decoration: InputDecoration(
            hintText: 'Details of what you want to do',
          ),
        ),
      ],
    );
  }

  Widget _dropDownPriority() {
    String priority = 'Low';
    if (widget.todo.priority == 0) {
      priority = 'Low';
    } else if (widget.todo.priority == 1) {
      priority = 'Medium';
    } else if (widget.todo.priority == 2) {
      priority = 'High';
    }

    return DropdownButton(
      hint: Text('$priority Priority'),
      items: <String>['Low', 'Medium', 'High'].map((String priority) {
        return DropdownMenuItem<String>(
          value: priority,
          child: FlatButton(
            onPressed: () {
              _updatePriority(priority);
              print('$priority is choosed');
            },
            child: Text('$priority'),
          ),
        );
      }).toList(),
      onChanged: (_) {},
    );
  }

  Widget _submitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 90, vertical: 10),
      color: Colors.green,
      child: FlatButton(
        onPressed: () {
          _repository.editTodo(widget.todo.id, widget.todo);
          print('Edit todo btn pressed');
          Navigator.pushReplacementNamed(context, '/');
        },
        child: Text('Edit'),
      ),
    );
  }

  Widget _dateTimePicker() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DateTimeField(
          format: format,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              _updateDateTime(date, time);
              setState(() {
                showDateTimeFiled = false;
              });
              return DateTimeField.combine(date, time);
            } else {
              setState(() {
                showDateTimeFiled = false;
              });
              return currentValue;
            }
          },
        ),
      ],
    );
  }

  Widget _showDateTimeFieldBtn() {
    return FlatButton(
      onPressed: () {
        setState(() {
          showDateTimeFiled = true;
        });
      },
      child: Text('Select Deadline'),
    );
  }

  Widget _buildDateTimeField() {
    if (showDateTimeFiled) {
      return _dateTimePicker();
    }
    return _showDateTimeFieldBtn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/');
          },
        ),
        title: Text('Add Todo'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: <Widget>[
            _buildTitleTF(),
            Divider(height: 10),
            _buildDescriptionTF(),
            Divider(height: 10),
            _dropDownPriority(),
            Divider(height: 10),
            _buildDateTimeField(),
            Divider(height: 10),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            _submitBtn()
          ],
        ),
      ),
    );
  }
}
