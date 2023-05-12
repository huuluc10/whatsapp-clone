import 'dart:io';
import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:chatapp_clone_whatsapp/common/widgets/custom_button.dart';
import 'package:chatapp_clone_whatsapp/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  static const routeName = '/user-information';

  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  File? image;
  String? username;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGalary(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text;

    if (name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
            context,
            name,
            image,
          );
    }
  }

  void logout() async {
    ref.read(authControllerProvider).logout(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                const SizedBox(height: 14),
                Stack(
                  children: [
                    image == null
                        ? const CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://as1.ftcdn.net/v2/jpg/03/53/11/00/1000_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg'),
                            radius: 64,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(image!),
                            radius: 64,
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                        width: 50,
                        height: 40,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: ref.read(authControllerProvider).getUserData(),
                  builder: (context, snapshot) {
                    String username;
                    String phoneNumber = 'Data is loading';
                    if (snapshot.hasData) {
                      username = snapshot.data!.name;
                      if (username.isNotEmpty) {
                        nameController.text = username;
                      }
                      phoneNumber = snapshot.data!.phoneNumber;
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(
                                    Icons.person_2,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.75,
                                    child: TextField(
                                      controller: nameController,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your name',
                                        label: Text('Name'),
                                        labelStyle: TextStyle(
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.75,
                                    padding: const EdgeInsets.only(top: 5),
                                    child: const Text(
                                      'This is not your username or pin. This name will be visible to your Application contacts.',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                              IconButton(
                                onPressed: storeUserData,
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Divider(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Phone',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    phoneNumber,
                                    style: const TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                // Expanded(child: Container()),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 88,
                          height: 40,
                          child: CustomButton(text: 'Log out', onPress: logout),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
