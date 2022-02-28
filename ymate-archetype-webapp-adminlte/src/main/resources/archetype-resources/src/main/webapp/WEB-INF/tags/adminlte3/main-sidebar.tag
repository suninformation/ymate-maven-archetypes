<%--
  AdminLTE v3.x Main Sidebar.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%@ taglib tagdir="/WEB-INF/tags/adminlte3" prefix="adminlte" %>
<%-- Attributes --%>
<%@ attribute name="_brandHref" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_brandImgSrc" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_brandLargeImgSrc" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_brandTitle" rtexprvalue="true" type="java.lang.String" %>

<%-- 自定义区域：必须与 .layout-fixed 并用且与 .text-sm 不兼容 --%>
<%@ attribute name="_customPart" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_showUserPanel" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_username" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_profileHref" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_avatarSrc" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_showSearchPanel" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_searchPlaceholder" rtexprvalue="true" type="java.lang.String" %>

<%@ attribute name="_sidebarNoExpand" rtexprvalue="true" type="java.lang.Boolean" %>

<%@ attribute name="_navFlat" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_navLegacy" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_navCompact" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_navChildIndent" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_navCollapseHideChild" rtexprvalue="true" type="java.lang.Boolean" %>

<%-- Tag Body --%>
<%-- Main Sidebar Container --%>
<aside class="main-sidebar <c:if test="${not empty _customPart}">main-sidebar-custom </c:if>sidebar-dark-primary elevation-4<c:if test="${_sidebarNoExpand}"> sidebar-no-expand</c:if>">
    <%-- Brand Logo --%>
    <adminlte:brand-logo _imgSrc="${_brandImgSrc}" _largeImgSrc="${_brandLargeImgSrc}" _title="${_brandTitle}" _href="${_brandHref}"/>
    <%-- Sidebar --%>
    <div class="sidebar">
        <c:if test="${_showUserPanel}">
            <%-- Sidebar user (optional) --%>
            <adminlte:user-panel _avatarSrc="${_avatarSrc}" _username="${_username}" _profileHref="${_profileHref}"/>
        </c:if>
        <c:if test="${_showSearchPanel}">
            <%-- SidebarSearch Form --%>
            <adminlte:nav-search _inSidebar="true" _placeholder="${func:defaultIfBlank(_searchPlaceholder, '搜索')}"/>
        </c:if>
        <%-- Sidebar Menu --%>
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column<c:if test="${_navFlat}"> nav-flat</c:if><c:if test="${_navLegacy}"> nav-legacy</c:if><c:if test="${_navCompact}"> nav-compact</c:if><c:if test="${_navChildIndent}"> nav-child-indent</c:if><c:if test="${_navCollapseHideChild}"> nav-collapse-hide-child</c:if>" data-widget="treeview" role="menu" data-accordion="false">
                <%-- Add icons to the links using the .nav-icon class with font-awesome or any other icon font library --%>
                <jsp:doBody/>
            </ul>
        </nav>
        <%-- /.sidebar-menu --%>
    </div>
    <%-- /.sidebar --%>
    <c:if test="${not empty _customPart}">
        <div class="sidebar-custom">${_customPart}</div>
        <%-- /.sidebar-custom --%>
    </c:if>
</aside>
