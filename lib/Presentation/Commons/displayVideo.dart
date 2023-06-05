import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Presentation/Commons/videoPlayerWidget.dart';
import 'package:flutter/material.dart';
class DisplayVideo extends StatelessWidget {
  const DisplayVideo({Key? key,required this.videoUrl, this.height, this.width}) : super(key: key);
  final String? videoUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  VideoPlayerWidget(
            videoUrl: videoUrl??"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
          )),
        );
      },
      child: Container(
        color: kBlackColor,
        height: height,
        width: width,
      ),
    );
  }
}
