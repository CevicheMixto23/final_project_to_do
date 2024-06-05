import 'package:final_project_to_do/models/task_model.dart';
import 'package:final_project_to_do/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Task>>? _futureTasks;
  Future<List<Task>>? _futureTasksDone;

  void _reloadTasks(String idUser) {
    setState(() {
      _futureTasks = getTasks(idUser);
      _futureTasksDone = getTasksDone(idUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    final parametro = ModalRoute.of(context)!.settings.arguments as String;
    _reloadTasks(parametro);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
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
              Icons.logout,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Cerrar Sesión"),
                      content: const Text("¿Estás seguro de cerrar sesión?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancelar")),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cerrar Sesión"))
                      ],
                    );
                  });
            },
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
                      future: _futureTasks,
                      builder: (context, snapshot) {
                        if (snapshot.hasData == false) {
                          return const Center(
                              child: SizedBox(
                            height: 100,
                          ));
                          //CircularProgressIndicator());
                        } else {
                          return TaskList(
                            tareas: snapshot.data,
                            onCheckboxChanged: (index, newValue) async {
                              await changeTaskStatus(snapshot.data![index].uid!,
                                  snapshot.data![index]);
                              _reloadTasks(parametro);
                            },
                            reloadTasks: () {
                              _reloadTasks(parametro);
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
                        future: _futureTasksDone,
                        builder: (context, snapshot) {
                          if (snapshot.hasData == false) {
                            return const Center(
                                child: SizedBox(
                              height: 100,
                            ));
                            //CircularProgressIndicator());
                          } else {
                            return TaskDoneList(
                              tareas: snapshot.data,
                              onCheckboxChanged: (index, newValue) async {
                                await changeTaskStatus(
                                    snapshot.data![index].uid!,
                                    snapshot.data![index]);
                                _reloadTasks(parametro);
                              },
                              reloadTasks: () {
                                _reloadTasks(parametro);
                              },
                            );
                          }
                        })
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
          backgroundColor: Colors.blueGrey,
          shape: const StadiumBorder(),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AddTaskWidget(
                      onAdded: (task) {
                        setState(() {
                          addTask(task).then((_) {
                            Navigator.of(context).pop();
                          }); //tareas.add(task);
                        });
                        _reloadTasks(parametro);
                      },
                      idUser: parametro);
                });
          },
          child: const Icon(
            Icons.add_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

//

class AddTaskWidget extends StatefulWidget {
  final Function(Task) onAdded;
  final String idUser;
  const AddTaskWidget({super.key, required this.onAdded, required this.idUser});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  TextEditingController taskController = TextEditingController(text: "");
  String deadline = "";

  Task task = Task("", false, "", "");
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Agregar Tarea"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            maxLength: 15,
            controller: taskController,
            decoration: const InputDecoration(hintText: "Nombre de la tarea"),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025))
                  .then((value) {
                deadline = task.dateTimeToStr(value!);
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
            onPressed: () async {
              Task task =
                  Task(taskController.text, false, deadline, widget.idUser);
              await widget.onAdded(task);
            },
            child: const Text("Agregar"))
      ],
    );
  }
}

class TaskList extends StatefulWidget {
  final List<Task>? tareas;
  final Function(int, bool?) onCheckboxChanged;
  final Function() reloadTasks;
  const TaskList(
      {super.key,
      required this.tareas,
      required this.onCheckboxChanged,
      required this.reloadTasks});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final today = DateTime.now();
    return SizedBox(
      height: size.height * 0.30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.tareas?.length,
          itemBuilder: (context, index) {
            String dateString = widget.tareas?[index].deadlineTask ?? "";
            DateTime date = DateTime.parse(
                "${dateString.substring(6, 10)}-${dateString.substring(3, 5)}-${dateString.substring(0, 2)}");

            return Container(
              width: size.width * 0.5,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: !today.isAfter(date)
                    ? const Color.fromARGB(255, 240, 224, 47)
                    : const Color.fromRGBO(241, 58, 33, 0.8),
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
                              value: widget.tareas?[index].doneTask ?? false,
                              onChanged: (newBool) async {
                                await widget.onCheckboxChanged(index, newBool);
                              },
                              activeColor: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DeleteConfirmation(
                                      index: index,
                                      onElementDeleted: () async {
                                        await deleteTask(
                                            widget.tareas![index].uid!);
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pop();
                                        widget.reloadTasks();
                                      },
                                    );
                                  });
                            },
                            icon: const Icon(Icons.delete),
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
                        widget.tareas?[index].nameTask ?? "",
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
                          Row(
                            mainAxisAlignment: today.isAfter(date)
                                ? MainAxisAlignment.spaceAround
                                : MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.tareas?[index].deadlineTask ?? "",
                                style: GoogleFonts.rowdies(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              if (today.isAfter(date))
                                const Icon(
                                  Icons.warning,
                                  color: Colors.yellow,
                                ),
                              const SizedBox(width: 5)
                            ],
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

class TaskDoneList extends StatefulWidget {
  final List<Task>? tareas;
  final Function(int, bool?) onCheckboxChanged;
  final Function() reloadTasks;
  const TaskDoneList(
      {super.key,
      required this.tareas,
      required this.onCheckboxChanged,
      required this.reloadTasks});

  @override
  State<TaskDoneList> createState() => _TaskDoneListState();
}

class _TaskDoneListState extends State<TaskDoneList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.3,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.tareas?.length,
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
                color: const Color.fromARGB(255, 24, 206, 88),
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
                              value: widget.tareas?[index].doneTask ?? false,
                              onChanged: (newBool) async {
                                await widget.onCheckboxChanged(index, newBool);
                              },
                              activeColor: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return DeleteConfirmation(
                                      index: index,
                                      onElementDeleted: () async {
                                        await deleteTask(
                                            widget.tareas![index].uid!);
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pop();
                                        widget.reloadTasks();
                                      },
                                    );
                                  });
                            },
                            icon: const Icon(Icons.delete),
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
                        widget.tareas?[index].nameTask ?? "",
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
                            widget.tareas?[index].deadlineTask.toString() ?? "",
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

class DeleteConfirmation extends StatelessWidget {
  final int index;
  final Future<void> Function() onElementDeleted;
  const DeleteConfirmation(
      {super.key, required this.index, required this.onElementDeleted});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Eliminar tarea"),
      content: const Text("¿Estás seguro de eliminar esta tarea?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancelar")),
        TextButton(
            onPressed: () {
              onElementDeleted();
            },
            child: const Text("Eliminar"))
      ],
    );
  }
}
