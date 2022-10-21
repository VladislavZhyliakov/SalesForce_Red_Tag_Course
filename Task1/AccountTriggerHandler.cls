public with sharing class AccountTriggerHandler {
    public static void createRelatedOpportunity(List<Account> accounts)
    {
        List<Opportunity> relatedOpportunities = new List<Opportunity>();
        for(Account a: accounts/*[SELECT Id, Name FROM Account WHERE Id IN : accounts]*/)
        {
            Opportunity opp = new Opportunity();
            opp.AccountId = a.Id;
            opp.Name = a.Name + ' ' + String.valueOf(system.today().month()) + '-' + String.valueOf(system.today().year());
            opp.StageName = 'Prospecting';
            opp.CloseDate = system.today() + 90;

            relatedOpportunities.add(opp);
        }
        insert relatedOpportunities;
    }

    public static void updateRelatedOpportunities(List<Account> oldAccounts, List<Account> newAccounts)
    {
        List<Account> accountsNameChanged = new List<Account>();

        for(Account oldAcc: oldAccounts)
        {
            for(Account newAcc: newAccounts)
            {
                if(oldAcc.Id == newAcc.Id && oldAcc.Name != newAcc.Name)
                {
                    accountsNameChanged.add(newAcc);
                }
            }
        }

        List<Account> accountsWithOpportunities = new List<Account>([SELECT Name, Id, (SELECT Name, CreatedDate FROM Opportunities) FROM Account WHERE Id IN: accountsNameChanged]);

        System.debug(accountsWithOpportunities);

        List<Opportunity> oppsToChangeName = new List<Opportunity>();

        for(Account a: accountsWithOpportunities)
        {
            for(Opportunity opp: a.Opportunities)
            {
                String NameDatePart = String.valueOf(opp.CreatedDate.month())+'-'+String.valueOf(opp.CreatedDate.year());
                opp.Name = a.Name + ' ' + NameDatePart;
                oppsToChangeName.add(opp);
            }
        }

        update oppsToChangeName;
    }

    public static void sendConfirmationEmailOnAccountDeletion(List<Account> accounts)
    {
        String email, subject, body;
        Integer oppCounter = 1;
        email = UserInfo.getUserEmail();
        subject = 'Deletion of Account and Related Opportunity/Opportunities';

        body = 'Hi ' + UserInfo.getFirstName()+' '+UserInfo.getLastName()+'!'+'\nDue to deletion of Account:\n';

       // List<Account> accountsWithOpportunities = [SELECT Id, Name, (SELECT Name, Id, Amount FROM Opportunities) FROM Account WHERE Id IN : accounts];


       List<Opportunity>relatedOpportunities = [SELECT Name, Id, Amount, AccountId FROM Opportunity WHERE AccountID IN:accounts];

        for(Account a: accounts)
        {
            body += a.Name+' all next related Opportunities were deleted as well:\n';
            for(Opportunity opp: relatedOpportunities)
            {
                if(opp.AccountId == a.Id){
                    body += String.valueOf(oppCounter) + ') Opportunity Id: '+opp.Id + ', Opportunity Name: '+opp.Name+', Amount: '+opp.Amount+'\n';
                    oppCounter++;
                }
            }
            oppCounter=1;
        }

        EmailManager.sendMail(email, subject, body);

    }

    public static void deleteRelatedOpportunities(List<Account> accounts)
    {
        List<Opportunity>relatedOpportunities = [SELECT Name, Id, Amount, AccountId FROM Opportunity WHERE AccountID IN:accounts];
        delete relatedOpportunities;
    }
}
