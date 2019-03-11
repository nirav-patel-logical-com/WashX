import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:uuid/uuid.dart';
import 'package:wash_x/constants.dart';
import 'package:wash_x/custom/customWardrobeItem.dart.dart';
import 'package:wash_x/enum.dart';
import 'package:image/image.dart' as Im;
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:wash_x/models/photosModel.dart';
import 'package:wash_x/models/washItem.dart';
import 'package:wash_x/models/washItemBrand.dart';
import 'package:wash_x/models/washItemCategory.dart';
import 'package:wash_x/models/washItemColor.dart';
import 'package:wash_x/models/washItemPattern.dart';
import 'package:wash_x/widgets/helperWidgets.dart';

class WardrobeModel extends Model {
  WashItem item = new WashItem();

  int step = 1;
  int captureStep = 1;

  double bottomSheetSize = 130.0;
  double captureBottomSheetSize = 200.0;
  bool isCameraVisible = false;
  bool isNewVisible = false;
  bool isMatchFound = false;
  bool isBottomSheetExpanded = false;

  Uuid uuid = new Uuid();

  String imagePath;
  String itemImagePath;
  String labelImagePath;
  String barcodeImagePath;
  String topLabel = Constants.wardrobeNameLabel;
  String nextButtonLabel = Constants.wardrobeNameBtnLabel;
  String topCaptureLabel = Constants.wardrobeCaptureLabel;
  String nextCaptureButtonLabel = Constants.wardrobeCaptureBtnLabel;
  String bottomDescription = Constants.wardrobeBottomDescriptionDefault;
  String bottomTrailDescription =
      Constants.wardrobeBottomTrailDescriptionDefault;
  String bottomCaptureDescription =
      Constants.wardrobeBottomCaptureDescriptionDefault;

  CameraType cameraType;
  Permission permission;
  Offset start;

  List<WashItemPattern> get washPattern => patternList;
  List<WashItemCategory> get washCategoryList => categogyList;
  List<WashItemColor> get washColor => colorsList;
  List<WashItemBrand> get washBrandList => brandList;
//  List<WashItem> get getWardrobeItemList =>  wardrobeItemList.forEach((x)=>x.state=new CustomWardrobeExpansionTileState());
  // List<WashItem> get getWardrobeItemList {
  //   wardrobeItemList
  //       .forEach((x) => x.state = new CustomWardrobeExpansionTileState());
        
  //   return wardrobeItemList;
  // }
  List<WashItem> getWardrobeItemList = [
  new WashItem(
      itemCount: 6,
      image:
          "https://firebasestorage.googleapis.com/v0/b/wash-x1.appspot.com/o/washItems%2F2663BD00E44011E8D14A2B5106226C5A%2Fitem1542356946917.jpg.jpg?alt=media&token=dc95656b-96e1-4ad5-877f-fe6ed2e2c4ee",
      brand: "Adidas",
      category: "Skirt",
      basket: "My Basket",
      color: "Yellow",
      description: "This is a nice skirt",
      isModified: false,
      id: "ABTGG7889NBB",
      name: "Adi-Skirt",
      pattern: "Vertical Stripes",
      price: "20.0",
      care: [0, 2, 3]),
  new WashItem(
    itemCount: 2,
    image:
        "https://www.google.co.in/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png",
    brand: "Nike",
    basket: "Work Basket",
    category: "Shirt",
    color: "Red",
    description: "This is a nice Shirt",
    isModified: true,
    id: "ABTGG3889NBB",
    name: "NikeYoShirt",
    pattern: "Plain",
    price: "10.0",
    care: [1, 3],
  ),
  new WashItem(
    itemCount: 0,
    image:
        "https://firebasestorage.googleapis.com/v0/b/wash-x1.appspot.com/o/washItems%2F2663BD00E44011E8D14A2B5106226C5A%2Fitem1542356946917.jpg.jpg?alt=media&token=dc95656b-96e1-4ad5-877f-fe6ed2e2c4ee",
    brand: "Adidas",
    basket: "New Basket",
    category: "Skirt",
    color: "Yellow",
    description: "This is a nice skirt",
    isModified: false,
    id: "ABTGG7889NBB",
    name: "Adi-Shirt",
    pattern: "Horizontal Stripes",
    price: "20.0",
    care: [0, 2, 1],
  ),
  new WashItem(
    itemCount: 4,
    image:
        "https://www.google.co.in/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png",
    brand: "Nike",
    basket: "HomeBasket",
    category: "Shirt",
    color: "Red",
    description: "This is a nice Shirt",
    isModified: true,
    id: "ABTGG3889NBB",
    name: "NikeYoloShirt",
    pattern: "Plain",
    price: "50.0",
    care: [0, 2, 3],
  ),
  new WashItem(
    itemCount: 0,
    image:
        "https://firebasestorage.googleapis.com/v0/b/wash-x1.appspot.com/o/washItems%2F2663BD00E44011E8D14A2B5106226C5A%2Fitem1542356946917.jpg.jpg?alt=media&token=dc95656b-96e1-4ad5-877f-fe6ed2e2c4ee",
    brand: "Adidas",
    category: "Pants",
    color: "Yellow",
    description: "This is a nice pants",
    isModified: true,
    id: "ABTGG7889NBB",
    name: "fav-jeans",
    pattern: "Vertical Stripes",
    price: "20.0",
    care: [0, 2, 3],
  ),
  new WashItem(
    itemCount: 2,
    image:
        "https://www.google.co.in/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png",
    brand: "Nike",
    category: "Shirt",
    color: "Red",
    description: "This is a nice Shirt",
    isModified: true,
    id: "ABTGG3889NBB",
    name: "NikeYoShirt",
    pattern: "Plain",
    price: "10.0",
    care: [0, 2],
  ),
];

