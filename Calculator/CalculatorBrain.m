//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Adam Tait on 9/3/12.
//  Copyright (c) 2012 Rally. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
//    @property (nonatomic, strong) NSMutableArray *operandStack;
    @property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

//@synthesize operandStack = _operandStack;
@synthesize programStack = _programStack;

//- (NSMutableArray *)operandStack {
//    if(!_operandStack) {
//        _operandStack = [[NSMutableArray alloc] init];
//    }
//    return _operandStack;
//}

//- (void)pushOperand:(double)operand {
//    NSNumber *numberObject = [NSNumber numberWithDouble:operand];
//    [self.operandStack addObject:numberObject];
//}
//
//- (double)popOperand {
//    NSNumber *operandObject = [self.operandStack lastObject];
//    if(operandObject) [self.operandStack removeLastObject];
//    return [operandObject doubleValue];
//}

//- (double)performOperation:(NSString *)operation {
//    double result = 0;
//    if([operation isEqualToString:@"+"]){
//        double first = [self popOperand];
//        double second = [self popOperand];
//        result = first + second;
//    }
//    else if([operation isEqualToString:@"*"]){
//        result = [self popOperand] * [self popOperand];
//    }
//    else if([operation isEqualToString:@"-"]){
//        double subtrahend = [self popOperand];
//        result = [self popOperand] - subtrahend;
//    }
//    else if([operation isEqualToString:@"/"]){
//        double divisor = [self popOperand];
//        if (divisor) result = [self popOperand] / divisor;
//    }
//    else if([operation isEqualToString:@"sin"]){
//        result = sin([self popOperand]);
//    }
//    else if([operation isEqualToString:@"cos"]){
//        result = cos([self popOperand]);
//    }
//    else if([operation isEqualToString:@"sqrt"]){
//        result = sqrt([self popOperand]);
//    }
//    else if([operation isEqualToString:@"π"]){
//        result = 3.14159265;
//    }
//    
//    [self pushOperand:result];
//    return result;
//}

- (void)clearOperands {
    [self.programStack removeAllObjects];
}


- (NSMutableArray *)programStack
{
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

- (id)program
{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"Implement this in Homework #2";
}

- (void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

+ (double)popOperandOffProgramStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffProgramStack:stack] +
            [self popOperandOffProgramStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffProgramStack:stack] *
            [self popOperandOffProgramStack:stack];
        } else if ([operation isEqualToString:@"-"]) {
            double subtrahend = [self popOperandOffProgramStack:stack];
            result = [self popOperandOffProgramStack:stack] - subtrahend;
        } else if ([operation isEqualToString:@"/"]) {
            double divisor = [self popOperandOffProgramStack:stack];
            if (divisor) result = [self popOperandOffProgramStack:stack] / divisor;
        }
    }
    
    return result;
}

+ (double)runProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffProgramStack:stack];
}

@end
