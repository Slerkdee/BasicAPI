import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final v1, v2, v3, v4;
  DetailPage(this.v1, this.v2, this.v3, this.v4);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var _v1, _v3, _v4;

  @override
  void initState() {
    super.initState();
    _v1 = widget.v1;
    _v3 = widget.v3;
    _v4 = widget.v4;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _v1,
          style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [MyBox()],
        ),
      ),
    );
  }

  Widget MyBox() {
    return Container(
      padding: EdgeInsets.all(20),
      height: 700,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        //color: Colors.blue[50],
        image: DecorationImage(
            image: NetworkImage(_v3),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.50), BlendMode.darken)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_v1,
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(_v4,
              style: TextStyle(fontSize: 16, color: Colors.white)),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
