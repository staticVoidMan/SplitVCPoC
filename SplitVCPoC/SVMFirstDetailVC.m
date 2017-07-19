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
}

-(IBAction)btnShowMaster_Act:(UIButton *)sender {
    [UIView animateWithDuration:0.27f
                     animations:^{
                         [self.splitViewController setPreferredDisplayMode:UISplitViewControllerDisplayModeAllVisible];
                     }];
}

@end
