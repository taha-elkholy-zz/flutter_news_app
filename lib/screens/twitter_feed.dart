import 'package:flutter/material.dart';
import 'package:news_app/sharedui/navigation_drawer.dart';

class TwitterFeed extends StatefulWidget {
  @override
  _TwitterFeedState createState() => _TwitterFeedState();
}

class _TwitterFeedState extends State<TwitterFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter Feed'),
        centerTitle: false,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){})
        ],
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(itemBuilder: (context, position){
        return Card(
          child: Column(
            children: [
              _cardHeader(),
              _cardBody(),
              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16, top: 16),
                child: SizedBox(width: double.infinity,height: 1,child: Container(color: Colors.grey,),),
              ),
              _cardFooter(),
            ],
          ),
        );
      },itemCount: 20,),
    );
  }

  Widget _cardHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: CircleAvatar(backgroundImage: ExactAssetImage('assets/images/placeholder_bg.png'),radius: 24,),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            children: [
              Text('Taha Elkholy ',style: TextStyle(fontWeight: FontWeight.w600),),
              Text('@taha_elkholy',style: TextStyle(color: Colors.grey),),
            ],
          ),
          SizedBox(height: 8,),
          Text('Fri, 14-7-2021 . 14.23', style: TextStyle(color: Colors.grey),),
        ],),
      ],
    );
  }
  Widget _cardBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 16,right: 16,bottom: 8),
      child: Text('Any Text Here Any Text Here Any Text Here Any Text Here Any Text Here ',style: TextStyle(fontWeight: FontWeight.w600),),
    );
  }Widget _cardFooter() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Row(children: [
           IconButton(icon: Icon(Icons.repeat,color: Colors.orange,),onPressed: (){},),
           Text('25', style: TextStyle(color: Colors.grey),)
         ],),
         Row(
           children: [
             TextButton(onPressed: (){}, child: Text('SHARE',style: TextStyle(color: Colors.orange),)),
             TextButton(onPressed: (){}, child: Text('OPEN',style: TextStyle(color: Colors.orange),)),
           ],
         ),
        ],
      ),
    );
  }
}
