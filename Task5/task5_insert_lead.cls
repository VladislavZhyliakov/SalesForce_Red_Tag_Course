public without sharing class task5_insert_lead {
    @AuraEnabled
    public static void insertLead(String fname, String lname, String email, String phone, String question, String product){
      
            Group tempQueue = [SELECT Id, Name from Group where Type = 'Queue' AND DeveloperName = 'Red_Tag_Website_Lead_s'];
            Lead a = new Lead();
            a.LastName = lname;
            a.FirstName = fname;
            a.Email = email;
            a.Phone = phone;
            a.Company = 'None';
            a.Status = 'Open - Not Contacted';
            a.Product__c =  product;
            a.Contact_us_question_field__c = question;
            a.OwnerId=tempQueue.Id;
            insert a;
        
            
        
    }
}
