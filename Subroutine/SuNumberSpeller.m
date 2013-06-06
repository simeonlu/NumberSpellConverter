//
//  SuNumberSpeller.m
//  Subroutine
//
//  Created by Shimin Lu on 11/03/2013.
//  Copyright (c) 2013 shimin lu. All rights reserved.
//

#import "SuNumberSpeller.h"
@interface SuNumberSpeller ()
{
    NSArray*_tensDigits;
    NSArray*_units;
    NSArray*_largeUnits;
    
}

@end


@implementation SuNumberSpeller

-(id)init{

    self= [super init];
    if (self) {
        _units = @[@"one",
                   @"two",
                   @"three",
                   @"four",
                   @"five",
                   @"six",
                   @"seven",
                   @"eight",
                   @"nine",
                   @"ten",
                   @"eleven",
                   @"twelve",
                   @"thirteen",
                   @"fourteen",
                   @"fifteen",
                   @"fifteen",
                   @"seventeen",
                   @"eighteen",
                   @"nineteen"
                   ];
        
        _tensDigits = @[@"twenty",
                        @"thirty",
                        @"forty",
                        @"fifty",
                        @"sixty",
                        @"seventy",
                        @"eighty",
                        @"ninety"
                        ];
        
        _largeUnits = @[@"hundred",
                        @"thousand",
                        @"million",
                        @"billion",
                        @"trillion",
                        @"quadrillion"];
    }
    return self;
}

-(NSString*)spellFormatNumber:(NSNumber*)number{
    
    long long num = [number longLongValue];
    NSMutableString* spellResult = [[NSMutableString alloc]init];
    int i = 0;
    while (num) {
       int remainder = num%1000;       
        NSString *str =[self spellThreeDigits:remainder];
        
        if (i&&remainder) {
            if (str.length>0) {
                NSString*lstr = [NSString stringWithFormat:@"%@ %@ ",str,_largeUnits[i]];
                [spellResult insertString:lstr atIndex:0];
            }                       
        }else {
            if (str.length>0) {
                if (num>100) {
                    NSRange range = [str rangeOfString:@"hundred" options:NSBackwardsSearch];
                    if (range.location!=NSNotFound) {
                        [spellResult appendString:str];
                        [spellResult insertString:@" and" atIndex:range.location + @"hundred".length];
                    } else  [spellResult appendFormat:@"and %@",str ];
                }else [spellResult appendString:str];
            }
        }
       
        num /=1000;
        i++;       
    }
    
    NSLog(@"spelling result: +%@+",spellResult);
    return [spellResult stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

}

-(NSString*)spellThreeDigits:(NSUInteger)num{

    if (num==0)     { return @"";    }
    if (num%100==0) { return [NSString stringWithFormat:@"%@ hundred",_units[num/100-1]];    }
    
    NSMutableString *result = [[NSMutableString alloc]init];
    int u=0,t=0,h=0;
    
    //split out
    u = num%10;
    t = ((num-u)%100)/10;
    h = ((num-t-u)%1000)/100;
    
    NSLog(@"u t h :%d,%d,%d",u ,t, h);

    if (h>0) {     [result appendFormat:@"%@ %@ ",_units[h-1],_largeUnits[0]];    }
    
    if (t>0) {        
        if (t>1) {
            
            [result appendFormat:@"%@",_tensDigits[t-2]];            
            if (u>0) {  [result appendFormat:@"-%@",_units[u-1]];   }
            
        }else {
            int tens = num%100;
            [result appendString:_units[tens-1]];
        }
    }else {        
        [result appendString:_units[u-1]];  }
 
 
    return result;
}

-(NSString*)convertToSpellString:(NSString*)numStr{

    if (numStr.length==0) { return @"";    }
    
    
    NSArray *parts = [[NSString stringWithFormat:@"%.02f",[numStr doubleValue]] componentsSeparatedByString:@"."];
    
    // integer part
    
    NSString*convertedIntStr = nil;
    NSDecimalNumber *numInt = [NSDecimalNumber decimalNumberWithString:parts[0]];
    
    long long s = [numInt longLongValue];
    if (s>0) {
        NSString *currency =  s>1? @" DOLLARS": @" DOLLAR";
        
        convertedIntStr = [[[self spellFormatNumber:numInt] stringByAppendingString:currency ]uppercaseString];        
    }
        
    //fraction part
    
    if (parts.count>1) {
        NSString *convertedDeciStr =nil;
        NSDecimalNumber *numDeci = [NSDecimalNumber decimalNumberWithString:parts[1]];
        int c = [numDeci integerValue];
        
        if (c>0) {
            NSString *cent =  c>1? @" CENTS": @" CENT";
            convertedDeciStr = [[[self spellFormatNumber:numDeci] stringByAppendingString:cent] uppercaseString];
            if (convertedIntStr) {
                return [NSString stringWithFormat:@"%@ AND %@",convertedIntStr,convertedDeciStr];
            }else  return convertedDeciStr;        
        }
    }
    
    
    return  convertedIntStr? convertedIntStr :@"";
}



@end
