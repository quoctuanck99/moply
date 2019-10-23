<%-- 
    Document   : resultUpload
    Created on : Jul 12, 2019, 3:51:11 PM
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
            <title>Upload | Moply</title>
            <style>
                .wrap{
                    background-image: url('img/formbackground/adminbg.jpg');
                }
                h1{
                    font-size: 50px;
                    text-align: center;
                    margin-bottom: 80px;
                    color: rgb(64, 151, 119);
                }
                #message{
                    text-align: center;
                    margin-left: 30%;
                    margin-right: 30%;
                    margin-top: 20%;
                    margin-bottom: 20%;
                    padding: 10% 0 10% 0;
                    border: 3px solid #1f7f5c; 
                    border-radius: 20px;

                }
                #message p{
                    font-size: 20px;
                }
            </style>
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
            <link rel="stylesheet" href="template/nagivator/style.css" type="text/css" />
            <link rel="stylesheet" href="view/css/contentStyle.css" type="text/css" />  
        </head>           
        <body>
            <div class="main_container">
                <div class="content">
                    <div class="wrap">
                        <div class="container">                           
                            <div id="message">
                                <p>Upload successfull!</p>
                                <a href="${path}">Continue</a><br>
                            <c:if test="${path eq 'song'}">
                                <a href="play?songid=${songid}">Go to your song!</a>
                            </c:if>
                            <c:if test="${path eq 'singers'}">
                                <a href="singers?artistid=${artistid}">Go to the artist profile!</a>
                            </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <jsp:include page="../../template/footer/footer.jsp"></jsp:include>
    </body>
</html>
