import 'package:flutter/material.dart';

class IncrementBtn extends StatefulWidget {
  const IncrementBtn({super.key});

  @override
  State<IncrementBtn> createState() => _IncrementBtnState();
}

class _IncrementBtnState extends State<IncrementBtn> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    
    void IncrementCounter(){
      setState(() {
        counter++;
      });
    }
    
    void DecrementCounter(){
      setState(() {
        counter--;
      });
    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('State Manage Buttons'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
                '$counter',style: TextStyle(fontSize: 40),
            ),
          ),
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: IncrementCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue
                  ),
                  child: Text('Increment',style: TextStyle(color: Colors.white),)
              ),
              SizedBox(width: 30,),
              ElevatedButton(onPressed: DecrementCounter,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text('Decrement',style: TextStyle(color: Colors.white),)
              )
            ],
          )
        ],
      ),

    );
  }
}
