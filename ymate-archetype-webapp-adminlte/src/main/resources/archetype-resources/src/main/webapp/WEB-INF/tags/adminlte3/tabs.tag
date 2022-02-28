<%--
  AdminLTE v3.x Nav Tabs.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_pills" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_fill" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_justified" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_content" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_id" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_style" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_class" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_attrs" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<ul <c:if test="${not empty _id}">id="${_id}" </c:if> class="nav nav-<c:choose><c:when test="${_pills}">pulls</c:when><c:otherwise>tabs</c:otherwise></c:choose><c:if test="${_fill}"> nav-fill</c:if><c:if test="${_justified}"> nav-justified</c:if><c:if test="${not empty _class}"> ${_class}</c:if>"<c:if test="${not empty _style}"> style="${_style}"</c:if><c:if test="${not empty _attrs}"> ${_attrs}</c:if>>
    <jsp:doBody/>
</ul>
<c:if test="${not empty _content}"><div class="tab-content">${_content}</div></c:if>