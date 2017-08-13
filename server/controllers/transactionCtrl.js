module.exports = {
	getAllTransactions: function(req, res, next) {
		const db = req.app.get('db');

		db.getAllTransactions().then(response => {
			res.status(200).send(response)
		}).catch(err => console.log(err))
	},
	getTransactionsByAccount: function(req, res, next) {
		const db = req.app.get('db');
		db.getTransactionsByAccount([req.params.accountId])
			.then(response => {
				res.status(200).send(response)
			}).catch(err => console.log(err))
	}
}