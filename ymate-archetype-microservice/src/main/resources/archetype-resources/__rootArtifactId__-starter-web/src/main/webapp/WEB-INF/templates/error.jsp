#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page import="net.ymate.platform.commons.lang.BlurObject" %>
<%@ page import="net.ymate.platform.webmvc.util.WebUtils" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html>
<html lang="zh" class="md">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width">
    <base href="<%=WebUtils.baseUrl(request)%>"/>
    <title>
        <%
            int ret = BlurObject.bind(request.getAttribute("ret")).toIntValue();
            out.write(ret != 0 ? WebUtils.getOwner().getOwner().getI18n().load("messages", "error.page.title_wrong", "Wrong!") : WebUtils.getOwner().getOwner().getI18n().load("messages", "error.page.title_warn", "Tips!"));
        %>
    </title>
    <link rel="stylesheet" href="assets/error/error.css">
</head>
<%
    out.write("<body><div class=${symbol_escape}"content${symbol_escape}"><div class=${symbol_escape}"icon");
    out.write(ret == 0 ? " icon-warning" : " icon-wrong");
    out.write("${symbol_escape}"></div><h1>");
    Integer status = BlurObject.bind(request.getParameter("_sc")).toInteger();
    if (status != null) {
        out.write(WebUtils.httpStatusI18n(WebUtils.getOwner(), status));
    } else {
        out.write(StringUtils.trimToEmpty(BlurObject.bind(request.getAttribute("msg")).toStringValue()));
        if (ret != 0) {
            out.write(StringUtils.SPACE);
            out.write(WebUtils.getOwner().getOwner().getI18n().load("messages", "error.page.label_code", "Code:"));
            out.write(StringUtils.SPACE);
            out.write(String.valueOf(ret));
        }
    }
    out.write("</h1>");
    //
    String subtitle = BlurObject.bind(request.getAttribute("subtitle")).toStringValue();
    if (StringUtils.isNotBlank(subtitle)) {
        out.write("<p id=${symbol_escape}"subtitle${symbol_escape}">");
        out.write("<span>" + subtitle + "</span>");
        //
        String moreUrl = BlurObject.bind(request.getAttribute("moreUrl")).toStringValue();
        if (StringUtils.isNotBlank(moreUrl)) {
            out.write("<a class=${symbol_escape}"learn-more-button${symbol_escape}" href=${symbol_escape}"" + moreUrl + "${symbol_escape}">" + WebUtils.getOwner().getOwner().getI18n().load("messages", "error.page.btn_more_details", "For more details.") + "</a>");
        }
        out.write("</p>");
    }
    Object data = request.getAttribute("data");
    if (data instanceof Map) {
        if (!((Map) data).isEmpty()) {
            String labelName = WebUtils.getOwner().getOwner().getI18n().load("messages", "error.page.label_details", "Details are as follows:");
            out.write("<div><div class=${symbol_escape}"detail${symbol_escape}"><em>" + labelName + "</em><ul>");
            for (Object item : ((Map) data).values()) {
                out.write("<li>" + BlurObject.bind(item).toStringValue() + "</li>");
            }
            out.write("</ul></div><div class=${symbol_escape}"clearer${symbol_escape}"></div></div>");
        }
    }
    out.write("</div></body></html>");
%>