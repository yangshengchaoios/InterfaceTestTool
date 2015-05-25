//
//  ITTModel.m
//  InterfaceTestTool
//
//  Created by yangshengchao on 15/5/25.
//  Copyright (c) 2015年 Builder. All rights reserved.
//

#import "ITTModel.h"

@implementation InterfaceGroupModel
+ (NSArray *)FetchGroups {
    NSMutableArray *groupArray = [NSMutableArray array];
    FMDatabase *db = [FMDatabase databaseWithPath:DBRealPath];
    if ([db open]) {
        FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM interface_group ORDER BY sequenceId ASC"];
        while ([resultSet next]) {
            InterfaceGroupModel *dataModel = [InterfaceGroupModel new];
            dataModel.groupId = [resultSet intForColumn:@"groupId"];
            dataModel.groupName = [resultSet stringForColumn:@"groupName"];
            dataModel.sequenceId = [resultSet intForColumn:@"sequenceId"];
            [groupArray addObject:dataModel];
        }
    }
    [db close];
    return groupArray;
}
- (void)initInterfaceArray {
    if (nil == self.interfaceArray) {
        self.interfaceArray = [NSMutableArray array];
    }
    else {
        [self.interfaceArray removeAllObjects];
    }
    FMDatabase *db = [FMDatabase databaseWithPath:DBRealPath];
    if ([db open]) {
        FMResultSet *resultSet = [db executeQueryWithFormat:@"SELECT * FROM interface WHERE groupId = %ld ORDER BY sequenceId ASC", self.groupId];
        while ([resultSet next]) {
            InterfaceModel *dataModel = [InterfaceModel new];
            dataModel.interfaceId = [resultSet intForColumn:@"interfaceId"];
            dataModel.groupId = [resultSet intForColumn:@"groupId"];
            dataModel.interfaceName = [resultSet stringForColumn:@"interfaceName"];
            dataModel.interfacePrefixUrl = [resultSet stringForColumn:@"interfacePrefixUrl"];
            dataModel.interfacePath = [resultSet stringForColumn:@"interfacePath"];
            dataModel.interfaceRemark = [resultSet stringForColumn:@"interfaceRemark"];
            dataModel.interfaceRequestType = [resultSet intForColumn:@"interfaceRequestType"];
            dataModel.interfaceStatus = [resultSet intForColumn:@"interfaceStatus"];
            dataModel.sequenceId = [resultSet intForColumn:@"sequenceId"];
            dataModel.totalCaseNumber = [resultSet intForColumn:@"totalCaseNumber"];
            dataModel.successCaseNumber = [resultSet intForColumn:@"successCaseNumber"];
            dataModel.partialCaseNumber = [resultSet intForColumn:@"partialCaseNumber"];
            dataModel.errorCaseNumber = [resultSet intForColumn:@"errorCaseNumber"];
            [self.interfaceArray addObject:dataModel];
        }
    }
    [db close];
}
- (BOOL)addToDB {
    BOOL isSuccess = NO;
    FMDatabase *db = [FMDatabase databaseWithPath:DBRealPath];
    if ([db open]) {
        isSuccess = [db executeUpdateWithFormat:@"INSERT INTO interface_group (groupName, sequenceId) VALUES('%@',%ld)", self.groupName, self.sequenceId];
    }
    [db close];
    return isSuccess;
}
- (BOOL)saveToDB {
    BOOL isSuccess = NO;
    FMDatabase *db = [FMDatabase databaseWithPath:DBRealPath];
    if ([db open]) {
        isSuccess = [db executeUpdateWithFormat:@"UPDATE interface_group SET groupName = '%@', sequenceId = %ld WHERE groupId = %ld", self.groupName, self.sequenceId, self.groupId];
    }
    [db close];
    return isSuccess;
}
- (BOOL)deleteFromDB {
    BOOL isSuccess = NO;
    FMDatabase *db = [FMDatabase databaseWithPath:DBRealPath];
    if ([db open]) {
        //第一步：删除testcase
        isSuccess = [db executeUpdateWithFormat:@"DELETE FROM test_case WHERE interfaceId IN (SELECT interfaceId FROM interface WHERE groupId = %ld)", self.groupId];
        //第二步：删除interface
        if (isSuccess) {
            isSuccess = [db executeUpdateWithFormat:@"DELETE FROM interface WHERE groupId = %ld", self.groupId];
        }
        //第三步：删除group
        if (isSuccess) {
            isSuccess = [db executeUpdateWithFormat:@"DELETE FROM interface_group WHERE groupId = %ld", self.groupId];
        }
    }
    [db close];
    return isSuccess;
}
@end

