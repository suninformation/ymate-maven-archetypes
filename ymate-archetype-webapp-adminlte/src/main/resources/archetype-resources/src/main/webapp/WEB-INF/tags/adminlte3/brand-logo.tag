<%--
  AdminLTE v3.x Brand Logo.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_title" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_href" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_imgSrc" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_imgAlt" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_largeImgSrc" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_inTopNav" rtexprvalue="true" type="java.lang.Boolean" %>

<%-- Tag Body --%>
<a href="${func:defaultIfBlank(_href, '#')}" class="<c:choose><c:when test="${_inTopNav}">navbar-brand</c:when><c:otherwise>brand-link <c:if test="${not empty _largeImgSrc}">logo-switch</c:if></c:otherwise></c:choose>">
    <c:choose><c:when test="${not empty _largeImgSrc}">
        <img src="@{page.path}${func:defaultIfBlank(_imgSrc, 'assets/adminlte3/img/AdminLTELogo.png')}" alt="${func:defaultIfBlank(_imgAlt, 'AdminLTE Logo')} Small" class="brand-image-xl logo-xs">
        <img src="@{page.path}${_largeImgSrc}" alt="${func:defaultIfBlank(_imgAlt, 'AdminLTE Logo')} Large" class="brand-image-xs logo-xl" style="left: 12px">
    </c:when><c:otherwise>
        <img src="@{page.path}${func:defaultIfBlank(_imgSrc, 'assets/adminlte3/img/AdminLTELogo.png')}" alt="${func:defaultIfBlank(_imgAlt, 'AdminLTE Logo')}" class="brand-image img-circle elevation-3" style="opacity: .8">
        <span class="brand-text font-weight-light">${func:defaultIfBlank(_title, 'AdminLTE 3')}</span>
    </c:otherwise></c:choose>
</a>
