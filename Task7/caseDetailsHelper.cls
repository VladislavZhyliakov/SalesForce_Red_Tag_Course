public with sharing class  caseDetailsHelper {
    @AuraEnabled (cacheable = True)
    public static List<Case> caseDetails(Id caseIdForDetails) {
       List<Case> a = [select Owner.Name, Status, CaseNumber,  Contact.Name, ContactPhone, AccountId,  ContactEmail, Type, Origin, Reason from Case where id =:caseIdForDetails LIMIT 1];
       return a;
    }
}
