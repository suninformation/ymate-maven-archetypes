<%--
  AdminLTE v3.x Info Box.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_title" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_value" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_icon" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_iconStyle" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_progressValue" rtexprvalue="true" type="java.lang.Integer" %>
<%@ attribute name="_progressDesc" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_progressStyle" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_showLoading" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_loadingDarkMode" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_gradient" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_bgStyle" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<div class="info-box <c:if test="${not empty _bgStyle}">bg<c:if test="${_gradient}">-gradient</c:if>-${func:defaultIfBlank(_bgStyle, 'primary')}</c:if>">
    <c:if test="${not empty _icon}"><span class="info-box-icon <c:if test="${empty _bgStyle}">bg-${func:defaultIfBlank(_iconStyle, 'info')}</c:if>"><i class="far fa-${_icon}"></i></span></c:if>
    <div class="info-box-content">
        <span class="info-box-text">${_title}</span>
        <span class="info-box-number">${_value}</span>
        <c:if test="${not empty _progressValue}">
            <div class="progress"><div class="progress-bar <c:if test="${empty _bgStyle}">bg-${func:defaultIfBlank(_progressStyle, 'info')}</c:if>" style="width: ${_progressValue}%"></div></div>
            <c:if test="${not empty _progressDesc}"><span class="progress-description">${_progressDesc}</span></c:if>
        </c:if>
    </div>
    <c:if test="${_showLoading}"><div class="overlay <c:if test="${_loadingDarkMode}">dark</c:if>"><i class="fas fa-2x fa-sync-alt fa-spin"></i></div></c:if>
</div>
