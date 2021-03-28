<?php class_exists('MagmaCore\Ash\AbstractTemplate') or exit; ?>
<!doctype html>
<html class="no-js" lang="">

<head>
    <meta charset="utf-8">
    <title> <?php echo htmlentities($locale['title'], ENT_QUOTES, 'UTF-8') ?> </title>
    <meta name="description" content=" <?php echo htmlentities($locale['description'], ENT_QUOTES, 'UTF-8') ?> ">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title> <?php echo htmlentities($locale['title'], ENT_QUOTES, 'UTF-8') ?> </title>

    <link href="https://fonts.googleapis.com/css?family=Lato|Nunito|Open+Sans+Condensed:300,700|Roboto|Oswald:wght@300&display=swap" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <?php echo $func->addcss(['all.min', 'sb-admin-2.min']) ?>
</head>

<body>


    <!-- Outer Row -->
    
<div class="container">
    <div class="row justify-content-center">
        <div class="col-xl-10 col-lg-12 col-md-9">

            <div class="card o-hidden border-0 shadow-lg my-5">
                <div class="card-body p-0">
                    <div class="row">
                        <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                        <div class="col-lg-6">
                            <div class="p-5">
                                <div class="text-center">
                                    <h1 class="h4 text-gray-900 mb-4"><?php echo htmlentities($locale['form']['page_title'], ENT_QUOTES, 'UTF-8') ?></h1>
                                </div>
                                <?php echo $form ?>
                                <hr>
                                <div class="text-center">
                                    <a class="small" href="/password/forgot"><?php echo htmlentities($locale['form']['forgot_password'], ENT_QUOTES, 'UTF-8') ?></a>
                                </div>
                                <div class="text-center">
                                    <a class="small" href="/register"><?php echo htmlentities($locale['form']['create_account'], ENT_QUOTES, 'UTF-8') ?></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>
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