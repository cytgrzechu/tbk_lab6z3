const express = require('express');
const bodyParser = require('body-parser')
const app = express();
var express_port = 3000

const {Pool} = require('pg');
const pool = new Pool({
    user: 'postgres',
    host: '172.17.0.2',
    database: 'db',
    password: 'mysecretpassword',
    port: 5432,
});

app.use(bodyParser.urlencoded({
    extended: true
}));

app.use(bodyParser.json());

app.listen(express_port, '0.0.0.0', ()=>{
    console.log('Application listening at 0.0.0.0:'+express_port);
})

app.get('/cars', async (req, res) => {
    const result = await pool.query('SELECT * FROM cars');
    res.send(result.rows);
});

app.post('/addCar', (req, res) => {
    const {model, year, details} = req.body;
    pool.query("INSERT INTO cars (model, year, details) VALUES ($1, $2, $3) RETURNING *", [model, year, details], (err, results) => {
        if (err) {
            throw err;
        }
        res.send(results.rows[0].model + ' added.' );
    });
});