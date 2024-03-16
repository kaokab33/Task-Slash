class ProductState {}

class InitialState extends ProductState {}

class LoadingState extends ProductState {}

class FailedState extends ProductState {
  FailedState(this.error);
  String error;
}

class SuccessState extends ProductState {}

class ChangeIndexColorState extends ProductState {}

class ChangeIndexImageState extends ProductState {}

class ChangeIndexSizeState extends ProductState {}

class ChangeIndeMaterialState extends ProductState {}
