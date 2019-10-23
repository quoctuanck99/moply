<%-- 
    Document   : slider
    Created on : Jul 4, 2019, 11:22:03 AM
    Author     : quoct
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
    /* Slideshow container */
    .slideshow-container {
        max-width: 100%;
        position: static;
        margin: auto;
        z-index: -1;
    }
    /* Ẩn các slider */
    .mySlides {
        display: none;

    }
    /* Định dạng nội dung Caption */
    .text {
        color: #f2f2f2;
        font-size: 15px;
        padding: 8px 12px;
        position: absolute;
        bottom: 8px;
        width: 100%;
        text-align: center;
    }

    /* định dạng các chấm chuyển đổi các slide */
    .dot {
        cursor:pointer;
        height: 13px;
        width: 13px;
        margin: 0 5px;
        background-color: #bbb;
        border-radius: 50%;
        display: inline-block;
        transition: background-color 0.6s ease;
    }
    /* khi được hover, active đổi màu nền */
    .active, .dot:hover {
        background-color: #717171;
    }

    /*     Thêm hiệu ứng khi chuyển đổi các slide */
    /*        .fade {
                -webkit-animation-name: fade;
                -webkit-animation-duration: 3s;
                animation-name: none;
                animation-duration: 3s;
                z-index: -1;
            }*/

    @-webkit-keyframes fade {
        from {opacity: .4} 
        to {opacity: 1}
    }

    @keyframes fade {
        from {opacity: .4} 
        to {opacity: 1}
    }
</style>

<div class="slideshow-container">
    <div class="mySlides fade">
        <img src="img/sliderImg/slide-1.jpg" style="width:100%">
        <!--<div class="text">Nội dung caption của slide đầu tiên!</div>-->
    </div>

    <div class="mySlides fade">
        <img src="img/sliderImg/slide-2.jpg" style="width:100%">
        <!--<div class="text">Nội dung caption của slide thứ 2!</div>-->
    </div>

    <div class="mySlides fade">
        <img src="img/sliderImg/slide-3.jpg" style="width:100%">
        <!--<div class="text">Nội dung caption của slide thứ 3!</div>-->
    </div>
</div>
<br>
<div style="text-align:center">
    <span class="dot" onclick="currentSlide(0)"></span> 
    <span class="dot" onclick="currentSlide(1)"></span> 
    <span class="dot" onclick="currentSlide(2)"></span> 
</div>  

<script>
    //khai báo biến slideIndex đại diện cho slide hiện tại
    var slideIndex;
    // KHai bào hàm hiển thị slide
    function showSlides() {
        var i;
        var slides = document.getElementsByClassName("mySlides");
        var dots = document.getElementsByClassName("dot");
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        for (i = 0; i < dots.length; i++) {
            dots[i].className = dots[i].className.replace(" active", "");
        }

        slides[slideIndex].style.display = "block";
        dots[slideIndex].className += " active";
        //chuyển đến slide tiếp theo
        slideIndex++;
        //nếu đang ở slide cuối cùng thì chuyển về slide đầu
        if (slideIndex > slides.length - 1) {
            slideIndex = 0;
        }
        //tự động chuyển đổi slide sau 5s
        setTimeout(showSlides, 10000);
    }
    //mặc định hiển thị slide đầu tiên 
    showSlides(slideIndex = 0);


    function currentSlide(n) {
        showSlides(slideIndex = n);
    }
</script>
