<%--
  AdminLTE v3.x Form Custom Checkbox.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_id" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_name" rtexprvalue="true" type="java.lang.String" required="true" %>
<%@ attribute name="_value" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_helpText" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_disabled" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_checked" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_style" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_class" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_attrs" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_formGroupStyle" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_formGroupClass" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_formGroupAttrs" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<div class="form-group ${_formGroupClass}"<c:if test="${not empty _formGroupStyle}"> style="${_formGroupStyle}"</c:if><c:if test="${not empty _formGroupAttrs}"> ${_formGroupAttrs}</c:if>>
    <div class="custom-control custom-checkbox">
        <input name="${_name}" type="checkbox" class="custom-control-input ${_class}"<c:if test="${not empty _id}"> id="${_id}_input"</c:if> value="${func:defaultIfBlank(_value, 'on')}"<c:if test="${_checked}"> checked="checked"</c:if><c:if test="${_disabled}"> disabled="disabled"</c:if><c:if test="${not empty _style}"> style="${_style}"</c:if><c:if test="${not empty _attrs}"> ${_attrs}</c:if>>
        <label class="custom-control-label"<c:if test="${not empty _id}"> for="${_id}_input"</c:if>><jsp:doBody/></label>
    </div>
    <c:if test="${not empty _helpText}"><small class="form-text text-muted">${_helpText}</small></c:if>
</div>