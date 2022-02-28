<%--
  AdminLTE v3.x Main Header.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%@ taglib tagdir="/WEB-INF/tags/adminlte3" prefix="adminlte" %>
<%-- Attributes --%>
<%@ attribute name="_brandHref" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_brandImgSrc" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_brandTitle" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_rightPart" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_inTopNav" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_style" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_class" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_attrs" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<nav class="main-header navbar navbar-expand<c:if test="${_inTopNav}">-md</c:if> navbar-light navbar-white">
    <c:choose><c:when test="${_inTopNav}">
        <div class="container">
            <adminlte:brand-logo _inTopNav="${_inTopNav}" _imgSrc="${_brandImgSrc}" _title="${_brandTitle}" _href="${_brandHref}"/>
            <button class="navbar-toggler order-1" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse order-3" id="navbarCollapse"><jsp:doBody/></div>
            ${_rightPart}
        </div>
    </c:when><c:otherwise><jsp:doBody/></c:otherwise></c:choose>
</nav>
