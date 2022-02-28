<%--
  AdminLTE v3.x Small Box.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_title" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_value" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_icon" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_footerText" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_footerHref" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_showLoading" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_loadingDarkMode" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_gradient" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_bgStyle" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<div class="small-box bg<c:if test="${_gradient}">-gradient</c:if>-${func:defaultIfBlank(_bgStyle, 'primary')}">
    <div class="inner">
        <h3>${_value}</h3>
        <p>${_title}</p>
    </div>
    <c:if test="${not empty _icon}"><div class="icon"><i class="fas fa-${_icon}"></i></div></c:if>
    <c:if test="${_showLoading}"><div class="overlay <c:if test="${_loadingDarkMode}">dark</c:if>"><i class="fas fa-2x fa-sync-alt fa-spin"></i></div></c:if>
    <a href="${func:defaultIfBlank(_footerHref, '#')}" class="small-box-footer"><c:out value="${func:defaultIfBlank(_footerText, 'More info')} "/><i class="fas fa-arrow-circle-right"></i></a>
</div>
