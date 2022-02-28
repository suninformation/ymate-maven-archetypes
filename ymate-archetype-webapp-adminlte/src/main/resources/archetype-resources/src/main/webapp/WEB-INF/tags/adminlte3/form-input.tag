<%--
  AdminLTE v3.x Form Input.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_id" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_name" rtexprvalue="true" type="java.lang.String" required="true" %>
<%@ attribute name="_type" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_label" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_icon" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_placeholder" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_helpText" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_disabled" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_plaintext" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_style" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_class" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_attrs" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_formGroupStyle" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_formGroupClass" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_formGroupAttrs" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<div class="form-group ${_formGroupClass}"<c:if test="${not empty _formGroupStyle}"> style="${_formGroupStyle}"</c:if><c:if test="${not empty _formGroupAttrs}"> ${_formGroupAttrs}</c:if>>
    <c:if test="${not empty _label}"><label<c:if test="${not empty _id}"> for="${_id}_input"</c:if>>${_label}</label></c:if>
    <div class="input-group">
        <jsp:doBody var="_bodyStr" scope="page"/>
        <c:choose><c:when test="${_plaintext}">
            <input name="${_name}" type="text" class="form-control-plaintext ${_class}" readonly="readonly"<c:if test="${not empty _id}"> id="${_id}_input"</c:if><c:if test="${not empty _style}"> style="${_style}"</c:if><c:if test="${not empty _attrs}"> ${_attrs}</c:if><c:if test="${not empty _bodyStr}"> value="${_bodyStr}"</c:if>>
        </c:when><c:otherwise>
            <input name="${_name}" type="${func:defaultIfBlank(_type, 'text')}" class="form-control ${_class}"<c:if test="${not empty _id}"> id="${_id}_input"</c:if><c:if test="${not empty _placeholder}"> placeholder="${_placeholder}"</c:if><c:if test="${_disabled}"> disabled="disabled"</c:if><c:if test="${not empty _style}"> style="${_style}"</c:if><c:if test="${not empty _attrs}"> ${_attrs}</c:if><c:if test="${not empty _bodyStr}"> value="${_bodyStr}"</c:if>>
            <c:if test="${not empty _icon}"><div class="input-group-append">
                <div class="input-group-text"><i class="fa fa-${_icon}"></i></div>
            </div></c:if>
        </c:otherwise></c:choose>
    </div>
    <c:if test="${not empty _helpText}"><small class="form-text text-muted">${_helpText}</small></c:if>
</div>