trigger EmailInsertIntoAccField on Contact (after insert, after update) {
    if(Trigger.isAfter && Trigger.isInsert){
        EmailInsertIntoAccFieldHandler.FillEmailintoAccField(trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        EmailInsertIntoAccFieldHandler.FillEmailintoAccField(trigger.new);
    }
}