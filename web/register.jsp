<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    </head>
    <body class="bg-dark">
        <%@include file="navbar.jsp" %>

        <main>
            <div class="container mt-5">
                <div class="col-md-4 offset-md-4">
                    <div class="card">
                        <div class="card-header bg-dark text-white text-center">
                            <h5 class="card-title"><span class="fa fa-user-plus"></span> Register</h5>
                        </div>
                        <div class="card-body">
                            <form id="reg-form">
                                <div class="mb-2">
                                    <label for="name" class="form-label">Name</label>
                                    <input type="text" class="form-control" id="name" name="user_name" required>
                                </div>
                                <div class="mb-2">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="user_email" required>
                                </div>
                                <div class="mb-2">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="password" name="user_password" required>
                                </div>
                                <div class="mb-2">
                                    <label for="gender" class="form-label">Gender</label>
                                    <select class="form-select" id="gender" name="gender" required>
                                        <option value="male">Male</option>
                                        <option value="female">Female</option>
                                        <option value="other">Other</option>
                                    </select>
                                </div>
                                <div class="mb-2">
                                    <label for="about" class="form-label">About</label>
                                    <textarea class="form-control" id="about" name="about" rows="2" placeholder="Please tell something about yourself"></textarea>
                                </div>
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="termsCheck" name="check" required>
                                    <label class="form-check-label" for="termsCheck">Agree terms and conditions</label>
                                </div>
                                <div class="text-center mt-3">
                                    <div class="container p-1" id="loader" style="display:none">
                                        <span class="fa fa-refresh fa-spin fa-1x"></span>
                                        <h6>Please Wait...</h6>
                                    </div>
                                    <button type="submit" class="btn btn-outline-dark" id="submit-btn">Register</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <script>
            $(document).ready(function () {
                $('#reg-form').on('submit', function (event) {
                    event.preventDefault();
                    let form = $(this);
                    let formData = form.serialize();

                    $("#submit-btn").hide();
                    $("#loader").show();

                    $.ajax({
                        url: "RegisterServlet",
                        type: "POST",
                        data: formData,
                        success: function (data) {
                            $("#submit-btn").show();
                            $("#loader").hide();

                            if (data.trim() === 'Data Inserted') {
                                swal({
                                    title: "Good job!",
                                    text: "Registration successful!",
                                    icon: "success",
                                    button: "Login Page"
                                }).then((value) => {
                                    if (value) {
                                        window.location.href = "login.jsp";
                                    }
                                });
                            } else {
                                swal(data);
                            }
                        },
                        error: function () {
                            $("#submit-btn").show();
                            $("#loader").hide();
                            swal("Something went wrong, please try again.");
                        }
                    });
                });
            });
        </script>

    </body>
</html>
