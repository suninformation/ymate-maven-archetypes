<%--
  AdminLTE v3.x Modal.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_static" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_keyboard" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_focus" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_show" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_scrollable" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_large" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_extraLarge" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_title" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_header" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_footer" rtexprvalue="true" type="java.lang.String" %>

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

<%@ attribute name="_showCloseBtn" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_showFooterSubmitBtn" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_footerSubmitBtnText" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_showFooterCancelBtn" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_footerCancelBtnText" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_bodyStyle" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_bodyClass" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_bodyAttrs" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_id" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_style" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_class" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_attrs" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<div <c:if test="${not empty _id}">id="${_id}" </c:if>class="modal<c:if test="${not empty _class}"> ${_class}</c:if>"<c:if test="${_static}"> data-backdrop="static"</c:if> data-keyboard="<c:choose><c:when test="${_keyboard}">true</c:when><c:otherwise>false</c:otherwise></c:choose>" data-show="<c:choose><c:when test="${_show}">true</c:when><c:otherwise>false</c:otherwise></c:choose>" data-focus="<c:choose><c:when test="${_focus}">true</c:when><c:otherwise>false</c:otherwise></c:choose>" tabindex="-1"<c:if test="${not empty _style}"> style="${_style}"</c:if><c:if test="${not empty _attrs}"> ${_attrs}</c:if>>
    <div class="modal-dialog<c:if test="${_scrollable}"> modal-dialog-scrollable</c:if><c:choose><c:when test="${_extraLarge}"> modal-xl</c:when><c:when test="${_large}"> modal-lg</c:when></c:choose>">
        <div class="modal-content">
            <c:if test="${not empty _title or not empty _header}"><div class="modal-header">
                <c:choose><c:when test="${not empty _header}">${_header}</c:when><c:otherwise>
                    <h5 class="modal-title">${_title}</h5>
                    <c:if test="${_showCloseBtn}"><button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button></c:if>
                </c:otherwise></c:choose>
            </div></c:if>
            <div class="modal-body ${_bodyClass}" <c:if test="${not empty _bodyStyle}">style="${_bodyStyle}" </c:if> ${_bodyAttrs}><c:choose><c:when test="${_useFormBody}"><form<c:if test="${not empty _formId}"> id="${_formId}"</c:if><c:if test="${not empty _formClass or _formInline}"> class="${_formClass}<c:if test="${_formInline}"> form-inline</c:if>"</c:if><c:if test="${not empty _formAction}"> action="${_formAction}"</c:if><c:if test="${not empty _formMethod}"> method="${_formMethod}"</c:if><c:choose><c:when test="${not empty _formEnctype}"> enctype="${_formEnctype}"</c:when><c:when test="${_formMultipart}"> enctype="multipart/form-data"</c:when><c:when test="${_formUrlencoded}"> enctype="application/x-www-form-urlencoded"</c:when></c:choose><c:if test="${not empty _formAttrs}"> ${_formAttrs}</c:if>><jsp:doBody/></form></c:when><c:otherwise><jsp:doBody/></c:otherwise></c:choose></div>
            <c:choose><c:when test="${not empty _footer}"><div class="modal-footer">${_footer}</div></c:when><c:otherwise>
                <c:if test="${_showFooterCancelBtn or _showFooterSubmitBtn}"><div class="modal-footer">
                    <c:if test="${_showFooterCancelBtn}"><button type="button" class="btn btn-secondary" data-widget="modal-action-btn"<c:choose><c:when test="${not _useFormBody}"> data-modal-action="cancel" data-dismiss="modal"</c:when><c:otherwise> data-modal-action="reset"</c:otherwise></c:choose>>${func:defaultIfBlank(_footerCancelBtnText, _useFormBody ? 'Reset' : 'Cancel')}</button> </c:if>
                    <c:if test="${_showFooterSubmitBtn}"><button type="button" class="btn btn-primary" data-widget="modal-action-btn" data-modal-action="submit">${func:defaultIfBlank(_footerSubmitBtnText, 'Submit')}</button></c:if>
                </div></c:if>
            </c:otherwise></c:choose>
        </div>
    </div>
</div>