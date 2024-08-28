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
    readLink();
    fetchData();
    Timer.periodic(const Duration(seconds: 5), (Timer t) => fetchData());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                          Navigator.pushNamed(context, '/settings');
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
                    containG("CPU", "$cpuUsage%", cpuUsage, 100, colorCPU,
                        colorBack, width),
                    const SizedBox(width: 25),
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
                containL(width, diskUsage,
                    "${diskUseGB.toStringAsFixed(2)}/${diskTotGB.toStringAsFixed(2)}GB"),
                const SizedBox(height: 25),
                containC(width, height, "CPU Usage", cpuUsage.toString(), usage,
                    cpuData),
                const SizedBox(height: 25),
                containC(
                    width,
                    height,
                    "Memory Usage",
                    "${memoryUsed}/${memoryTotal}MB",
                    memoryFree.toString(),
                    memData),
                const SizedBox(height: 25),
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
      final file = File(filePath);

      if (await file.exists()) {
        // If the file exists, read the contents
        final contents = await file.readAsString();
        setState(() {
          url = contents.trim();
        });
      } else {
        final link = await rootBundle.loadString('assets/link.txt');
        await file.create(recursive: true);
        await file.writeAsString(link.trim());
        setState(() {
          url = link.trim();
        });
      }
      fetchData();
    } catch (e) {
      print("Error reading the link file: $e");
    }
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        cpuUsage = data['cpu_usage_percentage'];
        memoryTotal = data['memory_usage']['total_mb'].toDouble();
        memoryUsed = data['memory_usage']['used_mb'].toDouble();
        memoryTotGB = memoryTotal / 1024;
        memoryUsedGB = memoryUsed / 1024;
        memUsage = (memoryUsed / memoryTotal) * 100;
        memoryFree = memoryTotal - memoryUsed;
        diskTotal = data['disk_usage']['total_mb'].toDouble();
        diskUsed = data['disk_usage']['used_mb'].toDouble();
        diskFree = (data['disk_usage']['free_mb'].toDouble()) / 1024;
        diskUsage = (diskUsed / diskTotal) * 100;
        diskTotGB = diskTotal / 1024;
        diskUseGB = diskUsed / 1024;
        if (cpuUsage <= 30) {
          usage = "Low";
        } else if (cpuUsage > 30 && cpuUsage <= 70) {
          usage = "Medium";
        } else {
          usage = "High";
        }
        time += 1;
        cpuData.add(FlSpot(time.toDouble(), cpuUsage));
        memData.add(
            FlSpot(time.toDouble(), double.parse(memUsage.toStringAsFixed(2))));
        diskData.add(FlSpot(
            time.toDouble(), double.parse(diskUsage.toStringAsFixed(2))));
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
