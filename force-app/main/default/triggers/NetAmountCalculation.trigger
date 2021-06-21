/**
 * @author Vanessa DREUX
 * @date 14/06/2021
 * @description This class holds the trigger parameters to update Net_Amount__c field on Orders
 */
trigger NetAmountCalculation on OrderItem(after insert, after update, after delete) {
	if (Trigger.isInsert || Trigger.isUpdate) {
		NetAmountCalculationClass.updateNetAmountOnOrder(Trigger.new);
	}

	if (Trigger.isDelete) {
		NetAmountCalculationClass.updateNetAmountOnOrder(Trigger.old);
	}
}
