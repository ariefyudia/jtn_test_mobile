import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class TransactionContent extends StatefulWidget {
  TransactionContent({super.key, required this.listData});

  List listData;

  @override
  State<TransactionContent> createState() => _TransactionContentState();
}

class _TransactionContentState extends State<TransactionContent> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  // List data = [
  //   {
  //     "name": "Arief Yudia Ramadhani",
  //     "email": "ariefyudia@gmail.com",
  //     "phone": "08988122591"
  //   }
  // ];

  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();

  Widget buildCtn() {
    return ListView.separated(
      key: _contentKey,
      padding: EdgeInsets.only(left: 5, right: 5),
      itemBuilder: (c, i) {
        return Container(
          child: Card(
            margin:
                EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
            child: Center(
              child: Text(widget.listData[i]['name']),
            ),
          ),
          height: 100.0,
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 0.5,
          color: Colors.greenAccent,
        );
      },
      itemCount: widget.listData.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SmartRefresher(
      header: WaterDropMaterialHeader(
        backgroundColor: Colors.white,
        color: Colors.blue,
      ),
      primary: true,
      key: _refresherKey,
      controller: _refreshController,
      // enablePullUp: true,
      physics: BouncingScrollPhysics(),
      footer: ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        completeDuration: Duration(milliseconds: 500),
      ),
      onRefresh: () async {
        //monitor fetch data from network
        await Future.delayed(Duration(milliseconds: 1000));

        // for (int i = 0; i < 10; i++) {
        //   data.add("Item $i");
        // }

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
      child: buildCtn(),
    );
  }
}
