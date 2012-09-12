//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Adam Tait on 9/3/12.
//  Copyright (c) 2012 Rally. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

    - (void)pushOperand:(double)operand;
    - (double)performOperation:(NSString *)operation;
    - (void)clearOperands;

    @property (nonatomic, readonly) id program;

    + (NSString *)descriptionOfProgram:(id)program;
    + (double)runProgram:(id)program;

@end
