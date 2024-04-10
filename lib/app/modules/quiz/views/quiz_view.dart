import 'package:flutter/material.dart';

class QuizView extends StatelessWidget {
  const QuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF732DA2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF732DA2) ,
        title: Text('Quiz', style: TextStyle(color: Colors.grey.shade200, fontWeight: FontWeight.bold),   ),
          centerTitle: true,

      ),

      body: SingleChildScrollView(

        child: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                buildHeroTile(
                  context,
                  'Flutter quiz ',
                  'Flutter quiz',
                  'questions concerning widgets',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(3),
                  ),
                ),
                buildHeroTile(
                  context,
                  'Flutter quiz ',
                  'Flutter quiz',
                  'questions concerning get cli',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(3),
                  ),
                ),
                buildHeroTile(
                  context,
                  'Flutter quiz ',
                  'Flutter quiz',
                  'questions about Stateful and stateless',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(3),
                  ),
                ),
                buildHeroTile(
                  context,
                  'Flutter quiz ',
                  'Flutter quiz',
                  'questions concerning get cli',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(3),
                  ),
                ),
                buildHeroTile(
                  context,
                  'Flutter quiz ',
                  'Flutter quiz',
                  'questions concerning get cli',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(3),
                  ),
                ),
                buildHeroTile(
                  context,
                  'Flutter quiz ',
                  'Flutter quiz',
                  'questions concerning get cli',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(3),
                  ),
                ),
                buildHeroTile(
                  context,
                  'Flutter quiz ',
                  'Flutter quiz',
                  'questions concerning get cli',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(
                    padding: EdgeInsets.all(3),
                  ),
                ),
                buildHeroTile(
                  context,
                  'Flutter quiz ',
                  'Flutter quiz',
                  'questions concerning get cli',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(

                    padding: EdgeInsets.all(3),
                  ),
                ),
                buildHeroTile(
                  context,
                  'Flutter quiz ',
                  'Flutter quiz',
                  'questions concerning get cli',
                  Colors.grey.shade200,
                  SizedBox(height: 2),
                  Container(

                    padding: EdgeInsets.all(3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeroTile(BuildContext context, String tag, String title,
      String subtitle, Color tileColor, Widget? sizedBox, Widget? container) {
    return Column(
      children: [
        if (sizedBox != null) sizedBox,
        if (container != null) container,
        Hero(
          tag: tag,
          child: Material(
            child: ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
              tileColor: tileColor,
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(title: const Text('ListTile Hero')),
                    body: Center(
                      child: Hero(
                        tag: 'ListTile-Hero',
                        child: Material(
                          child: ListTile(
                            title: const Text('ListTile with Hero'),
                            subtitle: const Text('Tap here to go back'),
                            tileColor: Colors.blue[700],
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }));
              },
            ),
          ),
        ),
      ],
    );
  }
}