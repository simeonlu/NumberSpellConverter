//
//  SuTestSample.m
//  Subroutine
//
//  Created by Shimin Lu on 15/03/2013.
//  Copyright (c) 2013 shimin lu. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "SuNumberSpeller.h"

@interface SuTestSample : GHTestCase{
    SuNumberSpeller *_speller;
}
@end


@implementation SuTestSample

-(void)setUp{
    [super setUp];
    _speller = [[SuNumberSpeller alloc]init];
}

-(void)tearDown{
    _speller = nil;
    [super tearDown];
}

-(void)testBigNumber{
    NSString *num = @"0";
    NSString *result = [_speller convertToSpellString:num];
    GHAssertNotNil(result, @"failed");
    
    num = @"512534";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"FIVE HUNDRED TWELVE THOUSAND FIVE HUNDRED AND THIRTY-FOUR DOLLARS", result, @"converted 512534 failed");
    
    num = @"1441011.07";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"ONE MILLION FOUR HUNDRED FORTY-ONE THOUSAND AND ELEVEN DOLLARS AND SEVEN CENTS", result, @"converted 1441011.07 failed");
    
    num = @"2001234000.70";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"TWO BILLION ONE MILLION TWO HUNDRED THIRTY-FOUR THOUSAND DOLLARS AND SEVENTY CENTS", result, @"converted 2001234000.70 failed");
    
    num = @"100000.23";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"ONE HUNDRED THOUSAND DOLLARS AND TWENTY-THREE CENTS", result, @"converted 100000.23 failed");
    
    num = @"100000000";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"ONE HUNDRED MILLION DOLLARS", result, @"converted 100000000 failed");
    
    num = @"123456780003456789";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"ONE HUNDRED TWENTY-THREE QUADRILLION FOUR HUNDRED FIFTY-SIX TRILLION SEVEN HUNDRED EIGHTY BILLION THREE MILLION FOUR HUNDRED FIFTY-SIX THOUSAND SEVEN HUNDRED AND EIGHTY-FOUR DOLLARS", result, @"converted 123456780003456789 failed");
    
    num = @"1234567800034.78";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"ONE TRILLION TWO HUNDRED THIRTY-FOUR BILLION FIVE HUNDRED SIXTY-SEVEN MILLION EIGHT HUNDRED THOUSAND AND THIRTY-FOUR DOLLARS AND SEVENTY-EIGHT CENTS", result, @"converted 1234567800034.78 failed");

}

-(void)testSmallNumber{
    
    NSString *num = @"0";
    NSString *result = [_speller convertToSpellString:num];
    GHAssertEqualStrings(@"", result, @"converted 0 failed");
    
  
    num = @"11.09";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"ELEVEN DOLLARS AND NINE CENTS", result, @"converted 11.09 failed");
    
    num = @"12.13";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"TWELVE DOLLARS AND THIRTEEN CENTS", result, @"converted 12.13 failed");
    
    num = @"56.789";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"FIFTY-SIX DOLLARS AND SEVENTY-NINE CENTS", result, @"converted 56.789 failed");
    
    num = @"100.8";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"ONE HUNDRED DOLLARS AND EIGHTY CENTS", result, @"converted 100.8 failed");
    
    num = @"2000.8";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"TWO THOUSAND DOLLARS AND EIGHTY CENTS", result, @"converted 2000.8 failed");
    
    num = @"3110";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"THREE THOUSAND ONE HUNDRED AND TEN DOLLARS", result, @"converted 3110 failed");
    
}

-(void)testSpecialNumber {

    NSString *num = @"0";
    NSString *result = [_speller convertToSpellString:num];
    GHAssertEqualStrings(@"", result, @"converted 0 failed");
    
    num = @"0.1334";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"THIRTEEN CENTS", result, @"converted 0.03 failed");
    
    num = @"0.01";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"ONE CENT", result, @"converted 11.09 failed");
    
    num = @"0.1";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"TEN CENTS", result, @"converted 12.13 failed");
    
    num = @"1.0";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"ONE DOLLAR", result, @"converted 56.789 failed");
    
    num = @"100";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"ONE HUNDRED DOLLARS", result, @"converted 100 failed");
    
    num = @"2000";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"TWO THOUSAND DOLLARS", result, @"converted 2000 failed");
    
    num = @"30000";
    result =[_speller convertToSpellString:num];
    GHAssertEqualStrings(@"THIRTY THOUSAND DOLLARS", result, @"converted 30000 failed");
    

}


@end
