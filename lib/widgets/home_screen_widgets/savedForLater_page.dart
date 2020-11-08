import 'package:flutter/material.dart';

class SavedForLater extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => ListTile(
        title: Text('data'),
      ),
      itemCount: 10,
    );
  }
}
