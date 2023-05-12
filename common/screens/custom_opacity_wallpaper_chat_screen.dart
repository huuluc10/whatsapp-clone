import 'package:chatapp_clone_whatsapp/common/widgets/custom_button.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/my_message_card.dart';
import 'package:chatapp_clone_whatsapp/features/chat/widgets/sender_message_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomWallpaperScreen extends StatefulWidget {
  const CustomWallpaperScreen({super.key});
  static const String routeName = '/custom-wallpaper';

  @override
  State<CustomWallpaperScreen> createState() => _CustomWallpaperScreenState();
}

class _CustomWallpaperScreenState extends State<CustomWallpaperScreen> {
  double _currentSliderValue = 0.3;

  void getValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? sliderValue = prefs.getDouble('sliderValue') ?? 0.3;
    _currentSliderValue = sliderValue;
    setState(() {});
  }

  void setValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('sliderValue', _currentSliderValue);
  }

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Wallpaper')),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/wallpaper.jpg'),
            fit: BoxFit.fill,
            opacity: _currentSliderValue,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: const [
                MyMessageCard(message: 'This is my message example', date: '', type: null,),
                SenderMessageCard(
                  message: 'This is sender message example',
                  date: '',
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  Slider(
                    value: _currentSliderValue,
                    max: 1,
                    min: 0,
                    activeColor: Colors.green,
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: CustomButton(
                        text: 'Change',
                        onPress: setValue,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
