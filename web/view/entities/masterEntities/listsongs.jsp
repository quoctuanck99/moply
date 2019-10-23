<%-- 
    Document   : listsongs
    Created on : Jul 23, 2019, 11:37:25 AM
    Author     : quoct
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="p" uri="../../../WEB-INF/tlds/pagingTag.tld"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../../../template/nagivator/nagivatorBar.jsp"></jsp:include>
        <head>
            <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Jura" />
            <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Varela+Round" /><link rel='stylesheet' href='//fonts.googleapis.com/css?family=Jura' type='text/css' /> 
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Aministrator Panel | Moply</title>
        </head>           
        <link rel="stylesheet" href="template/nagivator/style.css" type="text/css" />
        <link rel="stylesheet" href="view/css/contentStyle.css" type="text/css" />  
        <style>
            .wrap{
                min-height: 800px;
                padding-left: 20px;
                padding-right: 20px;
                padding-top: 20px;
                font-family: "Oxygen", HelveticaNeue, "Helvetica Neue", Helvetica, Arial, sans-serif;  
                background-image: url('img/formbackground/adminbg.jpg');
            }
            .wrap img{
                width: 30px;
                height: 30px;
                vertical-align: middle;
            }
            .wrap hr{
                border-top: 0.2px solid lavender;
                margin: 1% 1% 1% 1%;
            }

            a {
                color: #0c5460;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                font-size: 20px;
            }

            th, td {
                text-align: left;
                padding: 20px;
            }

            tr:nth-child(even){background-color: #f2f2f2}

            th {
                background-color: #4CAF50;
                color: white;
            }
            .pagination {
                display: inline-block;
                margin: 0px 500px 20px 480px;
            }

            .pagination a {
                color: black;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
            }

            .pagination a.active {
                background-color: #4CAF50;
                color: white;
            }
            .pagination a:hover:not(.active) {background-color: #ddd;
            
            </style>
            <body>
                <div class="main_container">
                    <div class="content">
                        <div class="wrap">
                            <div class="page_title"><h2>Songs List </h2></div>
                            <hr>
                            <br>
                            <table>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Artist</th>
                                    <th>Category</th>
                                    <th>Uploader</th>
                                    <th>Function</th>
                                </tr>
                            <c:forEach items="${songs}" var="s">
                                <tr>
                                    <td>${s.getSongid()}</td>
                                    <td><a href="play?songid=${s.getSongid()}">${s.getName()}</a></td>
                                    <td>${s.getArtistname()}</td>
                                    <td>${s.getKindid()}</td>
                                    <td>${s.getUploader()}</td>
                                    <td>
                                        <a href="#"><img src="img/icon/setting_icon.png"/></a>
                                        <a href="#"><img src="img/icon/delete_icon.png"/></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                        <p:PagingTag gap="1" pageindex="${pageindex}" totalpage="${totalpage}"/>
                    </div>
                </div>
            </div>
            <jsp:include page="../../../template/footer/footer.jsp"></jsp:include>
        </body>
    </html>
