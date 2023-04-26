import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => RegisterState();
}

class RegisterState extends State<RegisterPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool nameSubmited = true;
  bool firstnameSubmited = true;
  bool passwordSubmited = true;
  bool emailSubmited = true;

  bool hasEnoughChar(TextEditingController ed) {
    final text = ed.value.text;
    if (text.isEmpty || text.length < 4) {
      return false;
    }
    return true;
  }

  bool isCorrectEmail(TextEditingController ed){
    return RegExp(r"^\S+@\S+\.\S+")
        .hasMatch(ed.value.text);
  }

  @override
  Widget build(BuildContext context) {
    final Width = MediaQuery.of(context).size.width;
    final Height = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                        //padding : EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.4),
                        width: Width>600 ? Width*0.3 : Width*0.75,
                        height: Height>300 ? Height*0.6 : Height*0.9,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Créer un compte",
                                softWrap: false,
                                style: TextStyle(

                                    fontSize: 40
                                ),),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: 'Nom',
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(),
                                    errorText: nameSubmited ? null : 'Trop court',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: firstnameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: 'Prénom',
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(),
                                    errorText: firstnameSubmited ? null : 'Trop court',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder(),
                                    errorText: emailSubmited ? null : "L'email n'est pas correct",
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  obscureText: true,
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    labelText: 'Mot de passe',
                                    prefixIcon: Icon(Icons.password),
                                    border: OutlineInputBorder(),
                                    errorText: passwordSubmited ? null : 'Trop court',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  padding: const EdgeInsets.all(20.0),
                                  minWidth: Width>600 ? Width*0.30 : Width*0.5,
                                  //minWidth: MediaQuery.of(context).size.width * 0.15,

                                  onPressed: (){
                                    setState(() {
                                      hasEnoughChar(nameController) ? nameSubmited = true : nameSubmited = false;
                                      hasEnoughChar(firstnameController) ? firstnameSubmited = true : firstnameSubmited = false;
                                      hasEnoughChar(passwordController) ? passwordSubmited = true : passwordSubmited = false;
                                      isCorrectEmail(emailController) ? emailSubmited = true : emailSubmited = false;

                                    });
                                    if(nameSubmited && firstnameSubmited && passwordSubmited && emailSubmited){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Votre compte a bien été crée")),
                                      );
                                      Navigator.pop(context);
                                    }
                                    else{
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Les informations n'ont pas été remplies correctement")),
                                      );
                                    }
                                  }
                                  ,//,
                                  color: Colors.indigoAccent,
                                  textColor: Colors.white,
                                  child: const Text("M'inscrire"),
                                ),
                              )
                            ],),
                        ),
                      )

                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}