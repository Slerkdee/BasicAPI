import 'dart:convert';
import 'package:cardview/pages/detail.dart';
import 'package:flutter/material.dart';

/*------- package สำหรับ request จาก Web ใช้  3 package -----*/
import 'package:http/http.dart' as http;
import 'dart:async';
//import 'dart:convert';  ปล.เรียกใช้ก่อนหน้านี้แล้ว
/*------- End package สำหรับ request จาก Web ใช้  3 package -----*/

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ความรู้เกี่ยวกับสัตว์",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      // body: Padding(
      //     padding: EdgeInsets.all(10),
      //     /*------- ชุดคำสั่งสำหรับอ่านไฟล์ Json -----*/
      //     child: FutureBuilder(
      //       builder: (context, snapshot) {
      //         var data = json.decode(snapshot.data
      //             .toString()); //[{ลิง......},{สุนัขไทยหลังอาน...},{}]
      //         return ListView.builder(
      //           itemBuilder: (BuildContext context, int index) {
      //             return MyBox(data[index]['title'], data[index]['subtitle'],
      //                 data[index]['image_url'], data[index]['detail']);
      //           },
      //           itemCount: data.length,
      //         );
      //       },
      //       future:DefaultAssetBundle.of(context).loadString('assets/data.json'),
      //     )),
      // /*------- End อ่านไฟล์ Json -----*/

      body: Padding(
          padding: EdgeInsets.all(10),
          /*------- ชุดคำสั่งสำหรับอ่านไฟล์ Json from Web http request-----*/
          child: FutureBuilder(
            builder: (context,AsyncSnapshot snapshot) {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return MyBox(snapshot.data[index]['title'], snapshot.data[index]['subtitle'],
                      snapshot.data[index]['image_url'], snapshot.data[index]['detail']);
                },
                itemCount:snapshot.data.length,
              );
            },
            future: getData(),
          )),
      /*------- End ชุดคำสั่งสำหรับอ่านไฟล์ Json from Web http request-----*/
    );
  }

  Widget MyBox(String title, String subtitle, String image_url, String detail) {
    /*------- สร้าง ตัวแปร รับค่าจาก Json เพื่อส่งไปอีกไฟล์-----*/
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;

    /*-------END สร้าง ตัวแปร รับค่าจาก Json เพื่อส่งไปอีกไฟล์-----*/

    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        //color: Colors.blue[50],
        image: DecorationImage(
            image: NetworkImage(image_url),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.60), BlendMode.darken)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(subtitle, style: TextStyle(fontSize: 16, color: Colors.white)),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                        v1, v2, v3, v4), //ส่งค่าที่อ่านได้ไปที่ไฟล์ Detail
                  ));
            },
            child: Text('อ่านต่อ'),
          )
        ],
      ),
    );
  }
 /*------ function สำหรับ get ไฟล์จาก github ------*/
  Future getData() async {
    //https://raw.githubusercontent.com/Slerkdee/BasicAPI/main/data.json
    var url = Uri.http('raw.githubusercontent.com','/Slerkdee/BasicAPI/main/data.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
  /*------ End function สำหรับ get ไฟล์จาก github ------*/
}
