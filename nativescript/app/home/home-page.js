import { Frame, Observable, ObservableArray } from "@nativescript/core";
import * as PhotoService from "../services/photos.service";

async function createViewModel() {
  const viewModel = new Observable();
  viewModel.loadingVisibility = "hidden";
  viewModel.photos = await PhotoService.getPhotos();

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
  page.bindingContext = {
    loadingVisibility: "visible",
    photos: [],
    onPhotoTap: null,
  };
}

export async function onNavigatedTo(args) {
  const page = args.object;
  page.bindingContext = await createViewModel();
}
