import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grouping_message_example/model/data_message_model.dart';
import 'package:grouped_list/grouped_list.dart';

class ImagesGroup extends StatefulWidget {
  ImagesGroup({Key? key}) : super(key: key);

  @override
  State<ImagesGroup> createState() => _ImagesGroupState();
}

class _ImagesGroupState extends State<ImagesGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Group'),
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
                  if (dataMessageModel.dataMessage![i].attachment == 'image') {
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
                      return Image.network('${list[index]['body']}');
                    });
              }
            }),
      ),
    );
  }
}

//  return GroupedListView<DataMessage, dynamic>(
//                   elements: dataMessageModel.dataMessage!,
//                   groupBy: (e) => e.attachment,
//                   groupSeparatorBuilder: (dynamic groupByValue) => Text(groupByValue),
//                   itemBuilder: (context, DataMessage element) =>
//                       Text(element.attachment!),
//                 );

//  List<DataMessage> datamessage = dataMessageModel.dataMessage!;
//               final groups = groupBy(datamessage, (DataMessage e) {
//                 return print(e.attachment);
//               });
//               return GridView.count(
//                 crossAxisCount: 2,
//                 children: List.generate(dataMessageModel.dataMessage!.length,
//                     (index) {
//                   if (dataMessageModel.dataMessage![index].attachment !=
//                       'image') {
//                     return Container();
//                   }
//                   return Text(
//                       '${dataMessageModel.dataMessage![index].attachment}');
//                 }),
//               );
