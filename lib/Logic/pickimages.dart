import 'package:deuscurat_admin/Utils/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PickingFiles{
  pickFile() async {
    // Pick an image
    try{
      var result = await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        final sizeInBytes = result.files.first.size;
        final sizeInKB = sizeInBytes / 1024;
        if(sizeInKB > 10240){
          FlutterToastFunction().getToast(title: "Image size is more than 10Mb",color: Colors.red);
          return null;
        }
        // print("eeee${result.files.single}");
        //print("dddd${result}");
        return result;
      } else {
        return null;
      }
    }catch(e){
      return null;
    }

  }


  pickFileVideo() async {
    // Pick an image
    try{
      var result = await FilePicker.platform.pickFiles(allowCompression: true,type: FileType.video,);

      if (result != null) {
        final sizeInBytes = result.files.first.size;
        final sizeInKB = sizeInBytes / 1024;
        if(sizeInKB > 10240){
          FlutterToastFunction().getToast(title: "Video size is more than 10Mb",color: Colors.red);
          return null;
        }
        return result;
      } else {
        return null;
      }
    }catch(e){
      return null;
    }

  }
}