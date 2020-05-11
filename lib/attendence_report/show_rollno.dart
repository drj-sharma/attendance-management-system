import 'package:attendencemanagementsystem/utilitiesdb/database_helper.dart';
import 'package:flutter/material.dart';

class ShowRollNo extends StatefulWidget {
  @override
  _ShowRollNoState createState() => _ShowRollNoState();
}

class _ShowRollNoState extends State<ShowRollNo> {

  Future<List<Map<String, dynamic>>> _getStudentsRollNo() async {
    var res = await DatabaseHelper().getRollNo();
    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStudentsRollNo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('Attendence Report',),
      ),
      body: Container(
        child: FutureBuilder(
          initialData: [],
          future: _getStudentsRollNo(),

          // ignore: missing_return
          builder: (BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.data.length < 1) {
    return Center(child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('Please Insert Students from the plus "+" button and get them attendence first.', style: TextStyle(color: Colors.blueGrey), ),
    ));
    } else {
      return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Ink(
                  color: Colors.white,
                  child:
                  ListTile(
                    title: Text(snapshot.data[index]['rollNo'].toString(),
                      style: TextStyle(
                        color: Colors.blueGrey[900], fontSize: 26,),),
                    subtitle: Text(snapshot.data[index]['name'],
                      style: TextStyle(color: Colors.blue, fontSize: 16,),),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 30.0),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () async {
                      print(snapshot.data[index]['name'].toString());
                      var result = await DatabaseHelper().getReportTillNow(
                          snapshot.data[index]['rollNo'].toString());

                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              ShowReportByRollNo(studentReport: result)));
                    },
                  ),),
                Divider(height: 3.0,)
              ],
            );
          });
    }
          }
        )
      ),
    );
  }
}

class ShowReportByRollNo extends StatefulWidget {
  List<Map<String, dynamic>> studentReport = [];
  ShowReportByRollNo({Key key, @required this.studentReport}) : super(key: key);

  @override
  _ShowReportByRollNoState createState() => _ShowReportByRollNoState();
}

class _ShowReportByRollNoState extends State<ShowReportByRollNo> {
  double percentile = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.studentReport);
    setState(() {
      percentile = (widget.studentReport[1]["Total"]/widget.studentReport[0]["count"])*100;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('Attendence Report'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Center(child: Text('Total Lectures: ${widget.studentReport[0]["count"].toString()}', style: TextStyle(fontSize: 30.0),)),
          ),
          SizedBox(height: 10.0,),
          Container(
            child: Center(child: Text('Attended Lectures: ${widget.studentReport[1]["Total"].toString()}', style: TextStyle(fontSize: 20.0),))
          ),
          SizedBox(height: 30.0,),
          Container(
            child: Center(child: Text('PERCENTILE: ${percentile.toString()}%', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.blue),)),
          ),
        ],
      ),
    );
  }
}
