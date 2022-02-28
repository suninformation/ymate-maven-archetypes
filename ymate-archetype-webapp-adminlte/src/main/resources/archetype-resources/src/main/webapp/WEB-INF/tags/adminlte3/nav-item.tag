<%--
  AdminLTE v3.x NavItem.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%-- 超链接地址，默认：# --%>
<%@ attribute name="_href" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_header" rtexprvalue="true" type="java.lang.Boolean" %>
<%-- 当屏幕宽度较小且该值为true时则该项将隐藏 --%>
<%@ attribute name="_hideOnNav" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_pushMenu" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_themeSwitch" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_fullscreen" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_controlSidebar" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_menuItem" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_active" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_subItems" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_icon" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_badgeText" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_badgeStyle" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<c:choose><c:when test="${_header}">
    <li class="nav-header">
        <jsp:doBody/>
    </li>
</c:when><c:when test="${_pushMenu}">
    <li class="nav-item"><a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a></li>
</c:when><c:when test="${_themeSwitch}">
    <li class="nav-item">
        <div class="theme-switch-wrapper nav-link">
            <label class="theme-switch" for="checkbox">
                <input type="checkbox" id="checkbox">
                <span class="slider round"></span>
            </label>
        </div>
    </li>
</c:when><c:when test="${_fullscreen}">
    <li class="nav-item"><a class="nav-link" data-widget="fullscreen" href="#" role="button"><i class="fas fa-expand-arrows-alt"></i></a></li>
</c:when><c:when test="${_controlSidebar}">
    <li class="nav-item"><a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button"><i class="fas fa-th-large"></i></a></li>
</c:when><c:when test="${_menuItem}">
    <li class="nav-item <c:if test="${_active && not empty _subItems}">menu-open</c:if>">
        <a href="${func:defaultIfBlank(_href, '#')}" class="nav-link <c:if test="${_active}">active</c:if>">
            <i class="far fa-${func:defaultIfBlank(_icon, 'circle')} nav-icon"></i>
            <p>
                <jsp:doBody/>
                <c:if test="${not empty _subItems}"><i class="fas fa-angle-left right"></i></c:if>
                <c:if test="${not empty _badgeText}"><span class="right badge badge-${func:defaultIfBlank(_badgeStyle, 'danger')}">${_badgeText}</span></c:if>
            </p>
        </a>
        ${_subItems}
    </li>
</c:when><c:otherwise>
    <li class="nav-item <c:if test="${_active}">bg-secondary rounded active </c:if> <c:if test="${_hideOnNav}">d-none d-sm-inline-block</c:if>">
        <a href="${func:defaultIfBlank(_href, '#')}" class="nav-link"><c:if test="${not empty _icon}"><i class="far fa-${_icon}"></i> </c:if><jsp:doBody/><c:if test="${not empty _badgeText}"><span class="badge badge-${func:defaultIfBlank(_badgeStyle, 'danger')} navbar-badge">${_badgeText}</span></c:if></a>
        ${_subItems}
    </li>
</c:otherwise></c:choose>