public with sharing class deleteAllLeadsController {
    @AuraEnabled
    public static void deleteAllLeads(Integer i) {
        if(i == 1)
        {
           LeadsAllDeleteBatchController leadsTD = new LeadsAllDeleteBatchController();
           Database.executeBatch(leadsTD);
        }

    }
}


