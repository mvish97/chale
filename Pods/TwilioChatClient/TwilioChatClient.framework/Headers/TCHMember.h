//
//  TCHMember.h
//  Twilio Chat Client
//
//  Copyright (c) 2017 Twilio, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TCHConstants.h"

/** Representation of a Member on a chat channel. */
@interface TCHMember : NSObject

/** The identity for this member. */
@property (nonatomic, strong, readonly, nullable) NSString *identity;

/** Index of the last Message the Member has consumed in this Channel. */
@property (nonatomic, copy, readonly, nullable) NSNumber *lastConsumedMessageIndex;

/** Timestamp the last consumption updated for the Member in this Channel. */
@property (nonatomic, copy, readonly, nullable) NSString *lastConsumptionTimestamp;

/** Timestamp the last consumption updated for the Member in this Channel as an NSDate. */
@property (nonatomic, strong, readonly, nullable) NSDate *lastConsumptionTimestampAsDate;

/** Obtain a static snapshot of the user descriptor object for this member.
 
 @param completion Completion block that will specify the result of the operation and the user descriptor.
 */
- (void)userDescriptorWithCompletion:(nonnull TCHUserDescriptorCompletion)completion;

/** Obtain a subscribed user object for the member.  If no current subscription exists for this user, this will
 fetch the user and subscribe them.  The least recently used user object will be unsubscribed if you reach your instance's
 user subscription limit.
 
 @param completion Completion block that will specify the result of the operation and the newly subscribed user.
 */
- (void)subscribedUserWithCompletion:(nonnull TCHUserCompletion)completion;

@end
