//
//  SVMMasterVC.m
//  SplitVCPoC
//
//  Created by Amin Siddiqui on 17/07/17.
//  Copyright © 2017 svmLogics. All rights reserved.
//

#import "SVMMasterVC.h"

@interface SVMMasterVC () <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tvMenu;
    
    NSArray *arrDatasource;
    NSInteger selectedRow;
}
@end

@implementation SVMMasterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.splitViewController setPreferredDisplayMode:UISplitViewControllerDisplayModePrimaryHidden];
    [tvMenu setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    arrDatasource = @[@{@"title"                : @"First"
                        , @"segueIdentifier"    : @"segueSVMFirstDetailVC"}
                      , @{@"title"              : @"Second"
                          , @"segueIdentifier"  : @"segueSVMSecondDetailVC"}];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrDatasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictOption = arrDatasource[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"master option"];
    [cell.textLabel setText:dictOption[@"title"]];
    
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //Hide Master viewController (with animation)
    [UIView animateWithDuration:0.27f
                     animations:^{
                         [self.splitViewController setPreferredDisplayMode:UISplitViewControllerDisplayModePrimaryHidden];
                     }];
    
    if (indexPath.row != selectedRow) {
        selectedRow = indexPath.row;
        
        //Load Detail viewController
        NSDictionary *dictOption = arrDatasource[indexPath.row];
        NSString *strSegueIdentifier = dictOption[@"segueIdentifier"];
        
        NSLog(@"Loading Detail viewController with segue identifier: %@", strSegueIdentifier);
        [self performSegueWithIdentifier:strSegueIdentifier
                                  sender:nil];
    }
}

@end
