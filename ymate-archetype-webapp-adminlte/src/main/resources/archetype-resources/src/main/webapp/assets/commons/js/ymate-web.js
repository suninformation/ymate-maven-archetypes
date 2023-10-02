/*
 * Copyright 2007-2022 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
;(function ($) {

    "use strict";

    /**
     * Ajax 请求结果通用错误处理
     *
     * @param result 响应结果对象
     * @param messageShow 消息提示组件对象
     * @param callback 响应结果无错误时的回调接口
     * @param template 自定义字符串模版
     * @private
     */
    function __parseResultErrorMsg(result, messageShow, callback, template) {
        if (result) {
            if (result.ret !== 0) {
                if (!template) {
                    template = "{0}<br/>";
                }
                var _messages = "";
                if (result.ret === -1 && result.data) {
                    $.each(result.data, function (item) {
                        _messages = __format(template, result.data[item]);
                    });
                } else {
                    _messages = result.msg;
                }
                if (_messages) {
                    if (messageShow) {
                        messageShow.show(_messages);
                    } else {
                        console.log(_messages);
                    }
                }
                if (callback && callback instanceof Function) {
                    callback(result);
                }
            } else if (callback && callback instanceof Function) {
                callback(result);
            }
        }
    }

    /**
     * 字符串模板参数替换
     *
     * @param str 模板字符串
     * @param text 替换参数
     * @returns {*}
     * @private
     */
    window.__format = function (str, text) {
        var args = arguments;
        return str.replace(/{(\d+)}/g, function (m, i) {
            return args[parseInt(i) + 1];
        });
    }

    /**
     * 请求统一发送方法
     *
     * @param options
     */
    $.requestSender = function (options) {

        var defaults = {
            url: "",
            type: "POST",
            global: false,
            accepts: null,
            async: null,
            cache: null,
            timeout: 0,
            data: null,
            traditional: true, // 防止深度序列化
            processData: null,
            contentType: null,
            dataType: "json",
            dataFilter: null,
            headers: null,
            mimeType: null,
            password: null,
            xhrFields: null,
            jsonp: null,
            jsonpCallback: null,
            beforeSend: null,
            complete: null,
            success: null,
            error: null,
            scriptCharset: null,
            statusCode: null
            // statusCode: {
            //     404: function () {
            //         console.debug("404 Page Not Found.");
            //     }
            // }
        };

        var opts = {};

        $.each($.extend({}, defaults, options), function (name, value) {
            if (value) {
                opts[name] = value;
            }
        });

        opts.beforeSend = function (XMLHttpRequest) {
            console.debug("__beforeSend:" + opts.url);
            return options.beforeSend ? options.beforeSend(XMLHttpRequest) : true;
        }

        opts.complete = function (XMLHttpRequest, textStatus) {
            console.debug("__complete:" + opts.url + ", status:" + textStatus);
            if (options.complete) {
                options.complete(XMLHttpRequest, textStatus);
            }
        }

        opts.success = function (data, textStatus, jqXHR) {
            console.debug("__success:" + opts.url + ", status:" + textStatus);
            if (options.success) {
                options.success(data, textStatus, jqXHR);
            }
        }

        opts.error = function (XMLHttpRequest, textStatus, errorThrown) {
            console.debug("__error:" + opts.url + ", status:" + textStatus + ", errorThrown:" + errorThrown);
            if (XMLHttpRequest['responseJSON'] && options.success) {
                options.success(XMLHttpRequest['responseJSON'], textStatus, XMLHttpRequest);
            } else if (options.error) {
                options.error(XMLHttpRequest, textStatus, errorThrown);
            } else {
                __commonsAjaxError(XMLHttpRequest, textStatus, errorThrown);
            }
        }

        $.ajax(opts);
    };

    /**
     * 消息提示组件
     *
     * @param options
     * @returns {{show: __show, clean: __clean}}
     */
    $.fn.messageShow = function (options) {

        var defaults = {
            // 消息模板
            tmpl: "<div class=\" alert alert-{%=(o.style ? o.style : 'danger')%} alert-dismissable\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\"><span aria-hidden=\"true\">&times;</span><span class=\"sr-only\">Close</span></button>{% print(o.message, true);%}</div>",
            // 初始时默认显示文本
            defaultText: ""
        };

        var opts = $.extend({}, defaults, options);

        var __target = $(this);

        if (!opts.defaultText) {
            opts.defaultText = __target.attr("data-message-show");
        }
        __clean();

        /**
         * 显示消息
         *
         * @param msg 消息内容
         * @param style 样式, 默认danger, 可选:[danger|warning|info|success|primary]
         * @private
         */
        function __show(msg, style) {
            var _msg = {
                message: msg
            };
            if (style) {
                _msg.style = style;
            }
            __target.empty();
            __target.html(tmpl(opts.tmpl, _msg));
        }

        function __clean() {
            __target.empty();
            if (opts.defaultText) {
                __show(opts.defaultText, "warning");
            }
        }

        return {
            show: __show,
            clean: __clean
        }
    };

    /**
     * 图形验证码组件
     *
     * @param options
     * @returns {{isEnabled: *, refresh: __refreshImg, clean: __clean, enabled: __enabled}}
     */
    $.fn.captcha = function (options) {

        var defaults = {
            // 图片请求URL地址
            url: "captcha",
            // 验证码文本域Id或对象
            captchaField: 'input[name="captcha"]',
            // 创建时是否请求图片
            refresh: true,
            // 是否禁用
            disabled: false,
            // 验证码图片按钮Id或对象
            captchaBtn: "#_captchaImg",
            // 用于存放验证码HTML段的模板Id
            templateId: "_captcha_template",
            // 用于放置HTML的标签容器Id
            container: "#_captcha_container"
        };

        var opts = $.extend({}, defaults, options);

        var __target = $(this);

        var __flag = false;

        if (!opts.disabled) {
            if (opts.container && opts.captchaBtn) {
                __enabled();
            }
            //
            __target.on("click", __refreshImg);

            if (opts.refresh) {
                __refreshImg();
            }
        }

        function __refreshImg() {
            if (!opts.disabled) {
                var _v = "_v=" + Date.now();
                if (opts.url.indexOf("?") > 0) {
                    _v = "&" + _v;
                } else {
                    _v = "?" + _v;
                }
                __target.attr("src", opts.url + _v);
            }
        }

        function __clean() {
            if (!opts.disabled) {
                if (opts.captchaField) {
                    $(opts.captchaField).val('');
                }
            }
        }

        function __enabled() {
            if (!__flag && opts.templateId && opts.container) {
                opts.disabled = false;
                __flag = true;
                //
                var _content = tmpl(opts.templateId, {});
                $(opts.container).append(_content);
                //
                __target = $(opts.captchaBtn).on("click", __refreshImg);
                //
                if (opts.refresh) {
                    __refreshImg();
                }
            }
        }

        function __isEnabled() {
            return !opts.disabled;
        }

        return {
            refresh: __refreshImg,
            clean: __clean,
            enabled: __enabled,
            isEnabled: __isEnabled()
        }
    };

    /**
     * 短信或邮件验证码发送组件
     *
     * @param options
     * @returns {{captchaType: (string|*)}}
     */
    $.fn.captchaSender = function (options) {

        var defaults = {
            // 验证码类型：auto|sms|mail
            type: "auto",
            // 自定义动作标识
            action: null,
            // 验证码作用域
            scope: null,
            // 图片验证码请求URL地址
            captcha_url: "captcha",
            // 手机号码或邮件地址文本域ID或对象
            targetField: null,
            // 消息提示组件
            messageShow: null,
            // 重发等待时间(秒)
            timeout: 120,
            // 等待提示语
            showText: "{0}秒后重发",
            // 手机号码或邮件地址格式错误时的提示信息
            formatErrorMsg: "数据格式不正确",
            // 请求发送异常时的提示信息
            errorMsg: "验证码发送失败，请稍后重试",
            // 请求发送成功时的提示信息
            successMsg: "验证码已发送，请注意查收",
            // 回调方法, 格式: {error: function(...){...}, success:function(...){...}}
            callback: null
        };

        var opts = $.extend({}, defaults, options);

        var __timer;

        var __targetBtn = $(this);

        // 按钮原始文本内容
        var __btnOriginalText = __targetBtn.text();

        var __targetField = opts.targetField ? $(opts.targetField) : null;

        if (__targetField && opts.messageShow) {
            __targetBtn.on("click", __send).prop({disabled: !__checkTarget()});
            __targetField.on("input", function (e) {
                __targetBtn.prop({disabled: !__checkTarget()});
            })
        } else {
            console.debug("CaptchaSender initialization failed.")
        }

        $("#_captcha_modal_container").append(tmpl("_captcha_modal_template", {
            "type": opts.type,
            "action": opts.action
        }));

        var __messageShow = $('#_sendCaptchaMessage').messageShow();

        var __modal = $("#_sendCaptchaModal").modal({keyboard: false, backdrop: "static", show: false});

        var __captcha = $('#_captchaSendImg').captcha({
            url: opts.captcha_url,
            captchaField: '#_captcha_send_field',
            captchaBtn: "#_captchaSendImg",
            templateId: "_captcha_send_template",
            container: "#_send_captcha_container"
        });

        var __captchaField = $("#_captcha_send_field");

        __modal.on("shown.bs.modal", function (e) {
            __messageShow.clean();
            __captcha.clean();
            __captcha.refresh();
            __captchaField.focus();
        });

        var __captchaType = opts.type === "auto" ? null : opts.type;

        function __checkTarget() {
            var _targetValue = __targetField.val();
            if (_targetValue) {
                var _sms = /^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(17[0-9])|(18[0-9]))\d{8}$/.test(_targetValue);
                var _mail = /^\w[-._\w]*\w@\w[-._\w]*\w\.\w{2,8}$/.test(_targetValue);
                if (opts.type === "auto") {
                    if (_sms) {
                        __captchaType = "sms";
                        return true;
                    } else if (_mail) {
                        __captchaType = "mail";
                        return true;
                    }
                } else if (opts.type === "sms") {
                    return _sms;
                } else if (opts.type === "mail") {
                    return _mail;
                }
            }
            return false;
        }

        function __reset() {
            if (__timer) {
                window.clearInterval(__timer);
                __targetBtn.text(__btnOriginalText).prop({disabled: !__checkTarget()});
            }
        }

        function __send() {
            if (!__checkTarget()) {
                opts.messageShow.show(opts.formatErrorMsg);
            } else {
                __modal.modal("show");
                //
                var _form = $("#_sendCaptchaForm");
                if (_form) {
                    _form[0].reset();
                    _form.validator({
                        delay: 500,
                        html: true,
                        disable: false,
                        focus: true
                    }).on("submit", function (e) {
                        if (!e.isDefaultPrevented()) {
                            e.preventDefault();
                            //
                            __targetBtn.prop({disabled: true});
                            //
                            var __time = opts.timeout ? opts.timeout : 120;
                            __timer = window.setInterval(function () {
                                __targetBtn.text(__format(opts.showText, __time));
                                if (__time < 1) {
                                    __reset();
                                }
                                __time--;
                            }, 1000);
                            //
                            var _data = {};
                            _data.captcha = __captchaField.val();
                            if (opts.action) {
                                _data.action = opts.action;
                            }
                            if (opts.scope) {
                                _data.scope = opts.scope;
                            }
                            if (__captchaType === "sms") {
                                _data.mobile = __targetField.val();
                            } else if (__captchaType === "mail") {
                                _data.email = __targetField.val();
                            }
                            //
                            $.requestSender({
                                url: __format(_form.attr('action'), __captchaType),
                                data: _data,
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    __reset();
                                    if (opts.callback && opts.callback.error && opts.callback.error instanceof Function) {
                                        opts.callback.error(XMLHttpRequest, textStatus, errorThrown)
                                    } else if (opts.errorMsg) {
                                        __messageShow.show(opts.errorMsg);
                                    }
                                },
                                success: function (result, textStatus, jqXHR) {
                                    if (result) {
                                        if (result.ret !== 0) {
                                            __reset();
                                            if (result.ret === -50 || result.ret === -6) {
                                                if (opts.errorMsg) {
                                                    __messageShow.show(opts.errorMsg);
                                                }
                                            } else if (opts.callback && opts.callback.success && opts.callback.success instanceof Function) {
                                                opts.callback.success(result, textStatus, jqXHR)
                                            } else {
                                                __parseResultErrorMsg(result, __messageShow);
                                            }
                                            __captcha.clean();
                                            __captcha.refresh();
                                        } else if (opts.successMsg) {
                                            __modal.modal("hide");
                                            opts.messageShow.show(opts.successMsg, "info");
                                        }
                                    }
                                }
                            });
                        }
                    });
                }
            }
        }

        return {
            getCaptchaType: function () {
                return __captchaType;
            }
        }
    };

    /**
     * 表单处理器
     *
     * @param options
     * @returns {{getForm: (function(): *|jQuery|HTMLElement), getMessageShow: (function(): null), reset: __reset, getFormData: (function(): *), getOptions: (function(): *), getValidate: (function(): *)}}
     */
    $.fn.submitter = function (options) {

        var defaults = {
            /*
            // 消息提示组件
            messageShow: null,
            action: '',
            method: '',
            timeout: 0,
            validator: {
                delay: 500,
                html: true,
                disable: false,
                focus: true
                // feedback: {
                //     success: 'glyphicon-ok',
                //     error: 'glyphicon-remove'
                // },
                // custom: {
                //     equals: function ($el) {
                //         var matchValue = $el.data("equals"); // foo
                //         if ($el.val() !== matchValue) {
                //             return "Hey, that's not valid! It's gotta be " + matchValue;
                //         }
                //     }
                // }
            },
            validation: {
                enabled: false,
                rules: {},
                messages: {}
            },
            beforeSubmit: function (requestOpts, data) {
            },
            afterSubmit: function (textStatus, data) {
            },
            onError: function (XMLHttpRequest, textStatus, errorThrown) {
            },
            onSuccess: function (data, textStatus, jqXHR) {
            }
            */
        };

        var opts = $.extend({}, defaults, options);

        var __form = $(this);
        var __formValidate;
        if (__form.validate && opts.validation && opts.validation.enabled) {
            var validationOpts = {
                errorElement: 'span',
                errorPlacement: function (error, element) {
                    error.addClass('invalid-feedback');
                    element.closest('.form-group').append(error);
                },
                highlight: function (element, errorClass, validClass) {
                    $(element).addClass('is-invalid');
                },
                unhighlight: function (element, errorClass, validClass) {
                    $(element).removeClass('is-invalid');
                }
            };
            __formValidate = __form.validate($.extend({}, validationOpts, opts.validation));
        } else if (opts.validator) {
            __form.validator(opts.validator).on("submit", __onSubmit);
        } else {
            __form.on("submit", __onSubmit);
        }

        function __onSubmit(e) {
            if (!e.isDefaultPrevented()) {
                e.preventDefault();
                //
                if (__formValidate && !__formValidate.valid()) {
                    return;
                }
                //
                if (opts.messageShow) {
                    opts.messageShow.clean();
                }
                //
                var _requestOpts = {
                    url: opts.action || __form.attr("action"),
                    type: opts.method || __form.attr("method"),
                    timeout: opts.timeout,
                };
                var _data = __getFormData();
                if (opts.beforeSubmit && opts.beforeSubmit instanceof Function) {
                    opts.beforeSubmit(_requestOpts, _data);
                }
                _requestOpts = $.extend({}, _requestOpts, {
                    data: _data,
                    success: function (data, textStatus, jqXHR) {
                        __parseResultErrorMsg(data, opts.messageShow, function () {
                            if (opts.onSuccess && opts.onSuccess instanceof Function) {
                                opts.onSuccess(data, textStatus, jqXHR);
                            }
                        });
                        if (opts.afterSubmit && opts.afterSubmit instanceof Function) {
                            opts.afterSubmit(textStatus, data, jqXHR);
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        if (opts.onError && opts.onError instanceof Function) {
                            opts.onError(XMLHttpRequest, textStatus, errorThrown);
                        } else {
                            __commonsAjaxError(XMLHttpRequest, textStatus, errorThrown);
                        }
                        if (opts.afterSubmit && opts.afterSubmit instanceof Function) {
                            opts.afterSubmit(textStatus, errorThrown);
                        }
                    }
                });
                $.requestSender(_requestOpts);
            }
        }

        function __getOptions() {
            return opts;
        }

        function __getFrom() {
            return __form;
        }

        function __getFormData() {
            return __form.serializeJSON();
        }

        function __getMessageShow() {
            return opts.messageShow;
        }

        function __reset() {
            if (__form[0]) {
                __form[0].reset();
            }
            if (__formValidate) {
                __formValidate.resetForm();
            }
            if (opts.messageShow) {
                opts.messageShow.clean();
            }
        }

        function __getValidate() {
            return __formValidate;
        }

        return {
            getOptions: __getOptions,
            getForm: __getFrom,
            getFormData: __getFormData,
            getMessageShow: __getMessageShow,
            reset: __reset,
            getValidate: __getValidate
        }
    };

    /**
     * 日期范围选择器封装
     *
     * @param options
     * @returns {{getDataRangePacker: (function(): jQuery)}}
     */
    $.fn.dateRangeWrapper = function (options) {

        var defaults = {
            "singleDatePicker": false,
            "showDropdowns": false,
            "showWeekNumbers": true,
            "showISOWeekNumbers": true,
            "timePicker": false,
            "timePicker24Hour": true,
            "timePickerSeconds": true,
            "autoApply": false,
            "maxSpan": {
                "days": 365
            },
            "ranges": {
                "今天": [moment(), moment()],
                "昨天": [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                "近7天": [moment().subtract(6, 'days'), moment()],
                "近30天": [moment().subtract(29, 'days'), moment()],
                "本月": [moment().startOf('month'), moment().endOf('month')],
                "上个月": [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
            },
            "locale": {
                "format": "YYYY-MM-DD",
                "separator": " / ",
                "applyLabel": "应用",
                "cancelLabel": "取消",
                "fromLabel": "从",
                "toLabel": "到",
                "customRangeLabel": "自定义",
                "weekLabel": "周",
                "daysOfWeek": [
                    "日",
                    "一",
                    "二",
                    "三",
                    "四",
                    "五",
                    "六"
                ],
                "monthNames": [
                    "一月",
                    "二月",
                    "三月",
                    "四月",
                    "五月",
                    "六月",
                    "七月",
                    "八月",
                    "九月",
                    "十月",
                    "十一月",
                    "十二月"
                ],
                "firstDay": 1
            },
            "autoUpdateInput": false,
            "alwaysShowCalendars": true,
            "startDate": moment().startOf('month'),
            "endDate": moment().endOf('month'),
            "opens": "center"
        };

        var opts = $.extend({}, defaults, options);

        var __dateRangePicker = $(this).daterangepicker(opts, function (start, end, label) {
            console.log('New date range selected: ' + start.format(opts.locale.format) + ' to ' + end.format(opts.locale.format) + ' (predefined range: ' + label + ')');
        });
        if (!opts.autoUpdateInput) {
            __dateRangePicker.on('apply.daterangepicker', function (ev, picker) {
                $(this).val(picker.startDate.format(opts.locale.format) + opts.locale.separator + picker.endDate.format(opts.locale.format));
            });
            __dateRangePicker.on('cancel.daterangepicker', function (ev, picker) {
                $(this).val('');
            });
        }

        return {
            get: function () {
                return __dateRangePicker;
            }
        }
    };

    /**
     * 表单包装器
     *
     * @param options
     * @returns {{submit: __submit, getForm: (function(): *|jQuery|HTMLElement), getMessageShow: (function(): *), setFormData: __setFormData, reset: __reset, getFormData: (function(): *), getOptions: (function(): *), getFormSubmitter: (function(): {getForm: (function(): (*|Window.jQuery)), getMessageShow: (function(): *), reset: __reset, getFormData: (function(): *), getOptions: (function(): *), validate: __validate}|jQuery)}}
     */
    $.fn.formWrapper = function (options) {

        var defaults = {
            /*
            action: '',
            method: '',
            timeout: 0,
            validation: {
                enabled: false,
                rules: {},
                messages: {}
            },
            beforeSubmit: function (formWrapper, requestOpts, data) {
            },
            afterSubmit: function (formWrapper, textStatus, data) {
            },
            onReset: function (formEl, formSubmitter) {
            },
            onError: function (formWrapper, XMLHttpRequest, textStatus, errorThrown) {
            },
            onSuccess: function (formWrapper, data, textStatus, jqXHR) {
            }
            */
        };

        var opts = $.extend({}, defaults, options);

        var __formWrapperInst = {
            getOptions: __getOptions,
            getForm: __getForm,
            getFormData: __getFormData,
            setFormData: __setFormData,
            submit: __submit,
            reset: __reset,
            getFormSubmitter: __getFormSubmitter,
            getMessageShow: __getMessageShow
        };

        var __formEl = $(this);
        var __messageShow, __messageShowEl = $('.messageShow', __formEl);
        if (__messageShowEl.length > 0) {
            __messageShow = __messageShowEl.messageShow();
        }
        var __defaultFormValues = __formEl.serializeJSON();
        var __formSubmitBtn = $('button[type="submit"]', __formEl);
        var __formSubmitter = __formEl.submitter({
            messageShow: __messageShow,
            action: opts.action,
            method: opts.method,
            timeout: opts.timeout,
            validation: opts.validation,
            beforeSubmit: function (requestOpts, data) {
                if (opts.beforeSubmit) {
                    opts.beforeSubmit(__formWrapperInst, requestOpts, data);
                }
            },
            afterSubmit: function (textStatus, data) {
                if (opts.afterSubmit) {
                    opts.afterSubmit(__formWrapperInst, data);
                }
            },
            onError: function (XMLHttpRequest, textStatus, errorThrown) {
                if (opts.onError) {
                    opts.onError(__formWrapperInst, XMLHttpRequest, textStatus, errorThrown);
                } else {
                    __commonsAjaxError.call(__formWrapperInst, XMLHttpRequest, textStatus, errorThrown);
                }
            },
            onSuccess: function (data, textStatus, jqXHR) {
                if (opts.onSuccess) {
                    opts.onSuccess(__formWrapperInst, data, textStatus, jqXHR);
                }
            }
        });
        // var __formResetBtn = $('button[type="reset"]', __formEl);

        /* 若直接将自定义重置处理逻辑与Reset按钮绑定会造成表单清空的问题，请手动调用formWrapper的reset方法
        if (__formResetBtn.length > 0) {
            __formResetBtn.on('click', function (e) {
                if (!e.isDefaultPrevented()) {
                    e.preventDefault();
                    __reset();
                }
            });
        }
        */

        function __getOptions() {
            return opts;
        }

        function __getForm() {
            return __formEl;
        }

        function __getFormData() {
            return __formSubmitter.getFormData();
        }

        function __setFormData(formData, excludeKeys) {
            if (formData) {
                $.each(formData, function (key, value) {
                    var excluded = false;
                    if (excludeKeys) {
                        if (excludeKeys instanceof Array) {
                            $.each(value, function (_, item) {
                                if (key === item) {
                                    excluded = true;
                                    return false;
                                }
                            });
                        } else {
                            excluded = key === excludeKeys;
                        }
                    }
                    if (!excluded) {
                        var _formField = __formEl.find('[name=' + key + ']');
                        if ($.type(_formField[0]) !== "undefined") {
                            var _fieldTagName = _formField[0].tagName.toLowerCase();
                            if (_fieldTagName === "input") {
                                if (_formField.attr("type") === "radio") {
                                    $('input:radio[name="' + key + '"]', __formEl).attr("checked", false);
                                    $('input:radio[name="' + key + '"][value="' + value + '"]', __formEl).attr("checked", true);
                                } else if (_formField.attr("type") === "checkbox") {
                                    $('input:checkbox[name="' + key + '"]', __formEl).attr("checked", false);
                                    if (value instanceof Array) {
                                        $.each(value, function (idx, item) {
                                            $('input:checkbox[name="' + key + '"][value="' + item + '"]', __formEl).attr("checked", true);
                                        });
                                    } else {
                                        $('input:checkbox[name="' + key + '"][value="' + value + '"]', __formEl).attr("checked", true);
                                    }
                                } else {
                                    _formField.attr('value', value);
                                }
                            } else if (_fieldTagName === "select") {
                                _formField.find("option").attr("selected", false);
                                _formField.find("option[value='" + value + "']").attr("selected", true);
                                //
                                $('.select2', __formEl).trigger('change');
                            } else if (_fieldTagName === "textarea") {
                                if (_formField.summernote && _formField.hasClass("summernote")) {
                                    _formField.summernote('code', value);
                                } else {
                                    _formField.text(value);
                                }
                            } else {
                                console.warn("Failure to assign value to: ", key, value);
                            }
                        }
                    }
                });
            }
        }

        function __submit() {
            if (__formSubmitBtn && __formSubmitBtn.length > 0) {
                __formSubmitBtn.trigger('click');
            } else {
                __formEl.submit();
            }
        }

        function __reset() {
            //
            __setFormData(__defaultFormValues);
            //
            __formSubmitter.reset();
            //
            $('.select2', __formEl).trigger('change');
            //
            if (opts.onReset) {
                opts.onReset(__formEl, __formSubmitter);
            }
        }

        function __getFormSubmitter() {
            return __formSubmitter;
        }

        function __getMessageShow() {
            return __messageShow;
        }

        return __formWrapperInst;
    };

    function __processActions(actions, actionName) {
        var _actionFunc = actions && actions[actionName];
        if (!_actionFunc) {
            if (actionName === 'submit') {
                _actionFunc = function () {
                    this.getFormWrapper().submit();
                }
            } else if (actionName === 'reset') {
                _actionFunc = function () {
                    this.getFormWrapper().reset();
                }
            }
        }
        return _actionFunc;
    }

    /**
     * 模态对话框包装器
     *
     * @param options
     * @returns {{getFormWrapper: (function(): null), hide: __hide, getModal: (function(): *|jQuery), show: __show, setTitle: __setTitle}}
     */
    $.fn.modalWrapper = function (options) {

        var defaults = {
            configs: {
                backdrop: 'static',
                keyboard: false,
                focus: true,
                show: false
            },
            /*
            form: {
                enabled: false,
                action: '',
                method: '',
                timeout: 0,
                validation: {
                    enabled: false,
                    rules: {},
                    messages: {}
                },
                beforeSubmit: function (formWrapper, requestOpts, data) {
                },
                afterSubmit: function (formWrapper, textStatus, data) {
                },
                onReset: function (formEl, formSubmitter) {
                },
                onError: function (formWrapper, XMLHttpRequest, textStatus, errorThrown) {
                },
                onSuccess: function (formWrapper, data, textStatus, jqXHR) {
                }
            },
            actions: {
                demo: function () {
                }
            },
            onShow: function (event) {
            },
            onHide: function (event) {
            }
            */
        };

        var opts = $.extend({}, defaults, options);

        var __modal = $(this).modal(opts.configs);
        // 为了解决select2组件筛选框无法输入的问题!
        __modal.removeAttr("tabindex", "-1");

        var __modalWrapperInst = {
            setTitle: __setTitle,
            setBodyContent: __setBodyContent,
            getModal: __getModal,
            getFormWrapper: __getFormWrapper,
            show: __show,
            hide: __hide
        }

        if (opts.onShow) {
            __modal.on('show.bs.modal', function (event) {
                opts.onShow.call(__modalWrapperInst, event);
            });
        }
        if (opts.onHide) {
            __modal.on('hidden.bs.modal', function (event) {
                opts.onHide.call(__modalWrapperInst, event);
            });
        }

        var __formWrapper = null;
        if (opts.form && opts.form.enabled) {
            var _formEl = $('form', __modal);
            if (_formEl.length > 0) {
                __formWrapper = _formEl.formWrapper({
                    action: opts.form.action,
                    method: opts.form.method,
                    timeout: opts.form.timeout,
                    validation: opts.form.validation,
                    beforeSubmit: function (formWrapper, requestOpts, data) {
                        if (opts.form.beforeSubmit) {
                            opts.form.beforeSubmit.call(__modalWrapperInst, formWrapper, requestOpts, data);
                        }
                    },
                    afterSubmit: function (formWrapper, textStatus, data) {
                        if (opts.form.afterSubmit) {
                            opts.form.afterSubmit.call(__modalWrapperInst, formWrapper, textStatus, data);
                        }
                    },
                    onReset: function (formEl, formSubmitter) {
                        if (opts.form.onReset) {
                            opts.form.onReset.call(__modalWrapperInst, formEl, formSubmitter);
                        }
                    },
                    onError: function (formWrapper, XMLHttpRequest, textStatus, errorThrown) {
                        if (opts.form.onError) {
                            opts.form.onError.call(__modalWrapperInst, formWrapper, XMLHttpRequest, textStatus, errorThrown);
                        } else {
                            __commonsAjaxError.call(__modalWrapperInst, XMLHttpRequest, textStatus, errorThrown);
                        }
                    },
                    onSuccess: function (formWrapper, data, textStatus, jqXHR) {
                        if (opts.form.onSuccess) {
                            opts.form.onSuccess.call(__modalWrapperInst, formWrapper, data, textStatus, jqXHR);
                        }
                    }
                });
            }
        }

        $('[data-widget="modal-action-btn"]', __modal).each(function () {
            var _actionBtn = $(this);
            var _actionFuncName = _actionBtn.attr('data-modal-action');
            if (_actionFuncName) {
                var _actionFunc = __processActions(opts.actions, _actionFuncName);
                if (_actionFunc && _actionFunc instanceof Function) {
                    _actionBtn.on('click', function () {
                        _actionFunc.call(__modalWrapperInst);
                    });
                }
            }
        });

        function __setTitle(title) {
            var _modalEl = $('.modal-title', __modal);
            if (_modalEl && _mdalEl.length > 0) {
                _modalEl.html(title);
            }
        }

        function __setBodyContent(content) {
            var _bodyEl = $('.modal-body', __modal);
            if (_bodyEl && _bodyEl.length > 0) {
                _bodyEl.html(content);
            }
        }

        function __getModal() {
            return __modal;
        }

        function __getFormWrapper() {
            return __formWrapper;
        }

        function __show() {
            __modal.modal('show');
        }

        function __hide() {
            __modal.modal('hide');
        }

        return __modalWrapperInst;
    }

    /**
     * 标签面板切换器
     *
     * @param options
     * @returns {{getFormWrapper: (function(*): *), show: __show, reset: __reset}}
     */
    $.fn.tabSwitcher = function (options) {

        var defaults = {
            /*
            modalId: null,
            tabs: [{
                id: '',
                title: '',
                form: {
                    action: '',
                    method: '',
                    timeout: 0,
                    validation: {
                        enabled: false,
                        rules: {},
                        messages: {}
                    },
                    beforeSubmit: function (formWrapper, requestOpts, data) {
                    },
                    afterSubmit: function (formWrapper, textStatus, data) {
                    },
                    onReset: function (formEl, formSubmitter) {
                    },
                    onError: function (formWrapper, XMLHttpRequest, textStatus, errorThrown) {
                    },
                    onSuccess: function (formWrapper, data, textStatus, jqXHR) {
                    }
                },
                onShow: function (tabContent, formWrapper) {
                },
            }]
            */
        };

        var opts = $.extend({}, defaults, options);

        var __tabsEl = $(this);

        var __modalWrapper = null;
        if (opts.modalId) {
            __modalWrapper = $('#' + opts.modalId).modalWrapper({
                onShow: function (event) {
                    if (event && event.title) {
                        this.setTitle(event.title);
                    }
                },
                onHide: function (event) {
                    __reset();
                }
            });
        }

        var __tabSwitcherInst = {
            show: __show,
            reset: __reset,
            getFormWrapper: __getFormWrapper
        }

        var __formWrappers = {};
        var __tabOnShow = {};

        if (opts.tabs && opts.tabs.length > 0) {
            for (var _idx = 0; _idx < opts.tabs.length; _idx++) {
                (function (_item) {
                    if (_item.id) {
                        if (_item.form) {
                            var _formEl = $('#' + _item.id + ' form');
                            if (_formEl.length > 0) {
                                __formWrappers[_item.id] = _formEl.formWrapper({
                                    action: _item.form.action,
                                    method: _item.form.method,
                                    timeout: _item.form.timeout,
                                    validation: _item.form.validation,
                                    beforeSubmit: function (formWrapper, requestOpts, data) {
                                        if (_item.form.beforeSubmit) {
                                            _item.form.beforeSubmit.call(__tabSwitcherInst, formWrapper, requestOpts, data);
                                        }
                                    },
                                    afterSubmit: function (formWrapper, textStatus, data) {
                                        if (_item.form.afterSubmit) {
                                            _item.form.afterSubmit.call(__tabSwitcherInst, formWrapper, textStatus, data);
                                        }
                                    },
                                    onReset: function (formEl, formSubmitter) {
                                        if (_item.form.onReset) {
                                            _item.form.onReset.call(__tabSwitcherInst, formEl, formSubmitter);
                                        }
                                    },
                                    onError: function (formWrapper, XMLHttpRequest, textStatus, errorThrown) {
                                        if (_item.form.onError) {
                                            _item.form.onError.call(__tabSwitcherInst, formWrapper, XMLHttpRequest, textStatus, errorThrown);
                                        } else {
                                            __commonsAjaxError.call(__tabSwitcherInst, XMLHttpRequest, textStatus, errorThrown);
                                        }
                                    },
                                    onSuccess: function (formWrapper, data, textStatus, jqXHR) {
                                        if (_item.form.onSuccess) {
                                            _item.form.onSuccess.call(__tabSwitcherInst, formWrapper, data, textStatus, jqXHR);
                                        }
                                    }
                                });
                            }
                        }
                        if (_item.onShow) {
                            __tabOnShow[_item.id] = {
                                show: _item.onShow,
                                title: _item.title,
                                content: $('#' + _item.id)
                            };
                        }
                    }
                })(opts.tabs[_idx]);
            }
        }

        function __findTab(tabId) {
            return $('a[href="#' + tabId + '"]', __tabsEl);
        }

        function __show(tabId) {
            var _tab = __findTab(tabId);
            if (_tab.length > 0) {
                var _tabInfo = __tabOnShow[tabId];
                if (_tabInfo) {
                    _tabInfo.show.call(__tabSwitcherInst, _tabInfo.content, __formWrappers[tabId]);
                    _tab.tab('show');
                    if (__modalWrapper) {
                        if (_tabInfo.title) {
                            __modalWrapper.setTitle(_tabInfo.title);
                        }
                        __modalWrapper.show();
                    }
                    $(window).trigger('resize');
                }
            }
        }

        function __reset() {
            $.each(__formWrappers, function (key, val) {
                val.reset();
            });
        }

        function __getFormWrapper(tabId) {
            return __formWrappers[tabId];
        }

        return __tabSwitcherInst;
    };

    $.fn.paginatorOn = function (resultSet, onChangeCallback, options) {
        var opts = $.extend({}, {
            paginated: resultSet ? resultSet.paginated : false,
            totalPages: resultSet ? resultSet.pageCount : 0,
            recordsTotal: resultSet ? resultSet.paginated ? resultSet.recordCount : resultSet.resultData ? resultSet.resultData.length : 0 : 0,
            currentPage: resultSet ? resultSet.pageNumber : 0,
            onChange: onChangeCallback && onChangeCallback instanceof Function ? onChangeCallback : null
        }, options);
        return $(this).paginator(opts);
    };

    /**
     * 分页组件封装及扩展
     *
     * https://vampire2008.github.io/bootstrap4-paginator/
     * https://github.com/Vampire2008/bootstrap4-paginator
     *
     * @param options
     * @returns {{getCurrentPage: (function(): number|*), getRecordsTotal: (function(): number), getTotalPages: (function(): number)}}
     */
    $.fn.paginator = function (options) {

        var defaults = {
            paginated: true,
            language: 'zh_CN',
            regional: {
                'zh_CN': {
                    currentPage: '第 {0} / {1} 页',
                    recordsTotal: '总记录数: {0}'
                }
            },
            totalPages: 0,
            recordsTotal: 0,
            currentPage: 0,
            // small, normal, large
            size: "normal",
            useBootstrapTooltip: false,
            // bootstrapTooltipOptions: null,
            alignment: 'center',
            numberOfPages: 5,
            // pageUrl: function(type, page, current){
            //     return "https://example.com/list/page/" + page;
            // },
            // alwaysDisplayNextPrevButtons: true,
            // alwaysDisplayFirstLastButtons: true,
            itemTexts: function (type, page, current) {
                switch (type) {
                    case "first":
                        return "&laquo;";
                    case "prev":
                        return "&larr;";
                    case "next":
                        return "&rarr;";
                    case "last":
                        return "&raquo;";
                    case "page":
                        return page;
                }
            },
            itemContainerClass: function (type, page, current) {
                return (page === current) ? "active" : "pointer-cursor";
            },
            onPageChanged: function (event, oldPage, newPage) {
            },
            onPageClicked: function (event, originalEvent, type, page) {
                if (options.onChange) {
                    event.stopImmediatePropagation();
                    var pages = $(event.currentTarget).bootstrapPaginator("getOption");
                    if (pages.currentPage !== page) {
                        options.onChange(page);
                    }
                }
            }
        };

        var opts = $.extend({}, defaults, options);
        if (opts.currentPage > opts.totalPages) {
            opts.currentPage = opts.totalPages;
        } else if (opts.currentPage <= 0) {
            opts.currentPage = 1;
        }

        var __paginatorEl = $(this);

        if (opts.paginated && opts.totalPages) {
            $('ul:last', __paginatorEl).bootstrapPaginator(opts);
        }

        __drawPaginationInfo();

        function __drawPaginationInfo() {
            var __paginationInfoEl = $('.paginationInfo', __paginatorEl);
            if (__paginationInfoEl.length > 0) {
                var _str = '<nav><ul class="pagination" style="margin-bottom: 0; margin-top: 0;">';
                if (opts.paginated && opts.totalPages) {
                    _str += '<li class="page-item disabled"><span class="page-link">' + __format(opts.regional[opts.language].currentPage, opts.currentPage, opts.totalPages) + '</span></li>';
                }
                __paginationInfoEl.html(_str + '<li class="page-item disabled"><span class="page-link">' + __format(opts.regional[opts.language].recordsTotal, opts.recordsTotal) + '</span></li></ul></nav>');
            }
        }

        return {
            getCurrentPage: function () {
                return opts.currentPage;
            },

            getTotalPages: function () {
                return opts.totalPages;
            },

            getRecordsTotal: function () {
                return opts.recordsTotal;
            },

            getOptions: function () {
                return opts;
            },

            redrawRecordsTotal: function (newRecordsTotal) {
                opts.recordsTotal = newRecordsTotal < 0 ? 1 : newRecordsTotal;
                __drawPaginationInfo();
            }
        }
    };

    if ($.fn.bootstrapPaginator) {
        $.fn.bootstrapPaginator.regional["zh_CN"] = {
            first: "首页",
            prev: "上一页",
            next: "下一页",
            last: "末页",
            current: "当前页",
            page: "第 ${0} 页"
        }
    }

    /**
     * jsGrid组件封装及扩展
     *
     * @param options
     * @returns {{removeItem: (function(*): null), findItem: (function(*): null), getTable: (function(): *|jQuery|jQuery|jQuery.jsGrid), getResult: (function(): *[]), selectedIds: (function(): *[]), refresh: refresh, selectedItems: (function(): *[])}}
     */
    $.fn.tableWrapper = function (options) {

        var defaults = {
            url: '',
            dataType: 'json',
            height: '',
            width: '100%',
            sorting: false,
            autoload: false,
            checkbox: false,
            actions: [
                // {
                //     icon: 'far fa-file',
                //     title: 'add',
                //     callback: function (item) {}
                // },
                // {
                //     icon: 'far fa-edit',
                //     title: 'edit',
                //     callback: function (item) {}
                // },
                // {
                //     icon: 'far fa-trash-alt',
                //     title: 'delete',
                //     callback: function (item) {}
                // },
                // {
                //     icon: 'far fa-file-alt',
                //     title: 'detail',
                //     callback: function (item) {}
                // },
            ],
            fields: [],
            locale: 'zh-cn',
            onInit: function (args) {
            },
            onLoad: __onLoad,
            onLoading: function (args) {
            },
            onLoaded: function (data, grid) {
            },
            onError: function (args) {
            },
            afterData: function (result) {
                return result;
            }
        };

        var opts = $.extend({}, defaults, options);

        var _result = [];

        var _selectedItems = [];

        if (opts.checkbox) {
            if (!opts.fields || opts.fields.length === 0) {
                opts.fields = [{name: 'id'}];
            }
            opts.fields[0] = {
                headerTemplate: function () {
                    return $("<input>").attr("type", "checkbox").attr("class", "selectAllCheckbox")
                },
                itemTemplate: function (_, item) {
                    var value = item[opts.fields[0].name];
                    return $("<input>")
                        .attr("type", "checkbox")
                        .attr("class", "itemCheckbox")
                        .val(value)
                        .prop("checked", $.inArray(value, _selectedItems) > -1)
                        .on("change", function () {
                            $(this).is(":checked") ? __doSelectItem($(this).val()) : __doUnselectItem($(this).val());
                        });
                },
                name: opts.fields[0].name || 'id',
                align: "center",
                width: 25,
                sorting: false
            }
        }

        if (opts.actions && opts.actions.length > 0) {
            opts.fields[opts.fields.length] = {
                itemTemplate: function (_, item) {

                    /*
                    <div class="btn-group">
                        <button type="button" class="btn btn-default"><i class="far fa-plus-square"></i></button>
                        <button type="button" class="btn btn-default"><i class="far fa-edit"></i></button>
                        <button type="button" class="btn btn-default"><i class="far fa-trash-alt"></i></button>
                        <div class="btn-group">
                            <button type="button" class="btn btn-default dropdown-toggle dropdown-icon" data-toggle="dropdown">
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="#">Dropdown link</a>
                                <a class="dropdown-item" href="#">Dropdown link</a>
                            </div>
                        </div>
                    </div>
                    */

                    function _createBtnGroup(dropdown, dropdownBody) {
                        var _btnGroup = $('<div>').attr('class', 'btn-group btn-group-sm');
                        if (dropdown) {
                            _btnGroup.append('<button type="button" class="btn btn-default dropdown-toggle dropdown-icon" data-toggle="dropdown"></button>');
                            if (dropdownBody) {
                                _btnGroup.append(dropdownBody);
                            }
                        }
                        return _btnGroup;
                    }

                    function _createBtn(icon, callback, item) {
                        return $('<button>')
                            .attr('type', 'button')
                            .attr('class', 'btn btn-default')
                            .append($('<i>').attr('class', icon ? icon : 'far fa-circle'))
                            .on('click', function () {
                                callback.call(__tableInst, item);
                            });
                    }

                    function _createDropdownMenu(menuItems) {
                        var dropdownMenu = $('<div>').attr('class', 'dropdown-menu');
                        if (menuItems && menuItems.length > 0) {
                            for (var i = 0; i < menuItems.length; i++) {
                                dropdownMenu.append($('<a class="dropdown-item" href="#"><i class="' + (menuItems[i].icon ? menuItems[i].icon : 'far fa-circle') + '"></i> ' + menuItems[i].title + '</a>')
                                    .on('click', (function (dropdownItem) {
                                        return function () {
                                            dropdownItem.callback.call(__tableInst, item);
                                        }
                                    })(menuItems[i])));
                            }
                        }
                        return dropdownMenu;
                    }

                    var _btnGroup = _createBtnGroup();
                    $.each(opts.actions, function (_, action) {
                        if (_ < (opts.actions.length > 3 ? 2 : 3) && action.callback) {
                            _btnGroup.append(_createBtn(action.icon, action.callback, item))
                        }
                    });
                    if (opts.actions.length > 3) {
                        var _menuItems = [];
                        $.each(opts.actions, function (_, action) {
                            if (_ >= 2 && action.title && action.callback) {
                                _menuItems.push(action);
                            }
                        });
                        if (_menuItems.length > 0) {
                            _btnGroup.append(_createBtnGroup(true, _createDropdownMenu(_menuItems)));
                        }
                    }
                    return _btnGroup;
                },
                title: "",
                align: "center",
                width: 100,
                sorting: false
            }
        }

        if (opts.locale) {
            jsGrid.locale(opts.locale);
        }

        var _tableEl = $(this).jsGrid({
            height: opts.height || 'auto',
            width: opts.width || 'auto',
            sorting: opts.sorting,
            autoload: opts.autoload,
            paging: false,
            pageLoading: false,
            controller: {
                loadData: opts.onLoad
            },
            onInit: opts.onInit,
            onDataLoading: opts.onLoading,
            onDataLoaded: function (args) {
                _result = args.data;
                if (opts.onLoaded) {
                    opts.onLoaded(args.data, args.grid);
                }
            },
            onError: opts.onError,
            fields: opts.fields
        });

        function __onLoad(filter) {
            if (opts.url) {
                var deferred = $.Deferred();
                $.ajax({
                    url: opts.url,
                    dataType: opts.dataType,
                    data: filter || {},
                }).done(function (response) {
                    var result = response.value;
                    if (opts.afterData) {
                        result = opts.afterData(result);
                    }
                    deferred.resolve(result);
                }).fail(function () {
                    deferred.resolve([]);
                });
                return deferred.promise();
            }
            return filter ? filter : [];
        }

        var __doSelectItem = function (item) {
            _selectedItems.push(item);
            if ($(".itemCheckbox", _tableEl).length === $(".itemCheckbox:checked", _tableEl).length) {
                $(".selectAllCheckbox", _tableEl).prop("checked", true);
            } else {
                $(".selectAllCheckbox", _tableEl).prop("checked", false);
            }
        };

        var __doUnselectItem = function (item) {
            _selectedItems = $.grep(_selectedItems, function (i) {
                return i !== item;
            });
            if (_selectedItems.length === 0) {
                $(".selectAllCheckbox", _tableEl).attr('checked', false);
            }
            if ($(".itemCheckbox").length === $(".itemCheckbox:checked").length) {
                $(".selectAllCheckbox", _tableEl).prop("checked", true);
            } else {
                $(".selectAllCheckbox", _tableEl).prop("checked", false);
            }
        };

        if (opts.checkbox) {
            $(".selectAllCheckbox", _tableEl).click(function (item) {
                _selectedItems = [];
                if (this.checked) {
                    $(".itemCheckbox", _tableEl).each(function (_, _item) {
                        _item.checked = true;
                        __doSelectItem($(_item).val());
                    });
                } else {
                    $(".itemCheckbox", _tableEl).each(function (_, _item) {
                        _item.checked = false;
                        __doUnselectItem($(_item).val());
                    });
                    _selectedItems = [];
                }
            });
        }

        var __tableInst = {

            getResult: function () {
                return _result;
            },

            getTable: function () {
                return _tableEl;
            },

            selectedIds: function () {
                return _selectedItems;
            },

            selectedItems: function () {
                var _items = [];
                $.each(_result, function (_, item) {
                    if ($.inArray(item[opts.fields[0].name], _selectedItems) > -1) {
                        _items.push(item);
                    }
                });
                return _items;
            },

            findItem: function (id) {
                var _item = null;
                if (_result) {
                    $.each(_result, function (_, item) {
                        if (item[opts.fields[0].name] === id) {
                            _item = item;
                            return false;
                        }
                    });
                }
                return _item;
            },

            insertItem: function (newItem) {
                if (newItem) {
                    _result.splice(0, 0, newItem);
                    _tableEl.jsGrid("refresh");
                    return true;
                }
                return false;
            },

            removeItem: function (id) {
                var _item = null;
                if (_result) {
                    $.each(_result, function (_, item) {
                        if (item[opts.fields[0].name] === id) {
                            _item = item;
                            _result.splice(_, 1);
                            return false;
                        }
                    });
                    _selectedItems = $.grep(_selectedItems, function (i) {
                        return i !== id;
                    });
                    _tableEl.jsGrid("refresh");
                }
                return _item;
            },

            /**
             * 刷新(或重新加载)数据并重绘表格
             *
             * @param filter
             */
            refresh: function (filter) {
                _selectedItems = [];
                if (filter) {
                    _tableEl.jsGrid("loadData", filter);
                } else {
                    _tableEl.jsGrid("refresh");
                }
            }
        }
        return __tableInst;
    };

    /**
     * 侧边栏导航
     *
     * @param options
     */
    $.fn.sideNav = function (options) {

        var defaults = {
            /*
            activeItem: '',
            items: [
                {type: 'header', title: 'MAIN NAVIGATION'},
                {
                    title: 'Multilevel',
                    icon: '',
                    href: '#',
                    label: {color: 'warning', text: '8'},
                    items: [
                        {
                            title: 'Level One',
                            icon: 'share',
                            href: '#',
                            active: true
                        },
                        {
                            title: 'Level One',
                            icon: 'share',
                            href: '#',
                            label: {color: 'danger', text: '8'},
                            items: [
                                {title: 'Level Two', href: '#'},
                                {title: 'Level Two', href: '#'}
                            ]
                        }
                    ]
                }
            ]
            */
        };

        function __parseTreeLabel(label) {
            var labelStr = '';
            if (label && label.text) {
                labelStr += '<span class="right badge badge-' + (label.color ? label.color : 'warning') + '">' + label.text + '</span>';
            }
            return labelStr;
        }

        function __parseTreeItems(items) {
            var htmlStr = '';
            for (var i = 0; i < items.length; i++) {
                htmlStr += __parseTreeItem(items[i]);
            }
            return htmlStr;
        }

        function __parseTreeItem(item) {
            var htmlStr = '';
            if (item.title) {
                if (item.type && item.type === "header") {
                    htmlStr += "<li class=\"nav-header\">" + item.title + "</li>";
                } else if (item.items && item.items.length > 0) {
                    htmlStr += "<li class=\"nav-item" + (item.active ? ' menu-open' : '') + "\"><a href=\"#\" class=\"nav-link" + (item.active ? ' active' : '') + "\"><i class=\"far fa-circle nav-icon\"></i><p>" + item.title + "<i class=\"fas fa-angle-left right\"></i>" + __parseTreeLabel(item.label) + "</p></a>";
                    htmlStr += "<ul class=\"nav nav-treeview\">" + __parseTreeItems(item.items) + "</ul></li>";
                } else {
                    htmlStr += "<li class=\"nav-item \"><a href=\"" + (item.href ? item.href : "#") + "\" class=\"nav-link" + (item.active ? ' active' : '') + "\"><i class=\"far fa-" + (item.icon ? item.icon : "circle") + " nav-icon\"></i><p>" + item.title + __parseTreeLabel(item.label) + "</p></a></li>";
                }
            }
            return htmlStr;
        }

        $(this).append(__parseTreeItems($.extend({}, defaults, options).items));
    }

    /**
     * 顶部导航菜单
     *
     * @param options
     */
    $.fn.mainNav = function (options) {

        var hasThemeSwitch = false;

        var defaults = {
            /*
            activeItem: '',
            items: [
                {type: 'push-menu'},
                {
                    title: 'Multilevel',
                    icon: 'circle',
                    href: '#',
                    label: {color: 'danger', text: '8'},
                    active: false,
                    hideOnNav: true,
                    items: [
                        {
                            title: 'Level One',
                            icon: 'circle',
                            href: '#'
                        },
                        {
                            title: 'Level One',
                            href: '#',
                            items: [
                                {title: 'Level Two', icon: 'circle', href: '#'},
                                {title: 'Level Two', href: '#'}
                            ]
                        }
                    ]
                },
                {
                    title: 'Other',
                    icon: 'circle',
                    href: '#',
                    label: {color: 'warning', text: '8'},
                    active: true,
                    hideOnNav: true
                },
                {type: 'search-inline', title: 'Search'},
                {type: 'search', title: 'Search'},
                {type: 'theme-switch'},
                {type: 'fullscreen'},
                {type: 'control-sidebar'},
                {
                    type: 'user-menu',
                    title: 'Username',
                    description: '',
                    icon: 'assets/commons/img/avatar-none.jpg',
                    footer: {
                        profileHref: '#',
                        profileText: '',
                        signOutHref: '#',
                        signOutText: ''
                    }
                },
                {type: 'dropdown', title: 'No messages.', icon: 'bell', href: '#', label: {color: 'warning', text: '8'}, footer: 'See All'}
            ]
            */
        };

        function __parseItemLabel(label) {
            var labelStr = '';
            if (label && label.text) {
                labelStr += '<span class="badge badge-' + (label.color ? label.color : 'warning') + ' navbar-badge\">' + label.text + '</span>';
            }
            return labelStr;
        }

        function __parseMenuItems(items) {
            var htmlStr = '';
            for (var i = 0; i < items.length; i++) {
                htmlStr += __parseMenuItem(items[i]);
            }
            return htmlStr;
        }

        function __parseSubMenuItems(items) {
            var htmlStr = '';
            if (items && items.length > 0) {
                for (var _idx = 0; _idx < items.length; _idx++) {
                    var _item = items[_idx];
                    if (_item.title) {
                        if (_item.items && _item.items.length > 0) {
                            htmlStr += "<li class=\"dropdown-submenu dropdown-hover\">";
                            htmlStr += "<a href=\"#\" class=\"dropdown-item dropdown-toggle\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">" + _item.title + "</a>";
                            htmlStr += "<ul class=\"dropdown-menu border-0 shadow\">" + __parseSubMenuItems(_item.items) + "</ul>";
                            htmlStr += "</li>";
                        } else {
                            htmlStr += "<li><a href=\"" + (_item.href ? _item.href : "#") + "\" class=\"dropdown-item\">" + (_item.icon ? "<i class=\"far fa-" + _item.icon + "\"></i> " : "") + _item.title + "</a></li>";
                        }
                    }
                }
            }
            return htmlStr;
        }

        function __parseMenuItem(item) {
            var htmlStr = '';
            if (!item.type && item.title) {
                if (item.items && item.items.length > 0) {
                    htmlStr += "<li class=\"nav-item dropdown\">";
                    htmlStr += "<a href=\"#\" class=\"nav-link dropdown-toggle\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">" + item.title + "</a>";
                    htmlStr += "<ul class=\"dropdown-menu border-0 shadow\">" + __parseSubMenuItems(item.items) + "</ul>";
                    htmlStr += "</li>";
                } else {
                    htmlStr += "<li class=\"nav-item" + (item.hideOnNav ? " d-none d-sm-inline-block" : "") + (item.active ? " bg-secondary rounded active" : "") + "\"><a href=\"" + (item.href ? item.href : "#") + "\" class=\"nav-link\">" + (item.icon ? "<i class=\"far fa-" + item.icon + "\"></i> " : "") + item.title + __parseItemLabel(item.label) + "</a></li>";
                }
            } else if (item.type === 'push-menu') {
                htmlStr += "<li class=\"nav-item\"><a href=\"#\" class=\"nav-link\" data-widget=\"pushmenu\" role=\"button\"><i class=\"fas fa-bars\"></i></a></li>";
            } else if (item.type === 'search-inline' || item.type === 'search') {
                var placeholder = item.title ? item.title : "Search";
                if (item.type === 'search-inline') {
                    htmlStr += "<form class=\"form-inline ml-0 ml-md-3\"><div class=\"input-group input-group-sm\">" +
                        "<input class=\"form-control form-control-navbar\" type=\"search\" placeholder=\"" + placeholder + "\" aria-label=\"" + placeholder + "\">" +
                        "<div class=\"input-group-append\"><button class=\"btn btn-navbar\" type=\"submit\"><i class=\"fas fa-search\"></i></button></div></div></form>"
                } else {
                    htmlStr += "<li class=\"nav-item\"><a class=\"nav-link\" data-widget=\"navbar-search\" data-target=\"#main-header-search\" href=\"#\" role=\"button\"><i class=\"fas fa-search\"></i></a>" +
                        "<div class=\"navbar-search-block\" id=\"main-header-search\">" +
                        "<form class=\"form-inline\"><div class=\"input-group input-group-sm\">" +
                        "<input class=\"form-control form-control-navbar\" type=\"search\" placeholder=\"" + placeholder + "\" aria-label=\"" + placeholder + "\">\n" +
                        "<div class=\"input-group-append\"><button class=\"btn btn-navbar\" type=\"submit\"><i class=\"fas fa-search\"></i></button>" +
                        "<button class=\"btn btn-navbar\" type=\"button\" data-widget=\"navbar-search\"><i class=\"fas fa-times\"></i></button></div></div></form></div></li>";
                }
            } else if (item.type === 'dropdown') {
                htmlStr += "<li class=\"nav-item dropdown\"><a class=\"nav-link\" data-toggle=\"dropdown\" href=\"#\"><i class=\"far fa-" + (item.icon ? item.icon : "bell") + "\"></i>" + __parseItemLabel(item.label) + "</a>" +
                    "<div class=\"dropdown-menu dropdown-menu-lg dropdown-menu-right\">" +
                    "<span class=\"dropdown-item dropdown-header\">" + item.title + "</span>" +
                    "<div class=\"dropdown-divider\"></div>" +
                    "<a href=\"" + (item.href ? item.href : "#") + "\" class=\"dropdown-item dropdown-footer\">" + (item.footer ? item.footer : "See All") + "</a></div></li>";
            } else if (item.type === 'theme-switch') {
                htmlStr += "<li class=\"nav-item\"><div class=\"theme-switch-wrapper nav-link\"><label class=\"theme-switch\" for=\"checkbox\"><input type=\"checkbox\" id=\"checkbox\"><span class=\"slider round\"></span></label></div></li>";
                hasThemeSwitch = true;
            } else if (item.type === 'fullscreen') {
                htmlStr += "<li class=\"nav-item\"><a class=\"nav-link\" data-widget=\"fullscreen\" href=\"#\" role=\"button\"><i class=\"fas fa-expand-arrows-alt\"></i></a></li>";
            } else if (item.type === 'control-sidebar') {
                htmlStr += "<li class=\"nav-item\"><a class=\"nav-link\" data-widget=\"control-sidebar\" data-slide=\"true\" href=\"#\" role=\"button\"><i class=\"fas fa-th-large\"></i></a></li>";
            } else if (item.type === 'user-menu' && item.title) {
                htmlStr += "<li class=\"nav-item dropdown user-menu\"><a href=\"#\" class=\"nav-link dropdown-toggle\" data-toggle=\"dropdown\">" +
                    "<img src=\"" + (item.icon ? item.icon : "assets/commons/img/avatar-none.jpg") + "\" class=\"user-image img-circle elevation-2\" alt=\"User Avatar\">" +
                    "<span class=\"d-none d-md-inline\">" + item.title + "</span></a>" +
                    "<ul class=\"dropdown-menu dropdown-menu-lg dropdown-menu-right\">" +
                    "<li class=\"user-header bg-primary\"><img src=\"" + (item.icon ? item.icon : "assets/commons/img/avatar-none.jpg") + "\" class=\"img-circle elevation-2\" alt=\"User Avatar\"><p>" + item.title + "</p></li>";
                if (item.footer) {
                    htmlStr += "<li class=\"user-footer\">" +
                        "<a href=\"" + (item.footer.profileHref ? item.footer.profileHref : "#") + "\" class=\"btn btn-default btn-flat\">" + (item.footer.profileText ? item.footer.profileText : "Profile") + "</a>" +
                        "<a href=\"" + (item.footer.signOutHref ? item.footer.signOutHref : "#") + "\" class=\"btn btn-default btn-flat float-right\">" + (item.footer.signOutText ? item.footer.signOutText : "Sign out") + "</a>" +
                        "</li>";
                }
                htmlStr += "</ul></li>";
            }
            return htmlStr;
        }

        $(this).append(__parseMenuItems($.extend({}, defaults, options).items));
        if (hasThemeSwitch) {
            $.themeSwitch();
        }
    }

    $.buildStaticForm = function (items) {
        var _htmlStr = '';
        if (items && items.length > 0) {
            for (var i = 0; i < items.length; i++) {
                var _item = items[i];
                if (_item && _item.title) {
                    var _type = _item.type || 'text';
                    switch (_type) {
                        case 'textarea':
                            _htmlStr += '<div class=" form-group"><label>' + _item.title + '</label><div class="input-group"><textarea class="form-control-plaintext" readonly="readonly" rows="5">' + (_item.content ? _item.content : '') + '</textarea></div></div>';
                            break;
                        default:
                            _htmlStr += '<div class=" form-group"><label>' + _item.title + '</label><div class="input-group"><p class="form-control-plaintext">' + (_item.content ? _item.content : '') + '</p></div></div>';
                    }
                }
            }
        }
        return _htmlStr;
    }

    function __themeModeSet(targetEl) {
        if (!document.body.classList.contains('dark-mode')) {
            document.body.classList.add("dark-mode");
        }
        if (targetEl.classList.contains('navbar-light')) {
            targetEl.classList.add('navbar-dark');
            targetEl.classList.remove('navbar-light');
            if (targetEl.classList.contains('navbar-white')) {
                targetEl.classList.remove('navbar-white');
            }
        }
    }

    $.themeSwitch = function () {
        var themeSwitch = document.querySelector('.theme-switch input[type="checkbox"]');
        if (themeSwitch) {
            var mainHeader = document.querySelector('.main-header');
            if (mainHeader) {
                var currentTheme = localStorage.getItem('theme');
                if (currentTheme) {
                    if (currentTheme === 'dark') {
                        __themeModeSet(mainHeader);
                        themeSwitch.checked = true;
                    }
                }
                themeSwitch.addEventListener('change', function (e) {
                    if (e.target.checked) {
                        __themeModeSet(mainHeader);
                        localStorage.setItem('theme', 'dark');
                    } else {
                        __themeModeSet(mainHeader);
                        localStorage.setItem('theme', 'light');
                    }
                }, false);
            }
        }
    }

    /**
     * 卡片面板组件封装及扩展
     *
     * @param options
     * @returns {{getFormWrapper: (function(): *), getPaginator: (function(): *|null), getTableWrapper: (function(): *), drawPaginator: ((function(*, *): (*|jQuery|null))|*)}}
     */
    $.fn.cardWrapper = function (options) {

        var defaults = {
            /*
            actions: {
                demoAction: function () {
                }
            },
            form: {
                enabled: false,
                action: '',
                method: '',
                timeout: 0,
                validation: {
                    enabled: false,
                    rules: {},
                    messages: {}
                },
                beforeSubmit: function (formWrapper, requestOpts, data) {
                },
                afterSubmit: function (formWrapper, textStatus, data) {
                },
                onReset: function (formEl, formSubmitter) {
                },
                onError: function (formWrapper, XMLHttpRequest, textStatus, errorThrown) {
                },
                onSuccess: function (formWrapper, data, textStatus, jqXHR) {
                }
            },
            table: {
                url: '',
                dataType: 'json',
                height: '',
                width: '100%',
                sorting: true,
                autoload: false,
                checkbox: true,
                fields: [],
                locale: '',
                onInit: function (args) {
                },
                onLoad: function (filter) {
                },
                onLoading: function (args) {
                },
                onLoaded: function (data, grid) {
                },
                onError: function (args) {
                },
                afterData: function (result) {
                    return result;
                }
            }
            */
        };

        var opts = $.extend({}, defaults, options);

        var _cardEl = $(this);

        var _paginatorEl = $('[data-widget="card-paginator"]');

        var _paginator;

        var __cardInst = {
            getTableWrapper: function () {
                return _tableWrapper;
            },
            getFormWrapper: function () {
                return __formWrapper;
            },
            getPaginator: function () {
                return _paginatorEl ? _paginator : null;
            },
            drawPaginator: function (options, onChangeCallback) {
                if (_paginatorEl) {
                    _paginator = _paginatorEl.paginatorOn(options, onChangeCallback);
                    return _paginator;
                }
                return null;
            }
        }

        var _tableWrapper;
        if (opts.table) {
            var tableOpts = {};
            if (_paginatorEl && !opts.table.onInit) {
                opts.table.onInit = function (args) {
                    this.drawPaginator({recordCount: 0});
                }
            }
            $.each(opts.table, function (name, value) {
                if (value) {
                    if (value instanceof Function) {
                        tableOpts[name] = function () {
                            return value.apply(__cardInst, arguments);
                        };
                    } else {
                        tableOpts[name] = value;
                    }
                }
            });
            _tableWrapper = $('[data-widget="card-table"]', _cardEl).tableWrapper(tableOpts);
        }

        $('[data-widget="card-action-btn"]', _cardEl).each(function () {
            var _actionBtn = $(this);
            var _actionFuncName = _actionBtn.attr('data-card-action');
            if (_actionFuncName) {
                var _actionFunc = __processActions(opts.actions, _actionFuncName);
                if (_actionFunc && _actionFunc instanceof Function) {
                    _actionBtn.on('click', function () {
                        _actionFunc.apply(__cardInst);
                    });
                }
            }
        });

        var __formWrapper;
        if (opts.form && opts.form.enabled) {
            var _formEl = $('form', _cardEl);
            if (_formEl.length > 0) {
                __formWrapper = _formEl.formWrapper({
                        action: opts.form.action,
                        method: opts.form.method,
                        timeout: opts.form.timeout,
                        validation: opts.form.validation,
                        beforeSubmit: function (formWrapper, requestOpts, data) {
                            if (opts.form.beforeSubmit) {
                                opts.form.beforeSubmit.call(__cardInst, formWrapper, requestOpts, data);
                            }
                        },
                        afterSubmit: function (formWrapper, textStatus, data) {
                            if (opts.form.afterSubmit) {
                                opts.form.afterSubmit.call(__cardInst, formWrapper, textStatus, data);
                            }
                        },
                        onReset: function (formEl, formSubmitter) {
                            if (opts.form.onReset) {
                                opts.form.onReset.call(__cardInst, formEl, formSubmitter);
                            }
                        },
                        onError: function (formWrapper, XMLHttpRequest, textStatus, errorThrown) {
                            if (opts.form.onError) {
                                opts.form.onError.call(__cardInst, formWrapper, XMLHttpRequest, textStatus, errorThrown);
                            } else {
                                __commonsAjaxError.call(__cardInst, XMLHttpRequest, textStatus, errorThrown);
                            }
                        },
                        onSuccess: function (formWrapper, data, textStatus, jqXHR) {
                            if (opts.form.onSuccess) {
                                opts.form.onSuccess.call(__cardInst, formWrapper, data, textStatus, jqXHR);
                            } else if (data && data['data']) {
                                __pageWrapper.resultSet(data['data'], formWrapper);
                            }
                        }
                    }
                );
            }
        }

        return __cardInst;
    }

    /**
     * 页面包装器
     *
     * @param options
     * @returns {*|{cards: {}, refreshPage: __doPageRefresh, modals: {}, resultSet: __doResultSet}}
     */
    $.pageWrapper = function (options) {

        var defaults = {
            /*
            sidebar: {
                search: {
                    minLength: 1,
                    maxResults: 7,
                    notFoundText: 'Not Found.'
                },
                items: [
                    {type: 'header', title: 'MAIN NAVIGATION'},
                    {
                        title: 'Multilevel',
                        icon: '',
                        href: '#',
                        label: {color: 'warning', text: '8'},
                        items: [
                            {
                                title: 'Level One',
                                icon: 'share',
                                href: '#',
                                active: true
                            },
                            {
                                title: 'Level One',
                                icon: 'share',
                                href: '#',
                                label: {color: 'danger', text: '8'},
                                items: [
                                    {title: 'Level Two', href: '#'},
                                    {title: 'Level Two', href: '#'}
                                ]
                            }
                        ]
                    }
                ],
            },
            navbar: {
                someNavbarId: {
                    activeItem: '',
                    items: [
                        {type: 'push-menu'},
                        {
                            title: 'Multilevel',
                            icon: 'circle',
                            href: '#',
                            label: {color: 'danger', text: '8'},
                            active: false,
                            hideOnNav: true,
                            items: [
                                {
                                    title: 'Level One',
                                    icon: 'circle',
                                    href: '#'
                                },
                                {
                                    title: 'Level One',
                                    href: '#',
                                    items: [
                                        {title: 'Level Two', icon: 'circle', href: '#'},
                                        {title: 'Level Two', href: '#'}
                                    ]
                                }
                            ]
                        },
                        {
                            title: 'Other',
                            icon: 'circle',
                            href: '#',
                            label: {color: 'warning', text: '8'},
                            active: true,
                            hideOnNav: true
                        },
                        {type: 'search-inline', title: 'Search'},
                        {type: 'search', title: 'Search'},
                        {type: 'theme-switch'},
                        {type: 'fullscreen'},
                        {type: 'control-sidebar'},
                        {
                            type: 'user-menu',
                            title: 'Username',
                            description: '',
                            icon: 'assets/commons/img/avatar-none.jpg',
                            footer: {
                                profileHref: '#',
                                profileText: '',
                                signOutHref: '#',
                                signOutText: ''
                            }
                        },
                        {type: 'dropdown', title: 'No messages.', icon: 'bell', href: '#', label: {color: 'warning', text: '8'}, footer: 'See All'}
                    ]
                },
            },
            cards: {
                someCardId: {
                    actions: {
                        demoAction: function () {
                        }
                    },
                    form: {
                        enabled: false,
                        action: '',
                        method: '',
                        timeout: 0,
                        beforeSubmit: function (formWrapper, requestOpts, data) {
                        },
                        afterSubmit: function (formWrapper, textStatus, data) {
                        },
                        onReset: function (formEl, formSubmitter) {
                        },
                        onError: function (formWrapper, XMLHttpRequest, textStatus, errorThrown) {
                        },
                        onSuccess: function (formWrapper, data, textStatus, jqXHR) {
                        }
                    },
                    table: {
                        url: '',
                        dataType: 'json',
                        height: '',
                        width: '100%',
                        sorting: true,
                        autoload: false,
                        checkbox: true,
                        fields: [],
                        locale: '',
                        onInit: function (args) {
                        },
                        onLoad: function (filter) {
                        },
                        onLoading: function (args) {
                        },
                        onLoaded: function (data, grid) {
                        },
                        onError: function (args) {
                        },
                        afterData: function (result) {
                            return result;
                        }
                    }
                },
            },
            modals: {
                someModalId: {
                    form: {
                        enabled: true,
                        action: '',
                        method: '',
                        beforeSubmit: function (formWrapper, requestOpts, data) {
                        },
                        afterSubmit: function (formWrapper, textStatus, data) {
                        },
                        onReset: function (formEl, formSubmitter) {
                        },
                        onError: function (formWrapper, XMLHttpRequest, textStatus, errorThrown) {
                        },
                        onSuccess: function (formWrapper, data, textStatus, jqXHR) {
                        }
                    },
                    onShow: function (event) {
                    },
                    onHide: function (event) {
                    }
                },
            }
            */
        }

        var opts = $.extend({}, defaults, options);

        if (opts.sidebar) {
            if (opts.sidebar.items) {
                $("nav.mt-2 ul").sideNav({items: opts.sidebar.items});
            }
            $('[data-widget="sidebar-search"]').SidebarSearch(opts.sidebar.search || {
                minLength: 1,
                notFoundText: '未找到'
            })
        }

        if (opts.navbar) {
            $.each(opts.navbar, function (name, value) {
                if (value) {
                    $('#' + name).mainNav(value);
                }
            });
        }

        var _cards = {};
        if (opts.cards) {
            $.each(opts.cards, function (name, value) {
                if (value) {
                    _cards[name] = $('#' + name).cardWrapper(value);
                }
            });
        }

        var _modals = {};
        if (opts.modals) {
            $.each(opts.modals, function (name, value) {
                if (value) {
                    _modals[name] = $('#' + name).modalWrapper(value);
                }
            });
        }

        function __doPageRefresh(formWrapper, newPage, pageSize) {
            if (_cards.resultCard) {
                var formOpts = formWrapper.getOptions() || {};
                var _data = formWrapper.getFormData();
                if (newPage && newPage > 0) {
                    _data.page = newPage;
                }
                if (pageSize && pageSize > 0) {
                    _data.pageSize = pageSize;
                }
                $.requestSender({
                    url: formOpts.action || formWrapper.getForm().attr("action"),
                    type: formOpts.method || formWrapper.getForm().attr("method"),
                    timeout: formOpts.timeout || 0,
                    data: _data,
                    success: function (data, textStatus, jqXHR) {
                        if (data && data['ret'] === 0) {
                            __doResultSet(data['data'], formWrapper);
                        } else {
                            __commonsWarnMsgShow(data['msg']);
                        }
                    },
                    error: __commonsAjaxError
                });
            }
        }

        function __doResultSet(result, formWrapper) {
            if (_cards.resultCard && _cards.resultCard.getTableWrapper()) {
                _cards.resultCard.getTableWrapper().refresh(result['resultData']);
                _cards.resultCard.drawPaginator(result, function (newPage) {
                    __doPageRefresh(formWrapper, newPage, result['pageSize']);
                });
            }
        }

        window.__pageWrapper = {
            modals: _modals,
            cards: _cards,
            resultSet: __doResultSet,
            refreshPage: __doPageRefresh
        };
        return window.__pageWrapper;
    }

})(jQuery);

$(function () {

    "use strict";

    window.__overlayShow = function (hide) {
        if (hide) {
            $.LoadingOverlay("hide");
        } else {
            $.LoadingOverlay("show");
        }
    };

    window.__confirmShow = function (options) {
        var defaults = {
            title: '警告',
            content: '确认要继续执行吗？',
            icon: 'fas fa-exclamation-triangle',
            type: 'red',
            typeAnimated: true,
            i18n: {
                ok: '确认',
                cancel: '取消'
            },
            ok: function () {
            },
            cancel: function () {
            }
        };
        var opts = $.extend({}, defaults, options);
        $.confirm({
            title: opts.title,
            content: opts.content,
            icon: opts.icon,
            type: opts.type,
            typeAnimated: opts.typeAnimated,
            buttons: {
                'ok': {
                    text: opts.i18n.ok,
                    btnClass: 'btn-' + opts.type,
                    action: opts.ok
                },
                'cancel': {
                    text: opts.i18n.cancel,
                    action: opts.cancel
                },
            }
        });
    };

    window.__notifyShow = function (options) {

        var defaults = {
            // 可选值：[default|sweetalert2|toastr]
            type: '',
            timeout: 3000,
        };

        var opts = $.extend({}, defaults, options);

        if ((!opts.type || opts.type === 'sweetalert2') && window.Swal) {
            var Toast = Swal.mixin({
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: opts.timeout || 3000
            });

            function __toast(icon, text) {
                if (text) {
                    Toast.fire({
                        icon: icon || 'info',
                        title: text
                    });
                }
            }

            return {
                success: function (text) {
                    __toast('success', text);
                },
                info: function (text) {
                    __toast('info', text);
                },
                error: function (text) {
                    __toast('error', text);
                },
                warn: function (text) {
                    __toast('warning', text);
                },
                question: function (text) {
                    __toast('question', text);
                },
            }
        } else if ((!opts.type || opts.type === 'toastr') && window.toastr) {
            return {
                success: function (text) {
                    toastr.success(text);
                },
                info: function (text) {
                    toastr.info(text);
                },
                error: function (text) {
                    toastr.error(text);
                },
                warn: function (text) {
                    toastr.warning(text);
                },
            }
        } else {
            function __toasts(icon, text, title) {
                if (text) {
                    $(document).Toasts('create', {
                        class: icon || 'bg-info',
                        autohide: true,
                        delay: opts.timeout || 750,
                        title: title || 'Toast',
                        body: text
                    })
                }
            }

            return {
                success: function (text, title) {
                    __toasts('bg-success', text, title || 'Success');
                },
                info: function (text, title) {
                    __toasts('bg-info', text, title || 'Info');
                },
                error: function (text, title) {
                    __toasts('bg-danger', text, title || 'Error');
                },
                warn: function (text, title) {
                    __toasts('bg-warning', text, title || 'Warning');
                },
            }
        }
    };

    window.__commonsAjaxError = function (XMLHttpRequest, textStatus, errorThrown) {
        __notifyShow().error("请求发送（超时或网络异常）失败，请检查并重试！");
    }

    window.__commonsWarnMsgShow = function (msg) {
        __notifyShow().warn(msg || '请求响应未知错误，请稍后重试！');
    }

    // 绑定黑暗模式切换事件
    $.themeSwitch();

    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="popover"]').popover();

    // 尝试初始化自定义文件选择器组件
    if (window.bsCustomFileInput) {
        bsCustomFileInput.init();
    }

    if ($().summernote) {
        $('.summernote').each(function (index, domEle) {
            var _target = $(domEle);
            var _opts = {
                placeholder: _target.attr('placeholder') || '',
                height: _target.attr('data-summernote-height') || 100,
                minHeight: _target.attr('data-summernote-min-height') || null,
                maxHeight: _target.attr('data-summernote-max-height') || null,
                lang: _target.attr('data-summernote-lang') || 'zh-CN',
                dialogsInBody: true,
            };
            var _disabled = _target.attr('disabled') || _target.attr('readonly');
            if (_disabled) {
                _opts.toolbar = false;
            }
            _target.summernote(_opts);
            if (_disabled) {
                _target.summernote('disable');
            }
        });
    }

    // 尝试绑定可拖拽面板组件
    if ($().sortable) {
        $('.connectedSortable').sortable({
            placeholder: 'sort-highlight',
            connectWith: '.connectedSortable',
            handle: '.card-header, .nav-tabs',
            forcePlaceholderSize: true,
            zIndex: 999999
        })
        $('.connectedSortable .card-header').css('cursor', 'move')
    }
});