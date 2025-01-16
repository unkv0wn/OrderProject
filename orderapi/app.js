var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const bodyParser = require("body-parser");
require('dotenv').config()
const cors = require('cors')

//cors


//Router Index
var indexRouter = require('./routes/index');
var PaymentRouter = require('./routes/paymentform');
var UnitMeasurementRouter = require('./routes/unitmeasurement');
var CliforRouter = require('./routes/clifor');
var PublicPlaceRouter = require('./routes/publicplace');
var MarkRouter = require('./routes/Mark');
var ProductRouter = require('./routes/product');
var OrderRouter = require('./routes/order');
var OrderItemRouter = require('./routes/orderitem');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

// Remova essa linha
app.use(cors())


// Rotas da Api
app.use('/', indexRouter);
app.use('/paymentform', PaymentRouter);
app.use('/unitmeasurement', UnitMeasurementRouter);
app.use('/clifor', CliforRouter);
app.use('/publicplace', PublicPlaceRouter);
app.use('/mark', MarkRouter);
app.use('/product', ProductRouter);
app.use('/order', OrderRouter);
app.use('/orderitem', OrderItemRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
