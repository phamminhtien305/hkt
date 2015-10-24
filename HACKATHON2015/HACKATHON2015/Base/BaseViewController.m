//
//  BaseViewController.m
//  HACKATHON2015
//
//  Created by Minh Tien on 10/24/15.
//  Copyright (c) 2015 hackathon. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initUsingNib{
    self = [super initWithNibName:[[self class] nibName] bundle:nil];
    if(self)
    {
        
    }
    return self;
}


+(NSString *)nibName{
    return NSStringFromClass([super class]);
}



@end
