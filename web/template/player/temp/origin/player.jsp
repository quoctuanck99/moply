<%-- 
    Document   : player
    Created on : Jul 8, 2019, 11:21:41 PM
    Author     : quoct
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="model.Song"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html;charset=utf-8"/>
        <meta name="viewport" content="width=device-width">

        <!-- Insert to your webpage before the </head> -->
        <script src="template/player/audioplayerengine/jquery.js"></script>
        <script src="template/player/audioplayerengine/amazingaudioplayer.js"></script>
        <link rel="stylesheet" type="text/css" href="template/player/audioplayerengine/initaudioplayer-1.css">
        <script src="template/player/audioplayerengine/initaudioplayer-1.js"></script>
        <!-- End of head section HTML codes -->
        <style>
            #amazingaudioplayer-1{
                z-index: 0;
            }
        </style>
    </head>
    <body>
        <div style="margin:12px auto;">
            <!-- Insert to your webpage where you want to display the audio player -->
            <div id="amazingaudioplayer-1" style="display:block;position:relative;width:100%;height:auto;margin:0px auto 0px;">
                <ul class="amazingaudioplayer-audios" style="display:none;">
                    <c:if test="${playlist!=null}">
                        <c:forEach items="${playlist.getSongsList()}" var="s">
                            <li data-artist="${s.getArtistname()}" data-title="${s.getName()}" data-album="" data-info="" data-image="${s.getImgPath()}" data-duration="246">
                                <div class="amazingaudioplayer-source" data-src="${s.getTrackPath()}" data-type="audio/mpeg" ></div>
                            </li>
                        </c:forEach>
                    </c:if>
                    <c:if test="${playlist==null}">
                        <li data-artist="${song.getArtistname()}" data-title="${song.getName()}" data-album="" data-info="" data-image="${song.getImgPath()}" data-duration="246">
                            <div class="amazingaudioplayer-source" data-src="${song.getTrackPath()}" data-type="audio/mpeg" ></div>
                        </li>
                    </c:if>
                </ul>
            </div>
            <!-- End of body section HTML codes -->

        </div>

    </body>
</html>