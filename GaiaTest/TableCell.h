//
//  TableCell.h
//  GaiaTest
//
//  Created by Kevin Moy on 7/17/14.
//  Copyright (c) 2014 Kevin Moy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UIView *customLabel;

@property (weak, nonatomic) IBOutlet UIImageView *customImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end
