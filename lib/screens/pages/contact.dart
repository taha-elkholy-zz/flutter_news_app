import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController _nameController, _emailController, _messageController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: (isLoading) ? _loading() : _contactForm(),
      ),
    );
  }

  Widget _contactForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Your Name',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Your Name!';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Your Email',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter Your Email!';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Message ',
              ),
              maxLines: 4,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Write Your Message!';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    String name = _nameController.text;
                    String email = _emailController.text;
                    String message = _messageController.text;
                    setState(() {
                      isLoading = true;
                    });
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: Text(
                  'Send Message',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _sendMessage() {}
}
