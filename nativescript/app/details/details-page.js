import { Observable } from "@nativescript/core";
import * as PhotoService from "../services/photos.service";

async function createViewModel(args) {
  const viewModel = new Observable();
  viewModel.photo = await PhotoService.getPhotoById(args.photoId);
  return viewModel;
}

export async function onNavigatingTo(args) {
  const page = args.object;
  page.bindingContext = await createViewModel(page.navigationContext);
}
