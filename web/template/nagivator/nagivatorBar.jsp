<%-- 
    Document   : nagivatorBar
    Created on : Jul 2, 2019, 9:04:58 PM
    Author     : quoct
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<mvc:annotation-driven />               
<link rel="stylesheet" href="style.css" type="text/css" />
<!--<link href="https://fonts.googleapis.com/css?family=Righteous&display=swap" rel="stylesheet">-->
<!--<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>-->
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<style>
    #login{
        font-size: 20px;
    }
</style>
<div id="navBar">
    <ul class="nav">
        <li id="logo">
            <a href="home"><img src="img/navbar/logo.png" /></a>
        </li>
        <li>
            <a href="categories">Categories</a>
        </li>
        <li>
            <a href="singers">Singers</a>
        </li>
        <li>
            <a href="upload">Upload</a>
        </li>

        <li id="search">
            <form action="search" onsubmit="return validate();" method="get">
                <input type="text" name="search_text" id="search_text" placeholder="Searchs..." />
                <input type="button" name="search_button" id="search_button" >
            </form>
        </li>
        <c:if test="${account==null}">
            <li id="login">
                <a href="login">Login</a>
                <ul class="subLogin">
                    <li><a href="login">Login</a></li>
                    <li><a href="register">Register</a></li>
                </ul>
            </li>
        </c:if>
        <c:if test="${account!=null}">
            <li id="login">
                <c:if test="${account.getRole().getId()==1}">
                    <a href="#">${account.getUsername()}</a>
                    <ul class="subLogin">
                        <li><a href="adminpanel">Administrator Panel</a></li>
                        <li><a href="playlist">My playlists</a></li>
                        <li><a href="logout">Logout</a></li>
                    </ul>
                </c:if>
                <c:if test="${account.getRole().getId()!=1}">
                    <a href="#">${account.getUsername()}</a>
                    <ul class="subLogin">
                        <li><a href="playlist">My playlists</a></li>
                        <li><a href="logout">Logout</a></li>
                    </ul>
                </c:if>
            </li>
        </c:if>
    </ul>
</div>
<script>
    window.onscroll = function () {
        myFunction();
    };

    // Get the navbar
    var navbar = document.getElementById("navBar");

    // Get the offset position of the navbar
    var sticky = navbar.offsetTop;

    // Add the sticky class to the navbar when you reach its scroll position. Remove "sticky" when you leave the scroll position
    function myFunction() {
        if (window.pageYOffset >= sticky) {
            navbar.classList.add("sticky");
        } else {
            navbar.classList.remove("sticky");
        }
    }
    function validate() {
        //If the form value is "" (nothing)
        if (document.getElementById("search_text").value === "") {
            return false; //Stop the form from submitting
        }
        return true;
    }
</script>


