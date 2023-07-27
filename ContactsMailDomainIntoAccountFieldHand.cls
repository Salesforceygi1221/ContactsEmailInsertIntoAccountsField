public class ContactsMailDomainIntoAccountFieldHand {
    public static void insertIntoDescription(List<Contact> conlist){
        Set<String> emailDomains = new Set<String>();

        // Collect unique email domains from updated contacts
        for (Contact contact : conlist) {
            String email = contact.Email;
            if (email != null) {
                String[] emailParts = email.split('@');
                if (emailParts.size() > 1) {
                    emailDomains.add(emailParts[1]);
                }
            }
        }

        // Update related accounts with unique email domains
        List<Account> accountsToUpdate = new List<Account>();
        for (Account account : [SELECT Id, Description FROM Account WHERE Id IN (SELECT AccountId FROM Contact WHERE Id IN :conlist)]) {
            Set<String> existingDomains = new Set<String>();

            // Parse existing unique domains from the account's description
            if (account.Description != null) {
                existingDomains.addAll(account.Description.split(','));
            }

            // Add new unique domains to the existing domains
            existingDomains.addAll(emailDomains);

            // Create a new description string with unique domains
            account.Description = String.join(new List<String>(existingDomains), ',');

            accountsToUpdate.add(account);
        }

        // Perform the updates
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
