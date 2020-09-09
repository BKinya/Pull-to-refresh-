import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OnlyListView extends StatefulWidget {
  @override
  _OnlyListViewState createState() => _OnlyListViewState();
}

class _OnlyListViewState extends State<OnlyListView> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<String> data = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];

  Widget buildCtn() {
    return ListView.separated(
      reverse: true,
      padding: EdgeInsets.only(left: 5, right: 5),
      itemBuilder: (c, i) => Center(
        child: Text(data[i]),
      ),
      separatorBuilder: (context, index) {
        return Container(
          height: 0.5,
          color: Colors.greenAccent,
        );
      },
      itemCount: data.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: true,
      child: buildCtn(),
      physics: BouncingScrollPhysics(),
      footer: ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        completeDuration: Duration(milliseconds: 500),
      ),
      onRefresh: () async {
        //monitor fetch data from network
        await Future.delayed(Duration(milliseconds: 1000));

        for (int i = 0; i < 10; i++) {
          data.add("Item $i");
        }

        if (mounted) setState(() {});
        _refreshController.refreshCompleted();

        /*
        if(failed){
         _refreshController.refreshFailed();
        }
      */
      },
      onLoading: () async {
        //monitor fetch data from network
        await Future.delayed(Duration(milliseconds: 180));
//        for (int i = 0; i < 10; i++) {
//          data.add("Item $i");
//        }
        if (mounted) setState(() {});
        _refreshController.loadFailed();
      },
    );
  }
}
