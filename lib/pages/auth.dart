import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:leo/scoped_models/main.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        fit: BoxFit.cover,
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
        image: AssetImage('assets/background.jpg'));
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  void _submitForm(Function login) {
    if (!_formData['acceptTerms']) {
      return;
    }
    // _formKey.currentState.save();
    login(_formData['email'], _formData['password']);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(image: _buildBackgroundImage()),
            child: ListView(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'E-Mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (String value) {
                    setState(() {
                      _formData['email'] = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      _formData['password'] = value;
                    });
                  },
                ),
                _buildAcceptSwitch(),
                SizedBox(
                  height: 10.0,
                ),
                ScopedModelDescendant<MainModel>(
                  builder:
                      (BuildContext cotext, Widget child, MainModel model) {
                    return RaisedButton(
                      child: Text('LOGIN'),
                      onPressed: () => _submitForm(model.login),
                    );
                  },
                ),
              ],
            )));
  }
}
