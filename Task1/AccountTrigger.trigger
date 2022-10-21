trigger AccountTrigger on Account (after insert, after update, before delete) {
    if(Trigger.isAfter && Trigger.isInsert)
    {
        AccountTriggerHandler.createRelatedOpportunity(Trigger.new);
    }
    else if(Trigger.isAfter && Trigger.isUpdate)
    {
        AccountTriggerHandler.updateRelatedOpportunities(Trigger.old, Trigger.new);
    }
    else if(Trigger.isBefore && Trigger.isDelete){
        AccountTriggerHandler.sendConfirmationEmailOnAccountDeletion(Trigger.old);
        AccountTriggerHandler.deleteRelatedOpportunities(Trigger.old);
    }
}