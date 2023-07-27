@isTest
public class TestContactsMailDomainIntoAccountField {
    @testSetup static void setCommonData(){
        List<Account> acclist = new List<Account>();
        acclist.add(new Account(Name = 'test1', Description = ''));
        insert acclist;
        
        List<Contact> conlist = new List<Contact>();
        for(Integer i = 0; i<5; i++){
            Contact con = new Contact();
            con.LastName = 'testContact';
            con.AccountId = acclist[0].Id;
            con.Email = 'test123@gmail.com';
            conlist.add(con);
        }
        insert conlist;
    }
    @isTest static void testInsertIntoDescription(){
        Account acc = [Select Id, Description From Account where Name = 'test1' limit 1];
        List<Contact> conlist = [Select Id, LastName, Email, AccountId from Contact where AccountId=:acc.Id]; 
        //test method
        Test.startTest();
        ContactsMailDomainIntoAccountFieldHand.insertIntoDescription(conlist);
        Test.stopTest();
    }
}