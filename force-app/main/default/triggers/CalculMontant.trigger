/**
 * @author Vanessa DREUX
 * @date 14/06/2021
 * @description This class holds the trigger parameters to update Net_Amount__c field on Orders
 */
trigger CalculMontant on OrderItem(after insert, after update, after delete) {
	if (Trigger.isInsert || Trigger.isUpdate) {
		CalculMontantClass.updateNetAmountOnOrder(Trigger.new);
	}

	if (Trigger.isDelete) {
		CalculMontantClass.updateNetAmountOnOrder(Trigger.old);
	}
}
