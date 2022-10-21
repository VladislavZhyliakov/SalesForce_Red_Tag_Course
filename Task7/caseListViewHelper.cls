public with sharing class caseListViewHelper {
    @AuraEnabled
    public static List<Case> getCasesBranch() {
        Id usersId = UserInfo.getUserId();

        User currentUser = [select Branch_Number__c from User where id =: usersId LIMIT 1];
       
        return [select CaseNumber, Status, CreatedDate, Branch_Number__c from Case where Branch_Number__c =: currentUser.Branch_Number__c ORDER BY CreatedDate DESC] ;
    }
}
