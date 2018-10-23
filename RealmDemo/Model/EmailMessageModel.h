//
//  EmailMessageModel.h
//  RealmDemo
//
//  Created by Phuc Nguyen on 10/3/18.
//  Copyright © 2018 Phuc Nguyen. All rights reserved.
//

#import "AbstractModel.h"

@interface EmailMessageModel : AbstractModel

@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *body;

@end

RLM_ARRAY_TYPE(EmailMessageModel)
