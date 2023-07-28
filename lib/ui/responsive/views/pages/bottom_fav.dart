








import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/ui/route/route.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

class BottomFav extends StatefulWidget {
  BottomFav({super.key});

  @override
  State<BottomFav> createState() => _BottomFavState();
}

class _BottomFavState extends State<BottomFav> {
  final box = GetStorage();
  String? userEmail;

  @override
  void initState() {
     super.initState();
    userEmail = box.read('email');
    print(userEmail);
   
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder
      <QuerySnapshot<Map<String, dynamic>>>
      (
          stream: FirebaseFirestore.instance
              .collection('user\'s_favourite')
              .doc(userEmail)
              .collection('items')
              .snapshots(),
          builder: (context, snapshot) {

            if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              final docs = snapshot.data!.docs;
              if (docs.length == 0) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {


                return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (_, index) {
                      return Card(
                        child: ListTile(
                            title: Text(docs[index]['title']),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                docs[index]['img_url'][0],
                              ),
                            ),

                        trailing: IconButton(
                          onPressed: (){
                            FirebaseFirestore.instance
                            .collection('user\'s_favourite')
                            .doc(userEmail)
                            .collection('items')
                             .doc(docs[index].id)
                             .delete();
                            
                          }, 
                          icon: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red,
                            ),
                          ), 
                              
                     onTap: () {
                       var data = {
                         'title': docs[index]['title'],
                          'describtion': docs[index]['describtion'],
                          'prices': docs[index]['prices'],
                          'img_url': docs[index]['img_url'],
                          'document_id': docs[index].id,

                       };
                       Get.toNamed(details, arguments: data);

                     }  
                     
                     ,
                      ),
                      );
                    });
              }
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}




//  trailing: IconButton(
//                                 onPressed: () {
//                                   FirebaseFirestore.instance
//                                   .collection('user\'s_favourite')
//                                   .doc(userEmail)
//                                   .collection('items')
//                                   .doc(docs[index].id)
//                                   // .delete();