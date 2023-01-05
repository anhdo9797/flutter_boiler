fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## Android
### android build
```
fastlane android build
```
Build the Android application.
### android deploy
```
fastlane android deploy
```
Build and upload to Diawi
### android push
```
fastlane android push
```
Push new versions
### android deploy_prod
```
fastlane android deploy_prod
```
Build and upload apk prod to Diawi

----

## iOS
### ios deploy
```
fastlane ios deploy
```
Deploy app

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
