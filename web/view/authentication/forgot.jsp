<%-- 
    Document   : forgot
    Created on : Jul 8, 2019, 11:45:59 AM
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
                    padding-top: 15%;
                    padding-bottom: 15%;
                    font-family: "Oxygen", HelveticaNeue, "Helvetica Neue", Helvetica, Arial, sans-serif;       
                    padding-left: 25%;
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
                table #loginButton{
                    height: 50px;
                    font-size: 20px;
                }
                table .button{
                     text-align: center; 
                     height: 50px;  
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
                    width: 30%;
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
                            <table align="center">
                                <tr class="uAndp">
                                    <td>Enter your username:</td>
                                    <td><input type="text" placeholder="username"></td>
                                </tr>
                                <tr class="uAndp">
                                    <td>Enter the registered email:</td>
                                    <td><input type="email" </td>
                                </tr>
                                <tr class="button">
                                    <td colspan="2">
                                        <input id="loginButton" type="submit" value="Next">
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        <jsp:include page="../../template/footer/footer.jsp"></jsp:include>
    </body>
</html>