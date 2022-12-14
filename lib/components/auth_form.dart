

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleshopflutter/exceptions/auth_exception.dart';

import '../models/auth.dart';

enum AuthMode {Signup, Login}

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with SingleTickerProviderStateMixin{

  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Map<String, String> _authData = {
    'email': '',
    'senha': ''
  };

  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.linear)
    );
    _slideAnimation = Tween(begin: Offset(0, -1.5), end: Offset(0,0)).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.linear)
    );
  
  }

  void dispose(){
    super.dispose();
    _controller?.dispose();
  }

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  void _switchAuthMode(){
    setState(() {
      if(_isLogin()){
        _authMode = AuthMode.Signup;
        _controller?.forward();
      }else {
        _authMode = AuthMode.Login;
        _controller?.reverse();
      }
    });
  }

  void _showErrorDialog(String msg){
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text("Erro"),
      content: Text(msg),
      actions: [
        TextButton(onPressed:()=> Navigator.of(context).pop(), child: Text("Fechar"))
      ],
    ));
  }

  Future<void> _submit() async{
    final isValid = _formKey.currentState?.validate() ?? false;
    if(!isValid){
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);
    
    try{
      if(_isLogin()){
        //Login
        await auth.singin(_authData['email']!, _authData['senha']!);
      }else{
        //Registrar
        await auth.signup(_authData['email']!, _authData['senha']!);
      }
    } on AuthException catch(error){
      _showErrorDialog(error.toString());
    }catch(error){
      _showErrorDialog('Ocorreu um erro inesperado!');
    }
    
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final device_size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 8,
      child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          height: _isLogin() ? 310 : 400,
          //height: _heightAnimation?.value.height ?? (_isLogin() ? 310 : 400),
          width: device_size.width*0.75,
          padding: const EdgeInsets.all(16),
          child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (_email){
                  final email = _email ?? '';
                  if(email.trim().isEmpty || !email.contains('@')){
                    return 'Informe um email v??lido';
                  }
                },
              ),

              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                controller: _passwordController,
                onSaved: (senha) => _authData['senha'] = senha ?? '',
                validator: _isLogin() 
                ? null 
                : (_password){
                  final password = _password ?? '';
                  if(password.isEmpty || password.length < 5){
                    return 'Informe uma senha valida';
                  }
                  return null;
                },
              ),
      
              AnimatedContainer(
                constraints: BoxConstraints(
                  minHeight: _isLogin() ?0 : 60,
                  maxHeight: _isLogin() ? 0 : 120
                ),
                duration: Duration(milliseconds: 300),
                curve: Curves.linear,
                child: FadeTransition(
                  opacity: _opacityAnimation!,
                  child: SlideTransition(
                    position: _slideAnimation!,
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Confirmar senha'),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      validator: _isLogin()
                      ? null
                      :(_senha){
                        final password = _senha ?? '';
                        if(password != _passwordController.text){
                          return 'Senhas informadas n??o s??o iguais';
                        }
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),

              if(_isLoading )
              CircularProgressIndicator()
              else
              ElevatedButton(
                onPressed: _submit, 
                child: Text(_authMode == AuthMode.Login ? "Entrar" : "Registrar"), 
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8)
                ),
              ),

              Spacer(),

              TextButton(
                onPressed: _switchAuthMode,
                child: Text(_isLogin() ? 'Registrar-se' : 'J?? possui conta?'),
              )
            ],
          ),
        ),
      ),
    );
  }
}