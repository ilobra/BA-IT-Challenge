const express = require('express');
const app = express();
const fs = require('fs');
const path=require('path');

const PORT = 3212;
const FILE = './feedback.json';
const FILETXT = './feedback.txt';

async function writeToFile(body) {
	const comments = await readFromFile();
	comments.push(body);
	const error = fs.writeFileSync(FILE, JSON.stringify(comments));
	return error;
}
/*
*Duomenų įrašymas į tekstinį failą
*/
async function writeToTextFile(body){
	//konstruojamas duomenų formatas ne JSON pavidalu
	var construct=body.vardas+ "\n" + body.elpastas+"\n"+body.data+" "+body.laikas+"\n"+body.komentaras+"\n --------------------------------- \n";
	const error = fs.appendFileSync(FILETXT, construct);
	return error;
}
async function readFromFile() {
	const rawdata = await fs.readFileSync(FILE);
	const comments = JSON.parse(rawdata);

	return comments;
}

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
//.html ir .css naudojimui nustatomas kelias į tuos failus
app.use(express.static(path.join(__dirname, 'views')));
app.engine('html', require('ejs').renderFile);

app.post('/feedbacks', async function(req, res) {
	await writeToFile(req.body);
	await writeToTextFile(req.body);
	//įvesti duomenys per index.html formą POST metodu
	var json=req.body; 
	//rezultatai atvaizduojami feedbacks.html faile 
	res.render('feedbacks.html', {json: json}, function (err, html) {
	if(err){
      console.log(err)
    }
    res.end(html)
	})
	//JSON puslapis
	/*res.json({
		success: true,
		body: req.body
	});*/	
});
app.get('/feedbacks', async function(req, res) {
  //iš failo paimti duomenys	
  var json= await readFromFile();
  //atvaizduojami visi atsiliepimai feedbacks.html faile
  res.render('feedbacks.html', {json: json}, function (err, html) {
  if(err){
      console.log(err)
    }
    res.end(html)
  })
    //JSON puslapis
	/*res.json({
               success: true,
               body: await readFromFile()
           });*/
});

app.listen(PORT, () => console.log(`Server app listening on port ${PORT}!`));
