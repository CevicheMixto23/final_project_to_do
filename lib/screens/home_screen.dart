import 'package:final_project_to_do/models/task_model.dart';
import 'package:final_project_to_do/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskExample {
  String nameTask;
  bool? doneTask;
  String deadlineTask;

  TaskExample(this.nameTask, this.doneTask, this.deadlineTask);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define las listas de tareas como propiedades del estado
  List<TaskExample> tareas = [
    TaskExample("Tarea Matematica", false, "15-06-2024"),
    TaskExample("Tarea Fisica", false, "15-06-2024"),
    TaskExample("Tarea Ingles", false, "15-06-2024"),
    TaskExample("Practicar Ruso", false, "15-06-2024"),
    TaskExample("Sacar al perro", false, "15-06-2024")
  ];

  List<TaskExample> tareasHechas = [
    TaskExample("Tarea Matematica", true, "15-06-2024"),
    TaskExample("Tarea Fisica", true, "15-06-2024"),
    TaskExample("Tarea Ingles", true, "15-06-2024"),
    TaskExample("Practicar Ruso", true, "15-06-2024"),
    TaskExample("Sacar al perro", true, "15-06-2024")
  ];

  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(76, 103, 147, 1),
        title: Center(
          child: Text('HAZLO',
              style: GoogleFonts.righteous(fontSize: 40, color: Colors.white)),
        ),
        leading: IconButton(
          icon: Image.asset(
            'assets/gato.png',
            width: 40,
            height: 40,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        "Tareas",
                        style: GoogleFonts.rowdies(fontSize: 30),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: getTasks(),
                      builder: (context,snapshot) {
                        if (snapshot.hasData == false) {
                          return const Center(child: CircularProgressIndicator());
                        }else {
                        return TaskList(
                          tareas: snapshot.data,
                          onCheckboxChanged: (index, newValue) {
                            setState(() {
                              //snapshot.data![index].doneTask = newValue;
                            });
                          },
                        );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        "Tareas Hechas",
                        style: GoogleFonts.rowdies(fontSize: 30),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder(
                      future: getTasksDone(),
                      builder: (context,snapshot) { 
                      return TaskDoneList(
                        tareas: snapshot.data,
                        onCheckboxChanged: (index, newValue) {
                          setState(() {
                            //tareasHechas[index].doneTask = newValue;
                          });
                        },
                      );}
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Text(
                        "$_dateTime",
                        style: GoogleFonts.rowdies(fontSize: 30),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
      floatingActionButton: Container(
        width: 80,
        height: 80,
        margin: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(189, 228, 241, 1),
          shape: const StadiumBorder(),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Agregar Tarea"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TextField(
                          decoration:
                              InputDecoration(labelText: "Nombre de la tarea"),
                        ),
                        TextButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2025))
                                .then((value) {
                              _dateTime = value;
                              setState(() {});
                            });
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Seleccionar fecha"),
                              Icon(Icons.calendar_today_outlined)
                            ],
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancelar")),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Agregar"))
                    ],
                  );
                });
          },
          child: const Icon(Icons.add_outlined),
        ),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<Task>? tareas;
  final Function(int, bool?) onCheckboxChanged;
  const TaskList(
      {super.key, required this.tareas, required this.onCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.25,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tareas?.length,
          itemBuilder: (context, index) {
            return Container(
              width: size.width * 0.5,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: const Color.fromRGBO(241, 58, 33, 0.8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              value: tareas?[index].doneTask ?? false,
                              onChanged: (newBool) {
                                onCheckboxChanged(index, newBool);
                              },
                              activeColor: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz),
                            color: Colors.black,
                            iconSize: 35,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 30),
                      child: Text(
                        tareas?[index].nameTask ?? "",
                        style: GoogleFonts.rowdies(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Fecha Límite: ",
                              style: GoogleFonts.rowdies(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          Text(
                            tareas?[index].deadlineTask.toString() ?? "" ,
                            style: GoogleFonts.rowdies(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class TaskDoneList extends StatelessWidget {
  final List<Task>? tareas;
  final Function(int, bool?) onCheckboxChanged;
  const TaskDoneList(
      {super.key, required this.tareas, required this.onCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.25,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tareas?.length,
          itemBuilder: (context, index) {
            return Container(
              width: size.width * 0.5,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: const Color.fromRGBO(125, 206, 233, 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              value: tareas?[index].doneTask ?? false,
                              onChanged: (newBool) {
                                onCheckboxChanged(index, newBool);
                              },
                              activeColor: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_horiz),
                            color: Colors.black,
                            iconSize: 35,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 30),
                      child: Text(
                        tareas?[index].nameTask ?? "",
                        style: GoogleFonts.rowdies(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Fecha Límite: ",
                              style: GoogleFonts.rowdies(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                          Text(
                            tareas?[index].deadlineTask.toString()  ?? "",
                            style: GoogleFonts.rowdies(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
