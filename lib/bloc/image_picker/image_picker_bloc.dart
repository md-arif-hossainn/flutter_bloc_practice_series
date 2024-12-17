

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_count/utils/image_picker_utils.dart';
import 'package:image_picker/image_picker.dart';

import 'image_picker_event.dart';
import 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {

  final ImagePickerUtils imagePickerUtils;

  ImagePickerBloc(this.imagePickerUtils) : super(const ImagePickerState()) {

    on<CameraCapture>(cameraCapture);
    on<GalleryImagePicker>(galleryCapture);
  }

  void cameraCapture(CameraCapture event, Emitter<ImagePickerState> states) async{
   XFile? file = await imagePickerUtils.cameraCapture();
   emit(state.copyWith(file: file));
  }

  void galleryCapture(GalleryImagePicker event, Emitter<ImagePickerState> states) async{
    XFile? file = await imagePickerUtils.pickImageFromGallery();
    emit(state.copyWith(file: file));
  }
}