  List<PhotosModel> get yourPhotosList => yourPhotoList;
  List<PhotosModel> get systemPhotosList => systemPhotoList;

  void changeCameraVisibility(bool value) async {
    await getWritePermission();
    await getReadPermission();
    isCameraVisible = value;
    notifyListeners();
  }

  Future getWritePermission() async {
    var per = Permission.WriteExternalStorage;
    bool res = await SimplePermissions.checkPermission(per);
    if (res) {
      return;
    }
    final result = await SimplePermissions.requestPermission(per);
    if (result == PermissionStatus.authorized) {
      debugPrint("Authorized");
    } else {
      getWritePermission();
    }
  }

  Future getReadPermission() async {
    var per = Permission.ReadExternalStorage;
    bool res = await SimplePermissions.checkPermission(per);
    if (res) {
      return;
    }
    final result = await SimplePermissions.requestPermission(per);
    if (result == PermissionStatus.authorized) {
      debugPrint("Authorized");
    } else {
      getReadPermission();
    }
  }

  void changeBottomSheet(bool value) {
    isNewVisible = value;
    notifyListeners();
  }

  void changeCameraType(CameraType value) {
    cameraType = value;
  }

//Gesture Detectors
  void verticalDragStart(DragStartDetails details) {
    start = details.globalPosition;
  }

  void verticalDragUpdate(DragUpdateDetails details, double height) {
    if (start.dy > details.globalPosition.dy) {
      captureBottomSheetSize = height;
      isBottomSheetExpanded = true;
    }
    notifyListeners();
  }

