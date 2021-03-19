<?php class_exists('MagmaCore\Ash\AbstractTemplate') or exit; ?>
<!DOCTYPE html>
<html>
	<head>
		<title> <?php echo $title ?> </title>
        <meta charset="utf-8">
	</head>
	<body>
     This is a form
<h1>Home</h1>
<p>Welcome to the home page, list of colors: Age is <?php echo $age ?></p>
<ul>
    <?php foreach($colors as $color): ?>
    <li><?php echo htmlentities($color, ENT_QUOTES, 'UTF-8') ?></li>
    <?php endforeach; ?>
</ul>


    </body>
</html>  