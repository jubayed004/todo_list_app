import 'package:flutter/material.dart';

import 'main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List App',

      debugShowCheckedModeBanner: false,
      home: HomeScreens()
    );
  }
}

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {

 bool _isLiked= false;
 void _toggelLike(){
   setState(() {
     _isLiked = !_isLiked;
   });

 }
TextEditingController todoTextEditingController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey();
List<todo> todos =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo List App"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            todos.clear();
            if(mounted){
              setState(() {

              });
            }
          }, icon: Icon(Icons.delete_sweep))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: _toggelLike,
                child: Icon(
                    _isLiked? Icons.favorite:Icons.favorite_border,
                color: _isLiked?Colors.red:Colors.grey,
                  size: 200,
                ),
            ),
            ListView.builder(
              shrinkWrap: true ,
              primary: false,
              itemCount: todos.length,
                itemBuilder: (context, index)=>ListTile(
                  onLongPress: (){

                    setState(() {
                      todos[index].isDone=!todos[index].isDone;
                    });
                  },
                  leading: todos[index].isDone?Icon(Icons.check_box_outline_blank):Icon(Icons.check_box),
                  title: Text(todos[index].title),

                  trailing: IconButton(onPressed: (){
                      todos.removeAt(index);
                      setState(() {

                      });
                  }, icon: Icon(Icons.delete)),
                )

            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => Container(

              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                          return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: todoTextEditingController,
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          labelText: "Enter number",
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Colors.black,width: 1)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black,width: 2)
                          ),

                        ),

                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          todos.add(todo(todoTextEditingController.text.trim(), false));
                          if(_formKey.currentState!.validate()){
                            todoTextEditingController.clear();

                          }

                          setState(() {

                          });
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}

class todo{
  String title;
  bool isDone;
  
  todo(this.title,this.isDone);
}