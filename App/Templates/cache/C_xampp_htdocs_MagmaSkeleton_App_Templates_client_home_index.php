<?php class_exists('MagmaCore\Ash\AbstractTemplate') or exit; ?>
<!doctype html>
<html class="no-js" lang="">

<head>
    <meta charset="utf-8">
    <title> <?php echo $locale['title'] ?> </title>
    <meta name="description" content=" <?php echo $locale['description'] ?> ">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> <?php echo $locale['title'] ?> </title>

    <link href="https://fonts.googleapis.com/css?family=Lato|Nunito|Open+Sans+Condensed:300,700|Roboto|Oswald:wght@300&display=swap" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <?php echo $func->addcss(['all.min', 'sb-admin-2.min']) ?>
</head>

<body>


    <!-- Outer Row -->
    

<div class="col-lg-8 mx-auto p-3 py-md-5">
    <header class="d-flex align-items-center pb-3 mb-5 border-bottom">
        <a href="/" class="d-flex align-items-center text-dark text-decoration-none">
            <span class="fs-4"><?php echo htmlentities($app['app']['app_name'], ENT_QUOTES, 'UTF-8') ?></span>
        </a>
    </header>

    <h1><?php echo htmlentities($locale['header_main']['page_title'], ENT_QUOTES, 'UTF-8') ?></h1>
    <p class="fs-5 col-md-8"><?php echo htmlentities($locale['header_main']['page_content'], ENT_QUOTES, 'UTF-8') ?></p>

    <div class="mb-5">
        <a href="https://github.com/TheCodingWorkshop/_MagmaCore" class="btn btn-primary btn-lg px-4"><?php echo htmlentities($locale['header_main']['page_button'], ENT_QUOTES, 'UTF-8') ?></a>
    </div>

    <hr class="col-3 col-md-2 mb-5">

    <div class="row g-5">
        <?php foreach($locale['columns'] as $column): ?>
        <div class="col-md-6">
            <h2><?php echo htmlentities($column['page_title'], ENT_QUOTES, 'UTF-8') ?></h2>
            <p><?php echo htmlentities($column['page_content'], ENT_QUOTES, 'UTF-8') ?></p>
            <ul class="icon-list">
                <?php foreach ($column['lists'] as $key => $text) : ?>
                <li><a href="<?php echo htmlentities($key, ENT_QUOTES, 'UTF-8') ?>" rel="noopener" target="_blank"><?php echo htmlentities($text, ENT_QUOTES, 'UTF-8') ?></a></li>
                <?php endforeach; ?>
            </ul>
        </div>
        <?php endforeach; ?>

    </div>

    <footer class="pt-5 my-5 text-muted border-top">
        <?php echo htmlentities($base['copyright'], ENT_QUOTES, 'UTF-8') ?> &middot; &copy; 2021
    </footer>
</div>

    <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>
     <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
    </div>


    <!-- Custom scripts for all pages-->
    <?php echo $func->addjs(['jquery.min', 'jquery.easing.min', 'bootstrap.bundle.min', 'sb-admin-2.min']) ?>

</body>

</html>     