<?php class_exists('MagmaCore\Ash\AbstractTemplate') or exit; ?>
<!DOCTYPE html>
<html>
	<head>
		<title> 
<?php echo $title ?> 
</title>
        <meta charset="utf-8">
		<meta name="description" content="Default description goes here">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link type='image/x-icon' href="" rel='shortcut icon'>
		<linkrel="apple-touch-icon" href="">
		<link rel="stylesheet" href="/public/assets/css/custom.css">
		 

		<style>body {font-family: 'Nunito', sans-serif;}</style>
		<script>
			$(window).on("load", function () {
			$(".preloader").fadeOut("slow");
			});
		</script>

		
	</head>
	<body>

		<main class="uk-section-small page-body">
			<section class="uk-container uk-container-large">
				 

    This is a form
    <h1>Home</h1>
    <p>Welcome to the home page, list of colors: Age is <?php echo $age ?></p>
    <ul>
        <?php foreach($colors as $color): ?>
        <li><?php echo htmlentities($color, ENT_QUOTES, 'UTF-8') ?></li>
        <?php endforeach; ?>
    </ul>



			</section>
			<!--//.uk-container-large -->
		</main>
    

	<script src="/public/assets/js/sidebar.js"></script>
	<script src="/public/assets/js/status.js"></script>
		<!-- Google Analytics: change UA-XXXXX-Y to be your site's ID. -->
		<script>
			window.ga = function () {
				const googleAnalytics = '';
				ga.q.push(arguments)
			};
			ga.q = [];
			ga.l = + new Date;
			ga('create', `${googleAnalytics}`, 'auto');
			ga('set', 'anonymizeIp', true);
			ga('set', 'transport', 'beacon');
			ga('send', 'pageview')
		</script>
		<script src="https://www.google-analytics.com/analytics.js" async></script>

	
<script src="test.js"></script>

    </body>

</html> 

 

 





