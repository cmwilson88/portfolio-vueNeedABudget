const bodyParser = require('body-parser'),
	  express 	 = require('express'),
	  cors		 = require('cors'),
	  app		 = express();


app.use(bodyParser.json())
app.use(cors())
app.use(express.static(`${__dirname}/../public/build`))





const PORT = 3000
app.listen(PORT, () => console.log(`Listening on port ${PORT}`))