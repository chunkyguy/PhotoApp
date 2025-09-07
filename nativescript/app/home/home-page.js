import { Frame, Observable, ObservableArray } from "@nativescript/core";
import * as PhotoService from "../services/photos.service";

function createViewModel() {
  const viewModel = new Observable();
  viewModel.photos = PhotoService.getPhotos();

  viewModel.onRefresh = () => {
    viewModel.set("photos", PhotoService.getPhotos());
  };

  viewModel.onPhotoTap = (args) => {
    Frame.topmost().navigate({
      moduleName: "details/details-page",
      context: { photoId: viewModel.photos[args.index].id },
    });
  };

  return viewModel;
}

export function onNavigatingTo(args) {
  if (args.isBackNavigation) {
    return;
  }

  const page = args.object;
  page.bindingContext = createViewModel();
}
