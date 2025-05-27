<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advanced Calculator</title>
    <style>
        :root {
            --primary-color: #4285f4;
            --secondary-color: #34a853;
            --accent-color: #ea4335;
            --light-color: #f8f9fa;
            --dark-color: #343a40;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        
        .calculator-container {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            width: 100%;
            max-width: 500px;
            transition: transform 0.3s ease;
        }
        
        .calculator-container:hover {
            transform: translateY(-5px);
        }
        
        h1 {
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 1.5rem;
            font-size: 2.2rem;
            position: relative;
        }
        
        h1::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: var(--secondary-color);
            margin: 10px auto;
            border-radius: 2px;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
            font-weight: 500;
        }
        
        input[type="text"] {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 1rem;
            transition: border 0.3s;
        }
        
        input[type="text"]:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(66, 133, 244, 0.2);
        }
        
        .operations-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin: 1.5rem 0;
        }
        
        .operation-option {
            display: flex;
            align-items: center;
            padding: 0.8rem;
            background-color: #f8f9fa;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .operation-option:hover {
            background-color: #e9ecef;
        }
        
        .operation-option input {
            margin-right: 0.8rem;
            accent-color: var(--primary-color);
        }
        
        button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 1rem 2rem;
            font-size: 1rem;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: background-color 0.3s, transform 0.2s;
        }
        
        button:hover {
            background-color: #3367d6;
            transform: translateY(-2px);
        }
        
        button:active {
            transform: translateY(0);
        }
        
        .result-display {
            margin-top: 1.5rem;
            padding: 1rem;
            background-color: #f8f9fa;
            border-radius: 5px;
            text-align: center;
            font-size: 1.2rem;
            display: none;
        }
        
        @media (max-width: 600px) {
            .operations-container {
                grid-template-columns: 1fr;
            }
            
            .calculator-container {
                margin: 1rem;
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="calculator-container">
        <h1>Advanced Calculator</h1>
        <form action="firstHomePage" method="get" id="calculatorForm">
            <div class="form-group">
                <label for="n1">First Number:</label>
                <input type="text" name="n1" id="n1" placeholder="Enter a number" required>
            </div>
            
            <div class="form-group">
                <label for="n2">Second Number:</label>
                <input type="text" name="n2" id="n2" placeholder="Enter a number" required>
            </div>
            
            <div class="operations-container">
                <label class="operation-option">
                    <input type="radio" name="r1" value="add" checked> 
                    Addition
                </label>
                
                <label class="operation-option">
                    <input type="radio" name="r1" value="sub"> 
                    Subtraction
                </label>
                
                <label class="operation-option">
                    <input type="radio" name="r1" value="mul"> 
                    Multiplication
                </label>
                
                <label class="operation-option">
                    <input type="radio" name="r1" value="div"> 
                    Division
                </label>
            </div>
            
            <button type="submit">Calculate</button>
        </form>
        
        <div class="result-display" id="resultDisplay">
            Result: <span id="resultValue"></span>
        </div>
    </div>

    <script>
        // Basic client-side validation and result display
        document.getElementById('calculatorForm').addEventListener('submit', function(e) {
            const n1 = parseFloat(document.getElementById('n1').value);
            const n2 = parseFloat(document.getElementById('n2').value);
            const operation = document.querySelector('input[name="r1"]:checked').value;
            const resultDisplay = document.getElementById('resultDisplay');
            const resultValue = document.getElementById('resultValue');
            
            if (isNaN(n1) || isNaN(n2)) {
                alert("Please enter valid numbers!");
                e.preventDefault();
                return;
            }
            
            // For demonstration, we'll calculate on client side
            // In a real app, this would be done server-side
            let result;
            switch(operation) {
                case 'add':
                    result = n1 + n2;
                    break;
                case 'sub':
                    result = n1 - n2;
                    break;
                case 'mul':
                    result = n1 * n2;
                    break;
                case 'div':
                    if (n2 === 0) {
                        alert("Cannot divide by zero!");
                        e.preventDefault();
                        return;
                    }
                    result = n1 / n2;
                    break;
            }
            
            resultValue.textContent = result;
            resultDisplay.style.display = 'block';
            
            // Prevent form submission for this demo
            // Remove this line in your actual implementation
            e.preventDefault();
        });
    </script>
</body>
</html>