@implementation InterfaceModel
- (void)initTestCaseArray {
    if (nil == self.testCaseArray) {
        self.testCaseArray = [NSMutableArray array];
    }
    else {
        [self.testCaseArray removeAllObjects];
    }
    FMDatabase *db = [FMDatabase databaseWithPath:DBRealPath];
    if ([db open]) {
        FMResultSet *resultSet = [db executeQueryWithFormat:@"SELECT * FROM test_case WHERE interfaceId = %ld ORDER BY sequenceId ASC", self.interfaceId];
        while ([resultSet next]) {
            TestCaseModel *dataModel = [TestCaseModel new];
            dataModel.caseId = [resultSet intForColumn:@"caseId"];
            dataModel.interfaceId = [resultSet intForColumn:@"interfaceId"];
            dataModel.caseInput = [resultSet stringForColumn:@"caseInput"];
            dataModel.caseOutput = [resultSet stringForColumn:@"caseOutput"];
            dataModel.caseOutputStd = [resultSet stringForColumn:@"caseOutputStd"];
            dataModel.caseOutputType = [resultSet intForColumn:@"caseOutputType"];
            dataModel.caseOutputModel = [resultSet stringForColumn:@"caseOutputModel"];
            dataModel.sequenceId = [resultSet intForColumn:@"sequenceId"];
            dataModel.caseStatus = [resultSet intForColumn:@"caseStatus"];
            dataModel.spendTime = [resultSet intForColumn:@"spendTime"];
            [self.testCaseArray addObject:dataModel];
        }
    }
    [db close];
}
- (BOOL)addToDB {
    BOOL isSuccess = NO;
    FMDatabase *db = [FMDatabase databaseWithPath:DBRealPath];
    if ([db open]) {
        isSuccess = [db executeUpdateWithFormat:@"INSERT INTO interface (groupId, interfaceName, interfacePrefixUrl, interfacePath, interfaceRemark, interfaceRequestType) VALUES(%ld,'%@','%@','%@','%@',%ld)", self.groupId, self.interfaceName, self.interfacePrefixUrl, self.interfacePath, self.interfaceRemark, self.interfaceRequestType];
    }
    [db close];
    return isSuccess;
}
- (BOOL)saveToDB {
    BOOL isSuccess = NO;
    FMDatabase *db = [FMDatabase databaseWithPath:DBRealPath];
    if ([db open]) {
        NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE interface SET groupId = %ld", self.groupId];
        [sql appendFormat:@",interfaceName = '%@'", self.interfaceName];
        [sql appendFormat:@",interfacePrefixUrl = '%@'", self.interfacePrefixUrl];
        [sql appendFormat:@",interfacePath = '%@'", self.interfacePath];
        [sql appendFormat:@",interfaceRemark = '%@'", self.interfaceRemark];
        [sql appendFormat:@",interfaceRequestType = %ld", self.interfaceRequestType];
        [sql appendFormat:@",interfaceStatus = %ld", self.interfaceStatus];
        [sql appendFormat:@",sequenceId = %ld", self.sequenceId];
        [sql appendFormat:@",totalCaseNumber = %ld", self.totalCaseNumber];
        [sql appendFormat:@",successCaseNumber = %ld", self.successCaseNumber];
        [sql appendFormat:@",partialCaseNumber = %ld", self.partialCaseNumber];
        [sql appendFormat:@",errorCaseNumber = %ld", self.errorCaseNumber];
        
        [sql appendFormat:@" WHERE interfaceId = %ld", self.interfaceId];
        isSuccess = [db executeUpdate:sql];
    }
    [db close];
    return isSuccess;
}
- (BOOL)deleteFromDB {
    BOOL isSuccess = NO;
    FMDatabase *db = [FMDatabase databaseWithPath:DBRealPath];
    if ([db open]) {
        //第一步：删除testcase
        isSuccess = [db executeUpdateWithFormat:@"DELETE FROM test_case WHERE interfaceId = %ld", self.interfaceId];
        //第二步：删除interface
        if (isSuccess) {
            isSuccess = [db executeUpdateWithFormat:@"DELETE FROM interface WHERE interfaceId = %ld", self.interfaceId];
        }
    }
    [db close];
    return isSuccess;
}
@end

@implementation TestCaseModel
- (BOOL)addToDB {
    BOOL isSuccess = NO;
    FMDatabase *db = [FMDatabase databaseWithPath:DBRealPath];
    if ([db open]) {
        isSuccess = [db executeUpdateWithFormat:@"INSERT INTO test_case (interfaceId, caseInput, caseOutput, caseOutputType, caseOutputModel, sequenceId, caseStatus, spendTime) VALUES(%ld, '%@', '%@', %ld, '%@', %ld, %ld, %ld)", self.interfaceId, self.caseInput, self.caseOutput, self.caseOutputType, self.caseOutputModel, self.sequenceId, self.caseStatus, self.spendTime];
    }
    [db close];
    return isSuccess;
}
- (BOOL)saveToDB {
    BOOL isSuccess = NO;
    FMDatabase *db = [FMDatabase databaseWithPath:DBRealPath];
    if ([db open]) {
        isSuccess = [db executeUpdateWithFormat:@"UPDATE test_case SET interfaceId = %ld, caseInput = '%@', caseOutput = '%@', caseOutputType = %ld, caseOutputModel = '%@', sequenceId = %ld, caseStatus = %ld, spendTime = %ld WHERE caseId = %ld",self.interfaceId, self.caseInput, self.caseOutput, self.caseOutputType, self.caseOutputModel, self.sequenceId, self.caseStatus, self.spendTime, self.caseId];
    }
    [db close];
    return isSuccess;
}
- (BOOL)deleteFromDB {
    BOOL isSuccess = NO;
    FMDatabase *db = [FMDatabase databaseWithPath:DBRealPath];
    if ([db open]) {
        isSuccess = [db executeUpdateWithFormat:@"DELETE FROM test_case WHERE caseId = %ld", self.caseId];
    }
    [db close];
    return isSuccess;
}
@end