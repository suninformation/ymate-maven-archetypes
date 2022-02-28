<%--
  AdminLTE v3.x Layout Base.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%-- 设置语言，默认：en --%>
<%@ attribute name="_lang" rtexprvalue="true" type="java.lang.String" %>
<%-- 设置字符集编码，默认：utf-8 --%>
<%@ attribute name="_charset" rtexprvalue="true" type="java.lang.String" %>
<%-- 设置视区，默认：width=device-width, initial-scale=1 --%>
<%@ attribute name="_viewport" rtexprvalue="true" type="java.lang.String" %>
<%-- Body相关配置 --%>
<%@ attribute name="_style" rtexprvalue="true" type="java.lang.String" %>
<%-- _class取值范围：[hold-transition|layout-top-nav|layout-boxed|layout-fixed|layout-navbar-fixed|layout-footer-fixed|sidebar-mini|sidebar-collapse|text-sm] --%>
<%@ attribute name="_class" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_attrs" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_baseHref" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_holdTransition" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_layoutTopNav" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_layoutBoxed" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_layoutFixed" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_layoutNavbarFixed" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_layoutFooterFixed" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_sidebarMini" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_sidebarCollapse" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_textSm" rtexprvalue="true" type="java.lang.Boolean" %>

<%-- Document相关配置 --%>
<%@ attribute name="_htmlClass" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_htmlAttrs" rtexprvalue="true" type="java.lang.String" %>
<%-- Wrapper相关配置 --%>
<%@ attribute name="_nonWrapper" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_wrapperStyle" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_wrapperClass" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_wrapperAttrs" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<!DOCTYPE html>
<html lang="${func:defaultIfBlank(_lang, 'en')}" <c:if test="${not empty _htmlClass}">class="${_htmlClass}" </c:if> ${_htmlAttrs}>
<head>
    <meta charset="${func:defaultIfBlank(_charset, 'utf-8')}">
    <meta name="viewport" content="${func:defaultIfBlank(_viewport, 'width=device-width, initial-scale=1')}">
    @{meta}
    <title>@{page.title}</title>
    <c:if test="${not empty _baseHref}"><base href="${_baseHref}"/></c:if>
    <%-- Google Font: Source Sans Pro --%>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <%-- Font Awesome Icons --%>
    <link rel="stylesheet" href="@{page.path}assets/adminlte3/plugins/fontawesome-free/css/all.min.css">
    <%-- overlayScrollbars --%>
    <link rel="stylesheet" href="@{page.path}assets/adminlte3/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    @{css}
    <%-- Theme style --%>
    <link rel="stylesheet" href="@{page.path}assets/adminlte3/css/adminlte.min.css">
    @{page.styles}
</head>
<body class="<c:if test="${_holdTransition}">hold-transition </c:if><c:if test="${_layoutTopNav}">layout-top-nav </c:if><c:if test="${_layoutBoxed}">layout-boxed </c:if><c:if test="${_layoutFixed}">layout-fixed </c:if><c:if test="${_layoutNavbarFixed}">layout-navbar-fixed </c:if><c:if test="${_layoutFooterFixed}">layout-footer-fixed </c:if><c:if test="${_sidebarMini}">sidebar-mini </c:if><c:if test="${_sidebarCollapse}">sidebar-collapse </c:if><c:if test="${_textSm}">text-sm </c:if> ${_class}" <c:if test="${not empty _style}">style="${_style}" </c:if> ${_attrs}>
<c:choose><c:when test="${!_nonWrapper}"><div class="wrapper ${_wrapperClass}" <c:if test="${not empty _wrapperStyle}">style="${_wrapperStyle}" </c:if> ${_wrapperAttrs}>
    <jsp:doBody/>
</div></c:when><c:otherwise><jsp:doBody/></c:otherwise></c:choose>
<%-- REQUIRED SCRIPTS -->
<%-- jQuery --%>
<script src="@{page.path}assets/adminlte3/plugins/jquery/jquery.min.js"></script>
<%-- jQuery UI --%>
<script src="@{page.path}assets/adminlte3/plugins/jquery-ui/jquery-ui.min.js"></script>
<%-- Bootstrap 4 --%>
<script src="@{page.path}assets/adminlte3/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<%-- overlayScrollbars --%>
<script src="@{page.path}assets/adminlte3/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>
@{script}
<%-- AdminLTE App --%>
<script src="@{page.path}assets/adminlte3/js/adminlte.min.js"></script>
<%--<script src="@{page.path}assets/commons/js/adminlte-demo.js"></script>--%>
@{page.scripts}
</body>
</html>
