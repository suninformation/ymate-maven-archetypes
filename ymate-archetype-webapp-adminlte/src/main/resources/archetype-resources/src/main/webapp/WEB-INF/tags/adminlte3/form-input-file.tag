<%--
  AdminLTE v3.x Form Input File.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_id" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_name" rtexprvalue="true" type="java.lang.String" required="true" %>
<%@ attribute name="_label" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_icon" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_placeholder" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_helpText" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_disabled" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_accept" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_acceptImageOnly" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_acceptVideoOnly" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_acceptAudioOnly" rtexprvalue="true" type="java.lang.Boolean" %>

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
        <div class="custom-file">
            <input name="${_name}" type="file" class="custom-file-input ${_class}"<c:if test="${not empty _id}"> id="${_id}_input"</c:if><c:if test="${not empty _placeholder}"> placeholder="${_placeholder}"</c:if><c:choose><c:when test="${not empty _accept}"> accept="${_accept}"</c:when><c:when test="${_acceptImageOnly}"> accept="image/*"</c:when><c:when test="${_acceptVideoOnly}"> accept="video/*"</c:when><c:when test="${_acceptAudioOnly}"> accept="audio/*"</c:when></c:choose><c:if test="${_disabled}"> disabled="disabled"</c:if><c:if test="${not empty _style}"> style="${_style}"</c:if><c:if test="${not empty _attrs}"> ${_attrs}</c:if>>
            <jsp:doBody var="_bodyStr" scope="page"/>
            <c:if test="${not empty _id}"><label class="custom-file-label" for="${_id}_input">${func:defaultIfBlank(_bodyStr, 'Choose file')}</label></c:if>
        </div>
    </div>
    <c:if test="${not empty _helpText}"><small class="form-text text-muted">${_helpText}</small></c:if>
</div>