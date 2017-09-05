const Auth0Strategy = require('passport-auth0'),
	  bodyParser 	= require('body-parser'),
	  passport 		= require('passport'),
	  express 	 	= require('express'),
	  session 		= require('express-session'),
	  massive		= require('massive'),
	  config		= require('../config'),
	  cors		 	= require('cors'),
	  app			= express();

//***************** Controllers **********************//
const userCtrl = require('./controllers/userCtrl')
const accountCtrl = require('./controllers/accountCtrl');
const budgetCtrl = require('./controllers/budgetCategoriesCtrl');
const payeeCtrl = require('./controllers/payeeCtrl');

//***************** Middleware **********************//
const userAuthMiddle = require('./middlewares/checkUserAuth')

app.use(bodyParser.json())
app.use(session({
	secret: 'a3fc94jf9-df9a3jf-ac382-fasdf2o4-fZd3ifjA12fx9$f',
	resave: false,
	saveUninitialized: false
}))
// app.use(cors({
// 	credentials: true,
// 	origin: 'http://localhost:8080'
// }))

app.use(cors());

app.use(passport.initialize());
app.use(passport.session());
app.use(express.static(`${__dirname}/../public/dist`))


massive(config.massiveURL)
	.then (db => {
		app.set('db', db);

		db.init_tables.schema_create_seed().then( res => {
			console.log('schema init');
			db.init_tables.schema_row_seed().then( res => {
				console.log('test rows created');
			}).catch(err => console.log(err));
		}).catch(err => console.log(err))
	}).catch(err => console.log(err))


///////////////////////////
//  Passport            //
/////////////////////////
passport.use(new Auth0Strategy({
	domain: config.domain,
	clientID: config.clientId,
	clientSecret: config.clientSecret,
	callbackURL: config.callbackURL
}, function(accessToken, refreshToken, extraParams, profile, done) {
	let db = app.get('db'),
		authId = profile.id,
		name = profile.displayName,
		email = profile.emails[0].value,
		username = profile.nickname

	db.users.get_user([authId]).then(res => {
		if(!res.length) {
			db.users.create_user([authId, name, email, username])
			.then((userCreated) => {
				return done(null, userCreated[0])
			}).catch(err => co/app/budgetnsole.log(err))
		} else {
			return done(null, res[0])
		}
	}).catch(err => console.log(err))
}))

app.get('/auth/', passport.authenticate('auth0'))
app.get('/auth/callback/', passport.authenticate('auth0', {successRedirect: 'http://localhost:8080/#/app/budget'}))

passport.serializeUser(function(user, done) {
	// let tempUserA = profileToSession
	// console.log('serializeUser//////////////', user)
	return done(null, user);
});

passport.deserializeUser(function(user, done) {
	// let tempUserB = profileFromSession
	// console.log('deSerializeUser///////////', user)
	return done(null, user)
});

app.get('/api/budgets', userCtrl.getUserBudgets);
app.get('/api/:b_id/transactions',  accountCtrl.getAllTransactions);
app.get('/api/:b_id/accounts',  accountCtrl.getAllAccounts);
app.get('/api/budget/:b_id/:month/:year', budgetCtrl.getBudgetCategories);
app.get('/api/:b_id/payees',  payeeCtrl.getPayees);
app.get('/api/:b_id',  budgetCtrl.getToBeBudgeted);

app.post('/api/budgets/new', userCtrl.createNewBudget)
app.post('/api/:b_id/accounts/new', accountCtrl.createAccount)
app.post('/api/:b_id/:mm/:yy/catgroups/new', budgetCtrl.createCategoryGroup)
app.post('/api/:b_id/:mm/:yy/spendcats/new', budgetCtrl.createSpendingCategory)
app.post('/api/:b_id/transactions/new', accountCtrl.createTransaction)
app.post('/api/:b_id/transactions/inflow', accountCtrl.createInflowTransaction)
app.post('/api/:b_id/payees/new', payeeCtrl.createPayee)

app.patch('/api/:b_id/spendcats/:spend_id/:mm/:yy', budgetCtrl.updateBudgetedAmount)
app.patch('/api/transactions/:t_id', accountCtrl.updateTransactionCleared)
app.patch('/api/:b_id/transactions/:t_id', accountCtrl.updateTransaction)
app.patch('/api/:b_id/transactions/:t_id/inflow', accountCtrl.updateInflowTransaction)
app.patch('/api/spendcats/:spend_id/', budgetCtrl.updateSpendCat)
app.patch('/api/catgroups/:catgroup_id', budgetCtrl.updateCatGroup)
app.patch('/api/accounts/:acc_id', accountCtrl.updateAccount)

app.delete('/api/:b_id/transactions/:t_id/:spendcat_id/:month/:year/:catgroup_act_id/:catgroup_id', accountCtrl.deleteTransaction)
app.delete('/api/catgroups/:group_id', budgetCtrl.deleteCategoryGroup)
app.delete('/api/spendcats/:spend_id', budgetCtrl.deleteSpendingCategory)


const PORT = 3000
app.listen(PORT, () => console.log(`Listening on port ${PORT}`))