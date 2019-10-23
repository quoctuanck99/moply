<%-- 
    Document   : singers
    Created on : Jul 7, 2019, 12:14:13 AM
    Author     : quoct
--%>
<%@page import="model.Artist"%>
<%@page import="java.util.ArrayList"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="p" uri="../../WEB-INF/tlds/pagingTag.tld"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../../template/nagivator/nagivatorBar.jsp"></jsp:include>
        <head>
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <link rel="stylesheet" href="view/css/style/bootstrap.css">
            <title>Singers | Moply | Music for you</title>
            <style>>-->

                .container-fluid .card{
                    z-index: -10000;
                    font-family:Arial, Helvetica, sans-serif;
                }
                .fb-profile img.fb-image-lg{
                    z-index: 0;
                    width: 100%;  
                    margin-bottom: 10px;

                }

                .fb-image-profile
                {
                    margin: -90px 10px 0px 50px;
                    z-index: 9;
                    width: 20%; 
                    border-radius: 200px;
                }

                @media (max-width:768px)
                {

                    .fb-profile-text>h1{
                        font-weight: 700;
                        font-size:16px;
                    }

                    .fb-image-profile
                    {
                        margin: -45px 10px 0px 25px;
                        z-index: 9;
                        width: 20%; 
                    }
                }
                .text {
                    text-align: justify;
                    text-justify: inter-word;
                    padding-left: 30px;
                    padding-right: 30px;
                    margin-top: 50px;
                }
                .fb-profile-text p{
                    color:#8c8c8c;
                }
                .text p{
                    color:#404040;
                    font-size: 20px;
                }
                .text h4{
                    color:#8c8c8c;
                }
                .search_container input{
                    border-style: groove;
                    border-radius: 5px;
                    padding: 5px 5px 5px 5px;
                    width: 30%;
                }
                .search_container button{
                    background-color: #4CAF50; /* Green */
                    border: none;
                    color: white;
                    padding: 6px 32px;
                    text-align: center;
                    text-decoration: none;
                    display: inline-block;
                    font-size: 16px;
                    border-radius: 5px;
                }
                .search_container button:hover{
                    background-color: #34ce57; /* Green */
                }
                .search_container button:active{
                    background-color: #404040; /* Green */
                }
                .card-title{
                    color: #404040; 
                    font-size: 20px; 
                    padding-top: 10px;
                }
                .card-text{
                    color: #8c8c8c; 
                    font-size: 15px;
                }
                .allSongsOfThisArtist{
                    padding-left: 30px;
                    padding-right: 30px;
                    padding-bottom: 30px;
                }
                #gender_Display font{
                    font-weight:900;
                    font-size: 25px;
                }
                .pagination {
                    display: inline-block;
                    margin: 0px 500px 20px 550px;
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
            </head>           
            <link rel="stylesheet" href="template/nagivator/style.css" type="text/css" />
            <link rel="stylesheet" href="view/css/contentStyle.css" type="text/css" />  
        <body>
            <div class="main_container">
                <div class="content">
                    <div class="wrap">
                        <c:if test="${empty param.artistid}"> 
                            <div class= "container-fluid">
                                <img align="left" src="img/artist/allArtistCover.jpg" alt="Profile image example" width="1170px" height="394.75px" style="padding-bottom: 20px;border-radius: 10px;"/>
                                <!--                            <form action="" method="get">
                                                                <div class="search_container">
                                                                    <input  type="text" name="singerName" placeholder="Search singer by name...">
                                                                    <button class="" onclick="(window.location = '?singerName=' + document.getElementsByName('singerName')[0].value);" type="button">Search</button>
                                                                </div>
                                                            </form>-->
                                <div class= "row d-inline-flex">
                                    <!-- Gallery Item 1 -->
                                    <c:forEach items="${artists}" var="a">
                                        <div onclick="location.href = '?artistid=${a.getId()}';" style="cursor: pointer;" class ="col-6 col-sm-4 col-md-3 p-2">
                                            <div class="card h-100">
                                                <img class="card-img" src="${a.getImgPath()}"/>
                                                <h4 class="card-title text-center">${a.getName()}</h4>
                                                <p class="card-text text-center">${a.getCountry().getName()}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <p:PagingTag gap="1" pageindex="${pageindex}" totalpage="${totalpage}"/>
                        </c:if>
                        <c:if test="${!(empty param.artistid)}">
                            <div class="fb-profile">
                                <img align="left" class="fb-image-lg" src="img/artist/coverProfile.jpg" alt="Profile image example" style="border-radius: 10px;"/>
                                <img align="left" class="fb-image-profile thumbnail" src="${artist.getImgPath()}" alt="Profile image example"/>
                                <div class="fb-profile-text">
                                    <h1>${artist.getName()}</h1>
                                    <p id="gender_Display"><font ${artist.isGender()?"style='color: blue;'":"style='color: pink;'"}>
                                        ${artist.isGender()?"♂":"♀"}
                                        </font> | ${artist.getDob()} | ${artist.getCountry().getName()}</p>
                                </div>
                            </div>
                            <br>
                            <div class="text">
                                <h4>Biography:</h4>
                                <p>${bio}</p>  
                            </div>
                            <div class="allSongsOfThisArtist">
                                <div class="list-group">
                                    <a href="/" onclick="return false;" class="list-group-item list-group-item-action">Songs of ${artist.getName()}</a>
                                    <c:forEach items="${allSongOfThisArtist}" var="s">
                                        <a href="play?songid=${s.getSongid()}" class="list-group-item list-group-item-action list-group-item-success">♫ ${s.getName()}</a>
                                    </c:forEach>
                                </div>

                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            <jsp:include page="../../template/footer/footer.jsp"></jsp:include>
        </body>
    </html>
