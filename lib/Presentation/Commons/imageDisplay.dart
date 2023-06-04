import 'package:cached_network_image/cached_network_image.dart';
import 'package:deuscurat_admin/Commons/colors.dart';
import 'package:deuscurat_admin/Commons/strings.dart';
import 'package:deuscurat_admin/Utils/progressIndicator.dart';
import 'package:flutter/material.dart';
class ImageDisplay extends StatelessWidget {
  const ImageDisplay({Key? key, this.height, this.width, this.imageUrl}) : super(key: key);
final double? height;
final double? width;
final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){showFullImage(imageUrl,context);},
      child: SizedBox(
        height:height,
        width: width,
        child: CachedNetworkImage(
          imageUrl:imageUrl.toString(),
          placeholder: (context, url) =>  Image.network(placeholder,
            height:height,
            width:width,
            fit: BoxFit.cover,),
          errorWidget: (context, url, error) =>Image.network(placeholder,
            height:height,
            width: width,
            fit: BoxFit.cover,),
          fit: BoxFit.cover,


        ),
      ),
    );
  }


}

void showFullImage(String? imageUrl, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) =>

          SimpleDialog(
            backgroundColor: kBlackColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: Align(
                alignment: Alignment.topRight,
                child: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.cancel,color: kRedColor,))),
            elevation: 4,
            children: [
              CachedNetworkImage(
                  imageUrl:imageUrl.toString(),
                  placeholder: (context, url) =>  const ShowProgressIndicator(),
                  errorWidget: (context, url, error) => Text("Error in showing image",style: Theme.of(context).textTheme.labelSmall,)


              ),
            ],
          )
  );
}
