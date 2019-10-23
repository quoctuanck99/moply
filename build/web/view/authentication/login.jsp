<%-- 
    Document   : login
    Created on : Jul 7, 2019, 12:31:17 AM
    Author     : quoct
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../../template/nagivator/nagivatorBar.jsp"></jsp:include>
        <head>
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Login | Moply</title>
            <style>
                .loginForm{
                    padding-top: 10%;
                    padding-bottom: 15%;
                    font-family: "Oxygen", HelveticaNeue, "Helvetica Neue", Helvetica, Arial, sans-serif;       
                    padding-left: 30%;
                    padding-right: 20%;
                    background-image: url('img/formbackground/login.jpg');
                }
                .loginForm input{
                    border-radius: 10px;
                    border: 1px solid #999;
                }
                .loginForm input:focus{
                    outline: none;
                    box-shadow: 0px 0px 5px #61C5FA;
                    border-color: #5AB0DB;
                }
                table{
                    background-color: #ebebeb;
                    border-spacing: 30px;
                    border-radius: 20px;
                    text-align: center;
                }
                #title{
                    padding: 5% 10% 5% 10%;
                    font-size: 20px;
                    color: #232323;
                }
                .uAndp input{
                    padding-top: 10px;
                    padding-bottom: 10px;
                    font-size: 20px;
                }
                .uAndp td{
                    font-size: 20px;
                    padding-top: 5px; 
                }
                #loginButton{
                    width: 50%;
                    background-color: rgb(64, 151, 119);
                    border: none;
                    color: white;
                    border-radius: 5px;
                }
                #loginButton:hover{
                    background-color: #1f7f5c;
                }
                #loginButton:active{
                    background-color: #232323;
                }
                #forgot{
                    font-size: 15px !important;
                }
            </style>
        </head>           
        <link rel="stylesheet" href="template/nagivator/style.css" type="text/css" />
        <link rel="stylesheet" href="view/css/contentStyle.css" type="text/css" />  
        <body>
            <div class="main_container">
                <div class="content">
                    <div class="wrap">
                        <div class="loginForm">
                            <form method="post" action="login">
                                <table align="center">
                                    <tr class="uAndp">
                                        <td>Username:</td>
                                        <td><input type="text" placeholder="username" name="username"></td>
                                    </tr>
                                    <tr class="uAndp">
                                        <td>Password:</td>
                                        <td><input type="password" name="password"/> </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><input type="checkbox" name="remember" /> Remember me</td>
                                    </tr>
                                    <tr class="uAndp">
                                        <td colspan="2">
                                            <input id="loginButton" type="submit" value="Login">
                                        </td>
                                    </tr>
                                    <tr id="forgot" class="uAndp">
                                        <td colspan="2"><a href="forgot" >Forgot password?</a></td>
                                    </tr>
                                    <tr id="forgot" class="uAndp">
                                        <td colspan="2"><a href="register" >Create an account</a></td>
                                    </tr>
                                </table>
                                <input type="text" name="requestPath" hidden value="${param.url}">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        <jsp:include page="../../template/footer/footer.jsp"></jsp:include>
    </body>
</html>
