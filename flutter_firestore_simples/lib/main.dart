import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title:  'Flutter Tech Post',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff543B7A),
        

      ),
      home: MyHomePage(title: 'Flutter post'),
      
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;



  @override
  _MyHomePageState createState() => _MyHomePageState();
  
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.bars),
          onPressed: (){
            
          },
        ),
        title: Container(
          alignment: Alignment.center,
          child: Text("Tech Post", style: TextStyle()),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.newspaper,
              size: 20.0,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ],
      ),
    body: StreamBuilder(
      stream: Firestore.instance.collection('post').snapshots(), // REFERENCIAR A COLEÇÃO LÁ NO FIREBASE CLOUD FIRESTORE
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          const Text("Loading"); // SE NÃO HOUVER NENHUMA REFERENCIA NO DATABASE
        } else {
          return ListView.builder(
            itemCount: snapshot.data.documents.length, // NUMERO DE DOCUMENTOS NO SNAPSHOT
            itemBuilder: (context, index){
            DocumentSnapshot mypost = snapshot.data.documents[index];
            return Stack(

              children: <Widget>[
                // CONFIGURANDO O LIST VIEW PARA INSERIR OS SNAPSHOTS
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350.0,
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      shadowColor: Color(0x802196F3),
                      child: Center(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(

                          // IMAGEM, TITULO E SUBTITULO AQUI 
                          children: <Widget>[

                            Container(
                               width: MediaQuery.of(context).size.width,
                               height: 200.0,

                               // CONTAINER DA IMAGEM
                               child: Image.network(

                                '${mypost['image']}',
                                fit: BoxFit.fill
                               ),
                              
                            ),

                            SizedBox(
                              // TITULO
                              height: 30.0,
                              width: MediaQuery.of(context).size.width,
                              child: Text('${mypost['title']}', 
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                              ),
                              
                              ),

            
                              
                            ),
                            SizedBox(

                              height: 30.0,
                               width: MediaQuery.of(context).size.width,
                             
                             child: Text('${mypost['subtitle']}', 
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                                
                              
                              ),
                              
                              ), 
                              


                            ),

                          ],
                        ),
                      ),),
                    
                    ),
                  ),

                ),

              Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .47,
                  left: MediaQuery.of(context).size.height * .52,

                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: CircleAvatar(
                    backgroundColor: Color(0xff543B7A),
                    child: Icon(Icons.star, color: Colors.white, size: 20.0),
                    
                  ),

                ),

              ),


              ],

            );
            }

          );
        }
      },
    ),
      
      
    );
  }
}                                   
 