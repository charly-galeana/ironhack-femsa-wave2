const express = require('express');
const app = express();
const router = express.Router();

app.get('/', (req, res) => {
    res.json({message:'respuesta de ejemplo'});
})

const PORT = 8899;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));