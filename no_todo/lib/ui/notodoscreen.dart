import 'package:flutter/material.dart';
import '../model/nodo_item.dart';
import '../util/database_client.dart';

class NotoDoScreen extends StatefulWidget {
  @override
  _NotoDoScreenState createState() => _NotoDoScreenState();
}

class _NotoDoScreenState extends State<NotoDoScreen> {
  final TextEditingController _textEditingController =
      new TextEditingController();
  var db = new DatabaseHelper();

  final List<NoDoItem> itemList = <NoDoItem>[];

  @override
  void initState() {
    super.initState();
    _readNODOList();

  }



  void _handleSubmit(String text) async {
    _textEditingController.clear();

    NoDoItem noDoItem = new NoDoItem(text, DateTime.now().toIso8601String());
    int saveItemId = await db?.saveItem(noDoItem);

    NoDoItem addedItem = await db.getItem(saveItemId);

setState(() {
  itemList.insert(0, addedItem);
});  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[

          new Flexible(

            child: new ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: itemList.length,
              itemBuilder: (_,int index){
                return new Card(
                  color: Colors.white10,
                  child: new ListTile(
                    title: itemList[index],
                    onLongPress: () => debugPrint(""),
                    trailing: new Listener(
                      key: new Key(itemList[index].itemNAme),
                      child: new Icon(Icons.remove_circle,
                      color: Colors.redAccent,),
                      onPointerDown: (pointerEvent) => debugPrint(""),
                    ),

                  ),

                );
              },
            ),


          ),
          new Divider(height: 1.3,)




        ],
      ),



      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.redAccent,
        tooltip: "Add Item",
        child: new ListTile(
          title: new Icon(Icons.add),
        ),
        onPressed: _showFormDialog,
      ),
    );
  }


  void _showFormDialog() {
    var alert = new AlertDialog(
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: "Item",
                hintText: "Eg: Dont buy stuff",
                icon: new Icon(Icons.note_add),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            _handleSubmit(_textEditingController.text);
            _textEditingController.clear();
            Navigator.pop(context);
          },
          child: Text("Save"),
        ),
        new FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        )
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }


  _readNODOList() async{

    List items = await db.getItems();
    items.forEach((item){
      NoDoItem noDoItem = NoDoItem.map(items);
print("Db items: ${noDoItem.itemNAme}");
    });
  }
}
