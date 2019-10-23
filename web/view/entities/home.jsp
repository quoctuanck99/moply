<%-- 
    Document   : home
    Created on : Jul 2, 2019, 10:26:16 PM
    Author     : quoct
--%>

<%@page import="java.util.Random"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Song"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html>
    <jsp:include page="../../template/nagivator/nagivatorBar.jsp"></jsp:include>
        <head>
            <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Jura" />
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Moply | Music for you</title>
            <style>
                .wrap hr{
                    border-top: 0.2px solid lavender;
                    margin: 1% 1% 1% 1%;
                }
                .a_song_container {
                    border-radius: 10px;
                    width: 380px;
                    height: 100px;
                    background-color: rgb(235, 235, 235);
                    font-family: Arial, Helvetica, sans-serif;
                    color: rgb(93, 93, 93);
                    transition: transform 0.5s;

                }

                .item_left {
                    float: left;
                    width: 100px;
                    height: 100px;
                }

                .song_thumbail {
                    border-radius: 10px;
                    width: 100px;
                    height: 100px;
                }

                .item_right {

                    float: right;
                    width: 260px;
                    height: 95px;
                    padding-top: 5px;
                    padding-left: 5px;
                    line-height: 25px;
                    size:20px;
                    color: #669282;
                    overflow: hidden;
                    text-overflow: ellipsis
                }

                .songname {
                    font-size: 15px;
                    color:#444;
                }

                a {
                    color: rgb(93, 93, 93);
                }
                table{
                    border-spacing: 15px;
                    margin-bottom: 35px;
                }
                .part_list_title{
                    margin-left: 20px;
                    font-size: 20px;
                    font-weight: bold;
                    color:#8d8f8e;
                    font-family: Jura; font-size: 24px; font-style: normal; font-variant: normal; font-weight: 700; line-height: 26.4px; } h3 { font-family: Jura; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 700; line-height: 15.4px; } p { font-family: Jura; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 19.99px; } blockquote { font-family: Jura; font-size: 21px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 29.99px; } pre { font-family: Jura; font-size: 13px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 18.57px;
                }
                .part_list_title a{
                    font-size:15px;
                    margin-right: 15px;

                }
                .random_artists_container .a_artist_item{
                    display: inline-block;
                    margin-bottom: 35px;
                    float: left;
                    transition: transform 0.5s;
                }
                .random_artists_container .artist_thumbail{
                    display: inline-block;
                    margin: 0px 24px 0px 24px; 
                }
                .random_artists_container .artist_name{
                    text-align: center;
                }
                .random_artists_container .artist_thumbail img{
                    width:100px;
                    height: 100px;
                    border-radius: 20px;
                }
                body a{
                    text-decoration: none;
                }

                .a_artist_item:hover {
                    -ms-transform: scale(1.1); /* IE 9 */
                    -webkit-transform: scale(1.1); /* Safari 3-8 */
                    transform: scale(1.1); 
                }
                .a_song_container:hover {
                    -ms-transform: scale(0.9); /* IE 9 */
                    -webkit-transform: scale(0.9); /* Safari 3-8 */
                    transform: scale(0.9); 
                }
                .an_category_container {
                    display: inline-block;
                    margin-left: 13px;
                    margin-bottom: 13px;
                }
                .category_thumbail{
                    text-align: center;
                    vertical-align: middle;
                    
                    color: white;
                    border-radius: 10px;
                    width: 270px;
                    height: 100px;
                    margin-left: 5px;
                    margin-right: 5px;
                    transition: transform 0.5s;
                }
                .category_thumbail p{
                    padding-top: 35px;
                    font-size: 20px;
                }
                .category_thumbail:hover {
                    -ms-transform: scale(0.9); /* IE 9 */
                    -webkit-transform: scale(0.98); /* Safari 3-8 */
                    transform: scale(0.9); 
                    filter: alpha(opacity=100);
                }
            </style>
        </head>           
        <link rel="stylesheet" href="template/nagivator/style.css" type="text/css" />
        <link rel="stylesheet" href="view/css/contentStyle.css" type="text/css" />  
        <body>
            <div class="main_container">
                <div class="content">
                    <div class="wrap">
                        <h1><jsp:include page="../../template/slider/slider.jsp"></jsp:include></h1>
                        <div class='part_list_title'>RECOMMENDED SONGS</div>
                        <hr>
                        <div class="song_items_container">
                            <table>
                            <c:set var="count" value="0"/>
                            <c:forEach items="${songs}" var="s">
                                <c:if test="${(count=count+1)%3!=0}">
                                    <c:if test="${count==1}">
                                        <tr> 
                                        </c:if>
                                        <td>
                                            <div class="a_song_container">
                                                <a href="play?songid=${s.getSongid()}">
                                                    <div class="item_left">
                                                        <img class="song_thumbail" src="${s.getImgPath()}">
                                                    </div>
                                                    <div class="item_right">
                                                        <b class="songname">${s.getName()}</b><br>
                                                        <b>Artist: </b>
                                                        <font>${s.getArtistname()}</font>
                                                        <br>
                                                        <b>Composer: </b>
                                                        <font>${s.getComposer()}</font>
                                                        <br>
                                                    </div>
                                                </a>
                                            </div>
                                        </td>
                                    </c:if>
                                    <c:if test="${count%3==0}">
                                        <td>
                                            <div class="a_song_container">
                                                <a href="play?songid=${s.getSongid()}">
                                                    <div class="item_left">
                                                        <img class="song_thumbail" src="${s.getImgPath()}">
                                                    </div>
                                                    <div class="item_right">
                                                        <b class="songname">${s.getName()}</b><br>
                                                        <b>Artist: </b>
                                                        <font >${s.getArtistname()}</font>
                                                        <br>
                                                        <b>Composer: </b>
                                                        <font>${s.getComposer()}</font>
                                                        <br>
                                                    </div>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </table>
                    </div>
                    <div class='part_list_title'>
                        <b>RECOMMENDED ARTIST</b>
                    </div>
                    <hr>
                    <div class="random_artists_container">
                        <c:forEach items="${artists}" var="a">
                            <div class='a_artist_item'>
                                <a href='singers?artistid=${a.getId()}'>
                                    <div class="artist_thumbail">
                                        <img src="${a.getImgPath()}">
                                        <div class='artist_name'>
                                            <p>${a.getName()}</p>
                                        </div>
                                    </div> 
                                </a>         
                            </div>
                        </c:forEach>
                    </div>
                    <br>
                    <div class='part_list_title'>
                        <b>RECOMMENDED CATEGORIES</b>
                    </div>
                    <hr>
                    <div class="random_cates_container">
                        <c:forEach items="${cates}" var="c">
                            <div class='an_category_container'>
                                <a href='categories?id=${c.getId()}'>
                                    <div class='category_thumbail' 
                                         style="background-image: url(img/categoriesBackground/<%=new Random().nextInt(4) + 1%>.jpg)">
                                        <p>${c.getName()}</p>
                                    </div> 
                                </a>         
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../../template/footer/footer.jsp"></jsp:include>
    </body>
</html>

