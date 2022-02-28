<%--
  AdminLTE v3.x Navbar-Nav.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%-- PushMenu开关状态，默认：false --%>
<%@ attribute name="_id" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_right" rtexprvalue="true" type="java.lang.Boolean" %>
<%@ attribute name="_inTopNav" rtexprvalue="true" type="java.lang.Boolean" %>

<%-- Tag Body --%>
<ul <c:if test="${not empty _id}">id="${_id}" </c:if>class="navbar-nav <c:if test="${_right}"><c:if test="${_inTopNav}">order-1 order-md-3 navbar-no-expand</c:if> ml-auto</c:if>">
    <jsp:doBody/>
</ul>