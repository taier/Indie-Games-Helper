/*
 The MIT License (MIT)
 
 Copyright (c) 2014 deniss.kaibagarovs@gmail.com, Denis Kaibagarovs.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import "IndieGamesHelperDefines.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol IndieGamesHelperDeleate <NSObject>

@optional

// ***** Advertising *****
// *** Full Screen ***
- (void)fullScreenAdvertDidLoad;
- (void)fullScreenAdvertPresented;
- (void)fullScreenAdvertWasClosed;
// *** Banner View ***
- (void)advertisingBannerDidLoad;

// ***** Purchases *****
- (void)removeADSSuccess;

@end

@interface IndieGamesHelper : NSObject
@property (nonatomic) id<IndieGamesHelperDeleate> delegate;

+ (IndieGamesHelper *)sharedInstance;

// ***** Share Methods *****
- (void)shareFacebookInViewController:(UIViewController *)viewController andText:(NSString *)text;

- (void)shareTwitterInViewController:(UIViewController *)viewController andText:(NSString *)text;

// ***** LeaderBoard Methods *****
- (void)authenticateLocalUser;

- (void)reportScore:(long long int)score;

- (void)showLeaderboardInViewController:(UIViewController *)viewController;

// ***** In App Purchase *****
- (void)purchaseRemovingAD;

- (void)restorePurchase;

// ***** Advertising *****

- (void)prepareFullScreenAdvertInViewController:(UIViewController *)viewController;

- (void)showFullScreenAdvertIfLoadedInViewController:(UIViewController *)viewController;

- (void)prepareBannerAdvertInViewController:(UIViewController *)viewController withSize:(AdvertBannerSize)bannerSize;

- (void)showBannerAdvertIfLoadedInViewController:(UIViewController *)viewController withBannerCenter:(CGPoint)center andSize:(AdvertBannerSize)bannerSize;

@end
