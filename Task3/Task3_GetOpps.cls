public class Task3_GetOpps {
    @AuraEnabled
    public static List<Opportunity> GetTop5OppsByAmount() {
            List<Opportunity> Opps = [Select Name, Amount, closeDate, StageName from Opportunity where Amount>0 AND isClosed = false];
            List<Opportunity> top5Opps = new List<Opportunity>();

            double max = Opps[0].Amount;
            integer counter = 0;
            integer index = 0;

            for(integer j = 0 ; j<5 ; j++){
                for(Opportunity opp: Opps)
                {
                    if(opp.Amount>max)
                    {
                        max = opp.Amount;
                        index = counter;
                    }
                    
                    counter++;
                }
                top5Opps.add(Opps[index]);
                Opps.remove(index);
            }

            return top5Opps;
    }
}
