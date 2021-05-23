trigger UpdateAccountCA on Order(after insert, after update, after delete) {
	if (Trigger.isInsert || Trigger.isUpdate) {
		UpdateAccountCA.UpdateAccountCA(Trigger.new);
	}

	if (Trigger.isDelete) {
		UpdateAccountCA.UpdateAccountCA(Trigger.old);
	}
}
