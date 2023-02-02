import 'package:flutter/material.dart';
import 'package:safety_assistant/location.dart';
import 'package:telephony/telephony.dart';

class SmsScreen extends StatefulWidget {
  SmsScreen({required this.title, required this.coord});

  final String title;
  Coord coord;

  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  final Telephony telephony = Telephony.instance;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController1 = TextEditingController();
  final TextEditingController _msgController1 = TextEditingController();
  final TextEditingController _phoneController2 = TextEditingController();
  final TextEditingController _msgController2 = TextEditingController();
  final TextEditingController _valueSms = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController1.text = '9359875192';
    _phoneController2.text = '9511871194';
    _msgController1.text =
        'ALERT!I met with an accident at http://maps.google.com/maps?q=${widget.coord.latitude},${widget.coord.longitude} please help me out!';
    _msgController2.text =
        "Nearest Police Station: https://www.google.com/maps/search/police+stations+near+me/@${widget.coord.latitude},${widget.coord.longitude}";
    _valueSms.text = '10';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneController1,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter number to send';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Phone number',
                        labelText: 'Number'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneController2,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter number to send';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Phone number',
                        labelText: 'Number'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 9,
                    controller: _msgController1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message';
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Message text',
                      labelText: 'Message',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 9,
                    controller: _msgController2,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message';
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Message text',
                      labelText: 'Message',
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => _sendSMS(), child: const Text('Send SMS')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _sendSMS() async {
    int _sms = 0;
    telephony.sendSms(
        to: _phoneController1.text, message: _msgController1.text);
    telephony.sendSms(
        to: _phoneController1.text, message: _msgController2.text);
    telephony.sendSms(
        to: _phoneController2.text, message: _msgController1.text);
    telephony.sendSms(
        to: _phoneController2.text, message: _msgController2.text);
  }
}
