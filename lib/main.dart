import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplitMoney(),
    );
  }
}

class SplitMoney extends StatefulWidget {
  const SplitMoney({super.key});

  @override
  State<SplitMoney> createState() => _SplitMoneyState();
}

class _SplitMoneyState extends State<SplitMoney> {
  int? people;
  double? amount;
  var taxes = [0, 3, 5, 7, 10, 15];
  int tax = 0;
  double? result;
  bool isFinished = false;

  TextEditingController peopleCtrl = TextEditingController();
  TextEditingController amountCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text("Splitter"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.people_alt_outlined,
                ),
                title: TextField(
                  onTap: () {
                    isFinished = false;
                    result = null;
                    setState(() {});
                  },
                  controller: peopleCtrl,
                  onChanged: (newVal) {
                    people = int.parse(newVal);
                    var taxPercent = amount! * tax / 100;
                    result = (amount! + taxPercent) / people!;
                    setState(() {});
                  },
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.indigo.shade300,
                  decoration: const InputDecoration(
                    label: Text("Number of People"),
                    floatingLabelStyle: TextStyle(
                      color: Colors.indigo,
                    ),
                    labelStyle: TextStyle(),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo)),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.monetization_on_outlined),
                title: TextField(
                  onTap: () {
                    isFinished = false;
                    result = null;
                    setState(() {});
                  },
                  controller: amountCtrl,
                  onChanged: (newVal) {
                    amount = double.parse(newVal);
                    var taxPercent = amount! * tax / 100;
                    result = (amount! + taxPercent) / people!;
                    setState(() {});
                  },
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.indigo.shade300,
                  decoration: const InputDecoration(
                    label: Text("Amount"),
                    floatingLabelStyle: TextStyle(color: Colors.indigo),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 13),
                      child: Text(
                        "Tax:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DropdownButton(
                      value: tax,
                      items: taxes.map((elem) {
                        return DropdownMenuItem(
                          value: elem,
                          child: Text("$elem"),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          tax = newVal!;
                          var taxPercent = amount! * tax / 100;
                          result = (amount! + taxPercent) / people!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: Column(
                  children: [
                    !isFinished && result != null
                        ? Text("$result")
                        : Container(),
                    isFinished
                        ? Text(
                            "$result per Person",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        : Container(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MaterialButton(
                  disabledColor: Colors.indigo.shade200,
                  onPressed: people == null || amount == null
                      ? null
                      : () {
                          // if (people == null || amount == null) {
                          //   result = null;
                          //   isFinished = false;
                          //   debugPrint(">>>>>>>$result");
                          //   null;
                          // } else
                          isFinished = true;
                          people = null;
                          amount = null;
                          tax = 0;
                          debugPrint(">>>>>>> $people &&&&&& $amount <<<<<<<<");

                          peopleCtrl.clear();
                          amountCtrl.clear();

                          setState(() {});
                        },
                  minWidth: MediaQuery.of(context).size.width,
                  color: Colors.indigo.shade300,
                  padding: const EdgeInsets.all(5),
                  child: const Text(
                    "Split",
                    style: TextStyle(fontSize: 18),
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
