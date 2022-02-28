<%--
  AdminLTE v3.x Main Content.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_title" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_subtitle" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_breadcrumbPart" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_inTopNav" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_showBackToTop" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_iframeMode" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_iframeI18nClose" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_iframeI18nCloseAll" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_iframeI18nCloseAllOther" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_iframeI18nTabEmpty" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_iframeI18nTabLoading" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_style" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_class" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_attrs" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<c:choose><c:when test="${_iframeMode}">
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper iframe-mode" data-widget="iframe" data-loading-screen="750">
        <div class="nav navbar navbar-expand navbar-white navbar-light border-bottom p-0">
            <div class="nav-item dropdown">
                <a class="nav-link bg-danger dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">${func:defaultIfBlank(_iframeI18nClose, 'Close')}</a>
                <div class="dropdown-menu mt-0">
                    <a class="dropdown-item" href="#" data-widget="iframe-close" data-type="all">${func:defaultIfBlank(_iframeI18nCloseAll, 'Close All')}</a>
                    <a class="dropdown-item" href="#" data-widget="iframe-close" data-type="all-other">${func:defaultIfBlank(_iframeI18nCloseAllOther, 'Close All Other')}</a>
                </div>
            </div>
            <a class="nav-link bg-light" href="#" data-widget="iframe-scrollleft"><i class="fas fa-angle-double-left"></i></a>
            <ul class="navbar-nav overflow-hidden" role="tablist"></ul>
            <a class="nav-link bg-light" href="#" data-widget="iframe-scrollright"><i class="fas fa-angle-double-right"></i></a>
            <a class="nav-link bg-light" href="#" data-widget="iframe-fullscreen"><i class="fas fa-expand"></i></a>
        </div>
        <div class="tab-content">
            <div class="tab-empty">
                <h2 class="display-4">${func:defaultIfBlank(_iframeI18nTabEmpty, 'No tab selected!')}</h2>
            </div>
            <div class="tab-loading">
                <div>
                    <h2 class="display-4">${func:defaultIfBlank(_iframeI18nTabLoading, 'Tab is loading')} <i class="fa fa-sync fa-spin"></i></h2>
                </div>
            </div>
        </div>
    </div>
</c:when><c:otherwise>
    <c:choose><c:when test="${_inTopNav}">
        <div class="content-wrapper">
            <div class="content-header">
                <div class="container">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1 class="m-0"><c:out value="${_title} "/><c:if test="${not empty _subtitle}"><small class="text-muted">${_subtitle}</small></c:if></h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">${_breadcrumbPart}</ol>
                        </div>
                    </div>
                </div>
            </div>
            <div class="content">
                <div class="container">
                    <jsp:doBody/>
                </div>
            </div>
            <c:if test="${_showBackToTop}"><a id="back-to-top" href="#" class="btn btn-primary back-to-top" role="button" aria-label="Scroll to top"><i class="fas fa-chevron-up"></i></a></c:if>
        </div>
    </c:when><c:otherwise>
        <div class="content-wrapper">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1 class="m-0"><c:out value="${_title} "/><c:if test="${not empty _subtitle}"><small class="text-muted">${_subtitle}</small></c:if></h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">${_breadcrumbPart}</ol>
                        </div>
                    </div>
                </div>
            </section>
            <section class="content">
                <div class="container-fluid">
                    <jsp:doBody/>
                </div>
            </section>
            <c:if test="${_showBackToTop}"><a id="back-to-top" href="#" class="btn btn-primary back-to-top" role="button" aria-label="Scroll to top"><i class="fas fa-chevron-up"></i></a></c:if>
        </div>
    </c:otherwise></c:choose>
</c:otherwise></c:choose>
