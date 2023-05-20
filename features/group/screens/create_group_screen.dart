import 'dart:io';
import 'package:chatapp_clone_whatsapp/common/enums/source_file_enum.dart';
import 'package:chatapp_clone_whatsapp/common/utils/colors.dart';
import 'package:chatapp_clone_whatsapp/common/utils/utils.dart';
import 'package:chatapp_clone_whatsapp/features/group/controller/group_controller.dart';
import 'package:chatapp_clone_whatsapp/features/group/widgets/select_contact_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../common/screens/main_screen_layout.dart';

class CreateGroupScreen extends ConsumerStatefulWidget {
  const CreateGroupScreen({super.key});
  static const routeName = '/create-group';

  @override
  ConsumerState<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
  File? image;
  TextEditingController nameGroup = TextEditingController();

  void selectImage() async {
    image = await pickImage(context, SourceFile.gallary);
    setState(() {});
  }

  Future<File> getImageFileFromAssets() async {
    final byteData = await rootBundle.load('assets/group.jpg');

    final file = File('${(await getTemporaryDirectory()).path}/group.jpg');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  void createGroup() async {
    image ??= await getImageFileFromAssets();
    if (nameGroup.text == '') {
      showSnackBar(context: context, content: 'Vui lòng nhập tên nhóm');
    }

    if (nameGroup.text.trim().isNotEmpty && image != null) {
      ref.read(groupControllerProvider).createGroup(
            context,
            nameGroup.text.trim(),
            image!,
            ref.read(selectGroupContacts),
          );
      ref.read(selectGroupContacts.notifier).update((state) => []);
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreenLayout.routeName, (route) => false,
          arguments: 2);
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameGroup.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo nhóm mới'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: Center(
                  child: Stack(
                    children: [
                      image == null
                          ? const CircleAvatar(
                              backgroundImage: AssetImage('assets/group.jpg'),
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
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nameGroup,
                        decoration: const InputDecoration(hintText: 'Tên nhóm'),
                      ),
                    ),
                    const Text(
                      'Chọn liên hệ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: const SelectContactGroup(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createGroup,
        backgroundColor: tabColor,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }
}
