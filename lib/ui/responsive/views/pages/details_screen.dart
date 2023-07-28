import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:food_delivery/ui/style/app_style.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/custom_button.dart';
import 'bottom_card.dart';

class DetailsScreen extends StatefulWidget {
  var data;

  DetailsScreen({required this.data});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _controller = PageController();

  final box = GetStorage();
  String? userEmail;

  //add to fav
  addToFav() async {
    FirebaseFirestore.instance
        .collection('user\'s_favourite')
        .doc(userEmail)
        .collection('items')
        .doc()
        .set({
          'title': widget.data['title'],
          'describtion': widget.data['describtion'],
          'prices': widget.data['prices'],
          'img_url': widget.data['img_url'],
          'document_id': widget.data['document_id'],
        })
        .then((value) =>
            Get.showSnackbar(AppStyles().successSnackBar('Added to favourite')))
        .catchError((error) => Get.showSnackbar(
            AppStyles().failedSnackBar('Something is wrong $error')));
  }
     //cheack fav
  Stream<QuerySnapshot<Map<String, dynamic>>> checkFav() async* {
    yield* FirebaseFirestore.instance
        .collection('user\'s_favourite')
        .doc(userEmail)
        .collection('items')
        .where('document_id', isEqualTo: widget.data['document_id'])
        .snapshots();
  }

 


    
     Future addToCard  ()async{
     final FirebaseAuth auth = FirebaseAuth.instance;
     var currentUser=auth.currentUser;
      CollectionReference collectionRef = FirebaseFirestore.instance.collection('user_card_items');
     return collectionRef.doc(currentUser!.email).collection('items').doc().set({
       'title': widget.data['title'],
          'describtion': widget.data['describtion'],
          'prices': widget.data['prices'],
          'img_url': widget.data['img_url'],
          'document_id': widget.data['document_id'],
     });
  }


   





  @override
  void initState() {
    super.initState();
    userEmail = box.read('email');
    print(userEmail);
    
  }

  @override
  Widget build(BuildContext context) {
    int index;
    int pageCount = widget.data["img_url"].length;
    final pages = List.generate(
        pageCount,
        (index) => Container(
              child: Image.network(widget.data["img_url"][index]),
            ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen'),
        actions: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: checkFav(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Text("Loading"),
                  );
                }
                return IconButton(
                    onPressed: () =>  snapshot.data!.docs.length == 0
                    ? addToFav()
                    : Get.showSnackbar(AppStyles().failedSnackBar('Already Added')),
                     icon: snapshot.data!.docs.length==0

                        ? Icon(
                            Icons.favorite_outline,
                          )
                        : Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          ));
              }),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Column(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.data["img_url"].length,
                  itemBuilder: (_, Index) {
                    return CachedNetworkImage(
                      height: 200,
                      width: 200,
                      imageUrl: widget.data['img_url'][Index],
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.fill,
                    );
                  },
                ),
              ),
              SmoothPageIndicator(
                onDotClicked: (index) {},
                controller: _controller,
                count: widget.data['img_url'].length,
                effect: SlideEffect(
                  activeDotColor: Colors.pinkAccent,
                  dotColor: Colors.pinkAccent.withOpacity(0.5),
                  dotHeight: 20,
                  dotWidth: 20,
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data['title'],
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.data['describtion'],
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '\$ ${widget.data['prices']}'.toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  customButton(
                    "Add to cart",
                    () =>addToCard(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
