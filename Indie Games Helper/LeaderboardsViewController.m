//
//  SecondViewController.m
//  Indie Games Helper
//
//  Created by Denis on 27/09/2014.
//  Copyright (c) 2014 deniss.kaibagarovs@gmail.com, Denis Kaibagarovs. All rights reserved.
//

#import "LeaderboardsViewController.h"
#import "IndieGamesHelper.h"

@interface LeaderboardsViewController () <UITextFieldDelegate> {
    NSString *enteredScore;
}

@end

@implementation LeaderboardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceivekkMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Text Field Delegates

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    enteredScore = [NSString stringWithFormat:@"%@%@",textField.text,string];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    enteredScore = textField.text;
    [textField resignFirstResponder];
    return NO;
}


#pragma mark Buttons

- (IBAction)onAuthorizeButtonPress:(id)sender {
    [[IndieGamesHelper sharedInstance] authenticateLocalUser];
}

- (IBAction)onSetScoreButtonPress:(id)sender {
    [[IndieGamesHelper sharedInstance] reportScore:[enteredScore integerValue]];
}
- (IBAction)onShowScoreButtonPress:(id)sender {
    [[IndieGamesHelper sharedInstance] showLeaderboardInViewController:self];
    
}

@end
