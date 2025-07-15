
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>NauticalNerves - English Grammar Quiz</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f0f8ff;
      margin: 0;
      padding: 0;
    }
    header {
      background-color: #003366;
      color: white;
      padding: 15px;
      text-align: center;
    }
    nav {
      background: #005599;
      padding: 10px;
      text-align: center;
    }
    nav a {
      color: white;
      margin: 0 15px;
      text-decoration: none;
      font-weight: bold;
    }
    main {
      max-width: 800px;
      margin: 20px auto;
      padding: 20px;
      background: white;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .question {
      margin: 20px 0;
    }
    .option {
      display: block;
      margin: 5px 0;
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 5px;
      cursor: pointer;
    }
    .correct {
      background-color: #c8f7c5;
      border-color: #27ae60;
    }
    .wrong {
      background-color: #f9c0c0;
      border-color: #e74c3c;
    }
    #score-container {
      text-align: center;
      font-size: 1.2em;
      margin-top: 30px;
      display: none;
    }
    .hidden {
      display: none;
    }
  </style>
</head>
<body>
  <header>
    <h1>Welcome to NauticalNerves</h1>
  </header>

  <nav>
    <a href="#home">Home</a>
    <a href="#quiz">Quiz</a>
    <a href="#about">About</a>
  </nav>

  <main id="home">
    <h2>🧠 English Grammar Quiz (Condensed)</h2>
    <p><strong>Instructions:</strong> Click the correct answer. Green = correct, Red = incorrect. Your score will be displayed at the end.</p>
    <div id="quiz"></div>
    <div id="score-container"></div>
  </main>

  <main id="about" class="hidden">
    <h2>About NauticalNerves</h2>
    <p>NauticalNerves is dedicated to providing simple, effective, and engaging grammar practice tools to learners of all ages. Our goal is to make English grammar easy and fun!</p>
  </main>

  <script>
    const quizData = [
      {
        question: "Which is an interrogative sentence?",
        options: ["I love ice cream.", "Are you coming to the party?", "She ran away.", "Close the door."],
        correct: 1
      },
      {
        question: "Identify the imperative sentence:",
        options: ["What a view!", "Please pass the salt.", "Are you tired?", "He is home."],
        correct: 1
      },
      {
        question: "Everyone ____ welcome.",
        options: ["are", "is", "be", "were"],
        correct: 1
      },
      {
        question: "Neither the boys nor the girl ____ late.",
        options: ["are", "is", "were", "be"],
        correct: 1
      },
      {
        question: "Which is punctuated correctly?",
        options: ["Lets eat Grandma!", "Let's eat, Grandma!", "Lets, eat Grandma!", "Let's, eat Grandma!"],
        correct: 1
      },
      {
        question: "Choose the correct apostrophe use:",
        options: ["Its raining", "It's raining", "Its' raining", "It rains'"],
        correct: 1
      },
      {
        question: "She said, 'I am tired.' → She said she ____ tired.",
        options: ["was", "is", "were", "had been"],
        correct: 0
      },
      {
        question: "He said, 'I will call you.' → He said he ____ call me.",
        options: ["would", "will", "shall", "can"],
        correct: 0
      },
      {
        question: "He has lived here ____ 2010.",
        options: ["since", "for", "in", "from"],
        correct: 0
      },
      {
        question: "She sings ____ than her sister.",
        options: ["better", "good", "more good", "best"],
        correct: 0
      }
    ];

    const quizContainer = document.getElementById('quiz');
    const scoreContainer = document.getElementById('score-container');
    let score = 0;

    quizData.forEach((q, index) => {
      const div = document.createElement('div');
      div.classList.add('question');

      const qText = document.createElement('h3');
      qText.textContent = `${index + 1}. ${q.question}`;
      div.appendChild(qText);

      q.options.forEach((opt, i) => {
        const btn = document.createElement('button');
        btn.textContent = opt;
        btn.classList.add('option');
        btn.onclick = function () {
          const siblings = this.parentNode.querySelectorAll('.option');
          siblings.forEach(s => s.disabled = true);
          this.classList.add(i === q.correct ? 'correct' : 'wrong');
          if (i === q.correct) score++;
          else siblings[q.correct].classList.add('correct');

          if (index === quizData.length - 1) {
            setTimeout(() => {
              scoreContainer.innerHTML = `<p>Your total score is <strong>${score} / ${quizData.length}</strong></p>`;
              scoreContainer.style.display = 'block';
            }, 500);
          }
        };
        div.appendChild(btn);
      });

      quizContainer.appendChild(div);
    });

    // Navigation
    document.querySelectorAll('nav a').forEach(link => {
      link.addEventListener('click', e => {
        e.preventDefault();
        document.querySelectorAll('main').forEach(section => section.classList.add('hidden'));
        const id = link.getAttribute('href');
        document.querySelector(id).classList.remove('hidden');
      });
    });
  </script>
</body>
</html>
