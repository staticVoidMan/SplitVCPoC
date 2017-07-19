//
//  SVMFirstDetailVC.m
//  SplitVCPoC
//
//  Created by Amin Siddiqui on 17/07/17.
//  Copyright © 2017 svmLogics. All rights reserved.
//

#import "SVMFirstDetailVC.h"

@interface SVMFirstDetailVC ()
{
    IBOutlet UIButton *btnShowMaster;
}
@end

@implementation SVMFirstDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem setLeftBarButtonItem:[self createHamburgerBarButton]];
}

-(IBAction)btnShowMaster_Act:(UIButton *)sender {
    [UIView animateWithDuration:0.27f
                     animations:^{
                         [self.splitViewController setPreferredDisplayMode:UISplitViewControllerDisplayModeAllVisible];
                     }];
}

#pragma mark - UISplitViewController Related Helper Methods
-(UIBarButtonItem *)createHamburgerBarButton {
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitle:@"☰"
            forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor]
                 forState:UIControlStateNormal];
    
    [barButton setCustomView:button];
    [button addTarget:self
               action:@selector(toggleMasterViewController:event:)
     forControlEvents:UIControlEventTouchUpInside];
    
    return barButton;
}

-(void)toggleMasterViewController:(UIButton *)sender event:(UIEvent *)event {
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
