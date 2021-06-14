/**
 * @author Vanessa DREUX
 * @date 14/06/2021
 * @description This class implements the Iterable<AggregateResult> to provide method for the agregation of the queried data
 */

global class AggregateResultIterable implements Iterable<AggregateResult> {
	private String query;

	global AggregateResultIterable(String soql) {
		query = soql;
	}

	global Iterator<AggregateResult> Iterator() {
		return new AggregateResultIterator(query);
	}
}
