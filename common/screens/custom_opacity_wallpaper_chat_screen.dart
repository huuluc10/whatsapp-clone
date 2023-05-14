import 'package:chatapp_clone_whatsapp/common/enums/message_enum.dart';
import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
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
    showSnackBar(context: context, content: 'Đã thay đổi thành công');
  }

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Điều chỉnh')),
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
                MyMessageCard(
                  message: 'Tin nhắn 1',
                  date: '',
                  type: MessageEnum.text,
                  messageId: '',
                  recieverUserId: '',
                ),
                SenderMessageCard(
                  message: 'Tin nhắn 2',
                  date: '',
                  type: MessageEnum.text,
                  messageId: '',
                  recieverUserId: '',
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
                        text: 'Thay đổi',
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
