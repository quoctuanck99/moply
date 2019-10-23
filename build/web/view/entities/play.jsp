<%-- 
    Document   : play
    Created on : Jul 8, 2019, 1:42:46 PM
    Author     : quoct
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.Song"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <jsp:include page="../../template/nagivator/nagivatorBar.jsp"></jsp:include>
        <head>
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
        <c:set var="s" value="${song}"></c:set>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Varela+Round" /><link rel='stylesheet' href='//fonts.googleapis.com/css?family=Jura' type='text/css' /> 
            <link rel="stylesheet" href="view/css/style/bootstrap.min.css">
            <script src="view/css/style/jquery.min.js"></script>
            <script src="view/css/style/bootstrap.min.js"></script>

            <title><c:if test="${playlist==null}">${s.getName()}</c:if>
            <c:if test="${playlist!=null}">${playlist.getName()}</c:if>
                | Moply | Music for you</title>
            <style>
                .aboutSong{
                    padding-left: 10px;
                    font-size:15px;
                }

                #uploader{
                    color: #bbb;
                }
                .a_song_container {
                    margin-right: 18px;
                    float:left;
                    border-radius: 10px;
                    width: 380px;
                    height: 100px;
                    background-color: rgb(235, 235, 235);
                    font-family: Arial, Helvetica, sans-serif;
                    color: rgb(93, 93, 93);
                    margin-bottom: 20px;
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
                    float: left;
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
                .random_songs{
                    margin-left: 4px;

                }
                .a_song_container:hover {
                    -ms-transform: scale(0.9); /* IE 9 */
                    -webkit-transform: scale(0.9); /* Safari 3-8 */
                    transform: scale(0.9); 
                }
                .lyrics{
                    min-height: 300px;
                    clear: both;
                }
                #add_playlist_button{
                    float:right;
                    margin-bottom: 10px;
                    margin-right: 10px;
                }
                #add_playlist_button img{
                    width: 20px;
                    height: 20px;
                }
                .playlist_info{
                    min-height: 300px;
                }
                .page_title{
                    color:#1f7f5c;
                    font-family: Jura; font-size: 24px; font-style: normal; font-variant: normal; font-weight: 700; line-height: 26.4px; } h3 { font-family: Varela Round; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 700; line-height: 15.4px; } p { font-family: Varela Round; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 19.99px; } blockquote { font-family: Varela Round; font-size: 21px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 29.99px; } pre { font-family: Varela Round; font-size: 13px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 18.57px
                }
            </style>
        </head>           
        <link rel="stylesheet" href="template/nagivator/style.css" type="text/css" />
        <link rel="stylesheet" href="view/css/contentStyle.css" type="text/css" />  
        <body>
            <div class="main_container">
                <div class="content">
                    <div class="wrap">
                    <c:if test="${playlist!=null}">
                        <div class="page_title"><h2>Playlist: ${playlist.getName()}</h2></div>
                    </c:if>
                    <c:if test="${playlist!=null&&playlist.getSongsList().size()==0}">
                        <p>This playlist is empty!</p>
                    </c:if>                 
                    <c:if test="${playlist!=null&&playlist.getSongsList().size()!=0}">
                        <jsp:include page="../../template/player/player.jsp"></jsp:include>
                    </c:if>                 

                    <div class="box_right">
                        <c:if test="${playlist==null}">
                            <jsp:include page="../../template/player/player.jsp"></jsp:include>
                                <div class="aboutSong">
                                    <div id="uploader">Uploader by: ${s.getUploader()}</div>
                                <div id="singer">Singer: <a href="singers?artistid=${s.getArtistid()}"><b>${s.getArtistname()}</b></a></div>
                                <div id="composer">Composer: ${s.getComposer()}</div>
                                <c:if test="${account!=null}">
                                    <a href="add?songid=${param.songid}"><div id="add_playlist_button">
                                            <img src="img/icon/add_icon.png"/>
                                            Add to my playlist
                                        </div>
                                    </a>
                                </c:if>
                            </div>

                            <div class="lyrics">
                                <div class="panel panel-default">
                                    <div class="panel-heading">Lyrics</div>
                                    <c:if test="${info.size()==0}">
                                        <div class="panel-body" style="height: 500px;">
                                            <i style="color: #bbb">Empty</i>
                                        </div>
                                    </c:if>
                                    <c:if test="${info.size()!=0}">
                                        <div class="panel-body">
                                            <c:forEach items="${info}" var="line" step="1">
                                                ${line}<br/>
                                            </c:forEach> 
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </c:if>

                        <c:if test="${playlist!=null}">
                            <div class="playlist_info">
                                <div id="singer">Singer: <b>Various Artists</b></div>
                            </div>
                        </c:if>

                        <div class="random_songs">
                            <p> <i style="color: #5a6268">  Recommended songs:</i></p>
                            <c:forEach items="${randomSongs}" var="s">
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
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../../template/footer/footer.jsp"></jsp:include>
    </body>
</html>
