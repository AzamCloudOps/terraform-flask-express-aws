const express = require('express');
const axios = require('axios');
const app = express();
const PORT = 3000;


app.use(express.urlencoded({ extended: true }));
app.use(express.json());

app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>Feedback Form</title>
      <style>
        body {
          font-family: Arial, sans-serif;
          background-color: #121212;
          color: #fff;
          display: flex;
          justify-content: center;
          align-items: center;
          height: 100vh;
          margin: 0;
        }
        .form-container {
          background-color: #1e1e1e;
          padding: 40px;
          border-radius: 15px;
          box-shadow: 0 0 20px rgba(0, 255, 200, 0.2);
          width: 350px;
        }
        input, textarea {
          width: 100%;
          padding: 10px;
          border: none;
          border-radius: 8px;
          margin-bottom: 20px;
          font-size: 16px;
        }
        button {
          padding: 10px 20px;
          border: none;
          border-radius: 8px;
          background-color: #00ffc3;
          color: #000;
          font-weight: bold;
          cursor: pointer;
          transition: 0.3s;
          width: 100%;
        }
        button:hover {
          background-color: #00cfa1;
        }
      </style>
    </head>
    <body>
      <div class="form-container">
        <form action="/submit" method="POST">
          <input type="text" name="name" placeholder="Your Name" required />
          <input type="email" name="email" placeholder="Your Email" required />
          <textarea name="message" placeholder="Your Feedback" rows="4" required></textarea>
          <button type="submit">Submit Feedback</button>
        </form>
      </div>
    </body>
    </html>
  `);
});

app.post('/submit', async (req, res) => {
  const { name, email, message } = req.body;

  try {
   await axios.post('http://13.126.193.28:5000/submit', { name, email, message }, {
      headers: { 'Content-Type': 'application/json' }
    });

    res.send(`
      <html>
      <body style="background:#121212; color:#00ffc3; font-family:sans-serif; display:flex; justify-content:center; align-items:center; height:100vh;">
        <div style="text-align:center;">
          <h1>✅ Feedback Submitted!</h1>
          <p>Thanks, ${name}! Your feedback has been received.</p>
          <a href="/" style="color:#00ffc3; text-decoration:underline;">Go Back</a>
        </div>
      </body>
      </html>
    `);
  } catch (error) {
    console.error('❌ Error sending feedback:', error.message);
    res.status(500).send(`
      <html><body style="background:#121212; color:#ff4d4d; font-family:sans-serif; display:flex; justify-content:center; align-items:center; height:100vh;">
        <div style="text-align:center;">
          <h1>❌ Error submitting feedback</h1>
          <p>Please try again later.</p>
          <a href="/" style="color:#00ffc3; text-decoration:underline;">Go Back</a>
        </div>
      </body></html>
    `);
  }
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Frontend running on http://3.109.209.44:${PORT}`);
});

