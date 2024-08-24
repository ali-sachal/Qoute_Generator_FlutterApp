import 'package:flutter/material.dart';
import 'package:qoutes/qoute_model.dart';

import 'api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool inProcess = false;
  QuoteModel? quote;

  @override
  void initState() {
    _fetchQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Qoutes By Great",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white24,
                  ),
                  height: 300,
                  width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30,
                          right: 20,
                          left: 20,
                          bottom: 20
                      ),
                    child:Text(
                      quote?.q ?? "_____________",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Colors.amber
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Text(quote?.a ?? ".........",
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.deepOrange,
                        fontFamily: 'serif')),
                const Spacer(),
                inProcess
                    ? const CircularProgressIndicator(color: Colors.white)
                    : ElevatedButton(
                        onPressed: () {
                          _fetchQuote();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade300),
                        child: const Text(
                          "Generate",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _fetchQuote() async {
    setState(() {
      inProcess = true;
    });
    try {
      final fetchedQuote = await Api.fetchRandomQuote();
      debugPrint(fetchedQuote.toJson().toString());
      setState(() {
        quote = fetchedQuote;
      });
    } catch (e) {
      debugPrint("Failed to Generate Quote");
    } finally {
      setState(() {
        inProcess = false;
      });
    }
  }
}
