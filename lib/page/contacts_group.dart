import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grouping_message_example/model/data_message_model.dart';

class ContactsGroup extends StatefulWidget {
  ContactsGroup({Key? key}) : super(key: key);

  @override
  State<ContactsGroup> createState() => _ContactsGroupState();
}

class _ContactsGroupState extends State<ContactsGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Group'),
      ),
      body: Container(
        child: FutureBuilder<String>(
            future: DefaultAssetBundle.of(context)
                .loadString("assets/message_dataset.json"),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                final jsonData = json.decode(snapshot.data!);
                DataMessageModel dataMessageModel =
                    DataMessageModel.fromJson(jsonData);

                List<Map<String, dynamic>> list = [];
                for (int i = 0; i < dataMessageModel.dataMessage!.length; i++) {
                  if (dataMessageModel.dataMessage![i].attachment ==
                      'contact') {
                    list += [
                      {
                        "body": dataMessageModel.dataMessage![i].body,
                        "attachment":
                            dataMessageModel.dataMessage![i].attachment,
                      }
                    ];
                  }
                }
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Center(
                          child: Column(
                        children: [
                          Text('${list[index]['body']}'),
                          SizedBox(
                            height: 20.0,
                          )
                        ],
                      ));
                    });
              }
            }),
      ),
    );
  }
}
