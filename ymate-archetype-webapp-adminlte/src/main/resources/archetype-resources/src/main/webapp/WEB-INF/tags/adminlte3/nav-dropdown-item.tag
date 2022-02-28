<%--
  AdminLTE v3.x Nav Dropdown Item.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%-- 超链接地址，默认：# --%>
<%@ attribute name="_href" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_header" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_divider" rtexprvalue="true" type="java.lang.Boolean" %>

<%-- Tag Body --%>
<c:choose><c:when test="${_divider}">
    <div class="dropdown-divider"></div>
</c:when><c:when test="${_header}">
    <span class="dropdown-item dropdown-header"><jsp:doBody/></span>
</c:when><c:otherwise>
    <a href="${func:defaultIfBlank(_href, '#')}" class="dropdown-item">
        <jsp:doBody/>
    </a>
</c:otherwise></c:choose>