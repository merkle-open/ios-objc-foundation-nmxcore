//
//  ViewController.m
//  ios-objc-foundation-nmxcore Example
//
//  Created by Tobias Baube on 29/06/16.
//  Copyright © 2016 Tobias Baube. All rights reserved.
//

#import "ViewController.h"
#import "NMXCore.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@" ");
    NSLog(@"-- NSNumber isPositive --");
    NSLog(@"Check if number is positive:  123 - %@",[@(123) isPositive]?@"YES":@"NO");
    NSLog(@"Check if number is positive: -123 - %@",[@(-123) isPositive]?@"YES":@"NO");
    
    NSLog(@" ");
    NSLog(@"-- NSNumber isPositiveOrZero --");
    NSLog(@"Check if number is positive:           0 - %@",[@(0) isPositive]?@"YES":@"NO");
    NSLog(@"Check if number is positive | zero:    0 - %@",[@(0) isPositiveOrZero]?@"YES":@"NO");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
