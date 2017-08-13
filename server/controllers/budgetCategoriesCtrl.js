module.exports = {
	getBudgetCategories(req, res, next) {
		const db = req.app.get('db')

		db.getBudgetCategories().then(response => {
			res.status(200).send(response)
		}).catch(err => console.log(err))
	}
}