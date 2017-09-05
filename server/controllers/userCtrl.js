module.exports = {
	getUserBudgets: function(req, res, next) {
		if(req.user) {
			const db = req.app.get('db');

			db.users.getUserBudgets([req.user.id])
				.then(response => {
					return res.status(200).send(response)
				}).catch(err => console.log(err))
		}
	},
	createNewBudget: function(req, res, next) {
		if(req.user) {
			const db = req.app.get('db');

			db.createNewBudget([req.user.id, req.body.name, req.body.month, req.body.year])
				.then(response => {
					return res.status(200).send(response)
				}).catch(err => console.log(err));
		}
	}
}