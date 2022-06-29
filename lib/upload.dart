import 'package:flutter/material.dart';

class Upload extends StatelessWidget {
  const Upload({Key? key, this.userImage, this.setUserContent, this.addMyData})
      : super(key: key);
  final userImage;
  final setUserContent;
  final addMyData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('upload'),
        actions: [
          ElevatedButton(
            child: Text('upload'),
            onPressed: () {
              addMyData();
            },
          )
        ],
      ),
      body: Column(children: [
        SizedBox(height: 300,child: Image.file(userImage)), // Image.asset()과 비슷하지
        TextField(
          decoration: InputDecoration(label: Text(' content? ')),
          onChanged: (textFromField) {
            setUserContent(textFromField);
            print(textFromField);
          },
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        )
      ]),
    );
  }
}
