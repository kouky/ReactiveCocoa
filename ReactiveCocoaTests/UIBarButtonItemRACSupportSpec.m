//
//  UIBarButtonItemRACSupportSpec.m
//  ReactiveCocoa
//
//  Created by Kyle LeNeau on 4/13/13.
//  Copyright (c) 2013 GitHub, Inc. All rights reserved.
//

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>
#import <Nimble/Nimble-Swift.h>

#import "RACControlCommandExamples.h"

#import "UIBarButtonItem+RACCommandSupport.h"
#import "RACCommand.h"
#import "RACDisposable.h"

QuickSpecBegin(UIBarButtonItemRACSupportSpec)

qck_describe(@"UIBarButtonItem", ^{
	__block UIBarButtonItem *button;
	
	qck_beforeEach(^{
		button = [[UIBarButtonItem alloc] init];
		expect(button).notTo(beNil());
	});

	qck_itBehavesLike(RACControlCommandExamples, ^{
		return @{
			RACControlCommandExampleControl: button,
			RACControlCommandExampleActivateBlock: ^(UIBarButtonItem *button) {
				NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:(NSMethodSignature * _Nonnull)[button.target methodSignatureForSelector:button.action]];
				invocation.selector = (SEL _Nonnull)button.action;

				id target = button.target;
				[invocation setArgument:&target atIndex:2];
				[invocation invokeWithTarget:target];
			}
		};
	});
});

QuickSpecEnd
