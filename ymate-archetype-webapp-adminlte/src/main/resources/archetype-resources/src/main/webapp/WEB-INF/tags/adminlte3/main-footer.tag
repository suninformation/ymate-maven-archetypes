<%--
  AdminLTE v3.x Main Footer.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="scriptless" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_core" prefix="ymweb" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>

<%-- Attributes --%>
<%@ attribute name="_version" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_copyright" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<footer class="main-footer">
    <div class="float-right d-none d-sm-block">
        <c:choose><c:when test="${not empty _version}">${_version}</c:when><c:otherwise><b>Version</b> 3.2.0</c:otherwise></c:choose>
    </div>
    <c:choose><c:when test="${not empty _copyright}">${_copyright}</c:when><c:otherwise><strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong> All rights reserved.</c:otherwise></c:choose>
</footer>
