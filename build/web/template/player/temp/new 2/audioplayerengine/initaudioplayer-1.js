jQuery(document).ready(function(){
    var scripts = document.getElementsByTagName("script");
    var jsFolder = "";
    for (var i= 0; i< scripts.length; i++)
    {
        if( scripts[i].src && scripts[i].src.match(/initaudioplayer-1\.js/i))
            jsFolder = scripts[i].src.substr(0, scripts[i].src.lastIndexOf("/") + 1);
    }
    jQuery("#amazingaudioplayer-1").amazingaudioplayer({
        jsfolder:jsFolder,
        skinsfoldername:"",
        volumeimagewidth:24,
        barbackgroundimage:"2_nasaspacescapes_0006_7.jpg",
        imagewidth:100,
        showtime:true,
        titleinbarwidth:80,
        showprogress:true,
        random:false,
        titleformat:"%TITLE%",
        height:600,
        prevnextimage:"prevnext-24-24-0.png",
        showinfo:true,
        imageheight:100,
        skin:"Jukebox",
        loopimage:"loop-24-24-0.png",
        loopimagewidth:24,
        volumebarheight:80,
        prevnextimageheight:24,
        infoformat:"By %ARTIST% %ALBUM%<br />%INFO%",
        stopotherplayers:true,
        showstop:false,
        preloadaudio:true,
        showvolumebar:true,
        titleinbarscroll:true,
        width:500,
        showtitleinbar:false,
        showloop:true,
        volumeimage:"volume-24-24-0.png",
        progresswidth:500,
        loopimageheight:24,
        tracklistitemformat:"%ID%. %TITLE% <span style='float:right;'>%DURATION%</span>",
        prevnextimagewidth:24,
        tracklistarrowimage:"tracklistarrow-16-16-0.png",
        playpauseimageheight:24,
        showbackgroundimage:true,
        progresswidthmode:"auto",
        stopimage:"stop-24-24-0.png",
        showvolume:true,
        playpauseimage:"playpause-24-24-0.png",
        showprevnext:true,
        backgroundimage:"2_nasaspacescapes_0006_7.jpg",
        volumebarpadding:8,
        progressheight:8,
        showtracklistbackgroundimage:true,
        playpauseimagewidth:24,
        showtitle:true,
        defaultvolume:-1,
        tracklistarrowimageheight:16,
        heightmode:"auto",
        titleinbarformat:"%TITLE%",
        showtracklist:true,
        stopimageheight:24,
        volumeimageheight:24,
        stopimagewidth:24,
        noncontinous:false,
        tracklistbackgroundimage:"2_nasaspacescapes_0006_7.jpg",
        showbarbackgroundimage:true,
        showimage:true,
        tracklistwidth:500,
        tracklistarrowimagewidth:16,
        timeformat:"%CURRENT% / %DURATION%",
        autoplay:true,
        loop:1,
        tracklistitem:10
    });
});