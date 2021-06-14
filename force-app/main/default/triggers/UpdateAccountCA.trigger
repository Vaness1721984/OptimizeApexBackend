/**
 * @author Vanessa DREUX
 * @date 14/06/2021
 * @description This class holds the trigger parameters to update Chiffre_d_affaire__c field on Accounts
 */
trigger UpdateAccountCA on Order(after insert, after update, after delete) {
	if (Trigger.isInsert || Trigger.isUpdate) {
		UpdateAccountCA.UpdateAccountCA(Trigger.new);
	}

	if (Trigger.isDelete) {
		UpdateAccountCA.UpdateAccountCA(Trigger.old);
	}
}
