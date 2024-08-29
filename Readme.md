## Table of Contents
- [About the App](#about-the-app)
- [App features](#app-features)
- [Help](#help)
  - [For Users](#for-users)
  - [For Developers](#for-developers)
- [Screenshots](#screenshots)
  
## About the App
System Monitor app is a minimalistic app build using flutter which helps you monitor your system status hosted on a server (in JSON format) from anywhere you want.

## App features:
* Minimal interface
* Real time monitoring
* Change URL any time
* Supports graphs, pie charts and linear charts
* No login needed
* Your data is not uploaded anywhere

## Help
### For Users
* Download latest release of the app from [Releases](https://github.com/aswin-asokan/System-Monitor/releases/)
* Click on Settings icon:
  
  <img src="https://github.com/user-attachments/assets/ebbd8e5d-4795-4b23-b1dc-292f18f7fef9" alt="step1: click on settings" height="500"/>
  
* Enter your source link in the text field and press save button.
  
  <img src="https://github.com/user-attachments/assets/7ead4a10-637d-4df7-88f1-39253c058e8f" alt="step2" height="500"/>
  
* Restart the app and you are good to go.

### For Developers
* Setup your system monitoring real time data and host it. Make sure that it is in JSON format as follows:

```json
{
  "cpu_usage_percentage": -> CPU utilization percentage
  "memory_usage": { 
    "total_mb": -> Total RAM capacity
    "used_mb": -> Currently used RAM
    "free_mb": -> Free RAM available
  },
  "disk_usage": {
    "total_mb": -> Total capacity of HDD storage
    "used_mb": -> Currently used storage
    "free_mb": -> Free available storage
  }
}
```

Example API Response:

```json
{
  "cpu_usage_percentage": 25.6,
  "memory_usage": {
    "total_mb": 1963,
    "used_mb": 1153,
    "free_mb": 88
  },
  "disk_usage": {
    "total_mb": 39511,
    "used_mb": 21401,
    "free_mb": 18110
  }
}
```

* Make sure to copy your source link
* Clone/Fork the repository to your system.
* Go to your assets folder.

  <img src="https://github.com/user-attachments/assets/5d60babf-9674-4aaa-b209-472176857d52" alt="folder" />
  
* Open the link.txt file.

  <img src="https://github.com/user-attachments/assets/f2b89597-5af6-4548-aab5-1ef913fe4162" alt="file"/>
  
* Change 'Your-Link-Here' to the required Source Link.

  <img src="https://github.com/user-attachments/assets/c3da4fe9-9cfc-4496-899f-419cd2146a67" alt="link.txt"/>

* This link will serve as the initial data to be fetched to the app (The app won't allow users to view or copy this link. Make sure to edit Settings.dart for making the link not editable if needed.)

  To remove the editing option go to **lib -> pages -> settings.dart**. Find and remove the code snippets given below:
  
```dart
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
  ),
```

  ```dart
  Future<void> writeData(String data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/assets/link.txt');
    await file.writeAsString(data);
  }

  _launchURL() async {
    final Uri url = Uri.parse('https://aswin-asokan.github.io/System-Monitor/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
```
* To get the Help documentation inside the app by connecting it to **Readme.md** file in your repository:
  
    * Go to the spplication repository in you github account.
    * In it's settings go to **Settings**.
    * In the left menu choose **Pages** and choose main as your branch.

      <img src="https://github.com/user-attachments/assets/67f9a038-e37b-4a75-8af8-a7017788ab11" alt="help">
    * Now go to **lib -> pages -> help** and find the below code snippet:

      ```dart
        @override
      void initState() {
        super.initState();
        controller = WebViewController()
          ..loadRequest(
            Uri.parse(
                'Your-ghPage-Link-Here'), //Paste your github page containing documentation link here
            //get the help page hosted as github page at initial state for webview loading
          );
      }
      ```
    * Paste your github page link in the **Your-ghPage-Link-Here** line.

* Run/Build your application.

## Screenshots

<div>
    <img src="https://github.com/user-attachments/assets/2f9255fd-ed67-4bdf-b70b-9884f3de745c" alt="home" height="500"/>
    <img src="https://github.com/user-attachments/assets/cc0cb7e9-b7d6-4f03-bac5-ba5a2d930b64" alt="cpu/mem" height="500"/>
    <img src="https://github.com/user-attachments/assets/233394c3-5169-4ddc-a1df-fc4d5ac14497" alt="mem/disk" height="500"/>
    <img src="https://github.com/user-attachments/assets/2d21af24-68ee-4ab0-8168-912d37fcae47" alt="settings" height="500"/>
    <img src="https://github.com/user-attachments/assets/d0164449-4180-4dd4-8cdb-e3175586df07" alt="toast1" height="500"/>
    <img src="https://github.com/user-attachments/assets/e645573a-b378-447e-a8fd-59b1296dd07e" alt="toast2" height="500"/>
</div>



  
