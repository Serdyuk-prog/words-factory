import 'package:flutter/material.dart';
import 'package:words_factory/home.dart';
import 'package:words_factory/onboarding.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _obscureText = true;
  final List<TextEditingController> _controller =
      List.generate(3, (i) => TextEditingController());

  final List<bool> _validate = [false, false, false];

  @override
  void dispose() {
    _controller.map((e) => e.dispose());
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 20),
                  height: 50,
                  width: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const Onboarding(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        )),
                        side: MaterialStateProperty.all(const BorderSide(
                            color: Colors.black,
                            width: 0.5,
                            style: BorderStyle.solid)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    child: const Icon(
                      Icons.arrow_back_ios_new_sharp,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Center(
                child: SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: Image.asset('assets/sign_up.png')),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  height: 1.33,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Create your account",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w400, height: 1.5),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
              child: TextField(
                controller: _controller[0],
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w400, height: 1),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  labelText: 'Name',
                  hintText: 'Your name',
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
              child: TextField(
                controller: _controller[1],
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w400, height: 1),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                  ),
                  labelText: 'E-mail',
                  hintText: 'Enter valid e-mail id as abc@gmail.com',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15),
              child: TextField(
                controller: _controller[2],
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w400, height: 1),
                obscureText: _obscureText,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    labelText: 'Password',
                    hintText: 'Enter secure password',
                    suffixIcon: IconButton(
                        color: Colors.black,
                        onPressed: _toggle,
                        icon: Icon(_obscureText == true
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined))),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                onPressed: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => HomePage()));
                  // print(_validate);
                  // print(_controller[1].text.isEmpty);
                  setState(() {
                    for (var i = 0; i < 3; i++) {
                      _controller[i].text.isEmpty
                          ? _validate[i] = true
                          : _validate[i] = false;
                    }
                  });
                  if (!_validate.every((element) => element == false)) {
                    errorAlert(context);
                  } else {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Home()));
                  }
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                onPressed: () {},
                child: const Text(
                  'Log in',
                  style: TextStyle(
                      color: Color.fromARGB(255, 120, 116, 109), fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> errorAlert(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Values Can\'t Be Empty'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
