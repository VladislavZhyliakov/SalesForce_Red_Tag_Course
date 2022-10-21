public class MaxOppAmountCalc {

public static void findMaxChildOppAmount(List<Opportunity> Opps){
             
    Set<Account> parentAccounts = new Set<Account>() ;
    List<Account> accountsToUpdate = new List<Account>() ;
        
        
        for(Opportunity opp: Opps)
        {
            if(opp.AccountId!=NULL){
            	Account a = new Account();
            	a.Id = opp.AccountId;
            	parentAccounts.add(a);
            }
        }

        boolean isFilled = parentAccounts.size()==0 ? false : true ;

       	
        if(isFilled){
            List<Opportunity> allRelatedOpps = [SELECT AccountId, Amount,Name from Opportunity where AccountID IN: parentAccounts];
                     
            double amount = 0;

            for(Account a: parentAccounts)
            {
                
                for(Opportunity opp: allRelatedOpps)
                {
                    if(opp.AccountId == a.Id)
                    {

                        if(opp.Amount > amount)
                        {
                            amount = opp.Amount;
                            system.debug(amount);        
                            system.debug(opp.Name);        

                        }
                    }
                }
                
            
                if(amount>=500000)
                {
                    a.CustomerPriority__c = 'High';
                    system.debug(a.CustomerPriority__c);
                }
                else if(amount<=5000)
                {
                    a.CustomerPriority__c = 'Low';
                    system.debug(a.CustomerPriority__c);
                }
                amount = 0;
                accountsToUpdate.add(a);
            }
            
            update accountsToUpdate;

        }
  }
    
public static void findMaxChildOppAmountDeletion(List<Opportunity> Opps){
    	     
    Set<Account> parentAccounts = new Set<Account>() ;
    List<Account> accountsToUpdate = new List<Account>() ;
        
        
    for(Opportunity opp: Opps)
        {
            if(opp.AccountId!=NULL){
            Account a = new Account();
            a.Id = opp.AccountId;
            parentAccounts.add(a);
        }
            
        }
       
    boolean isFilled = parentAccounts.size()==0 ? false : true ;
       
    if(isFilled)
        {                
            List<Opportunity> allRelatedOppsWithDeleted = [SELECT AccountId, Amount from Opportunity where AccountID IN: parentAccounts];
            List<Opportunity> allRelatedOpps = new List<Opportunity>();
           
            integer check = 0;
            for(Opportunity opp: allRelatedOppsWithDeleted)
            {
                for(Opportunity opp2: Opps)
                {
                    if(opp.Id == opp2.Id)
                    {
                        check = 1;
                        break;
                    }
                }
                if(check == 1)
                {
                    continue;
                }
                else
                {
                    allRelatedOpps.add(opp);
                }
                check = 0;
            }
                   
            double amount = 0;

            for(Account a: parentAccounts)
            {
                
                for(Opportunity opp: allRelatedOpps)
                {
                    if(opp.AccountId == a.Id)
                    {

                        if(opp.Amount > amount)
                        {
                            amount = opp.Amount;
                            system.debug(amount);        

                        }
                    }
                }
                
            
                if(amount>=500000)
                {
                    a.CustomerPriority__c = 'High';
                }
                else if(amount<=5000)
                {
                    a.CustomerPriority__c = 'Low';
                }
                amount = 0;
                accountsToUpdate.add(a);
            }
            update accountsToUpdate;
        }
    }
}