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

### Home screen

