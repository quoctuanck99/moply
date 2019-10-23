<%-- 
    Document   : register
    Created on : Jul 7, 2019, 12:31:23 AM
    Author     : quoct
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../../template/nagivator/nagivatorBar.jsp"></jsp:include>
        <head>
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Register | Moply</title>
            <style>
                .loginForm{
                    padding-top: 10%;
                    padding-bottom: 15%;
                    font-family: "Oxygen", HelveticaNeue, "Helvetica Neue", Helvetica, Arial, sans-serif;       
                    padding-left: 25%;
                    padding-right: 20%;
                    background-image: url('img/formbackground/register.jpg');
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
                    text-align: left;
                    font-size: 20px;
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
                #regButton{
                    width: 50%;
                    background-color: rgb(64, 151, 119);
                    border: none;
                    color: white;
                    border-radius: 5px;
                }
                #regButton:hover{
                    background-color: #1f7f5c;
                }
                #regButton:active{
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
                            <form  name="regForm" action="register" method="post" onsubmit="return validateForm();">
                                <table align="center">
                                    <tr class="uAndp">
                                        <td id="title">Username:</td>
                                        <td><input name="username" type="text"></td>
                                    </tr>
                                    <tr class="uAndp">
                                        <td id="title">Password:</td>
                                        <td><input name="password"  type="password" ></td>
                                    </tr>
                                    <tr class="uAndp">
                                        <td id="title">Re-enter password:</td>
                                        <td><input  name="re_password" type="password" ></td>
                                    </tr>
                                    <tr class="uAndp">
                                        <td id="title">Email:</td>
                                        <td><input name="email" type="email" ></td>
                                    </tr>
                                    <tr class="uAndp">
                                        <td id="title">Full name:</td>
                                        <td><input  name="fullname" type="text" ></td>
                                    </tr>
                                    <tr class="uAndp">
                                        <td id="title">Date of birth:</td>
                                        <td><input type="date" ></td>
                                    </tr>

                                    <tr class="uAndp">
                                        <td id="title">Gender:</td>
                                        <td> <input type="radio" checked="checked" name="gender" value="1">Male
                                            <input type="radio" name="gender" value="0">Female
                                        </td>
                                    </tr>
                                    <tr class="uAndp">
                                        <td colspan="2" id="title">Term of User:</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <textarea rows="10" cols="70">
Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type 
and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, 
remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, 
and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                                            </textarea>
                                        </td> 
                                    </tr>
                                    <tr class="uAndp">
                                        <td colspan="2"><input type="checkbox" name="termOfUser"> I agree to the Term of User</td>
                                    </tr>
                                    <tr class="uAndp">
                                        <td colspan="2">
                                            <input id="regButton" type="submit" value="Register">
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        <jsp:include page="../../template/footer/footer.jsp"></jsp:include>
    </body>
    <script>
        function validateForm() {
            var myForm = document.forms["regForm"];
            var u = myForm["username"].value;
            var p = myForm["password"].value;
            var rp = myForm["re_password"].value;
            var email = myForm["email"].value;
            var fullname=myForm["fullname"].value;
            var checkTerm=myForm["termOfUser"].value;
            var uReg=/^[a-zA-Z0-9]+$/;
            var pReg=/^[a-zA-Z0-9]([._](?![._])|[a-zA-Z0-9]){6,18}[a-zA-Z0-9]$/;
            var eReg=/^[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$/;
            var fullNameReg=/^[A-Za-z ]+$/;
            var result="";
            if(!uReg.test(u)){
                result+="- Username cannot be blank or contain special characters!\n";
            }
            if(!pReg.test(p)){
                result+="- Password must be at least 8 character, include number and letter and not contain special characters!\n";
            }
            if(pReg.test(p)&&p!==rp){
                result+="- Re-enter password is not match!\n";
            }
            if(!eReg.test(email)){
                result+="- Email is invalid!\n";
            }
            if(!fullNameReg.test(fullname)){
                result+="- Full name cannot be blank and only contain letter!\n";
            }
            if(result===""){
                if(checkTerm.checked===false){
                    result+="You haven't agreed to Term Of User!";
                    alert(result);
                    return false;
                }else{
                    return true;
                }
            }else{
                alert(result);
                return false;
            }
        }

    </script>
</html>
