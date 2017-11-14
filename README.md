[![Version](https://img.shields.io/cocoapods/v/NMXCore.svg?style=flat)](https://cocoapods.org/pods/NMXCore)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/namics/ios-objc-foundation-nmxcore/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/NMXCore.svg?style=flat)](https://cocoapods.org/pods/NMXCore)
[![Travis](https://img.shields.io/travis/namics/ios-objc-foundation-nmxcore.svg?style=flat)](https://travis-ci.org/namics/ios-objc-foundation-nmxcore)
[![Coverage Status](https://coveralls.io/repos/github/namics/ios-objc-foundation-nmxcore/badge.svg?branch=coveralls)](https://coveralls.io/github/namics/ios-objc-foundation-nmxcore?branch=coveralls)

# ios-objc-foundation-nmxcore
Current Version of the NMXCore Library
0.3.2

You can find the latest documentation under
http://namics.github.io/ios-objc-foundation-nmxcore/

# Include / Import
## Cocoapods
Navigate to the root directory of your .xcodeproj file.
If you don't have a "podfile" created yet, open your terminal and cd to your .xcodeproj-file.
Perform the following command. Make sure you have cocoapods installed:
### Cocoapods installation
Make sure to run latest cocoapods version:
https://guides.cocoapods.org/using/getting-started.html
```
[sudo] gem install cocoapods
```

### Cocoapods Setup
Navigate to your.xcodeproj file in the Mac Terminal, then do:
```
pod install
```

### Cocoapods - Include ios-objc-foundation-nmxcore:
Add the following line to your podfile:
```
pod 'NMXCore', '0.1.0'
```

A podfile could look like the following:
```
source 'https://github.com/CocoaPods/Specs.git'

target 'ProjectTarget' do
use_frameworks!

pod 'NMXCore', '0.1.0'

end
```

### Import the NMXHeader-Header file in your Project:
`#include "NMXCoreStatic.h"`


# Documentation
## Building Documentation
Documentation requires two components:
* [SourceKitten](https://github.com/jpsim/SourceKitten)
> brew install sourcekitten
* [jazzy](https://github.com/realm/jazzy)
> gem install jazzy

Then navigate in terminal to the root path of the repo, where ".jazzy.yaml" is located and run the following command:
`jazzy`
You will find the updated documentation under ./docs
or simply run:
`open ./docs/index.html`

If you added a new section in the Library, make sure to add the related section to the umbrella header file for the documentation generation. See NamicsLibHeaders.h

# How to update changes from the library.
## Setup
To modify pods register at cocoapods:
Make sure to run latest cocoapods version:
https://guides.cocoapods.org/using/getting-started.html
`[sudo] gem install cocoapods`
or
`[sudo] gem update cocoapods`

## Register/Add Owners for the Cocoapods Repo
https://guides.cocoapods.org/making/getting-setup-with-trunk.html
```
pod trunk register tobias.baube@namics.com 'Tobias Baube' --description='Namics MacBook'
```

Add Owners so they can also publish:
`pod trunk add-owner push ios-objc-foundation-nmxcore vorname.nachname@namics.com


## Automatic Deployment
You can automatically push your changes to the pod with calling
`sh deploy.sh VERSION`
Example:
`sh deploy.sh 0.2.1`
It might require administrator rights for creating code documentation automatically, see above

## Manual Deployment
1. Do your changes:
Open /Development/NMXCore.xcodeproj

2. Select The dynamic Framework target `NMXCore` and Archive the Library

2. Go to the main folder from Terminal, where 'NMXCore.podspec' is located, e.g.:
```
cd ~/Documents/ios-objc-foundation-nmxcore/
```

3. Validate the pod lib file in terminal:
`pod lib lint NMXCore.podspec`
`pod lib lint NMXCoreDylib.podspec`

4. Validate the specification in terminal:
```
pod spec lint NMXCore.podspec
pod spec lint NMXCoreDylib.podspec
```

5. Commit and push your changes in git, note down the tag id (important: the v-Prefix for tags!)
```
git add -A && git commit -m "Release 0.1.0"
git tag 'v0.1.0'
git push --tags
git push
```

6. Modify the Namics-Library.podspec
```
spec.version - new version
...
spec.source - tag to the one from step (5)
```

7. Update cocoapod spec:
pod trunk push NMXCore.podspec --verbose
