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
TextEditingController todoTextEditingController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey();
List<todo> todos =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo List App"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: todos.length,
          itemBuilder: (context, index)=>ListTile(
            title: Text(todos[index].title),

            trailing: IconButton(onPressed: (){

            }, icon: Icon(Icons.delete)),
          )

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
                        controller: todoTextEditingController,
                        decoration: const InputDecoration(
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
                          todoTextEditingController.clear();
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