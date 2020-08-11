import 'package:flutter/material.dart';

import '../../../models/course.dart';

class Essentials extends StatefulWidget {

  final GlobalKey<FormState> _key;
  final Course _course;

  Essentials(this._key, this._course);

  @override
  _EssentialsState createState() => _EssentialsState();
}

class _EssentialsState extends State<Essentials> {
  final _nickNode = FocusNode();

  final _idNode = FocusNode();

  final _icNode = FocusNode();

  final _unitsNode = FocusNode();

  @override
  void dispose() { 
    _nickNode.dispose();
    _idNode.dispose();
    _icNode.dispose();
    _unitsNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: widget._key,
          child: Column(
            children: [
              Text(
                'Essentials',
                style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.black,
                ),
              ),
              Divider(),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_nickNode),
                onSaved: (val) {
                  widget._course.name = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nick',
                  hintText: 'Short for Time Table',
                ),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                ),
                textInputAction: TextInputAction.next,
                focusNode: _nickNode,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_idNode),
                onSaved: (val) {
                  widget._course.nick = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'ID',
                  hintText: 'Should be unique',
                ),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                ),
                textInputAction: TextInputAction.next,
                focusNode: _idNode,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_icNode),
                onSaved: (val) {
                  widget._course.id = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'IC',
                ),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                ),
                textInputAction: TextInputAction.next,
                focusNode: _icNode,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_unitsNode),
                onSaved: (val) {
                  widget._course.ic = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Units',
                ),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Colors.black,
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                focusNode: _unitsNode,
                onFieldSubmitted: (_) => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
                onSaved: (val) {
                  widget._course.units = int.parse(val);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
