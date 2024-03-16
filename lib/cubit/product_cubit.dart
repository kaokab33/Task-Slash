import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slash/cubit/product_state.dart';
import 'package:slash/models/product.dart';
import 'package:slash/services/get_deteils.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(InitialState());
  late Product product;
  late int index = 0;
  late List<Map<String, dynamic>> allTest;
  late int indexOfImage = 0;
  late int indexOfSize = 0;
  late int indexMatrial = 0;
  late int genralIndex = 0;
  late bool hasColors = false;
  late bool hasSize = false;
  late bool hasMatrial = false;
  late String brandName;
  late List<String> properties = [' ', ' ', ''];
  late List<String> colors = [];
  late List<String> sizes = [];
  late List<String> matrials = [];
  void getProduct(int id) async {
    try {
      emit(LoadingState());
      product = await GetDetails().getDetails(id);
      for (int i = 0; i < product.availableProperties.length; i++) {
        properties.add(product.availableProperties[i].property!);
        for (int j = 0;
            j < product.availableProperties[i].values!.length;
            j++) {
          if (product.availableProperties[i].property == 'Color') {
            colors.add(product.availableProperties[i].values![j]);
          } else if (product.availableProperties[i].property == 'Size') {
            sizes.add(product.availableProperties[i].values![j]);
          } else if (product.availableProperties[i].property == 'Materials') {
            matrials.add(product.availableProperties[i].values![j]);
          }
        }
      }
      if (properties.contains('Color')) {
        hasColors = true;
        allTest = product.makeAllTestForColor(product);
      } else if (properties.contains('Size')) {
        // ignore: curly_braces_in_flow_control_structures
        hasSize = true;
        allTest = product.makeAllTestForSize(product);
      } else if (properties.contains('Materials')) {
        hasMatrial = true;
        allTest = product.makeAllTestForMaterial(product);
      } else {
        allTest = product.makeAllTestForNoAvailble(product);
      }
      genralIndex = setGenralIndex(properties);
      emit(SuccessState());
    } catch (e) {
      // ignore: deprecated_member_use
      if (e is DioError) {
        String errorMessage = 'Network error occurred';
        if (e.response != null) {
          errorMessage =
              'Error ${e.response!.statusCode}: ${e.response!.statusMessage}';
        } else {
          errorMessage = 'Error: ${e.message}';
        }
        emit(FailedState(errorMessage));
      } else {
        emit(FailedState('An unexpected error occurred: $e'));
      }
    }
  }

  int setGenralIndex(properties) {
    int genral = (properties.contains('Color'))
        ? index
        : (properties.contains('Size'))
            ? indexOfSize
            : indexMatrial;
    return genral;
  }

  void changeColor(int index) {
    this.index = index;
    genralIndex = setGenralIndex(properties);
    emit(ChangeIndexColorState());
  }

  void changeImage(int indexOfImage) {
    this.indexOfImage = indexOfImage;
    // genralIndex = setGenralIndex(properties);
    emit(ChangeIndexImageState());
  }

  void changeSize(int indexOfSize) {
    this.indexOfSize = indexOfSize;
    genralIndex = setGenralIndex(properties);
    emit(ChangeIndexSizeState());
  }

  void changeMaterial(int indexMatrial) {
    this.indexMatrial = indexMatrial;
    genralIndex = setGenralIndex(properties);
    emit(ChangeIndeMaterialState());
  }

  // ignore: non_constant_identifier_names
  int AddToCart() {
    String colorValue = '';
    String sizeValue = '';
    String matrialValue = '';
    int price = allTest[genralIndex]['Price'][0];
    if (properties.contains('Color')) {
      colorValue = allTest[index]['Color'];
      if (properties.contains('Size')) {
        sizeValue = allTest[genralIndex]['Size'][indexOfSize];
      }
      if (properties.contains('Materials')) {
        matrialValue = allTest[genralIndex]['Materials'][indexMatrial];
      }
    } else if (properties.contains('Size')) {
      sizeValue = allTest[genralIndex]['Size'];
      if (properties.contains('Materials')) {
        matrialValue = allTest[genralIndex]['Materials'][indexMatrial];
      }
    } else if (properties.contains('Materials')) {
      matrialValue = allTest[genralIndex]['Materials'];
    }
    return product.addToCart(
        colorValue, sizeValue, matrialValue, price, product);
    // emit(AddToCartState());
  }

  // ignore: non_constant_identifier_names
  void ChangeToInitialState() {
    index = 0;
    indexOfImage = 0;
    indexOfSize = 0;
    indexMatrial = 0;
    allTest = [];
    properties = [];
    genralIndex = 0;
    hasColors = false;
    hasSize = false;
    hasMatrial = false;
    colors = [];
    sizes = [];
    matrials = [];
    // product = null;
    emit(InitialState());
  }
}
