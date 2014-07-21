//
//  ViewController.h
//  GaiaTest
//
//  Created by Kevin Moy on 7/15/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIImageView+AFNetworking.h"
#import "TableCell.h"


@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
