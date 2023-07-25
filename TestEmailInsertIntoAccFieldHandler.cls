@isTest
public class TestEmailInsertIntoAccFieldHandler {
    
    @testSetup static void setCommonData(){
        List<Account> acclist = new List<Account>();
        Account ac1 = new Account(Name = 'demo Account', accounting_description__c = '');
        acclist.add(ac1);
        
        List<Contact> conlist = new List<Contact>();
        for(Integer i = 0; i<=5; i++){
            Contact con = new Contact();
            con.LastName = 'Demo'+i;
            con.Email = 'testsalesforce123@gmail.com';
            con.AccountId = ac1.Id;
            conlist.add(con);
        }
        insert acclist;
        insert conlist;
        
    }
    
    @isTest public static void updateEmailTest(){
        
        List<Contact> conlist = [Select Id, LastName, Email, AccountId From Contact where LastName = 'Demo0' limit 1];
        Account acc1 = [Select Id, Name, accounting_description__c From Account where Name = 'demo Account'];
        
        test.startTest();
        if(conlist[0].AccountId != null && conlist[0].Email != null){
            EmailInsertIntoAccFieldHandler.FillEmailintoAccField(conlist);
        }
        test.stopTest();
        Account updatedAcc = [Select Id, Name, accounting_description__c From Account where Name = 'demo Account'];
        //assertion when actual mail and expected mail is same
        //System.assertEquals(acc1.accounting_description__c, 'testsalesforce123@gmail.com');
    }
    
}