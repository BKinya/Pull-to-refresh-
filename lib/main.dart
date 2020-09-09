import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyPullToRefresh(),
  ));
}

class MyPullToRefresh extends StatefulWidget {
  @override
  _MyPullToRefreshState createState() => _MyPullToRefreshState();
}

class _MyPullToRefreshState extends State<MyPullToRefresh> {
  List list;
  var random;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    random = Random();
    refreshList();
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show();

    setState(() {
      list = List.generate(random.nextInt(10), (index) => 'item $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pull to refresh'),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: list?.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(list[index]),
          ),
        ),
      ),
    );
  }
}
