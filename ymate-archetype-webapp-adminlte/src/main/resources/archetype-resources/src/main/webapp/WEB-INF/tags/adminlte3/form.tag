<%--
  AdminLTE v3.x Form.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Attributes --%>
<%@ attribute name="_navbar" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_left" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_right" rtexprvalue="true" type="java.lang.Boolean" %>
<%-- inline: 内联表单 --%>
<%@ attribute name="_inline" rtexprvalue="true" type="java.lang.Boolean" %>
<%-- horizontal: 水平排列的表单 --%>
<%@ attribute name="_horizontal" rtexprvalue="true" type="java.lang.Boolean" %>
<%-- disabled: 禁用表单内所有控件 --%>
<%@ attribute name="_disabled" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_fieldset" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_legend" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_name" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_action" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_method" rtexprvalue="true" type="java.lang.String" %>
<%-- enctype: multipart/form-data|application/x-www-form-urlencoded --%>
<%@ attribute name="_enctype" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_multipart" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_urlencoded" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_id" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_style" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_class" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_attrs" rtexprvalue="true" type="java.lang.String" %>
<%-- Tag Body --%>
<form <c:if test="${not empty _id}">id="${_id}" </c:if><c:if test="${not empty _name}">name="${_name}" </c:if><c:if test="${not empty _action}">action="${_action}" </c:if><c:if test="${not empty _method}">method="${_method}" </c:if><c:choose><c:when test="${not empty _enctype}">enctype="${_enctype}" </c:when><c:when test="${_multipart}">enctype="multipart/form-data" </c:when><c:when test="${_urlencoded}">enctype="application/x-www-form-urlencoded" </c:when></c:choose><c:if test="${_navbar or _left or _right or _inline or _horizontal or not empty _class}">class="<c:choose><c:when test="${_navbar}"> navbar-form<c:choose><c:when test="${_left}"> navbar-left</c:when><c:when test="${_right}"> navbar-right</c:when></c:choose></c:when><c:otherwise><c:choose><c:when test="${_inline}">form-inline</c:when><c:when test="${_horizontal}">form-horizontal</c:when></c:choose></c:otherwise></c:choose><c:if test="${not empty _class}"> ${_class}</c:if>"</c:if><c:if test="${not empty _style}"> style="${_style}"</c:if><c:if test="${not empty _attrs}"> ${_attrs}</c:if>>
    <c:if test="${_fieldset or _disabled or not empty _legend}"><fieldset<c:if test="${_disabled}"> disabled</c:if>><c:if test="${not empty _legend}"><legend>${_legend}</legend></c:if></c:if>
    <jsp:doBody/>
    <c:if test="${_fieldset or _disabled or not empty _legend}"></fieldset></c:if>
</form>