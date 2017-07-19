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
    UIViewController *masterViewController;
    IBOutlet UITableView *tvMenu;
    
    NSMutableArray *arrDatasource;
    NSInteger selectedRow;
}
@end

@implementation SVMMasterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.splitViewController setPreferredDisplayMode:UISplitViewControllerDisplayModePrimaryHidden];
    [tvMenu setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    masterViewController = self.splitViewController.viewControllers.firstObject;
    
    [self createDatasource];
}

-(void)createDatasource {
    arrDatasource = [[NSMutableArray alloc] init];
    [arrDatasource addObject:[@{@"title"            : @"First"
                                , @"segueIdentifier": @"segueSVMFirstDetailVC"
                                , @"viewController" : self.splitViewController.viewControllers.lastObject
                                } mutableCopy]];
    [arrDatasource addObject:[@{@"title"            : @"Second"
                                , @"segueIdentifier": @"segueSVMSecondDetailVC"
                                } mutableCopy]];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrDatasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictDetailView = arrDatasource[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"master option"];
    [cell.textLabel setText:dictDetailView[@"title"]];
    
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
        NSDictionary *dictDetailView = arrDatasource[indexPath.row];
        NSString *strSegueIdentifier = dictDetailView[@"segueIdentifier"];
        
        if ([self shouldPerformSegueWithIdentifier:strSegueIdentifier
                                            sender:indexPath]) {
            [self performSegueWithIdentifier:strSegueIdentifier
                                      sender:indexPath];
        }
    }
    else {
        NSLog(@"No load needed");
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    NSIndexPath *indexPath = sender;
    NSDictionary *dictDetailView = arrDatasource[indexPath.row];
    
    if (dictDetailView[@"viewController"]) {
        /* if detail viewController was previously loaded then do not perform segue
         and instead update splitViewController manually with the captured detail
         viewController
         */
        
        UIViewController *detailVC = dictDetailView[@"viewController"];
        
        NSLog(@"Loading Existing: %@", detailVC);
        [self.splitViewController setViewControllers:@[masterViewController
                                                       , detailVC]];
        
        return NO;
    }
    
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *detailVC = segue.destinationViewController;
    
    /*
     Capture the detail viewController relative to it's index in the
     tableView datasource
     */
    NSIndexPath *indexPath = sender;
    NSMutableDictionary *dictDetailView = arrDatasource[indexPath.row];
    dictDetailView[@"viewController"] = detailVC;
    
    NSLog(@"Loading New: %@", detailVC);
}
@end
