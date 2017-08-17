module.exports = {
	getBudgetCategories(req, res, next) {
		const db = req.app.get('db')
		db.getBudgetCategories([req.params.b_id]).then(response => {
			res.status(200).send(response)
		}).catch(err => console.log(err))
	},
	createCategoryGroup(req, res, next) {
		const db = req.app.get('db')

		db.createCatGroup([req.body.name, req.params.b_id]).then(response => {
			res.status(200).send(response)
		}).catch(err => console.log(err))
	},
	createSpendingCategory(req, res, next) {
		const db = req.app.get('db')

		db.createSpendCat([req.body.name, req.body.catgroup_id, req.params.b_id])
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
		})
	},
	deleteSpendingCategory(req, res, next) {
		const db = req.app.get('db')

		db.deleteSpendCat([req.params.spend_id]).then(response => {
			res.status(200).send(response)
		}).catch(err => console.log(err))
	}
}