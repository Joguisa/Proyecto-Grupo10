import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_grupo10/presentation/providers/providers.dart';
import 'package:proyecto_grupo10/presentation/widgets/widgets.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              _LoginCard(),
              const SizedBox(height: 50),
              const Text(
                'Crear una nueva cuenta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            'Login',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 30),
          ChangeNotifierProvider(
            create: (_) => LoginFormProvider(),
            child: _LoginForm(),
          ),
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: 'ejemplo@ug.edu.com',
              labelText: 'Correo electrónico',
              prefixIcon: Icons.alternate_email_rounded,
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no luce como un correo';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              hintText: '*****',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe de ser de 6 caracteres';
            },
          ),
          const SizedBox(height: 30),
          _LoginButton(),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      disabledColor: Colors.grey,
      elevation: 0,
      color: Colors.deepPurple,
      onPressed: loginForm.isLoading
          ? null
          : () async {
              FocusScope.of(context).unfocus();

              if (!loginForm.isValidForm()) return;

              // Validar las credenciales ingresadas
              final isValidCredentials = loginForm.validateCredentials();

              if (isValidCredentials) {
                loginForm.isLoading = true;

                // Usar Navigator.of(context) antes de la operación asíncrona
                final navigator = Navigator.of(context);

                await Future.delayed(const Duration(seconds: 2));

                // Credenciales válidas, avanzar a la siguiente página
                navigator.pushReplacementNamed('home');
              } else {
                // Credenciales incorrectas, mostrar mensaje de error
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Correo o contraseña incorrectos.'),
                  ),
                );
              }
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text(
          loginForm.isLoading ? 'Espere' : 'Ingresar',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
