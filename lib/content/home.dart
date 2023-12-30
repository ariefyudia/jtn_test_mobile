import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();

  Widget buildCtn() {
    return SingleChildScrollView(
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        key: _contentKey,
        padding: EdgeInsets.only(left: 5, right: 5),
        itemBuilder: (c, i) => Container(
          child: Card(
            elevation: 2,
            child: ClipPath(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {},
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      border: Border(
                          right: BorderSide(
                        color: Colors.blue.shade200,
                        width: 20,
                      ))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nama Outlet'),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.money)),
                                SizedBox(
                                  width: 4,
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('IDR'))
                              ],
                            )),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('50.000')))
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.money)),
                                SizedBox(
                                  width: 4,
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('IDR'))
                              ],
                            )),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('50.000')))
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.money)),
                                SizedBox(
                                  width: 4,
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('IDR'))
                              ],
                            )),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('50.000')))
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(Icons.money)),
                                SizedBox(
                                  width: 4,
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('IDR'))
                              ],
                            )),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('50.000')))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) {
          return Container(
            height: 0.5,
            color: Colors.greenAccent,
          );
        },
        itemCount: 3,
      ),
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
