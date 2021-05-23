trigger CalculMontant on OrderItem(after insert, after update, after delete) {
	if (Trigger.isInsert || Trigger.isUpdate) {
		MontantNetOnOrderClass.updateNetAmountOnOrder(Trigger.new);
	}

	if (Trigger.isDelete) {
		MontantNetOnOrderClass.updateNetAmountOnOrder(Trigger.old);
	}
}
