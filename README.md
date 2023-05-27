name: chatapp_clone_whatsapp
description: A new Flutter project.

publish_to: "none" # Remove this line if you wish to publish to pub.dev

version: 1.0.0+1

environment:
sdk: ">=2.19.6 <3.0.0"

dependencies:
flutter:
sdk: flutter
cupertino_icons: ^1.0.5
agora_uikit: ^1.3.1
audioplayers: ^4.0.0
cached_network_image: ^3.2.3
cloud_firestore: ^4.5.0
enough_giphy_flutter: ^0.4.0
firebase_auth: ^4.2.2
firebase_core: ^2.9.0
firebase_storage: ^11.1.0
flutter_contacts: ^1.1.6
flutter_riverpod: ^2.3.4
flutter_sound: ^9.2.13
image_picker: ^0.8.7+2
intl: ^0.18.0
path_provider: ^2.0.14
permission_handler: ^10.2.0
story_view: ^0.14.0
swipe_to: ^1.0.2
uuid: ^3.0.7
shared_preferences: ^2.1.1
flutter_launcher_icons: ^0.13.1
url_launcher: ^6.1.11
http: ^0.13.6
file_picker: ^5.3.0
font_awesome_flutter: ^10.4.0
cached_video_player: ^2.0.4

dev_dependencies:
flutter_lints: ^2.0.1
flutter_test:
sdk: flutter

flutter_launcher_icons:
android: "launcher_icon"
ios: true
image_path: "assets/logo.jpg"
min_sdk_android: 21 # android min sdk min:16, default 21
web:
generate: true
image_path: "assets/logo.jpg"
background_color: "#hexcode"
theme_color: "#hexcode"
windows:
generate: true
image_path: "assets/logo.jpg"
icon_size: 48 # min:48, max:256, default: 48
macos:
generate: true
image_path: "assets/logo.jpg"

flutter:

uses-material-design: true

assets: - assets/
