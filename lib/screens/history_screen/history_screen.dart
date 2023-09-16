import 'package:chat_bot/consts/firebase_consts.dart';
import 'package:chat_bot/controller/history_controller.dart';
import 'package:chat_bot/controller/message_repository.dart';
import 'package:chat_bot/models/messagemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  final userid;
  HistoryScreen({
    super.key,
    required this.userid,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());
    final merepo = Get.put(MessageRepository());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        elevation: 10,
        title: Text(
          "History",
        ),
      ),
      body: FutureBuilder(
        future: controller.getMessageData(id: widget.userid.toString()),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (c, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: StretchMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                merepo.deleteMessage(
                                  userid: widget.userid.toString(),
                                  messageid:
                                      snapshot.data![index].id.toString(),
                                );
                                setState(() {});
                              },
                              icon: Icons.delete,
                              backgroundColor: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.blue.withOpacity(0.1),
                              ),
                              child: ListTile(
                                iconColor: Colors.blue,
                                leading: Icon(Icons.message),
                                title: Column( 
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("User: ${snapshot.data![index].user}"),
                                    Text("Bot: ${snapshot.data![index].bot}"),
                                  ],
                                ),
                                // subtitle:
                                //     Text("Bot: ${snapshot.data![index].bot}"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text("No Data!"),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: Text("Something went Wrong"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
