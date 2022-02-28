<%--
  AdminLTE v3.x Control Sidebar.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_nonWrapper" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_lightMode" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_style" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_class" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_attrs" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_wrapperStyle" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_wrapperClass" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_wrapperAttrs" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<aside class="control-sidebar control-sidebar-<c:choose><c:when test="${_lightMode}">light</c:when><c:otherwise>dark</c:otherwise></c:choose> ${_class}" <c:if test="${not empty _style}">style="${_style}" </c:if> ${_attrs}>
    <c:choose><c:when test="${_nonWrapper}">
        <jsp:doBody/>
    </c:when><c:otherwise>
        <div class="p-3 ${_wrapperClass}" <c:if test="${not empty _wrapperStyle}">style="${_wrapperStyle}" </c:if> ${_wrapperAttrs}>
            <jsp:doBody/>
        </div>
    </c:otherwise></c:choose>
</aside>
