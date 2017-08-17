const bodyParser = require('body-parser'),
	  express 	 = require('express'),
	  massive	 = require('massive'),
	  cors		 = require('cors'),
	  app		 = express();

const connectionString = require('../config')

const accountCtrl = require('./controllers/accountCtrl');
const budgetCtrl = require('./controllers/budgetCategoriesCtrl');

app.use(bodyParser.json())
app.use(cors())
app.use(express.static(`${__dirname}/../public/build`))


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
app.get('/api/budget/:b_id', budgetCtrl.getBudgetCategories)

app.post('/api/:b_id/accounts/new', accountCtrl.createAccount)
app.post('/api/:b_id/transactions/new', accountCtrl.createTransaction)
app.post('/api/:b_id/catgroups/new', budgetCtrl.createCategoryGroup)
app.post('/api/:b_id/spendcats/new', budgetCtrl.createSpendingCategory)

app.delete('/api/transactions/:t_id', accountCtrl.deleteTransaction)
app.delete('/api/catgroups/:group_id', budgetCtrl.deleteCategoryGroup)
app.delete('/api/spendcats/:spend_id', budgetCtrl.deleteSpendingCategory)
const PORT = 3000
app.listen(PORT, () => console.log(`Listening on port ${PORT}`))