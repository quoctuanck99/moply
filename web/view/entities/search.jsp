<%-- 
    Document   : search
    Created on : Jul 18, 2019, 2:12:38 PM
    Author     : quoct
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../../template/nagivator/nagivatorBar.jsp"></jsp:include>
        <head>
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Search | Moply</title>
        </head>           
        <link rel="stylesheet" href="template/nagivator/style.css" type="text/css" />
        <link rel="stylesheet" href="view/css/contentStyle.css" type="text/css" />  
        <style>
            .wrap{
                min-height: 600px;
                padding-left: 20px;
                padding-right: 20px;
                padding-top: 20px;
            }
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
            }
            .a_song_container:hover {
                -ms-transform: scale(0.9); /* IE 9 */
                -webkit-transform: scale(0.9); /* Safari 3-8 */
                transform: scale(0.9); 
            }
            .artists_container{
                margin-top: 20px;
            }
            .artists_container .a_artist_item{
                display: inline-block;
                margin-bottom: 10px;
                float: left;
                transition: transform 0.5s;
            }
            .artists_container .artist_thumbail{
                display: inline-block;
                margin: 25px 15px 0px 25px; 
            }
            .artists_container .artist_name{
                text-align: center;
            }
            .artists_container .artist_thumbail img{
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
        </style>
        <body>
            <div class="main_container">
                <div class="content">
                    <div class="wrap">
                        <h2>Search result</h2>
                        <hr>
                    <c:if test="${songs.size()==0&&artists.size()==0}">
                        <h1>No result found for "${param.search_text}"</h1>
                    </c:if>
                    <c:if test="${songs.size()!=0}">
                        <h4>Songs (${songs.size()})</h4>
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
                    </c:if>
                    <c:if test="${artists.size()!=0}">
                        <h4>Artists (${artists.size()})</h4>
                        <div class="artists_container">
                            <c:forEach items="${artists}" var="a">
                                <div class='a_artist_item'>
                                    <a href='singers?artistid=${a.getId()}'>
                                        <div class="artist_thumbail">
                                            <img src="${a.getImgPath()}">
                                            <div class='artist_name'>
                                                ${a.getName()}
                                            </div>
                                        </div> 
                                    </a>         
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>
        <jsp:include page="../../template/footer/footer.jsp"></jsp:include>
    </body>
</html>

