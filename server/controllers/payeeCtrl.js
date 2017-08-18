module.exports = {
	getPayees(req, res, next) {
		const db = req.app.get('db')

		db.getPayees([req.params.b_id]).then(response => {
			res.status(200).send(response)
		}).catch(err => console.log(err))
	},
	createPayee(req, res, next) {
		const db = req.app.get('db')
		db.createPayee([req.body.name, req.params.b_id]).then(response => {
			res.status(200).send(response)
		}).catch(err => console.log(err))
	}
}