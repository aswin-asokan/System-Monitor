import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:status_usage/colors.dart';
import 'package:status_usage/variables.dart';
import 'package:toastification/toastification.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController controller = TextEditingController(text: url);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorBack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context, '/home');
                        },
                        icon: Icon(
                          Symbols.chevron_backward,
                          color: Colors.white,
                          size: width * 0.1,
                        )),
                    Text(
                      "Settings",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Symbols.monitoring,
                      color: colorCPU,
                      size: width * 0.3,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "System Monitor",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "Monitor your device from Anywhere!",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w200),
                        ),
                      ],
                    )
                  ],
                ),
                //Removable if editing is not required
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          toast(context,
                              "'Enter the link where your system monitoring data is stored in the given text field'");
                        },
                        icon: Icon(
                          Symbols.help_outline,
                          color: Colors.white,
                          size: width * 0.04,
                        )),
                    Text(
                      "Change Link:",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    TextField(
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: width * 0.04,
                      ),
                      controller: controller,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: colorCPU), // Color when not focused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: colorCPU), // Color when focused
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: width * 0.08,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(colorCPU),
                          ),
                          onPressed: () async {
                            String link = controller.text.toString();
                            await writeData(link);
                            toast(context,
                                "Restart the application for changes to take place.");
                          },
                          child: Text(
                            "Save",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ],
                ), //Remove until here

                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text("Need any Help? ",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w200)),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/help');
                        },
                        child: Text("Click Here",
                            style: GoogleFonts.poppins(
                                color: Colors.blueAccent,
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w200)))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Functions
  //Write data to link file
  Future<void> writeData(String data) async {
    final directory =
        await getApplicationDocumentsDirectory(); //get directory path
    final file = File('${directory.path}/assets/link.txt'); //set file path
    await file.writeAsString(data); //write to file
  }
}

//toast generator
void toast(BuildContext context, String text) {
  //text represent toast message
  toastification.show(
    style: ToastificationStyle.flatColored,
    primaryColor: colorCPU,
    backgroundColor: colorContain,
    context: context, // optional if you use ToastificationWrapper
    title: Text(
      text,
      style: GoogleFonts.poppins(color: Colors.white),
    ),
    autoCloseDuration: const Duration(seconds: 5),
  );
}
