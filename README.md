# Swiftnotes [![Build Status](https://travis-ci.org/adrianchifor/Swiftnotes.svg)](https://travis-ci.org/adrianchifor/Swiftnotes) [![Maintainer](https://img.shields.io/badge/maintainer-adrianchifor-brightgreen.svg)](https://img.shields.io/badge/maintainer-adrianchifor-brightgreen.svg)

[Swiftnotes](https://play.google.com/store/apps/details?id=com.moonpi.swiftnotes) is a note taking app that takes simplicity and speed to a whole new level. 

It offers you a quick and easy way to stay organised, capture your thoughts, reminders or anything that's on your mind, any time, anywhere. No extra unnecessary features, just notes. For screenshots and more information visit the [Google PlayStore.](https://play.google.com/store/apps/details?id=com.moonpi.swiftnotes)

This repo contains the official source code of Swiftnotes for Android.

Current app version is 3.1.3.

### Build

Steps on how to build Swiftnotes:
- Make sure you have the latest version of Android Studio with Gradle v1.1.0 and the required Android SDK Tools installed (22.0.1 Build tools)
- Clone this repository
- Open Android Studio -> File -> Import Project
- Select build.gradle in Swiftnotes
- Go to Project Structure and make sure Android SDK and JDK paths are set
- Build -> Rebuild Project and Sync Gradle
- Good to go!

### License

Copyright &copy; 2015 MoonPi - Adrian Chifor

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

### Donate

To support development, you can donate with PayPal or Card using this [link](http://goo.gl/TQRlTa). For Bitcoin donations, our address is: 1PEGbaQAbCxaMs3TYu7e2NoVwAC7158Fvv. 

Donations help us implement amazing new features and deliver updates at a faster rate. Any amount would be most appreciated. Thank you!

### Run in Mobile-Center 25 devices
mobile-center test run espresso --app "Barlow/swiftnotes-01" --devices b5af14bb --app-path /Users/adamb/Desktop/Swiftnotes-master/app/build/outputs/apk/app-debug.apk --test-series "master" --locale "en_US" --build-dir /Users/adamb/Desktop/Swiftnotes-master/app/build/outputs/apk/ 

### Run in Xamarin Test Cloud 25 devices
xtc test /Users/adamb/Desktop/Swiftnotes-master/app/build/outputs/apk/app-debug.apk 33944d535fc5062737288aa1ebf97b09 --devices 88276745 --user adam.barlow@xamarin.com --workspace /Users/adamb/Desktop/Swiftnotes-master/app/build/outputs/apk/
