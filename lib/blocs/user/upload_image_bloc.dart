import 'package:mamo/api/api_constants.dart';
import 'package:mamo/api/api_response.dart';
import 'package:mamo/api/api_service.dart';
import 'package:mamo/model/request/base_response.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'dart:typed_data';
import 'dart:io';

class UploadImageBloc {
  Future<JDIResponse> uploadFile(String filePath, String imageBase64) async {
    var data = Map<String, dynamic>();
    data['FileName'] = filePath;
    data['Base64Content'] = imageBase64;
    var response =
        await ApiService(ApiConstants.UPLOAD_BASE64, data, null).getResponse();
    if (response.status == Status.SUCCESS) {
      JDIResponse jdiResponse = response.data;
      return jdiResponse;
    } else {
      return JDIResponse.create("999999", "Lỗi không xác định", 0, null);
    }
  }
  Future<ApiResponse<JDIResponse>> uploadFileMultiPart(Uint8List filePath, File file) async{
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromBytes(filePath,filename: path.basename(file.path) )
    });
    var response= await ApiService(ApiConstants.API_UPLOAD_IMAGE, null, null, formData: formData)
        .getResponse();
    return response;
  }
}
