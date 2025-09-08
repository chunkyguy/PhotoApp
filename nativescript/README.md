### Set up

1. Install nativescript with `npm install -g nativescript`

2. Check Android set up `ns doctor android`
```
No issues were detected.
✔ Your ANDROID_HOME environment variable is set and points to correct directory.
✔ Your adb from the Android SDK is correctly installed.
✔ The Android SDK is installed.
✔ A compatible Android SDK for compilation is found.
✔ Javac is installed and is configured properly.
✔ The Java Development Kit (JDK) is installed and is configured properly.
✔ Getting NativeScript components versions information...
✔ Component nativescript has 8.9.3 version and is up to date.
```

3. Check iOS set up `ns doctor ios`
```
No issues were detected.
✔ Xcode is installed and is configured properly.
✔ xcodeproj is installed and is configured properly.
✔ CocoaPods are installed.
✔ CocoaPods update is not required.
✔ CocoaPods are configured properly.
✔ Your current CocoaPods version is newer than 1.0.0.
✔ Python installed and configured correctly.
✔ Xcode version 16.3.0 satisfies minimum required version 10.
✔ Getting NativeScript components versions information...
✔ Component nativescript has 8.9.3 version and is up to date.
```

4. Create a new app `ns create photo-app --js`
```
.
├── app
├── App_Resources
├── hooks
├── jsconfig.json
├── nativescript.config.ts
├── node_modules
├── package-lock.json
├── package.json
├── README.md
└── webpack.config.js
```

5. Run `ns run ios`

![Set up](/screenshots/00-setup.png)

### UI

Native script works with a 2 way binding between the UI described in xml files and the corresponding view model written in javascript. 

The minimal example would be to create a `sample-page.xml` and a corresponding `sample-page.js`:

```xml
<Page xmlns="http://schemas.nativescript.org/tns.xsd" navigatingTo="navigatingTo">
    <ActionBar title="Sample" />
    <StackLayout class="p-20">
        <Label text="{{ message }}" class="h2 text-center" textWrap="true" />
        <Button text="Tap here" tap="{{ onTap }}" class="-primary" />
    </StackLayout>
</Page>
```

```js
import { Observable } from "@nativescript/core";

function createViewModel() {
  const viewModel = new Observable();
  viewModel.message = "Hello world!"
  return viewModel;
}

export function navigatingTo(args) {
  const page = args.object;
  page.bindingContext = createViewModel();
}
```
 
In this example the UI invokes the `navigatingTo()` whenever the page is rendered for the first time where can create our view model as an `Observable` type and pass it back to the UI as `bindingContext`.

Based on this information, if we mock a `PhotoService` as:

```js
photos = [
    {
      id: "37",
      author: "Austin Neill",
      width: 2000,
      height: 1333,
      url: "https://unsplash.com/photos/erTjj730fMk",
      download_url: "https://picsum.photos/id/37/2000/1333",
    },
    /* ... */
];

export function getPhotos() {
  return photos;
}

export function getPhotoById(id) {
  return photos.find((it) => it.id === id) || undefined;
}
```

Then we can create our `home-page` as:

```xml
<Page xmlns="http://schemas.nativescript.org/tns.xsd" navigatingTo="navigatingTo">
  <ActionBar title="Photos" />
  <StackLayout height="100%">
    <ListView
      height="100%"
      separatorColor="transparent"
      items="{{ photos }}"
      itemTap="{{ onPhotoTap }}"
      margin="10"
    >
      <ListView.itemTemplate>
        <GridLayout
          height="280"
          borderRadius="10"
          class="bg-secondary"
          rows="*, auto, auto"
          columns="*"
          margin="5 10"
          padding="0"
        >
          <Image
            row="0"
            margin="0"
            stretch="aspectFill"
            src="{{ download_url }}"
            backgroundColor="grey"
          />
          <Label
            row="1"
            margin="10 10 0 10"
            fontWeight="400"
            class="text-primary"
            fontSize="18"
            text="{{ author }}"
          />
        </GridLayout>
      </ListView.itemTemplate>
    </ListView>
  </StackLayout>
</Page>
```

```js
import { Frame, Observable, ObservableArray } from "@nativescript/core";
import * as PhotoService from "../services/photos.service";

function createViewModel() {
  const viewModel = new Observable();
  viewModel.photos = PhotosService.getPhotos();
  viewModel.onPhotoTap = (args) => { /* TODO */ };
  return viewModel;
}

export function navigatingTo(args) {
  if (args.isBackNavigation) {
    return;
  }

  const page = args.object;
  page.bindingContext = createViewModel();
}
```

![Home](/screenshots/01-home.png)

And our details page as:

```xml
<Page xmlns="http://schemas.nativescript.org/tns.xsd" navigatingTo="navigatingTo">
    <ActionBar title="{{ photo.author }}" />
     <StackLayout class="p-20">
        <Image src="{{ photo.download_url}}" />
        <Label text="{{ photo.url }}" class="caption text-center" textWrap="true" />
    </StackLayout>
</Page>
```

```js
import { Observable } from "@nativescript/core";
import * as PhotoService from "../services/photos.service";

function createViewModel() {
  const viewModel = new Observable();
  viewModel.photo = PhotosService.getPhotoById("42");
  return viewModel;
}

export function navigatingTo(args) {
  const page = args.object;
  page.bindingContext = createViewModel();
}
```

![Details](/screenshots/02-details.png)

### Navigation

To navigate from home to details page we need update our `home-page.js` to:

```js
  viewModel.onPhotoTap = (args) => {
    Frame.topmost().navigate({
      moduleName: "details/details-page",
      context: { photoId: viewModel.photos[args.index].id },
    });
  };
```

And then the `details-page.js` to parse the `photoId`

```js
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
```

### Networking

The final piece in the puzzle is fetching the data from the internet. That means updating our `PhotoService` to `async`

```js
async function getData(url) {
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Response status: ${response.status}`);
    }
    return await response.json();
  } catch (error) {
    console.error(error.message);
    return null;
  }
}

export async function getPhotos() {
  return await getData("https://picsum.photos/v2/list?page=2");
}

export async function getPhotoById(id) {
  return await getData(`https://picsum.photos/id/${id}/info`);
}
```

And then bubbling up the `async` calls to the view models layer

```js
export async function onNavigatingTo(args) {
  // ...
  const page = args.object;
  page.bindingContext = await createViewModel();
}

async function createViewModel() {
  const viewModel = new Observable();
  viewModel.photos = await PhotoService.getPhotos();
  // ...
  return viewModel;
}
```

Since the data is now coming via a network call. So we need to add a loading state to the app. This means two things. First  we need to update our home page to have a loading indicator.

```xml
<Page xmlns="http://schemas.nativescript.org/tns.xsd">
  <ActionBar title="Photos" />
  <GridLayout height="100%" rows="*" columns="*">
    <ActivityIndicator
      busy="true"
      visibility="{{ loadingVisibility }}"
      row="0"
    />
    <StackLayout height="100%" row="0">
      <!-- ... -->
    </StackLayout>

  </GridLayout>
</Page>
```

And second, we need to update our view model to handle both `navigatingTo` and `navigatedTo`
```xml
<Page
  xmlns="http://schemas.nativescript.org/tns.xsd"
  navigatingTo="onNavigatingTo"
  navigatedTo="onNavigatedTo"
>
  <!--  -->
</Page>
```

```js
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

async function createViewModel() {
  const viewModel = new Observable();
  viewModel.loadingVisibility = "hidden";
  viewModel.photos = await PhotoService.getPhotos();
  // ...
  return viewModel;
}
```

![Loading state](/screenshots/03-loading.gif)