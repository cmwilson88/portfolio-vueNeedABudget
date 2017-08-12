const bodyParser = require('body-parser'),
	  express 	 = require('express'),
	  massive	 = require('massive'),
	  cors		 = require('cors'),
	  app		 = express();

const connectionString = require('../config')

const transactionCtrl = require('./controllers/transactionCtrl');
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


app.get('/api/transactions', transactionCtrl.getAllTransactions);
app.get('/api/accounts/:accountId', transactionCtrl.getTransactionsByAccount)

const PORT = 3000
app.listen(PORT, () => console.log(`Listening on port ${PORT}`))