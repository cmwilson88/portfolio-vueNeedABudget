module.exports = {
	getAllAccounts: function(req, res, next) {
		const db = req.app.get('db');

		db.getAllAccounts([req.params.b_id]).then(response => {
			res.status(200).send(response)
		}).catch(err => console.log(err))
	},
	getAllTransactions: function(req, res, next) {
		const db = req.app.get('db');

		db.getAllTransactions([req.params.b_id]).then(response => {
			res.status(200).send(response)
		}).catch(err => console.log(err))
	},
	getTransactionsByAccount: function(req, res, next) {
		const db = req.app.get('db');
		db.getTransactionsByAccount([req.params.b_id, req.params.accountId])
			.then(response => {
				res.status(200).send(response)
			}).catch(err => console.log(err))
	}
}