  //handler for new bottomsheet
  Future onNewItemBtnClicked({BuildContext context}) async {
    if (step == 3) {
      var value;
      categogyList.forEach((x) {
        if (x.isSelected == true) {
          value = x.categoryName;
        }
        item.category = value;
      });
    } else if (step == 7) {
      HelperWidgets.loadingDialog(context);
      bool result = await _uploadNewItem();

      topLabel = Constants.wardrobeSuccessLabel;
      nextButtonLabel = Constants.wardrobeSuccessBtnLabel;
      bottomDescription = Constants.wardrobeSuccessMessage;
      bottomSheetSize = 150.0;
      step++;
      notifyListeners();
      Navigator.of(context).pop();

      if (result) {
        debugPrint("Successfully uploaded wash Item.");
      }
      return;
      //step = 0;
    }
    step++;
    //_colors.add(Colors.green);
    if (step == 1) {
      topLabel = Constants.wardrobeNameLabel;
      nextButtonLabel = Constants.wardrobeNameBtnLabel;
      bottomSheetSize = 130.0;
    } else if (step == 2) {
      topLabel = Constants.wardrobeBrandLabel;
      nextButtonLabel = Constants.wardrobeBrandBtnLabel;
      bottomSheetSize = 200.0;
    } else if (step == 3) {
      topLabel = Constants.wardrobeCategoryLabel;
      nextButtonLabel = Constants.wardrobeCategoryBtnLabel;
      bottomSheetSize = 350.0;
      bottomDescription = Constants.wardrobeTypeOfClothesAdding;
      bottomTrailDescription = Constants.wardrobeChooseType;
    } else if (step == 4) {
      topLabel = Constants.wardrobeColorLabel;
      nextButtonLabel = Constants.wardrobeColorBtnLabel;
      bottomSheetSize = 200.0;
      bottomDescription = Constants.wardrobeBottomDescriptionDefault;
      bottomTrailDescription = Constants.wardrobeBottomTrailDescriptionDefault;
    } else if (step == 5) {
      topLabel = Constants.wardrobePatternLabel;
      nextButtonLabel = Constants.wardrobePatternBtnLabel;
      bottomSheetSize = 200.0;
    } else if (step == 6) {
      topLabel = Constants.wardrobeDescLabel;
      nextButtonLabel = Constants.wardrobeDescBtnLabel;
      bottomSheetSize = 200.0;
      bottomDescription = Constants.wardrobeDescItemMessage;
      bottomTrailDescription = Constants.wardrobeDescItemTrailMessage;
    } else if (step == 7) {
      double height = MediaQuery.of(context).size.height;
      topLabel = Constants.wardrobeConfirmLabel;
      nextButtonLabel = Constants.wardrobeConfirmBtnLabel;
      bottomSheetSize = height - 40.0;
      bottomDescription = Constants.wardrobeConfirmItemMessage;
      bottomTrailDescription = Constants.wardrobeConfirmItemTrailMessage;
    } else if (step >= 8) {
      _resetState();
    }
    notifyListeners();
  }

  _resetState() {
    topLabel = Constants.wardrobeNameLabel;
    nextButtonLabel = Constants.wardrobeNameBtnLabel;
    topCaptureLabel = Constants.wardrobeCaptureLabel;
    nextCaptureButtonLabel = Constants.wardrobeCaptureBtnLabel;
    bottomSheetSize = 130.0;
    captureBottomSheetSize = 200.0;
    itemImagePath = "";
    labelImagePath = "";
    barcodeImagePath = "";
    isNewVisible = false;
    isCameraVisible = false;
    isMatchFound = false;
    isBottomSheetExpanded = false;
    bottomDescription = Constants.wardrobeBottomDescriptionDefault;
    bottomTrailDescription = Constants.wardrobeBottomTrailDescriptionDefault;
    bottomCaptureDescription =
        Constants.wardrobeBottomCaptureDescriptionDefault;
    step = 1;
    captureStep = 1;
    categogyList.forEach((x) => x.isSelected = false);
  }

  //Upload the Item to the databse
  Future<bool> _uploadNewItem() async {
    String itemId = uuid.v1();
    item.id = itemId.replaceAll("-", "").toUpperCase();
    var photoItemPath = "";
    var labelItemPath = "";
    var barcodeItemPath = "";

    if (itemImagePath != null && itemImagePath.isNotEmpty) {
      photoItemPath = await _pickSaveImage(itemImagePath);
    }
    if (labelImagePath != null && labelImagePath.isNotEmpty) {
      labelItemPath = await _pickSaveImage(labelImagePath);
    }
    if (barcodeImagePath != null && barcodeImagePath.isNotEmpty) {
      barcodeItemPath = await _pickSaveImage(barcodeImagePath);
    }

    await Firestore.instance
        .collection('WashItems')
        .document(item.name)
        .setData({
      'Id': item.id,
      'Name':
          item.name != null && item.name.isNotEmpty ? item.name : "un-named",
      'Category': item.category.toString(),
      'Color': item.color.toString(),
      'Image': itemImagePath != null && itemImagePath.isNotEmpty
          ? photoItemPath
          : "",
      'Label': labelImagePath != null && labelImagePath.isNotEmpty
          ? labelItemPath
          : "",
      'Barcode': barcodeImagePath != null && barcodeImagePath.isNotEmpty
          ? barcodeItemPath
          : "",
      'Description': item.description,
      'Pattern': item.pattern,
    }).catchError((e) {
      var platformException = e as PlatformException;
      debugPrint(platformException.message);
    });
    return true;
  }

