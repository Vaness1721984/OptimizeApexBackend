trigger CalculMontant on OrderItem(after insert, after update, after delete) {
	if (Trigger.isInsert || Trigger.isUpdate) {
		CalculMontantClass.updateNetAmountOnOrder(Trigger.new);
	}

	if (Trigger.isDelete) {
		CalculMontantClass.updateNetAmountOnOrder(Trigger.old);
	}
}
