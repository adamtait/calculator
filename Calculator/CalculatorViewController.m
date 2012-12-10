//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Adam Tait on 9/3/12.
//  Copyright (c) 2012 Rally. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
    @property (nonatomic) BOOL userIsInMiddleOfEnteringANumber;
    @property (nonatomic, strong) CalculatorBrain *brain;
    - (void)appendToHistory:(NSString *)string;
@end

@implementation CalculatorViewController

@synthesize history = _history;
@synthesize display = _display;
@synthesize userIsInMiddleOfEnteringANumber = _userIsInMiddleOfEnteringANumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    
    if(_userIsInMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        _userIsInMiddleOfEnteringANumber = YES;
    }

}
- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInMiddleOfEnteringANumber = NO;
    [self appendToHistory:self.display.text];
}

- (IBAction)clear {
    self.userIsInMiddleOfEnteringANumber = NO;
    [self.brain clearOperands];
    self.display.text = @"";
    self.history.text = @"";
}

- (IBAction)operationPressed:(UIButton *)sender {
    if(self.userIsInMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    NSString *operation = sender.currentTitle;
    [self appendToHistory:operation];
    
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)variablePressed:(UIButton *)sender {
    if(self.userIsInMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    
    NSString *variable = sender.currentTitle;
    [self appendToHistory:variable];
    [self.brain pushVariable:variable];
}


- (void)appendToHistory:(NSString *)string {
    self.history.text = [self.history.text stringByAppendingString:string];
    self.history.text = [self.history.text stringByAppendingString:@" "];
}

- (IBAction)variablesUsedPressed:(UIButton *)sender {
    
}

//NSLog(@"user touched %@", digit);

- (void)viewDidUnload {
    [self setHistory:nil];
    [super viewDidUnload];
}
@end
