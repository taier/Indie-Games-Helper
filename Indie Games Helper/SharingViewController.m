//
//  FirstViewController.m
//  Indie Games Helper
//
//  Created by Denis on 27/09/2014.
//  Copyright (c) 2014 deniss.kaibagarovs@gmail.com, Denis Kaibagarovs. All rights reserved.
//

#import "SharingViewController.h"
#import "IndieGamesHelper.h"

@interface SharingViewController () <UITextFieldDelegate> {
    NSString *enteredText;
}

@end

@implementation SharingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Text View Delegates

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    enteredText = [NSString stringWithFormat:@"%@%@",textField.text,string];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    enteredText = textField.text;
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)onFacebookButtonPress:(id)sender {
    [[IndieGamesHelper sharedInstance] shareFacebookInViewController:self andText:enteredText];
    
}
- (IBAction)onTwitterButtonPress:(id)sender {
    [[IndieGamesHelper sharedInstance] shareTwitterInViewController:self andText:enteredText];
}

@end
