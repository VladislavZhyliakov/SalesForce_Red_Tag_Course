public with sharing class setCaseStatusController {
    @AuraEnabled
    public static void setStatus(Id caseIdForDetails) {
        Case cs = new Case();
        cs.Id = caseIdForDetails;
        cs.Status = 'In progress';
        update cs;
    }
}
