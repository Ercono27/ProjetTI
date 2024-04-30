<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page non trouvée</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f5f5f5;
            padding: 50px;
        }
        h1 {
            font-size: 36px;
            color: #333;
        }
        p {
            font-size: 18px;
            color: #666;
        }
    </style>
</head>
<body>
<h1>404 - Page non trouvée</h1>
<p>Désolé, la page que vous recherchez est introuvable.</p>
<?php
$messages = ["La page que vous recherchez s'est évaporée dans le cyberespace."];
$message = $messages[array_rand($messages)];
echo "<p>$message</p>";
?>
</body>
</html>
