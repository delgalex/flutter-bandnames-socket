import 'dart:io';

import 'package:band_names/model/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5 ),
    Band(id: '1', name: 'Soda', votes: 3 ),
    Band(id: '1', name: 'Caifanes', votes: 4 ),
    Band(id: '1', name: 'Led', votes: 5 ),
    Band(id: '1', name: 'Bon jovi', votes: 2 ),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text( 'Bandas', style: TextStyle( color: Colors.black87 )),
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile( bands[i] )
        
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.add ),
        onPressed: addNewBan,
      ),    
    );
  }

  Widget  _bandTile( Band band ) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( direction ){
        print('directi¡tion $direction');
      },
      background: Container(
        padding: EdgeInsets.only( left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child:Text('Delete band', style: TextStyle( color: Colors.white) ),
        )
      ),
      child: ListTile(
            leading: CircleAvatar(
              child: Text( band.name.substring(0,2) ),
              backgroundColor: Colors.blue[100],
            ),
            title: Text( band.name ),
            trailing: Text( '${ band.votes }', style: TextStyle( fontSize: 20) ),
            onTap: () {
              addNewBan;
            },
          ),
    );
  }

  addNewBan(){
      // controlamos el textfield
      final textControler = new TextEditingController();

      if( Platform.isAndroid ){

        return showDialog(
          context: context, 
          builder: ( context ){
            return AlertDialog(
              title: Text('Cosita'),
              content: TextField(
                controller: textControler, // asignamos el controler al texfield
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text('Add'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => addBandToList( textControler.text)
                  
                )
              ]
            );
          }
        );

      }
      
      showCupertinoDialog(
        context: context, 
        builder: ( _ ){
          return CupertinoAlertDialog(
            title: Text('New band name:'),
            content: CupertinoTextField(
              controller: textControler,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Add'),
                onPressed: () => addBandToList(textControler.text),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Cerrar'),
                onPressed: () => Navigator.pop(context),
              )
            ]
          );
        }
      );
     
  }

  void addBandToList( String name ) {

    if( name.length > 1 ){
      this.bands.add( Band(id: DateTime.now().toString(), name: name, votes: 1 ) );
      setState(() {} );
    }

    Navigator.pop(context);

  }

}