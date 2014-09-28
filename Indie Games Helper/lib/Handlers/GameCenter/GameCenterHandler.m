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

@import GameKit;
#import "GameCenterHandler.h"
#import "IndieGamesHelperDefines.h"

@interface GameCenterHandler () <GKGameCenterControllerDelegate> {
    BOOL _gameCenterAvailable;
    BOOL _userAuthenticated;
    GKGameCenterViewController *_gameCenterController;
}

@end

@implementation GameCenterHandler

SINGLETON_GCD(GameCenterHandler);

- (instancetype)init {
    self = [super init];
    if (self) {
        _gameCenterAvailable = [self p_isGameCenterAvailable];
        if (!_gameCenterAvailable) return self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(authenticationChanged)
                                                     name:GKPlayerAuthenticationDidChangeNotificationName
                                                   object:nil];
        [self p_initLeaderboard];
    }
    return self;
}

- (void)p_initLeaderboard {
    [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
        
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            _gameCenterController = [[GKGameCenterViewController alloc] init];
            if (_gameCenterController != nil) {
                _gameCenterController.gameCenterDelegate = self;
                _gameCenterController.viewState = GKGameCenterViewControllerStateLeaderboards;
                _gameCenterController.leaderboardIdentifier = LEADERBOARD_ID;
            }
        }
    }];
}

- (void)authenticationChanged {
    if ([GKLocalPlayer localPlayer].isAuthenticated && !_userAuthenticated) {
        NSLog(@"Authentication changed, user authorized");
        _userAuthenticated = YES;
    } else if ([GKLocalPlayer localPlayer].isAuthenticated && _userAuthenticated) {
        NSLog(@"Authentication changed, user log out");
        _userAuthenticated = NO;
    }
}

- (void)authenticateLocalUser {
    if (!_gameCenterAvailable) return;
    NSLog(@"Authenticate local user");
    if (![GKLocalPlayer localPlayer].authenticated) {
                [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:nil];
//        [[GKLocalPlayer localPlayer] authenticateHandler];
    } else {
        NSLog(@"Already Authenticated");
    }
}

- (BOOL)p_isGameCenterAvailable {
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                           options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

- (void)reportScore:(long long int)score {
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:LEADERBOARD_ID forPlayer:[GKLocalPlayer localPlayer].playerID];
        scoreReporter.value = score;
        NSLog(@"Score reporter value: %@", scoreReporter);
        [GKScore reportScores:@[scoreReporter] withCompletionHandler:^(NSError *error) {
            if (error != nil) {
                NSLog(@"Error");
                // handle the reporting error
            }
            
        }];
    }
}

- (void)showLeaderboardInViewController:(UIViewController *)viewController {
    if (_gameCenterController) {
        [viewController presentViewController:_gameCenterController animated: YES completion:nil];
    }
}

#pragma mark Game Center controller delegate

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewControlle {
    [_gameCenterController dismissViewControllerAnimated:YES completion:nil];
}

@end
