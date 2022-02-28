<%--
  AdminLTE v3.x Tab Panel.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_active" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_id" rtexprvalue="true" required="true" type="java.lang.String" %>

<%@ attribute name="_style" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_class" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_attrs" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<div id="${_id}" class="tab-pane<c:if test="${_active}"> active</c:if><c:if test="${not empty _class}"> ${_class}</c:if>"<c:if test="${not empty _style}"> style="${_style}"</c:if><c:if test="${not empty _attrs}"> ${_attrs}</c:if>>
    <jsp:doBody/>
</div>