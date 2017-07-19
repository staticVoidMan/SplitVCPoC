//
//  SVMSecondDetailVC.m
//  SplitVCPoC
//
//  Created by Amin Siddiqui on 17/07/17.
//  Copyright © 2017 svmLogics. All rights reserved.
//

#import "SVMSecondDetailVC.h"

@interface SVMSecondDetailVC ()
{
    IBOutlet UIBarButtonItem *bbtnHamburger;
    IBOutlet UIButton *btnHamburger;
}
@end

@implementation SVMSecondDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)btnHamburger_Act:(UIButton *)sender {
    UISplitViewControllerDisplayMode displayMode = self.splitViewController.displayMode;
    if (displayMode != UISplitViewControllerDisplayModePrimaryHidden) {
        displayMode = UISplitViewControllerDisplayModePrimaryHidden;
    }
    else {
        displayMode = UISplitViewControllerDisplayModeAllVisible;
    }    
    
    [UIView animateWithDuration:0.27f
                     animations:^{
                         [self.splitViewController setPreferredDisplayMode:displayMode];
                     }];
}

@end
