import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grouping_message_example/model/data_message_model.dart';
import 'package:chat_list/chat_list.dart';
import 'package:grouping_message_example/page/contacts_group.dart';
import 'package:grouping_message_example/page/document_group.dart';
import 'package:grouping_message_example/page/images_group.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grouping message example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  var groupMenu = ['Images', 'Contacts', 'Documents'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grouping message example',
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return groupMenu.map((e) {
                return PopupMenuItem(
                  child: Text(e),
                  value: e,
                );
              }).toList();
            },
            onSelected: (item) {
              switch (item) {
                case 'Images':
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ImagesGroup();
                  }));
                  break;
                case 'Contacts':
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ContactsGroup();
                  }));
                  break;
                case 'Documents':
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DocumentGroup();
                  }));
                  break;
              }
            },
          )
        ],
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString("assets/message_dataset.json"),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            final jsonData = json.decode(snapshot.data!);
            DataMessageModel dataMessageModel =
                DataMessageModel.fromJson(jsonData);

            // Ascending by timestamp
            dataMessageModel.dataMessage!
                .sort(((a, b) => a.timestamp!.compareTo(b.timestamp!)));

            return ListView.builder(
                itemCount: dataMessageModel.dataMessage!.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment:
                          (dataMessageModel.dataMessage![index].from == "B"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              (dataMessageModel.dataMessage![index].from == "B"
                                  ? Colors.grey.shade200
                                  : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: dataMessageModel
                                    .dataMessage![index].attachment ==
                                'image'
                            ? Image.network(
                                '${dataMessageModel.dataMessage![index].body}')
                            : Text(
                                '${dataMessageModel.dataMessage![index].body}',
                                style: TextStyle(fontSize: 15),
                              ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}

// Text(
// '${dataMessageModel.dataMessage![index].body}',
// style: TextStyle(fontSize: 15),
// )
// dataMessageModel.dataMessage![index].attachment != 'image' ? Text() : Image.network('${dataMessageModel.dataMessage![index].body!}')
// ChatList(children: [
//                       dataMessageModel.dataMessage![index].from == 'A'
//                           ? Message(
//                               ownerName:
//                                   dataMessageModel.dataMessage![index].from,
//                               content: dataMessageModel
//                                           .dataMessage![index].body ==
//                                       null
//                                   ? ''
//                                   : dataMessageModel.dataMessage![index].body!,
//                               ownerType: OwnerType.sender,
//                             )
//                           : Message(
//                               ownerName:
//                                   dataMessageModel.dataMessage![index].from,
//                               ownerType: OwnerType.receiver,
//                             ),
//                     ], scrollController: _scrollController),