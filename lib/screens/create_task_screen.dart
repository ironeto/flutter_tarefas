import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../providers/task_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateTaskScreen extends StatefulWidget {
  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _effortHoursController = TextEditingController();
  LatLng _position = LatLng(0, 0);

  bool _validateName = false;
  bool _validateEffortHours = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _position = LatLng(position.latitude, position.longitude);
    });
  }

  void _createTask(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    final String name = _nameController.text;
    int effortHours = 0;
    try {
      effortHours = int.parse(_effortHoursController.text);
    } catch (e) {
      effortHours = 1;
    }

    tasksProvider.addTask(name, effortHours, _position.latitude, _position.longitude);

    Navigator.of(context).pop(); // Navigate back to the task list screen
  }

  bool _validateFields() {
    bool isValid = true;

    if (_nameController.text.isEmpty) {
      setState(() {
        _validateName = true;
      });
      isValid = false;
    } else {
      setState(() {
        _validateName = false;
      });
    }

    if (_effortHoursController.text.isEmpty) {
      setState(() {
        _validateEffortHours = true;
      });
      isValid = false;
    } else {
      setState(() {
        _validateEffortHours = false;
      });
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController? _mapController;
    Set<Marker> _markers = {};

    void _addMarker(LatLng position) {
      _markers.clear(); // Clear previous markers
      _markers.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
        ),
      );
      _position = position;
    }

    return ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Criar Tarefa'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  errorText: _validateName ? 'O campo Nome é obrigatório' : null,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _effortHoursController,
                decoration: InputDecoration(
                  labelText: 'Esforço (Hs)',
                  errorText: _validateEffortHours ? 'O campo Esforço é obrigatório' : null,
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                    markers: _markers,
                    initialCameraPosition: CameraPosition(
                      target: _position,
                      zoom: 15.0,
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
                    onPressed: () {
                      if (_validateFields()) {
                        _createTask(context);
                      }
                    },
                    child: Text('Salvar'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
