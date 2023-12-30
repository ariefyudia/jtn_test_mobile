import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jtn_test/content/home.dart';
import 'package:jtn_test/content/transaction.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

const fetchBackground = "fetchBackground";

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        // Code to run in background
        print('Task Schedule Running');
        var url = Uri.http('test-tech.api.jtisrv.com',
            '/md/public/API/BgService/Hit', {'q': '{http}'});

        // Await the http get response, then decode the json-formatted response.
        var response = await http.post(url, body: {
          "nama": "Arief Yudia Ramadhani",
          "email": "ariefyudia@gmail.com",
          "nohp": "08988122591"
        });
        if (response.statusCode == 200) {
          var jsonResponse =
              convert.jsonDecode(response.body) as Map<String, dynamic>;
          var data = jsonResponse;
          log(data.toString());
        } else {
          print('Request failed with status: ${response.statusCode}.');
        }
        break;
    }
    return Future.value(true);
  });
}

// void main() {
//   runApp(const MyApp());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );
  await Workmanager().registerPeriodicTask(
    "1",
    fetchBackground,
    frequency: Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'APP KEUANGAN'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    _updateAppbar();
    controller = TabController(vsync: this, length: 4);
    controller!.addListener(() {
      setState(() {
        _selectedIndex = controller!.index;
      });
    });
    super.initState();
  }

  void _updateAppbar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  List dataScheduler = [
    {
      "name": "Arief Yudia Ramadhani",
      "email": "ariefyudia@gmail.com",
      "phone": "08988122591"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      enableLoadingWhenFailed: true,
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: InkWell(
                  onTap: () {},
                  child: SvgPicture.asset('assets/svg/Button Notifikasi.svg'),
                )),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(200, 100),
            child: Container(
              child: TabBar(
                unselectedLabelColor: Colors.grey.withOpacity(0.5),
                dividerColor: Colors.transparent,
                indicatorColor: Colors.transparent,
                controller: controller,
                tabs: <Widget>[
                  SizedBox(
                    height: 100,
                    child: Tab(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            _selectedIndex == 0
                                ? 'assets/svg/Button Home Aktif.svg'
                                : 'assets/svg/Button Home Tidak Aktif.svg',
                          ),
                          const Text('Home')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Tab(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            _selectedIndex == 1
                                ? 'assets/svg/Button Transaksi Aktif.svg'
                                : 'assets/svg/Button Transaksi Tidak Aktif.svg',
                          ),
                          const Text('Transaksi')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Tab(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            _selectedIndex == 2
                                ? 'assets/svg/Button Laporan Aktif.svg'
                                : 'assets/svg/Button Laporan Tidak Aktif.svg',
                          ),
                          const Text('Laporan')
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Tab(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            _selectedIndex == 3
                                ? 'assets/svg/Button Tools Aktif.svg'
                                : 'assets/svg/Button Tools Tidak Aktif.svg',
                          ),
                          const Text('Tools')
                        ],
                      ),
                    ),
                  ),
                ],
                onTap: (index) {
                  // Should not used it as it only called when tab options are clicked,
                  // not when user swapped
                },
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            Scrollbar(
              child: HomeContent(),
            ),
            Scrollbar(
              child: TransactionContent(
                listData: dataScheduler,
              ),
            ),
            Center(
                child: Text(
              _selectedIndex.toString(),
              style: const TextStyle(fontSize: 40),
            )),
            Center(
                child: Text(
              _selectedIndex.toString(),
              style: const TextStyle(fontSize: 40),
            )),
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
