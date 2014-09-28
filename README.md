Indie Games Helper v.1.0
==================

Indie Games Helper is a lightweight API for adding:

1. Advertising
2. GameCenter
3. In App Purchase 
4. Sharing 

If you've used something from that list before, you know how much time and effort it takes to make it work. With this framework, it can be done in a few minutes.

## Usage
  1. Take lib folder form this Demo Project
  2. Add it to your project
  3. Add -ObjC flag for "Other linker flags" in project Build Settings
  4. Work for iOS version 7.0+


## Advertising
###### ! Will show Google advert if iAD not available !
  1. Setup your Google Advert id in GOOGLE_ADVERT_ID define
  2. Setup delegate for Advertising loading
  
  Banner
  
  `- (void)advertisingBannerDidLoad`

  Full Screen

  `- (void)fullScreenAdvertDidLoad;`
  

  3. Request advertising
  
  Banner

  `- (void)prepareBannerAdvertInViewController:(UIViewController *)viewController withSize:(AdvertBannerSize)bannerSize;`

  Full Screen
  
  `- (void)prepareFullScreenAdvertInViewController:(UIViewController *)viewController;`
  
  3. After loading deleage get called, you can show advertising
  
  Banner 

  `- (void)showBannerAdvertIfLoadedInViewController:(UIViewController *)viewController withBannerCenter:(CGPoint)center andSize:(AdvertBannerSize)bannerSize;`

  Full Screen
  
  `- (void)showFullScreenAdvertIfLoadedInViewController:(UIViewController *)viewController;`
  
  4. (Optional) Full screen banner will also call delegates 
  
  ` - (void)fullScreenAdvertPresented;`

  ` - (void)fullScreenAdvertWasClosed;`
  
## Game Center

  1. Setup your LEADERBOARD_ID
  2. Authorize user 

  `- (void)authenticateLocalUser; `
  
  3. Now you can use:
  
 `- (void)reportScore:(long long int)score; `

 `- (void)showLeaderboardInViewController:(UIViewController *)viewController; `
 
 ## In App Purchase
 
  1. Setup yout IN_APP_PURCHASE_ID
  2. Setup delegate for purchase (As example - removeAD)
  
  `- (void)removeADSSuccess;`

  3. Now you can use: 
  
  `- (void)purchaseRemovingAD;`

  `- (void)restorePurchase;`

## Sharing
  
  `- (void)shareFacebookInViewController:(UIViewController *)viewController andText:(NSString *)text;`

  `- (void)shareTwitterInViewController:(UIViewController *)viewController andText:(NSString *)text;`


## License
Indie Games Helper is available under the MIT license. See the LICENSE file for more information.





