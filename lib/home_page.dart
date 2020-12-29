import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:land/dummy.dart';
import 'package:land/home.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<MyData> _item = <MyData>[
    MyData(
        id: 'l1',
        title: 'Azamgarh',
        imageUrl:
            'https://s0.geograph.org.uk/geophotos/02/11/22/2112234_48ab8eb2.jpg',
        lat: 26.0739,
        lan: 83.1859,
        description:
            'This land only for forming because here this field of soul is very helpfull for the forming like vegetables, rice, Sugarcan etc.'),
    MyData(
        id: 'l2',
        title: 'Gorakhpur',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Fields_below_Frocester_Hill_%281565%29.jpg/1200px-Fields_below_Frocester_Hill_%281565%29.jpg',
        lat: 26.7606,
        lan: 83.3732,
        description:
            'This land only for forming because here this field of soul is very helpfull for the forming like vegetables, rice, Sugarcan etc.'),
    MyData(
        id: 'l3',
        title: 'Varanasi',
        imageUrl:
            'https://www.holoweb.net/liam/pictures/2004-09-uk-going-home/pages/cimg3221/cimg3221-2304x1728.jpg',
        lat: 25.3176,
        lan: 82.9739,
        description:
            'This land only for forming because here this field of soul is very helpfull for the forming like vegetables, rice, Sugarcan etc.'),
  ];

  String _latitude = "";
  String _longitude = "";

  void initState() {
    super.initState();
    getCurrentLoction();
  }

  getCurrentLoction() async {
    final geoPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _latitude = '${geoPosition.latitude}';
      _longitude = '${geoPosition.longitude}';
      print(_latitude);
      print(_longitude);
    });
  }

  void selectLand(BuildContext ctx, String id, String title, String imageUrl,
      double lat, double lon, String desc) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) => HomePage(
          landId: id,
          landTitle: title,
          landImage: imageUrl,
          landLat: lat,
          landLon: lon,
          landDesc: desc,
          landCLat: double.parse(_latitude),
          landCLon: double.parse(_longitude),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Land'),
      ),
      body: ListView.builder(
          itemCount: _item.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  selectLand(
                    context,
                    _item[index].id,
                    _item[index].title,
                    _item[index].imageUrl,
                    _item[index].lat,
                    _item[index].lan,
                    _item[index].description,
                  );
                },
                child: Card(
                  color: Colors.purple[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.network(_item[index].imageUrl),
                      ),
                      Text(
                        _item[index].title,
                        style: TextStyle(fontSize: 35),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
