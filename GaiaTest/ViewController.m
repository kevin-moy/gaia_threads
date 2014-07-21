//
//  ViewController.m
//  GaiaTest
//
//  Created by Kevin Moy on 7/15/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+AFNetworking.h"


static NSString * const BaseURLString = @"http://r.tentacl.com/forum/explore";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>


@property(nonatomic, strong) NSArray *threndsArray;
@property(nonatomic, strong) NSMutableArray *datasourceArray;
@end

@implementation ViewController


// Method to substring a string
//- (NSString *)extractString:(NSString *)fullString toLookFor:(NSString *)lookFor toStopBefore:(NSString *)stopBefore
//{
//    
//    NSRange firstRange = [fullString rangeOfString:lookFor];
//    NSRange secondRange = [[fullString substringFromIndex:firstRange.location] rangeOfString:stopBefore];
//    NSRange finalRange = NSMakeRange(firstRange.location, secondRange.location + [stopBefore length]);
//    
//    return [fullString substringWithRange:finalRange];
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil] forCellReuseIdentifier:@"cellIdentifier"];
    
    self.datasourceArray = [[NSMutableArray alloc] init];
    
    //Create string representing full url from base URl -> create NSURL object, -> dictionary of parameters
    
    NSURL *url = [NSURL URLWithString:BaseURLString];
    NSDictionary *parameters = @{@"subview": @"trending",
                                 @"sort_key": @"total",
                                 @"t": @"json",
                                 @"ajax": @"1",
                                 @"page": @"1",
                                 };
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //Create instance of AFHTTPSessionManager and set responseSerializer to default JSON seralizer. AFNetworking takes care of parsing JSON to you
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/x-javascript", nil];

    [manager GET:BaseURLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject)
    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Retrieved Data!"
//                                                            message:nil
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//        [alertView show];
        
        NSDictionary *dictionary = responseObject;
        NSLog(@"%@", dictionary.description);
        
       //
        self.threndsArray = dictionary[@"threads"];
        
        // Loop through each thrend in array to find certain information
        for (NSDictionary*threadDictionary in self.threndsArray)
        {
            
            //Get all the information from thrends array that we need to display: subject and description
            
            NSString *subject = threadDictionary[@"subject"];
            NSDictionary *firstPost = threadDictionary[@"firstPost"];
            NSString *body = firstPost[@"body"];
            
            
            //Get the image URL as a string between 2 parameters,
            NSString *imageURLString = nil;
            NSRange middle = [body rangeOfString:@"[img]"];
            if (middle.location != NSNotFound)
            {
                imageURLString = [body substringFromIndex:middle.location + middle.length];
                NSRange end = [imageURLString rangeOfString:@"[/img]"];
                if (end.location != NSNotFound)
                {
                    imageURLString = [imageURLString substringToIndex:end.location];
                }
            }
            NSString *descriptionString = [body substringToIndex:middle.location];

            
       //     NSString *imageURLString = [self extractString:BaseURLString toLookFor:@"[img]" toStopBefore:@"[/img]"];
            
            // Make dictionary to hold subject, body to access later
            NSDictionary *dict = @{@"title":subject,
                                   @"description":descriptionString,
                                   @"picture":imageURLString
                                   };
            
            // Store data in Array
            [self.datasourceArray addObject:dict];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:BaseURLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    TableCell *tablecell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    
    // If there is no cell, make a cell
    if (!tablecell)
    {
        tablecell = (TableCell *)[tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
        
     //     tablecell = [[TableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdentifier"];
    }
    
//    // Add image URL to cell
//    UIImageView *imageView = [[UIImageView alloc] init];
//    
//    imageView.frame = CGRectMake(4, 4, 50, 50);
////    imageView.center = CGPointMake(310, 48);
//    [tablecell.contentView addSubview:imageView];
    
    //Set image
    
//    [imageView setImageWithURL:imageURL];
//
    
    
    // Get dictionary from index of array
    NSDictionary *dict = self.datasourceArray[indexPath.row];
    
    //Convert NSString to NSURL
    NSURL *imageURL = [NSURL URLWithString:[dict[@"picture"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    // Set data onto cell
    [tablecell.customImage setImageWithURL:imageURL];
    tablecell.customImage.contentMode = UIViewContentModeScaleAspectFit;
    
    tablecell.titleLabel.text = dict[@"title"];
    tablecell.descriptionLabel.text = dict[@"description"];
   
    return tablecell;
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    TableCell *tableCell = (TableCell *)cell;
//    
//
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasourceArray.count;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
