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
			console.log('get all transactions')
			res.status(200).send(response)
		}).catch(err => console.log(err))
	},
	createAccount: function(req, res, next) {
		const db = req.app.get('db')
		db.createAccount([req.body.name, req.body.type, req.body.amount, req.params.b_id])
			.then(response => {
				res.status(200).send(response)
			}).catch(err => console.log(err));
	},
	createTransaction: function(req, res, next) {
		const db = req.app.get('db')
		db.createTransaction([
			req.body.account,
			req.body.date,
			req.body.payee,
			req.body.category,
			req.body.memo,
			req.body.outflow,
			req.body.inflow,
			req.params.b_id
			]).then(response => {
				res.status(200).send(response)
			}).catch(err => console.log(err))
	},
	updateTransactionCleared(req, res, next) {
		const db = req.app.get('db')

		db.updateTransactionCleared([req.body.cleared, req.params.t_id])
			.then(response => {
				res.status(200).send(response)
			}).catch(err  => console.log(err))
	},
	deleteTransaction: function(req, res, next) {
		const db = req.app.get('db')
		db.deleteTransaction([req.params.t_id])
			.then(response => {
				res.status(200).send(response)
			}).catch(err => console.log(err))
	}
}