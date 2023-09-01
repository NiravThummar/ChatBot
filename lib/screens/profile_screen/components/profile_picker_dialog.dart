// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class showProfilePictureDialog extends StatefulWidget {
//   // final Function(ImageSource source) onTap;
//   const showProfilePictureDialog({super.key});

//   @override
//   State<showProfilePictureDialog> createState() =>
//       _showProfilePictureDialogState();
// }

// class _showProfilePictureDialogState extends State<showProfilePictureDialog> {
//   var pickedImage;
//   pickImage(ImageSource imagetype) async {
//     final ImagePicker _picker = ImagePicker();
//     try {
//       final photo = await _picker.pickImage(source: imagetype);
//       if (photo == null) return;
//       final tempImg = File(photo.path);
//       setState(() {
//         this.pickedImage = tempImg;
//       });
//       Get.back();
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: Container(
//         height: 170,
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 5,
//               ),
//               Text(
//                 "Choose Profile Photo",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(
//                 height: 3,
//               ),
//               Divider(
//                 height: 1,
//                 color: Colors.black,
//                 thickness: 1,
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
//                 child: GestureDetector(
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.camera,
//                           size: 30,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           "Camera",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ],
//                     ),
//                     onTap: pickImage(ImageSource.camera)),
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
//                 child: GestureDetector(
//                   child: Row(
//                     children: [
//                       Icon(
//                         Icons.image,
//                         size: 30,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         "Gallery",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ],
//                   ),
//                   onTap: pickImage(ImageSource.gallery),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
