<%--
  AdminLTE v3.x Preloader.
--%>
<%@ tag language="java" pageEncoding="UTF-8" body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.ymate.net/ymweb_fn" prefix="func" %>
<%-- Attributes --%>
<%@ attribute name="_imgSrc" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_imgAlt" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_imgWidth" rtexprvalue="true" type="java.lang.String" %>
<%@ attribute name="_imgHeight" rtexprvalue="true" type="java.lang.String" %>

<%-- Tag Body --%>
<div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="@{page.path}${func:defaultIfBlank(_imgSrc, 'assets/adminlte3/img/AdminLTELogo.png')}" alt="${func:defaultIfBlank(_imgAlt, 'AdminLTE Logo')}" height="${func:defaultIfBlank(_imgHeight, '60')}" width="${func:defaultIfBlank(_imgWidth, '60')}">
</div>
