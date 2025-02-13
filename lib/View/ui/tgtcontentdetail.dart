import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:togetor/ui/tgtbutton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TGTContentDetail extends StatefulWidget {
  const TGTContentDetail({Key? key}) : super(key: key);

  @override
  _TGTContentDetailState createState() => _TGTContentDetailState();
}

class _TGTContentDetailState extends State<TGTContentDetail> {
  var _title = '제목 없음';
  var _detail = '설명 없음';
  var _participant = 0;
  var _maxParticipant = 0;
  var _createdDate = '0000-00-00';
  var _limitedDate = '0000-00-00';
  var _contentImage =
      'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/201912/13/ed91135f-1189-429d-ae2a-507664b03924.jpg';
  var _place = '대연동';
  var _contentState = '참가중';

  @override
  void initState() {
    super.initState();
    getContent();
  }

  @override
  Widget build(BuildContext context) {
    var participateTGTButtons = <TGTButton>[
      TGTButton(
        color: const Color(0xffffffff),
        width: 300.0,
        height: 100.0,
        borderRadius: 0.0,
        child: const Text(
          '나가기',
          style: TextStyle(
            color: Color(0xff18A0FB),
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          setState(() {
            _contentState = '참가';
          });
        },
      ),
      TGTButton(
        color: const Color(0xff18A0FB),
        width: 300.0,
        height: 100.0,
        borderRadius: 0.0,
        child: const Text(
          '채팅방',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          print('hihi');
        },
      ),
    ];
    var noParticipateTGTButtons = <TGTButton>[
      TGTButton(
        color: const Color(0xffffffff),
        width: 300.0,
        height: 100.0,
        borderRadius: 0.0,
        child: Text(
          '$_participant/$_maxParticipant',
          style: const TextStyle(
            color: Color(0xff18A0FB),
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          return null;
        },
      ),
      TGTButton(
        color: const Color(0xff18A0FB),
        width: 300.0,
        height: 100.0,
        borderRadius: 0.0,
        child: const Text(
          '참가하기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          setState(() {
            _contentState = '참가중';
          });
        },
      ),
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('상세 정보'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 5,
                        blurRadius: 7, // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      _contentImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                flex: 4,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _title,
                        style: const TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      flex: 4,
                    ),
                    Expanded(
                      child: Text(
                        _place,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      flex: 1,
                    )
                  ],
                ),
                flex: 2,
              ),
              Expanded(
                child: Text(
                  '$_createdDate\n$_limitedDate\n$_detail',
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: _contentState == '참가중'
                            ? participateTGTButtons[0]
                            : noParticipateTGTButtons[0]),
                    Expanded(
                        child: _contentState == '참가중'
                            ? participateTGTButtons[1]
                            : noParticipateTGTButtons[1])
                  ],
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getContent() async {
    String TGTContentUrl = "http://localhost:8080/contents/1";
    var TGTContentResponse = await http.get(TGTContentUrl);
    var TGTContentData =
        convert.jsonDecode(convert.utf8.decode(TGTContentResponse.bodyBytes));
    setState(
      () {
        _title = TGTContentData["title"];
        _detail = TGTContentData["detail"];
        _contentImage = TGTContentData["contentImage"];
        _participant = TGTContentData["Participant"];
        _maxParticipant = TGTContentData["maxParticipant"];
        _createdDate = TGTContentData['createdDate'];
        _limitedDate = TGTContentData["limitedDate"];
      },
    );
  }
}
