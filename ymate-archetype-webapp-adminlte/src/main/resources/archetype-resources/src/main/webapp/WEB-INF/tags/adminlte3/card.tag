<%--
  AdminLTE v3.x Card.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_title" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_header" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_tools" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_footer" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_showMaximizeBtn" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_showCollapseBtn" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_showRemoveBtn" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_showLoading" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_loadingDarkMode" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_outline" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_gradient" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_bgStyle" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_id" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_style" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_class" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_attrs" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_useFormBody" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_formInline" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_formId" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_formClass" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_formAction" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_formMethod" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_formEnctype" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_formMultipart" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_formUrlencoded" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_formAttrs" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_showFooterSubmitBtn" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_footerSubmitBtnText" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_showFooterCancelBtn" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_footerCancelBtnText" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_bodyStyle" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_bodyClass" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_bodyAttrs" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_headerStyle" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_headerClass" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_headerAttrs" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<div <c:if test="${not empty _id}">id="${_id}" </c:if>class="card <c:if test="${_outline}">card-outline </c:if><c:choose><c:when test="${not empty _bgStyle}">bg<c:if test="${_gradient}">-gradient</c:if>-${func:defaultIfBlank(_bgStyle, 'primary')}</c:when><c:otherwise>card-${func:defaultIfBlank(_style, 'primary')}</c:otherwise></c:choose><c:if test="${not empty _class}"> ${_class}</c:if>"<c:if test="${not empty _style}"> style="${_style}"</c:if><c:if test="${not empty _attrs}"> ${_attrs}</c:if>>
    <div class="card-header ${_headerClass}" <c:if test="${not empty _headerStyle}">style="${_headerStyle}" </c:if> ${_headerAttrs}>
        <c:if test="${not empty _title}"><h3 class="card-title">${_title}</h3></c:if>
        <c:if test="${not empty _tools || _showMaximizeBtn || _showCollapseBtn || _showRemoveBtn}">
            <div class="card-tools">
                <c:if test="${not empty _tools}">${_tools}</c:if>
                <c:if test="${_showMaximizeBtn}"><button type="button" class="btn btn-tool" data-card-widget="maximize"><i class="fas fa-expand"></i></button></c:if>
                <c:if test="${_showCollapseBtn}"><button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-minus"></i></button></c:if>
                <c:if test="${_showRemoveBtn}"><button type="button" class="btn btn-tool" data-card-widget="remove"><i class="fas fa-times"></i></button></c:if>
            </div>
        </c:if>
        <c:if test="${not empty _header}">${_header}</c:if>
    </div>
    <div class="card-body ${_bodyClass}" <c:if test="${not empty _bodyStyle}">style="${_bodyStyle}" </c:if> ${_bodyAttrs}><c:choose><c:when test="${_useFormBody}"><form<c:if test="${not empty _formId}"> id="${_formId}"</c:if><c:if test="${not empty _formClass or _formInline}"> class="${_formClass}<c:if test="${_formInline}"> form-inline</c:if>"</c:if><c:if test="${not empty _formAction}"> action="${_formAction}"</c:if><c:if test="${not empty _formMethod}"> method="${_formMethod}"</c:if><c:choose><c:when test="${not empty _formEnctype}"> enctype="${_formEnctype}"</c:when><c:when test="${_formMultipart}"> enctype="multipart/form-data"</c:when><c:when test="${_formUrlencoded}"> enctype="application/x-www-form-urlencoded"</c:when></c:choose><c:if test="${not empty _formAttrs}"> ${_formAttrs}</c:if>><jsp:doBody/></form></c:when><c:otherwise><jsp:doBody/></c:otherwise></c:choose></div>
    <c:if test="${_showLoading}"><div class="overlay <c:if test="${_loadingDarkMode}">dark</c:if>"><i class="fas fa-2x fa-sync-alt fa-spin"></i></div></c:if>
    <c:choose><c:when test="${not empty _footer}"><div class="card-footer">${_footer}</div></c:when><c:otherwise>
        <c:if test="${_showFooterCancelBtn or _showFooterSubmitBtn}"><div class="card-footer">
            <c:if test="${_showFooterSubmitBtn}"><button type="button" class="btn btn-primary" data-widget="card-action-btn" data-card-action="submit">${func:defaultIfBlank(_footerSubmitBtnText, 'Submit')}</button> </c:if>
            <c:if test="${_showFooterCancelBtn}"><button type="button" class="btn btn-secondary" data-widget="card-action-btn"<c:choose><c:when test="${not _useFormBody}"> data-card-action="cancel"</c:when><c:otherwise> data-card-action="reset"</c:otherwise></c:choose>>${func:defaultIfBlank(_footerCancelBtnText, _useFormBody ? 'Reset' : 'Cancel')}</button></c:if>
        </div></c:if>
    </c:otherwise></c:choose>
</div>
