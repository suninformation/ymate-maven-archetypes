<%--
  AdminLTE v3.x Breadcrumb Item.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_href" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_active" rtexprvalue="true" type="java.lang.Boolean" %>

<%-- Tag Body --%>
<li class="breadcrumb-item <c:if test="${_active}">active</c:if>"><c:choose><c:when test="${_active}">
    <jsp:doBody/>
</c:when><c:otherwise><a href="${func:defaultIfBlank(_href, '#')}">
    <jsp:doBody/>
</a></c:otherwise></c:choose></li>