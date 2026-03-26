const express = require('express');
const app = express();

const PORT = 3000;

app.get('/', (req, res) => {
    res.send('DevOps Node App Running 🚀');
});

app.get('/health', (req, res) => {
    res.status(200).send('OK');
});

if (require.main === module) {
    app.listen(PORT, () => {
        console.log(`Server running on port ${PORT}`);
    });
}

module.exports = app;