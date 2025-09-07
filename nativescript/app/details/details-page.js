import { Observable } from "@nativescript/core";
import * as PhotoService from "../services/photos.service";

function createViewModel(args) {
  const viewModel = new Observable();
  viewModel.photo = PhotoService.getPhotoById(args.photoId);

  viewModel.onRefresh = () => {
    viewModel.set("photo", PhotoService.getPhotoById(args.photoId));
  };

  return viewModel;
}

export function onNavigatingTo(args) {
  const page = args.object;
  page.bindingContext = createViewModel(page.navigationContext);
}
