<%--
  AdminLTE v3.x User Panel/Menu.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_username" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_description" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_avatarSrc" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_bgStyle" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_profileText" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_profileHref" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_signOutText" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_signOutHref" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_inTopNav" rtexprvalue="true" type="java.lang.Boolean" %>

<%-- Tag Body --%>
<c:choose><c:when test="${_inTopNav}">
    <li class="nav-item dropdown user-menu">
        <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">
            <img src="@{page.path}${func:defaultIfBlank(_avatarSrc, 'assets/adminlte3/img/user2-160x160.jpg')}" class="user-image img-circle elevation-2" alt="User Avatar">
            <span class="d-none d-md-inline">${_username}</span>
        </a>
        <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
            <li class="user-header bg-${func:defaultIfBlank(_bgStyle, 'primary')}">
                <img src="@{page.path}${func:defaultIfBlank(_avatarSrc, 'assets/adminlte3/img/user2-160x160.jpg')}" class="img-circle elevation-2" alt="User Avatar">
                <p>${_username}<c:if test="${not empty _description}"><small>${_description}</small></c:if></p>
            </li>
            <jsp:doBody var="_bodyStr" scope="page"/>
            <c:if test="${not empty _bodyStr}"><li class="user-body">${_bodyStr}</li></c:if>
            <li class="user-footer">
                <a href="${func:defaultIfBlank(_profileHref, '#')}" class="btn btn-default btn-flat">${func:defaultIfBlank(_profileText, 'Profile')}</a>
                <a href="${func:defaultIfBlank(_signOutHref, '#')}" class="btn btn-default btn-flat float-right">${func:defaultIfBlank(_signOutText, 'Sign out')}</a>
            </li>
        </ul>
    </li>
</c:when><c:otherwise>
    <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
            <img src="@{page.path}${func:defaultIfBlank(_avatarSrc, 'assets/adminlte3/img/user2-160x160.jpg')}" class="img-circle elevation-2" alt="User Avatar">
        </div>
        <div class="info">
            <a href="${func:defaultIfBlank(_profileHref, '#')}" class="d-block">${_username}</a>
        </div>
    </div>
</c:otherwise></c:choose>
