//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Adam Tait on 9/3/12.
//  Copyright (c) 2012 Rally. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInMiddleOfEnteringANumber;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userIsInMiddleOfEnteringANumber;

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    if(userIsInMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        userIsInMiddleOfEnteringANumber = YES;
    }

}
- (IBAction)enterPressed {
}

- (IBAction)operationPressed:(UIButton *)sender {
}

//NSLog(@"user touched %@", digit);

@end
