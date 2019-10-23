<%-- 
    Document   : createartist
    Created on : Jul 13, 2019, 12:43:18 AM
    Author     : quoct
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../../template/nagivator/nagivatorBar.jsp"></jsp:include>
        <head>
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <meta charset="UTF-8">
            <title>Create Artist | Moply</title>
            <style>
                .loginForm{
                    padding-top: 10%;
                    padding-bottom: 15%;
                    font-family: "Oxygen", HelveticaNeue, "Helvetica Neue", Helvetica, Arial, sans-serif;       
                    padding-left: 20%;
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
                    text-align: left;
                }
                table select{
                    padding-top: 10px;
                    padding-bottom: 10px;
                    font-size:20px;
                }
                #title{
                    padding: 5% 10% 5% 10%;
                    font-size: 20px;
                    color: #232323;
                }
                .formComponent input{
                    padding-top: 10px;
                    padding-bottom: 10px;
                    font-size: 20px;
                }
                .formComponent #buttonCon{
                    text-align: center;
                }
                .formComponent td{
                    font-size: 20px;
                    padding-top: 5px; 
                }
                .formComponent select{
                    width: 45%;
                    height: 100%;
                }
                #uploadButton{
                    width: 30%;
                    background-color: rgb(64, 151, 119);
                    border: none;
                    color: white;
                    border-radius: 5px;
                }
                #uploadButton:hover{
                    background-color: #1f7f5c;
                }
                #uploadButton:active{
                    background-color: #232323;
                }
                h1{
                    font-size: 50px;
                    text-align: center;
                    margin-bottom: 80px;
                    color: rgb(64, 151, 119);
                }
                #file_choose input{
                    border: none;
                }
            </style>
            <link rel="stylesheet" href="template/nagivator/style.css" type="text/css" />
            <link rel="stylesheet" href="view/css/contentStyle.css" type="text/css" />  
        </head>           
        <body>
            <div class="main_container">
                <div class="content">
                    <div class="wrap">
                        <div class="loginForm">
                            <form method="post" action="createartist" enctype="multipart/form-data">
                                <h1>CREATE ARTIST</h1>
                                <table align="center">
                                    <tr class="formComponent">
                                        <td>Artist name:</td>
                                        <td><input type="text" name="artistname"></td>
                                    </tr>
                                    <tr class="formComponent">
                                        <td>Gender:</td>
                                        <td>
                                            <input type="radio" checked name="gender" value="1"> Male 
                                            <input type="radio" name="gender" value="0"> Female
                                        </td>
                                    </tr>
                                    <tr class="formComponent">
                                        <td>Avatar:</td>
                                        <td id='file_choose'><input type="file" name="file" size="60" accept="image/*"/></td>
                                    </tr>
                                    <tr class="formComponent">
                                        <td>Date of birth:</td>
                                        <td>
                                            <input type="date" name="dob"/>
                                        </td>
                                    </tr>
                                    <tr class="formComponent">
                                        <td>Nationality:</td>
                                        <td>
                                            <select name="nationality">
                                            <c:forEach items="${countries}" var="l">
                                                <option value="${l.getId()}">${l.getName()}</option> 
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr class="formComponent">
                                    <td>Biography:</td>
                                    <td><textarea rows="10" cols="70" name="bio"></textarea> </td>
                                </tr>
                                <tr class="formComponent">
                                    <td colspan="2" id="buttonCon">
                                        <input id="uploadButton" type="submit" value="Create">
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
</html>

