module.exports = {
	getAllAccounts: function(req, res, next) {
		const db = req.app.get('db');

		db.getAllAccounts([req.params.b_id]).then(response => {
			return res.status(200).send(response)
		}).catch(err => console.log(err))
	},
	getAllTransactions: function(req, res, next) {
		const db = req.app.get('db');

		db.getAllTransactions([req.params.b_id]).then(response => {
			return res.status(200).send(response)
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
			req.params.b_id, 
			req.body.type,
			req.body.month,
			req.body.year,
			req.body.catgroup_act_id,
			req.body.catgroup_id
			]).then(response => {
				res.status(200).send(response)
			}).catch(err => console.log(err))
	},
	createInflowTransaction: function(req, res, next) {
		const db = req.app.get('db')
		db.createInflowTransaction([
			req.body.account,
			req.body.date,
			req.body.payee,
			req.body.category,
			req.body.memo,
			req.body.outflow,
			req.body.inflow,
			req.params.b_id,
			req.body.type,
			req.body.month,
			req.body.year,
			req.body.catgroup_act_id,
			req.body.catgroup_id
			]).then(response => {
				res.status(200).send(response)
			}).catch(err => console.log(err))
	},
	updateInflowTransaction(req, res, next) {
		const db = req.app.get('db')

		db.updateInflowTransaction([
			req.body.account,
			req.body.date,
			req.body.payee,
			req.body.category,
			req.body.memo,
			req.body.outflow,
			req.body.inflow,
			req.params.b_id,
			req.body.type,
			req.params.t_id,
			req.body.month,
			req.body.year,
			req.body.catgroup_act_id,
			req.body.catgroup_id
		]).then(response => {
			res.status(200).send(response)
		}).catch(err => console.log(err))
	},
	updateTransaction(req, res, next) {
		const db = req.app.get('db')

		db.updateTransaction([
			req.body.account,
			req.body.date,
			req.body.payee,
			req.body.category,
			req.body.memo,
			req.body.outflow,
			req.body.inflow,
			req.params.b_id,
			req.body.type,
			req.params.t_id,
			req.body.month,
			req.body.year,
			req.body.catgroup_act_id,
			req.body.catgroup_id
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
	updateAccount(req, res, next) {
		const db = req.app.get('db')

		db.updateAccount([req.body.name, req.params.acc_id])
			.then(response => {
				res.status(200).send(response)
			}).catch(err => console.log(err))
	},
	deleteTransaction: function(req, res, next) {
		const db = req.app.get('db')

		console.log('budget_id: ' + req.params.b_id);
		console.log('transaction id: ' + req.params.t_id)
		console.log('spendcat_id: ' + req.params.spendcat_id);
		console.log('month: ' + req.params.month);
		console.log('year: ' + req.params.year);
		console.log('catgroup_act_id: ' + req.params.catgroup_act_id);
		console.log('catgroup_id: ' + req.params.catgroup_id);
		db.deleteTransaction([
			req.params.b_id, 
			req.params.t_id, 
			req.params.spendcat_id, 
			req.params.month,
			req.params.year,
			req.params.catgroup_act_id,
			req.params.catgroup_id
			]).then(response => {
				res.status(200).send(response)
			}).catch(err => console.log(err))
	}
}