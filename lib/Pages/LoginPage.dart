
import 'package:flutter/material.dart';
import 'package:projetflutter/Objects/User.dart';
import 'package:projetflutter/Pages/MainPage.dart';

import '../Controllers/HttpServiceUser.dart';

class LoginPage extends StatefulWidget{


  @override
  State<StatefulWidget> createState() => LoginState();

}

class LoginState extends State<LoginPage> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var httpserviceuser = HttpServiceUser();

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    final Height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.yellow,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: EdgeInsets.only(top: Height*0.1),
                child: Form(
                  key: _formKey,
                  child:Container(
                    //color: Colors.blue,
                    width: Width>600 ? Width*0.3 : Width*0.75,
                    height: Height>300 ? Height*0.4 : Height*0.9,

                    //padding : EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.4),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Connexion",
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 40,
                              ),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              obscureText: true,
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: const InputDecoration(

                                labelText: 'Mot de passe',
                                prefixIcon: Icon(Icons.password),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaterialButton(
                              padding: const EdgeInsets.all(20.0),
                              minWidth: Width>600 ? Width*0.30 : Width*0.5,
                              onPressed: () async {
                                if (await Connect(emailController.text, passwordController.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Vous etes connecté')),
                                  );
                                  User user = await getUser(emailController.text);
                                  await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage(true, user)));
                                  //Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Login ou mot de passe incorrect')),
                                  );
                                }
                              },
                              color: Colors.indigoAccent,
                              textColor: Colors.white,
                              child: Text("Se connecter"),
                            ),
                          )
                        ],
                      ),
                    ),
                  )

                ),
              ),

            ],
          ),
        ),
      ),

    );
  }

  Future<bool> Connect(String email, String password) async {
    List<User> users = await httpserviceuser.getAllUsers();
    for(User user in users) {
      if (user.mail == email) {
        if (user.password == password) {
          return true;
        }
      }
    }
    return false;
  }
  Future<User> getUser(String email) async {
    List<User> users = await httpserviceuser.getAllUsers();
    for(User user in users) {
      if (user.mail == email) {
        return user;
      }
    }
    return User(0,"null","null","null","null",false,[],[]);
  }

}