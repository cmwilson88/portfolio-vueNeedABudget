module.exports = {
	getBudgetCategories(req, res, next) {
		const db = req.app.get('db')
		db.getBudgetCategories([req.params.b_id, req.params.month, req.params.year]).then(response => {
			res.status(200).send(response)
		}).catch(err => console.log(err))
	},
	getToBeBudgeted(req, res, next) {
		const db = req.app.get('db')
		db.getToBeBudgeted([req.params.b_id]).then(response => {
			res.status(200).send(response[0].to_be_budgeted)
		}).catch(err => console.log(err))
	},
	createCategoryGroup(req, res, next) {
		const db = req.app.get('db')

		db.createCatGroup([req.body.name, req.params.b_id, req.params.mm, req.params.yy]).then(response => {
			res.status(200).send(response)
		}).catch(err => console.log(err))
	},
	createSpendingCategory(req, res, next) {
		const db = req.app.get('db')

		db.createSpendCat([req.body.name, req.body.catgroup_id, req.params.b_id, req.params.mm, req.params.yy, req.body.catgroup_act_id])
			.then(response => {
				res.status(200).send(response)
			}).catch(err => console.log(err))
	},
	updateBudgetedAmount(req, res, next) {
		const db = req.app.get('db')

		db.updateBudgetedAmount([req.body.amount, req.params.spend_id, req.params.b_id])
			.then(response => {
				res.status(200).send(response)
			}).catch(err => console.log(err))
	},
	updateSpendCat(req, res, next) {
		const db = req.app.get('db')

		db.updateSpendCat([req.body.name, req.params.spend_id])
			.then(response => {
				res.status(200).send(response)
			}).catch(err => console.log(err))
	},
	updateCatGroup(req, res, next) {
		const db = req.app.get('db')

		db.updateCatGroup([req.body.name, req.params.catgroup_id])
			.then(response => {
				res.status(200).send(response)
			}).catch(err => console.log(err))
	},
	deleteCategoryGroup(req, res, next) {
		const db = req.app.get('db')

		db.deleteCatGroup([req.params.group_id]).then(response => {
			res.status(200).send(response)
		}).catch(err => {
			res.status(500).send()
			console.log(err)
		})
	},
	deleteSpendingCategory(req, res, next) {
		const db = req.app.get('db')

		db.deleteSpendCat([req.params.spend_id]).then(response => {
			res.status(200).send(response)
		}).catch(err => console.log(err))
	}
}