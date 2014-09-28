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

// Google Advert
@import AdSupport;
@import AudioToolbox;
@import AVFoundation;
@import CoreGraphics;
@import CoreTelephony;
@import EventKit;
@import EventKitUI;
@import MessageUI;
@import StoreKit;
@import SystemConfiguration;

// iAD
@import iAd;

#import <Foundation/Foundation.h>
#import "IndieGamesHelperDefines.h"
#import <UIKit/UIKit.h>

@protocol AdvertisingHandlerDelegate <NSObject>

// ***** Full Screen *****
- (void)fullScreenAdvertDidLoad;
- (void)fullScreenAdvertPresented;
- (void)fullScreenAdvertWasClosed;

// ***** Banner View *****
- (void)advertisingBannerDidLoad;

@end

@interface AdvertisingHandler : NSObject
@property id<AdvertisingHandlerDelegate> delegate;

+ (AdvertisingHandler *)sharedInstance;

- (void)prepareFullScreenAdvertInViewController:(UIViewController *)viewController;

- (void)showFullScreenAdvertIfLoadedInViewController:(UIViewController *)viewController;

- (void)prepareBannerAdvertInViewController:(UIViewController *)viewController withSize:(AdvertBannerSize)bannerSize;

- (void)showBannerAdverIfLoadedInViewController:(UIViewController *)viewController withBannerCenter:(CGPoint)center andSize:(AdvertBannerSize)bannerSize;

@end
