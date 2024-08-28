import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:status_usage/components/containC.dart';
import 'package:status_usage/components/containG.dart';
import 'package:status_usage/components/containL.dart';
import 'package:status_usage/colors.dart';
import 'package:status_usage/variables.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    readLink(); //read from file
    fetchData(); //fetch data from link
    Timer.periodic(const Duration(seconds: 5),
        (Timer t) => fetchData()); //fetch data every five seconds
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width; //get device width
    double height = MediaQuery.of(context).size.height; //get device height
    return Scaffold(
      backgroundColor: colorBack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "System Monitor",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/settings'); //push to settings page
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ))
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    //pichart for cpu usage
                    containG("CPU", "$cpuUsage%", cpuUsage, 100, colorCPU,
                        colorBack, width),
                    const SizedBox(width: 25),

                    //pie chart for memory usage
                    containG(
                      "Memory",
                      "${memoryUsedGB.toStringAsFixed(2)}/${memoryTotGB.toStringAsFixed(2)}GB",
                      memoryUsed,
                      memoryTotal,
                      colorMem,
                      colorBack,
                      width,
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                //linear chart for disk usage
                containL(width, diskUsage,
                    "${diskUseGB.toStringAsFixed(2)}/${diskTotGB.toStringAsFixed(2)}GB"),
                const SizedBox(height: 25),

                //graph for cpu
                containC(width, height, "CPU Usage", cpuUsage.toString(), usage,
                    cpuData),
                const SizedBox(height: 25),

                //graph for memory
                containC(
                    width,
                    height,
                    "Memory Usage",
                    "${memoryUsed}/${memoryTotal}MB",
                    memoryFree.toString(),
                    memData),
                const SizedBox(height: 25),

                //graph for disk
                containC(
                    width,
                    height,
                    "Disk Usage",
                    "${diskUseGB.toStringAsFixed(2)}/${diskTotGB.toStringAsFixed(2)}GB",
                    diskFree.toStringAsFixed(2),
                    diskData),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Functions

  Future<void> readLink() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/assets/link.txt';
      final file = File(filePath); //get link from linkt.txt

      if (await file.exists()) {
        // If the file exists, read the contents
        final contents = await file.readAsString();
        setState(() {
          url = contents.trim(); //set the url value to link from file
        });
      } else {
        //if file does not exist load default file value
        final link = await rootBundle.loadString('assets/link.txt');

        //create a new file for editing through textfield later
        await file.create(recursive: true);

        //write the initial link to the newly created file
        await file.writeAsString(link.trim());
        setState(() {
          url = link.trim(); //set the url value to link from file
        });
      }
      fetchData();
    } catch (e) {
      print("Error reading the link file: $e");
    }
  }

  Future<void> fetchData() async {
    //get response from the url from file
    final response = await http.get(Uri.parse(url));
    //2xx (Success) means the request was successfully received, understood, and accepted.
    //If success
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        cpuUsage = data['cpu_usage_percentage'];
        memoryTotal = data['memory_usage']['total_mb'].toDouble();
        memoryUsed = data['memory_usage']['used_mb'].toDouble();
        memoryTotGB = memoryTotal / 1024; //conversion to GB
        memoryUsedGB = memoryUsed / 1024; //conversion to GB
        memUsage = (memoryUsed / memoryTotal) * 100; //percentage calculation
        memoryFree = memoryTotal - memoryUsed; //free space calculation
        diskTotal = data['disk_usage']['total_mb'].toDouble();
        diskUsed = data['disk_usage']['used_mb'].toDouble();
        diskFree = (data['disk_usage']['free_mb'].toDouble()) /
            1024; //conversion to GB
        diskUsage = (diskUsed / diskTotal) * 100; //percentage calculation
        diskTotGB = diskTotal / 1024; //conversion to GB
        diskUseGB = diskUsed / 1024; //conversion to GB

        //usage warning text
        if (cpuUsage <= 30) {
          usage = "Low";
        } else if (cpuUsage > 30 && cpuUsage <= 70) {
          usage = "Medium";
        } else {
          usage = "High";
        }

        //time incrementer for graph
        time += 1;

        //adding the values from link every 5 seconds to list to be used in graph as values
        //cpu values list
        cpuData.add(FlSpot(time.toDouble(), cpuUsage));

        //memory values list
        memData.add(
            FlSpot(time.toDouble(), double.parse(memUsage.toStringAsFixed(2))));

        //disk values list
        diskData.add(FlSpot(
            time.toDouble(), double.parse(diskUsage.toStringAsFixed(2))));

        //remove values at a threshold in FCFS manner for ease of use
        if (cpuData.length > 10) {
          cpuData.removeAt(0);
        }
        if (memData.length > 10) {
          memData.removeAt(0);
        }
        if (diskData.length > 10) {
          diskData.removeAt(0);
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}
