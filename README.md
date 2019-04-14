#  ContextCueSDK
#### ContextCueSDK is the easiest way to _ethically_ earn money in your iOS app

Thanks for your interest in ContextCue! We aim to provide the best mobile ad monetization solution, all without tracking, collecting, or storing user data.

Don't have an account? [Get started](https://adstudio.contextcue.com/register)

## Having Trouble?
- Check out our support website at [https://support.contextcue.com](https://support.contextcue.com)
- Reach out to our team directly at [support@contextcue.com](mailto:support@contextcue.com)

## Installation
The ContextCueSDK provides multiple methods for installing the library into an application

### CocoaPods
[CocoaPods](https://cocoapods.org) is a dependency manager for both Swift and Objective-C Cocoa projects, which automates and simplifies the process of using 3rd-party libraries like the ContextCueSDK in your projects. You can install it with the following command:
```
$ gem install cocoapods
```
***Podfile*** To integrate ContextCueSDK into your application using CocoaPods, add it your pod file like so
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

target 'MyApp' do
pod 'ContextCueSDK', '~> 1.0'
end
```
Then run
```
$ pod install
```

## Integration
There are a few ways to integrate ContextCue ads into your application

A few things that you should be aware about for all ad banners
- Ads are centered both horizontally and verically. This means that if your view is larger than the ad, you'll have a transparent frame around the ad
- Ads are automatically refreshed every two minutes, but can be configured.
- `view.id` must be provided for _every_ ad view
- `view.loadAd()` must be called on _every_ view in order to start serving ads.
- All views can be created programmatically or through a storyboard

#### CCAdBannerView
This banner view gives complete control over the size of the ad that is loaded. However, with this extra power comes 
greater responsibility in handling device rotation and sizing.
```
@IBOutlet let bannerView: CCAdBannerView!
...
self.bannerView.id = "xsbQ1Tq8V"
self.bannerView.setSize(.LargeMobileBanner)
self.bannerView.loadAd()
```
#### CCAdBannerAutoSizeView
The CCAdBannerAutoSizeView will automatically fit the largest ad possible into the given view frame. It will also intelligently
fetch new ads if the size changes.
```
@IBOutlet let bannerView: CCAdBannerAutoSizeView!
...
self.bannerView.id = "xsbQ1Tq8V"
self.bannerView.loadAd()
```
### View Settings
| Setting | Type | Default Value | Required | Description |
| --- | --- | --- | --- | --- |
|`id`|`String`|`nil`|Yes|This is what identifies your ad as yours. It's highly recommended to have a unit id for each ad in your application. These can be found in the Publisher section of the ContextCue website.|
|`autoRefresh`|`Bool`|`true`|No|Enables or disables automatic ad refresh for an ad view|

### ContextCueSDK Settings
| Setting | Type | Default Value | Required | Description |
| --- | --- | --- | --- | --- |
|`identifier`|`String`|nil|Yes|This is the identifier that ContextCue uses to identify your app as your app. This can be found in your ContextCue account|
|`refreshInterval`|`TimeInterval`|`120`|No|Configures how often the ads are refreshed. Must be greater than 15 seconds|

Here is an example of the `refreshInterval` being set to 60 seconds globally
```
ContextCueSDK.shared.refreshInterval = TimeInterval(60)
```

## Supported Mobile Sizes
| Name | Width | Height |
| --- | --- | --- |
|MobileLeaderboard|320|50|
|LargeMobileBanner|320|100|
|MediumRectangle|300|250|
|Leaderboard|714|90|

## Reacting to Ad events
There are a number of events you can listen to by implementing the `CCAdViewDelegate`
### `didReceiveAd(_ view: CCAdBannerBaseView)`
This is called whenever an ad is successfully loaded.
	
### `failedToLoadAd(_ view: CCAdBannerBaseView, _ error: CCAdError)`
This is called whenever there was an error loading an ad. The available errors
can be found in [CCAdConstants.swift](ContextCueSDK/CCAdConstants.swift)
	
### `adWasTapped(_ view: CCAdBannerBaseView)`
This is called whenever an ad was tapped.
