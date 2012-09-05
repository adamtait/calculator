//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Adam Tait on 9/3/12.
//  Copyright (c) 2012 Rally. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack {
    if(!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void)pushOperand:(double)operand {
    NSNumber *numberObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:numberObject];
}

- (double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if(operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation {
    double result = 0;
    if([operation isEqualToString:@"+"]){
        result = [self popOperand] + [self popOperand];
    }
    else if([operation isEqualToString:@"*"]){
        result = [self popOperand] * [self popOperand];
    }
    else if([operation isEqualToString:@"-"]){
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    }
    else if([operation isEqualToString:@"/"]){
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    }
    else if([operation isEqualToString:@"sin"]){
        result = sin([self popOperand]);
    }
    else if([operation isEqualToString:@"cos"]){
        result = cos([self popOperand]);
    }
    else if([operation isEqualToString:@"sqrt"]){
        result = sqrt([self popOperand]);
    }
    
    [self pushOperand:result];
    return result;
}

@end
