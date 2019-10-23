<%-- 
    Document   : categories
    Created on : Jul 6, 2019, 11:42:30 PM
    Author     : quoct
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <jsp:include page="../../template/nagivator/nagivatorBar.jsp"></jsp:include>
        <head>
            <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Jura" />
            <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Varela+Round" /><link rel='stylesheet' href='//fonts.googleapis.com/css?family=Jura' type='text/css' /> 
            <meta name="viewport" content="width=device-width,initial-scale=1.0">
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Categories | Moply</title>
        </head>           
        <link rel="stylesheet" href="template/nagivator/style.css" type="text/css" />
        <link rel="stylesheet" href="view/css/contentStyle.css" type="text/css" />  
        <style>
            .wrap{
                min-height: 600px;
                padding-left: 20px;
                padding-right: 20px;
                padding-top: 20px;
                font-family: "Oxygen", HelveticaNeue, "Helvetica Neue", Helvetica, Arial, sans-serif;  
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
            .part_list_title{
                margin-left: 20px;
                font-family: Jura; font-size: 24px; font-style: normal; font-variant: normal; font-weight: 700; line-height: 26.4px; } h3 { font-family: Jura; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 700; line-height: 15.4px; } p { font-family: Jura; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 19.99px; } blockquote { font-family: Jura; font-size: 21px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 29.99px; } pre { font-family: Jura; font-size: 13px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 18.57px;
                                                                                                                                                                                                        font-weight: bold;
                                                                                                                                                                                                        color:#474747;
            }
            .part_list_title a{
                font-size:15px;
                margin-right: 15px;
            }
            .artists_container .a_artist_item{
                display: inline-block;
                margin-bottom: 10px;
                float: left;
                transition: transform 0.5s;
            }
            .artists_container .artist_thumbail{
                display: inline-block;
                margin: 0px 24px 0px 24px; 
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
            .a_song_container:hover {
                -ms-transform: scale(0.9); /* IE 9 */
                -webkit-transform: scale(0.9); /* Safari 3-8 */
                transform: scale(0.9); 
            }
            .cates_container p{
                font-size: 20px;
            }
            .page_title{
                color:#1f7f5c;
                font-family: Jura; font-size: 24px; font-style: normal; font-variant: normal; font-weight: 700; line-height: 26.4px; } h3 { font-family: Varela Round; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 700; line-height: 15.4px; } p { font-family: Varela Round; font-size: 14px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 19.99px; } blockquote { font-family: Varela Round; font-size: 21px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 29.99px; } pre { font-family: Varela Round; font-size: 13px; font-style: normal; font-variant: normal; font-weight: 400; line-height: 18.57px
            }
            .cates_container{
                margin-bottom: 30px;
            }
            .sub_cates_container .a_song_container{
                display: inline-block;
                margin: 5px 5px 5px 8px;
            }
        </style>
        <body>
            <div class="main_container">
                <div class="content">
                    <div class="wrap">
                        <div class="page_title"><h2>Categories</h2></div>
                        <hr>
                        <br>
                    <c:if test="${param.id!=null}">
                        <div class="cates_container">
                            <p>${cate.getName()}</p>
                            <hr> 
                            <div class="sub_cates_container">
                                <c:forEach items="${songs}" var="s">
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
                                </c:forEach>
                            </div>
                        </div>
                    </c:if>
                        
                    <c:if test="${param.id==null}">
                        <c:forEach items="${cates}" var="c">
                            <c:set var="count" value="${0}"></c:set>
                            <c:if test="${c.getId()!=0}">
                                <div class="cates_container">
                                    <a href="categories?id=${c.getId()}"><p>${c.getName()} ></p></a>
                                    <hr> 
                                    <div class="sub_cates_container">
                                        <c:forEach items="${songs}" var="s">
                                            <c:if test="${s.getKindid()==c.getId()&&count!=6}">
                                                <c:set var="count" value="${count+1}"></c:set>
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
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        <div class="cates_container">
                            <a href="categories?id=0"><p>Other...</p></a>
                            <hr>  
                            <div class="sub_cates_container">
                                <c:set var="count" value="${0}"></c:set>
                                <c:forEach items="${songs}" var="s">
                                    <c:if test="${s.getKindid()==0&&count!=6}">
                                        <c:set var="count" value="${count+1}"></c:set>
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
                                    </c:if>
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
