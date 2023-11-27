import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
              const SizedBox(
                height: 50,
              ),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(126, 226, 226, 226),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.bookmark_border,
                      color: Color.fromRGBO(21, 34, 79, 1),
                    ),
                  ),
                ),
                title: const Text(
                  "Bookmark",
                  style: TextStyle(
                    color: Color.fromRGBO(21, 34, 79, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(126, 226, 226, 226),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.settings,
                        color: Color.fromRGBO(21, 34, 79, 1),
                      ),
                    ),
                  ),
                  title: const Text(
                    "Settings",
                    style: TextStyle(
                      color: Color.fromRGBO(21, 34, 79, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(126, 226, 226, 226),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.question_mark,
                      color: Color.fromRGBO(21, 34, 79, 1),
                    ),
                  ),
                ),
                title: const Text(
                  "Update App",
                  style: TextStyle(
                    color: Color.fromRGBO(21, 34, 79, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(126, 226, 226, 226),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.logout,
                      color: Color.fromRGBO(21, 34, 79, 1),
                    ),
                  ),
                ),
                title: const Text(
                  "Log out",
                  style: TextStyle(
                    color: Color.fromRGBO(21, 34, 79, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
