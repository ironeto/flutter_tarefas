import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:intl/intl.dart'; // Added import for date formatting

import '../providers/task_provider.dart';
import '../models/task_model.dart';

class TaskShowScreen extends StatefulWidget {
  const TaskShowScreen({Key? key}) : super(key: key);

  @override
  _TaskShowScreenState createState() => _TaskShowScreenState();
}

class _TaskShowScreenState extends State<TaskShowScreen> {
  TaskModel? task;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController effortHoursController = TextEditingController();
  LatLng _position = LatLng(0, 0);

  GoogleMapController? _mapController;
  Set<Marker> _markers = {};

  bool _validateName = false;
  bool _validateEffortHours = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      task = ModalRoute.of(context)?.settings.arguments as TaskModel;
      nameController.text = task?.name ?? '';
      effortHoursController.text = task?.effortHours.toString() ?? '';
      _addMarker(LatLng(task!.latitude, task!.longitude));
    });

    // Set initial value for SpinBox
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final double effortHours = double.tryParse(effortHoursController.text) ?? 0;
      setState(() {
        effortHoursController.text = effortHours.toString();
      });
    });
  }

  void _addMarker(LatLng position) {
    setState(() {
      _markers.clear(); // Clear previous markers
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
        ),
      );
      _position = position;
    });
  }


  void _save() {
    final String name = nameController.text;
    final String effort = effortHoursController.text;
    final int effortHours = double.tryParse(effort)?.toInt() ?? 0;

    setState(() {
      _validateName = name.isEmpty;
      _validateEffortHours = effort.isEmpty;
    });

    if (!_validateName && !_validateEffortHours) {
      Provider.of<TasksProvider>(context, listen: false).save(
        task!,
        name,
        effortHours,
        _position.latitude,
        _position.longitude,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Tarefa'),
      ),
      body: Consumer<TasksProvider>(
        builder: (context, tasksProvider, _) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.0),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Nome:',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: TextField(
                      controller: nameController,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        errorText: _validateName ? 'Name is required' : null,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Esforço (Hs):',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: SpinBox(
                      value: double.tryParse(effortHoursController.text) ?? 0,
                      min: 0,
                      max: 100,
                      incrementIcon: Icon(Icons.add),
                      decrementIcon: Icon(Icons.remove),
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        errorText: _validateEffortHours ? 'Esforço (Hs) is required' : null,
                      ),
                      onChanged: (value) {
                        setState(() {
                          effortHoursController.text = value.toString();
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Data:',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      DateFormat('dd/MM/yyyy').format(task?.date ?? DateTime.now()),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: GoogleMap(
                        onMapCreated: (controller) {
                          _mapController = controller;
                        },
                        markers: _markers,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(task?.latitude ?? 0, task?.longitude ?? 0),
                          zoom: 3.0,
                        ),
                        onTap: (position) {
                          _addMarker(position);
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: _save,
                        child: Text('Salvar'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
