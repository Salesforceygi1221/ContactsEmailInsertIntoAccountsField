trigger ContactsMailDomainIntoAccountField on Contact (after update, after insert) {
    if(trigger.isAfter){
        if(trigger.isAfter || trigger.isUpdate){
            ContactsMailDomainIntoAccountFieldHand.insertIntoDescription(Trigger.new);
        }
    }
}
