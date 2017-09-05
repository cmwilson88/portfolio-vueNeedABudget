module.exports = {
	checkUserAuth(req, res, next) {
		if(req.user) {
			console.log('check session: ', req.session)
			console.log('check user auth: ',req.user)
			next();
		}

		res.redirect('http://localhost:8080/')
	}
}