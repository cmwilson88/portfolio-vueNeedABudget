const bodyParser = require('body-parser'),
	  express 	 = require('express'),
	  massive	 = require('massive'),
	  cors		 = require('cors'),
	  app		 = express();

const connectionString = require('../config')

const accountCtrl = require('./controllers/accountCtrl');
const budgetCtrl = require('./controllers/budgetCategoriesCtrl');
const payeeCtrl = require('./controllers/payeeCtrl');

app.use(bodyParser.json())
app.use(cors())
app.use(express.static(`${__dirname}/../public/dist`))


massive(connectionString)
	.then (db => {
		app.set('db', db);

		db.init_tables.schema_create_seed().then( res => {
			console.log('schema init');
			db.init_tables.schema_row_seed().then( res => {
				console.log('test rows created');
			}).catch(err => console.log(err));
		}).catch(err => console.log(err))
	}).catch(err => console.log(err))


app.get('/api/:b_id/transactions', accountCtrl.getAllTransactions);
app.get('/api/:b_id/accounts', accountCtrl.getAllAccounts);
app.get('/api/budget/:b_id/:month/:year', budgetCtrl.getBudgetCategories);
app.get('/api/:b_id/payees', payeeCtrl.getPayees);
app.get('/api/:b_id', budgetCtrl.getToBeBudgeted);

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