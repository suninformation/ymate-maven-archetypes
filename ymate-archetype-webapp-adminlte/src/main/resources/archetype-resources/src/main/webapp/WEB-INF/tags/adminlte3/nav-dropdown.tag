<%--
  AdminLTE v3.x Nav Dropdown.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%@ taglib tagdir="/WEB-INF/tags/adminlte3" prefix="adminlte" %>
<%-- Attributes --%>
<%@ attribute name="_icon" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_badgeText" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_badgeStyle" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_footerHref" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_footerText" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<li class="nav-item dropdown">
    <a class="nav-link" data-toggle="dropdown" href="#">
        <i class="far fa-${_icon}"></i>
        <span class="badge badge-${func:defaultIfBlank(_badgeStyle, 'danger')} navbar-badge">${_badgeText}</span>
    </a>
    <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
        <jsp:doBody/>
        <adminlte:nav-dropdown-item _divider="true"/>
        <a href="${func:defaultIfBlank(_footerHref, '#')}" class="dropdown-item dropdown-footer">${func:defaultIfBlank(_footerText, 'See All')}</a>
    </div>
</li>