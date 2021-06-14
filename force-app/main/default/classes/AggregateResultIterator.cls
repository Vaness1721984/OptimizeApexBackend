/**
 * @author Vanessa DREUX
 * @date 14/06/2021
 * @description This class implements the Iterator<AggregateResult> to provide method to define the conditions for exiting the loop
 */

global class AggregateResultIterator implements Iterator<AggregateResult> {
	AggregateResult[] results { get; set; }

	Integer index { get; set; }

	global AggregateResultIterator(String query) {
		index = 0;
		results = Database.query(query);
	}

	global boolean hasNext() {
		return results != null && !results.isEmpty() && index < results.size();
	}

	global AggregateResult next() {
		return results[index++];
	}
}