  //handler for capture bottomsheet
  Future onCaptureItemBtnClicked() async {
    debugPrint(captureStep.toString());
    if (captureStep == 2 && !isMatchFound) {
      changeBottomSheet(true);
      return;
    } else if (captureStep == 2 && isMatchFound) {
      topCaptureLabel = Constants.wardrobeSuccessImportLabel;
      nextCaptureButtonLabel = Constants.wardrobeSuccessImportBtnLabel;
      captureBottomSheetSize = 150.0;
      bottomCaptureDescription = Constants.wardrobeSuccessImportMessage;
      captureStep++;
      notifyListeners();
      //Handle if match found that is
      return;
    } else if (captureStep == 3) {
      _resetState();
      return;
    }
    captureStep++;
    var result = _findWashItemMatch();
    if (result) {
      isMatchFound = true;
      topCaptureLabel = Constants.wardrobeImportLabel;
      nextCaptureButtonLabel = Constants.wardrobeImportBtnLabel;
      captureBottomSheetSize = 200.0;
    } else {
      isMatchFound = false;
      topCaptureLabel = Constants.wardrobeNoMatchLabel;
      nextCaptureButtonLabel = Constants.wardrobeNoMatchBtnLabel;
      bottomCaptureDescription = Constants.wardrobeItemNotFoundMessage;
      captureBottomSheetSize = 150.0;
    }
    notifyListeners();
  }

  bool _findWashItemMatch() {
    //Write here to find a Match for given photograph
    return true;
  }

  Future<String> _pickSaveImage(String path) async {
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("washItems/" + item.id)
        .child("item" + path.split("/").toList().last);
    // var compressedImage = await compressImage(path);
    StorageUploadTask uploadTask = ref.putFile(new File(path));
    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

//for compressing images
  // Future<String> compressImage(String path) async {
  //   Im.Image image = Im.decodeImage(new File(path).readAsBytesSync());
  //   Im.Image compressedImage = Im.copyResize(image, 120);
  //   String compressedPath = path + "_small.jpg";
  //   new File(compressedPath)..writeAsBytesSync(Im.encodeJpg(compressedImage));
  //   return compressedPath;
  // }

  void addBrand(String value) {
    item.brand = value;
    onNewItemBtnClicked();
  }

  void addColor(String value) {
    item.color = value;
    onNewItemBtnClicked();
  }

  void addDescription(String value) {
    item.description = value;
    //  increaseCount();
  }

  void addName(String value) {
    onNewItemBtnClicked();
    item.name = value;
    debugPrint("name Added" + value);
  }

  void selectCategory(String value, int index) {
    item.category = value;
    categogyList.forEach((x) => x.isSelected = false);
    categogyList[index].isSelected = true;
    nextButtonLabel = "CORRECT";
    notifyListeners();
  }

  void addPatter(String value) {
    item.pattern = value;
    onNewItemBtnClicked();
  }

//Camera controlls --start
  void onTakePictureButtonPressed(
      CameraController controller, bool mounted) async {
    await takePicture(controller).then((String filePath) async {
      if (mounted) {
        imagePath = filePath;
        if (cameraType == CameraType.PHOTO) {
          itemImagePath = filePath;
        } else if (cameraType == CameraType.LABEL) {
          labelImagePath = filePath;
        } else {
          barcodeImagePath = filePath;
        }
        onCaptureItemBtnClicked();
        changeCameraVisibility(false);
        if (filePath != null) debugPrint('Picture saved to $filePath');
      }
    });
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<String> takePicture(CameraController controller) async {
    if (!controller.value.isInitialized) {
      debugPrint('Error: select a camera first.');
      return null;
    }
    final Directory extDir = await getExternalStorageDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      debugPrint(" A capture is already pending, do nothing.");
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      var exception = e as PlatformException;
      var error = exception.message;
      debugPrint(error);
      return null;
    }
    return filePath;
  }
//camera controls --end
}
