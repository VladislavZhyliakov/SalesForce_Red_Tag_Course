trigger Task2_OpportunnityAmountUpdate on Opportunity (after insert, after update,before delete) {
     if(Trigger.isInsert||Trigger.isUpdate){
		MaxOppAmountCalc.findMaxChildOppAmount(Trigger.New);
     }
     else if(Trigger.isDelete)
     {
	    	MaxOppAmountCalc.findMaxChildOppAmountDeletion(Trigger.Old);
     }
}