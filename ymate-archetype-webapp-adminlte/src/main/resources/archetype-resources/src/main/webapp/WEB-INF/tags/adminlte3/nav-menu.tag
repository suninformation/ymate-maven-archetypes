<%--
  AdminLTE v3.x Nav Menu.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_submenu" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_menuItem" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_icon" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_id" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_text" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_href" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<c:choose><c:when test="${_menuItem}">
    <li><a href="${func:defaultIfBlank(_href, '#')}" class="dropdown-item"><c:if test="${not empty _icon}"><i class="far fa-${_icon}"></i> </c:if><jsp:doBody/></a></li>
</c:when><c:otherwise>
    <li class="<c:choose><c:when test="${_submenu}">dropdown-submenu dropdown-hover</c:when><c:otherwise>nav-item dropdown</c:otherwise></c:choose>">
        <a id="${_id}" href="#" class="<c:choose><c:when test="${_submenu}">dropdown-item dropdown-toggle</c:when><c:otherwise>nav-link dropdown-toggle</c:otherwise></c:choose>" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><c:if test="${not empty _icon}"><i class="far fa-${_icon}"></i> </c:if>${_text}</a>
        <ul aria-labelledby="${_id}" class="dropdown-menu border-0 shadow">
            <jsp:doBody/>
        </ul>
    </li>
</c:otherwise></c:choose>