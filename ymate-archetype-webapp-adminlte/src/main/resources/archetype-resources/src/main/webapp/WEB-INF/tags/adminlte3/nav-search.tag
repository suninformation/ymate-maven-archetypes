<%--
  AdminLTE v3.x Nav Search.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_placeholder" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_inSidebar" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_inTopNav" rtexprvalue="true" type="java.lang.Boolean" %>

<%-- Tag Body --%>
<c:choose><c:when test="${_inSidebar}">
    <div class="form-inline mt-2">
        <div class="input-group" data-widget="sidebar-search">
            <input class="form-control form-control-sidebar" type="search" placeholder="${func:defaultIfBlank(_placeholder, 'Search')}" aria-label="${func:defaultIfBlank(_placeholder, 'Search')}">
            <div class="input-group-append">
                <button class="btn btn-sidebar">
                    <i class="fas fa-search fa-fw"></i>
                </button>
            </div>
        </div>
    </div>
</c:when><c:when test="${_inTopNav}">
    <form class="form-inline ml-0 ml-md-3">
        <div class="input-group input-group-sm">
            <input class="form-control form-control-navbar" type="search" placeholder="${func:defaultIfBlank(_placeholder, 'Search')}" aria-label="${func:defaultIfBlank(_placeholder, 'Search')}">
            <div class="input-group-append">
                <button class="btn btn-navbar" type="submit">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
    </form>
</c:when><c:otherwise>
    <li class="nav-item">
        <a class="nav-link" data-widget="navbar-search" data-target="#main-header-search" href="#" role="button">
            <i class="fas fa-search"></i>
        </a>
        <div class="navbar-search-block" id="main-header-search">
            <form class="form-inline">
                <div class="input-group input-group-sm">
                    <input class="form-control form-control-navbar" type="search" placeholder="${func:defaultIfBlank(_placeholder, 'Search')}" aria-label="${func:defaultIfBlank(_placeholder, 'Search')}">
                    <div class="input-group-append">
                        <button class="btn btn-navbar" type="submit">
                            <i class="fas fa-search"></i>
                        </button>
                        <button class="btn btn-navbar" type="button" data-widget="navbar-search">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </li>
</c:otherwise></c:choose>