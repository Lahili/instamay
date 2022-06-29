import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:instamay/StateStore.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key, this.data, this.addData, this.getAnotherData})
      : super(key: key);
  final data;
  final addData;
  final getAnotherData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scroll = ScrollController();
  var _url1 = 'https://codingapple1.github.io/app/more1.json';
  var _url2 = 'https://codingapple1.github.io/app/more2.json';
  int addDataIndex = 0;

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      print('in scroll.addListner');
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        print('end of the scroll');
        if (addDataIndex == 0) {
          widget.getAnotherData(_url1);
          addDataIndex++;
        } else if (addDataIndex == 1) {
          widget.getAnotherData(_url2);
          addDataIndex++;
        } else {
          print('no more data');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      return ListView.builder(
          itemCount: widget.data.length,
          controller: scroll,
          itemBuilder: (context, i) {
            print(widget.data);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.data[i]['image'].runtimeType == String
                    ? Image.network(widget.data[i]['image'])
                    : Image.file(widget.data[i]['image']),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Text('id: ${widget.data[i]['user']}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) {
                                return Profile();
                              },
                            ),
                          );
                        },
                      ),
                      Text('content: ${widget.data[i]['content']}'),
                      Text('likes: ${widget.data[i]['likes']}')
                    ],
                  ),
                ),
              ],
            );
          });
    } else {
      return CircularProgressIndicator();
    }
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
      ),
      body: Column(
        children: [
          Text(context.watch<StateStore>().name),
          ElevatedButton(
              onPressed: () {
                context.read<StateStore>().changeName();
              },
              child: Text('change name'))
        ],
      ),
    );
  }
}
