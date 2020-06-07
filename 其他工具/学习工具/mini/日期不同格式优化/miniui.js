function js_isTouchDevice() {
	try {
		return document.createEvent("TouchEvent"), !0
	} catch (t) {
		return !1
	}
}
function js_touchScroll(t) {
	if (js_isTouchDevice()) {
		var e = "string" == typeof t ? document.getElementById(t) : t,
			i = 0;
		e.addEventListener("touchstart", function(t) {
			i = this.scrollTop + t.touches[0].pageY, t.preventDefault()
		}, !1), e.addEventListener("touchmove", function(t) {
			this.scrollTop = i - t.touches[0].pageY, t.preventDefault()
		}, !1)
	}
}
function UUID() {
	for (var t = [], e = "0123456789ABCDEF".split(""), i = 0; 36 > i; i++) t[i] = Math.floor(16 * Math.random());
	t[14] = 4, t[19] = 3 & t[19] | 8;
	for (var i = 0; 36 > i; i++) t[i] = e[t[i]];
	return t[8] = t[13] = t[18] = t[23] = "-", t.join("")
}
function __OnIFrameMouseDown() {
	jQuery(document).trigger("mousedown")
}
function __BindIFrames() {
	for (var t = document.getElementsByTagName("iframe"), e = 0, i = t.length; i > e; e++) {
		var n = t[e];
		try {
			if (n.contentWindow) {
				var s = n.contentWindow.document;
				jQuery(s).bind("mousedown", __OnIFrameMouseDown)
			}
		} catch (o) {}
	}
}
mini = {
	components : {},
	uids : {},
	ux : {},
	isReady : !1,
	byClass : function(t, e) {
		return "string" == typeof e && (e = mini.byId(e)), jQuery("." + t, e)[0]
	},
	getComponents : function() {
		var t = [];
		for (var e in mini.components) {
			var i = mini.components[e];
			t.push(i)
		}
		return t
	},
	get : function(t) {
		if (!t) return null;
		if (mini.isControl(t)) return t;
		if ("string" == typeof t && "#" == t.charAt(0) && (t = t.substr(1)), "string" == typeof t) return mini.components[t];
		var e = mini.uids[t.uid];
		return e && e.el == t ? e : null
	},
	getbyUID : function(t) {
		return mini.uids[t]
	},
	findControls : function(t, e) {
		if (!t) return [];
		e = e || mini;
		var i = [],
			n = mini.uids;
		for (var s in n) {
			var o = n[s],
				l = t.call(e, o);
			if ((l === !0 || 1 === l) && (i.push(o), 1 === l)) break
		}
		return i
	},
	getChildControls : function(t) {
		var e = mini.get(t);
		if (!e) return [];
		var i = t.el ? t.el : t,
			n = mini.findControls(function(e) {
				return e.el && t != e && mini.isAncestor(i, e.el) && e.within ? !0 : !1
			});
		return n
	},
	emptyFn : function() {},
	createNameControls : function(t, e) {
		if (t && t.el) {
			e || (e = "_");
			for (var i = t.el, n = mini.findControls(function(t) {
						return t.el && t.name && mini.isAncestor(i, t.el) ? !0 : !1
					}), s = 0, o = n.length; o > s; s++) {
				var l = n[s],
					r = e + l.name;
				e === !0 && (r = l.name[0].toUpperCase() + l.name.substring(1, l.name.length)), t[r] = l
			}
		}
	},
	getbyName : function(t, e) {
		var i = mini.isControl(e),
			n = e;
		e && i && (e = e.el), e = mini.byId(e), e = e || document.body;
		var s = this.findControls(function(i) {
			return i.el && i.name == t && mini.isAncestor(e, i.el) ? 1 : !1
		}, this);
		return i && 0 == s.length && n && n.getbyName ? n.getbyName(t) : s[0]
	},
	getParams : function(t) {
		t || (t = location.href), t = t.split("?")[1];
		var e = {};
		if (t)
			for (var i = t.split("&"), n = 0, s = i.length; s > n; n++) {
				var o = i[n].split("=");
				try {
					e[o[0]] = decodeURIComponent(unescape(o[1]))
				} catch (l) {}
		}
		return e
	},
	reg : function(t) {
		this.components[t.id] = t, this.uids[t.uid] = t
	},
	unreg : function(t) {
		delete mini.components[t.id]
		,
		delete mini.uids[t.uid]
	},
	classes : {},
	uiClasses : {},
	getClass : function(t) {
		return t ? this.classes[t.toLowerCase()] : null
	},
	getClassByUICls : function(t) {
		return this.uiClasses[t.toLowerCase()]
	},
	idPre : "mini-",
	idIndex : 1,
	newId : function(t) {
		return (t || this.idPre) + this.idIndex++
	},
	copyTo : function(t, e) {
		if (t && e)
			for (var i in e) t[i] = e[i];
		return t
	},
	copyIf : function(t, e) {
		if (t && e)
			for (var i in e) mini.isNull(t[i]) && (t[i] = e[i]);
		return t
	},
	createDelegate : function(t, e) {
		return t ? function() {
			return t.apply(e, arguments)
		} : function() {}
	},
	isControl : function(t) {
		return !(!t || !t.isControl)
	},
	isElement : function(t) {
		return t && t.appendChild
	},
	isDate : function(t) {
		return !(!t || !t.getFullYear)
	},
	isArray : function(t) {
		return !(!t || !t.unshift)
	},
	isNull : function(t) {
		return null === t || void 0 === t
	},
	isNumber : function(t) {
		return !isNaN(t) && "number" == typeof t
	},
	isEquals : function(t, e) {
		return 0 === t || 0 === e || !mini.isNull(t) && "" != t || !mini.isNull(e) && "" != e ? t && e && t.getFullYear && e.getFullYear ? t.getTime() === e.getTime() : "object" == typeof t && "object" == typeof e ? mini.encode(t) == mini.encode(e) : String(t) === String(e) : !0
	},
	forEach : function(t, e, i) {
		for (var n = t.clone(), s = 0, o = n.length; o > s; s++) {
			var l = n[s];
			if (e.call(i, l, s, t) === !1) break
		}
	},
	sort : function(t, e, i) {
		i = i || t, t.sort(e)
	},
	removeNode : function(t) {
		jQuery(t).remove()
	},
	elWarp : document.createElement("div")
}, mini_regClass = function(t, e) {
	e = e.toLowerCase(), mini.classes[e] || (mini.classes[e] = t, t.prototype.type = e);
	var i = t.prototype.uiCls;
	mini.isNull(i) || mini.uiClasses[i] || (mini.uiClasses[i] = t)
}, mini_extend = function(t, e, i) {
	if ("function" != typeof e) return this;
	var n = t,
		s = n.prototype,
		o = e.prototype;
	if (n.superclass != o) {
		n.superclass = o, n.superclass.constructor = e;
		for (var l in o) s[l] = o[l];
		if (i)
			for (var l in i) s[l] = i[l];
		return n
	}
}, mini.copyTo(mini, {
	extend : mini_extend,
	regClass : mini_regClass,
	debug : !1
}), mini.namespace = function(t) {
	if ("string" == typeof t) {
		t = t.split(".");
		for (var e = window, i = 0, n = t.length; n > i; i++) {
			var s = t[i],
				o = e[s];
			o || (o = e[s] = {}), e = o
		}
	}
}, mini._getFunctoin = function(t) {
	if ("string" != typeof t) return null;
	for (var e = t.split("."), i = null, n = 0, s = e.length; s > n; n++) {
		var o = e[n];
		if (i = i ? i[o] : window[o], !i) break
	}
	return i
}, mini._getMap = function(name, obj) {
	if (!name) return null;
	if (-1 == name.indexOf(".") && -1 == name.indexOf("[")) return obj[name];
	var s = "obj." + name;
	try {
		var v = eval(s)
	} catch (e) {
		return null
	}
	return v
}, mini._setMap = function(t, e, i) {
	function n(t, e, i, n) {
		var s = t[e];
		s || (s = t[e] = []);
		for (var o = 0; i >= o; o++) {
			var l = s[o];
			l || (l = null === n || void 0 === n ? s[o] = {} : s[o] = n)
		}
		return t[e][i]
	}
	if (i && "string" == typeof t) {
		for (var s = t.split("."), o = null, l = 0, r = s.length; r - 1 >= l; l++) {
			var t = s[l];
			if (l == r - 1) {
				if (-1 == t.indexOf("]"))
					i[t] = e;else {
					var a = t.split("["),
						h = a[0],
						d = parseInt(a[1]);
					n(i, h, d, ""), i[h][d] = e
				}
				break
			}
			if (-1 == t.indexOf("]")) o = i[t], r - 2 >= l && null == o && (i[t] = o = {}), i = o;else {
				var a = t.split("["),
					h = a[0],
					d = parseInt(a[1]);
				i = n(i, h, d)
			}
		}
		return e
	}
}, mini.getAndCreate = function(t) {
	return t ? "string" == typeof t ? mini.components[t] : "object" == typeof t ? mini.isControl(t) ? t : mini.isElement(t) ? mini.uids[t.uid] : mini.create(t) : null : null
}, mini.create = function(t) {
	if (!t) return null;
	if (mini.get(t.id) === t) return t;
	var e = this.getClass(t.type);
	if (!e) return null;
	var i = new e;
	return i.set(t), i
}, __mini_setControls = function(t, e, i) {
	e = e || this._contentEl, i = i || this, t || (t = []), mini.isArray(t) || (t = [ t ]);
	for (var n = 0, s = t.length; s > n; n++) {
		var o = t[n];
		"string" == typeof o ? 0 == o.indexOf("#") && (o = mini.byId(o)) : mini.isElement(o) || (o = mini.getAndCreate(o), o = o.el), o && mini.append(e, o)
	}
	return mini.parse(e), i.doLayout(), i
}, mini._Layouts = {}, mini.layout = function(t, e) {
	function i(t) {
		if (t) {
			var n = mini.get(t);
			if (n) n.doLayout && (mini._Layouts[n.uid] || (mini._Layouts[n.uid] = n, (e !== !1 || 0 == n.isFixedSize()) && n.doLayout(!1),
				delete mini._Layouts[n.uid]
				));else {
				var s = t.childNodes;
				if (s)
					for (var o = 0, l = s.length; l > o; o++) {
						var r = s[o];
						i(r)
				}
			}
		}
	}
	document.body && (t || (t = document.body), i(t), t == document.body && mini.layoutIFrames())
}, mini.applyTo = function(t) {
	if (t = mini.byId(t), !t) return this;
	if (mini.get(t))
		throw new Error("not applyTo a mini control");
	var e = this.getAttrs(t);
	delete e._applyTo
	, mini.isNull(e.defaultValue) && !mini.isNull(e.value) && (e.defaultValue = e.value);
	var i = t.parentNode;
	return i && this.el != t && i.replaceChild(this.el, t), this.set(e), this._afterApply(t), this
}, mini._Removes = [], mini._ParseString = function(t, e, i) {
	for (var n = 0, s = i.length; s > n; n++) {
		var o = i[n],
			l = mini.getAttr(t, o);
		l && (e[o] = l)
	}
}, mini._ParseBool = function(t, e, i) {
	for (var n = 0, s = i.length; s > n; n++) {
		var o = i[n],
			l = mini.getAttr(t, o);
		l && (e[o] = "true" == l ? !0 : !1)
	}
}, mini._ParseInt = function(t, e, i) {
	for (var n = 0, s = i.length; s > n; n++) {
		var o = i[n],
			l = parseInt(mini.getAttr(t, o));
		isNaN(l) || (e[o] = l)
	}
}, mini._ParseColumns = function(el) {
	for (var columns = [], cs = mini.getChildNodes(el), i = 0, l = cs.length; l > i; i++) {
		var node = cs[i],
			jq = jQuery(node),
			column = {},
			editor = null,
			filter = null,
			subCs = mini.getChildNodes(node);
		if (subCs)
			for (var ii = 0, li = subCs.length; li > ii; ii++) {
				var subNode = subCs[ii],
					property = jQuery(subNode).attr("property");
				if (property && (property = property.toLowerCase(), "columns" == property && (column.columns = mini._ParseColumns(subNode), jQuery(subNode).remove()), "editor" == property || "filter" == property)) {
					for (var className = subNode.className, classes = className.split(" "), i3 = 0, l3 = classes.length; l3 > i3; i3++) {
						var cls = classes[i3],
							clazz = mini.getClassByUICls(cls);
						if (clazz) {
							var ui = new clazz;
							"filter" == property ? (filter = ui.getAttrs(subNode), filter.type = ui.type) : (editor = ui.getAttrs(subNode), editor.type = ui.type);break
						}
					}
					jQuery(subNode).remove()
				}
		}
		column.header = node.innerHTML, mini._ParseString(node, column, [ "name", "header", "field", "editor", "filter", "renderer", "width", "type", "renderer", "headerAlign", "align", "headerCls", "cellCls", "headerStyle", "cellStyle", "displayField", "dateFormat", "listFormat", "mapFormat", "trueValue", "falseValue", "dataType", "vtype", "currencyUnit", "digit", "summaryType", "summaryRenderer", "groupSummaryType", "groupSummaryRenderer", "defaultValue", "defaultText", "decimalPlaces", "data-options", "emptyText" ]), mini._ParseBool(node, column, [ "visible", "readOnly", "allowSort", "allowResize", "allowMove", "allowDrag", "autoShowPopup", "unique", "showPercent", "autoEscape" ]), void 0 === column.autoEscape && (column.autoEscape = !0), editor && (column.editor = editor), filter && (column.filter = filter), column.dataType && (column.dataType = column.dataType.toLowerCase()), "true" === column.defaultValue && (column.defaultValue = !0), "false" === column.defaultValue && (column.defaultValue = !1), columns.push(column);var options = column["data-options"];
		options && (options = eval("(" + options + ")"), options && mini.copyTo(column, options))
	}
	return columns
}, mini._topWindow = null, mini._getTopWindow = function() {
	function t(i) {
		try {
			i.___try = 1, e.push(i)
		} catch (n) {}
		i.parent && i.parent != i && t(i.parent)
	}
	if (mini._topWindow) return mini._topWindow;
	var e = [];
	return t(window), mini._topWindow = e[e.length - 1], mini._topWindow
};
var __ps = mini.getParams();
if (__ps._winid) try {
		window.Owner = mini._getTopWindow()[__ps._winid]
	} catch (ex) {}
mini._WindowID = "w" + Math.floor(1e4 * Math.random()), mini._getTopWindow()[mini._WindowID] = window, mini.__IFrameCreateCount = 1, mini.createIFrame = function(t, e) {
	function i() {
		0 != h && setTimeout(function() {
			e && e(a, d), d = !1
		}, 1)
	}
	var n = "__iframe_onload" + mini.__IFrameCreateCount++;
	window[n] = i, t || (t = "");
	var s = t.split("#");
	t = s[0];
	var o = "_t=" + Math.floor(1e6 * Math.random());
	t += -1 == t.indexOf("?") ? "?" + o : "&" + o, s[1] && (t = t + "#" + s[1]);
	var l = '<iframe style="width:100%;height:100%;" onload="' + n + '()"  frameborder="0"></iframe>',
		r = document.createElement("div"),
		a = mini.append(r, l),
		h = !1;
	setTimeout(function() {
		a && (a.src = t, h = !0)
	}, 5);
	var d = !0;
	return a._ondestroy = function() {
			window[n] = mini.emptyFn, a.onload = function() {}, jQuery(a).unbind("load"), a.src = "";try {
				a.contentWindow.document.write(""), a.contentWindow.document.close()
			} catch (t) {}
			a._ondestroy = null, a = null
		}, a
}, mini._doOpen = function(t) {
	"string" == typeof t && (t = {
		url : t
	}), t = mini.copyTo({
		width : 700,
		height : 400,
		allowResize : !0,
		allowModal : !0,
		closeAction : "destroy",
		title : "",
		titleIcon : "",
		iconCls : "",
		iconStyle : "",
		bodyStyle : "padding: 0",
		url : "",
		showCloseButton : !0,
		showFooter : !1
	}, t), t.closeAction || (t.closeAction = "destroy");
	var e = t.onload;
	delete t.onload;
	var i = t.ondestroy;
	delete t.ondestroy;
	var n = t.url;
	delete t.url;
	var s = new mini.Window;
	return s.set(t), s.load(n, e, i), s.show(), s
}, mini.open = function(t) {
	function e(t) {
		try {
			t.mini && p.push(t), t.parent && t.parent != t && e(t.parent)
		} catch (i) {}
	}
	if (t) {
		var i = t.currentWindow;
		i || (i = !1);
		var n = t.url;
		n || (n = "");
		var s = n.split("#"),
			n = s[0],
			o = "_winid=" + mini._WindowID;
		n += -1 == n.indexOf("?") ? "?" + o : "&" + o, s[1] && (n = n + "#" + s[1]);
		var l = -1 != n.indexOf("http");
		if (l)
			t.url = n;
		else if (i)
			t.url = n;else {
			var r = document.getElementsByTagName("BASE"),
				a = r && r.length ? r[0].href : null;
			if (a)
				t.url = a + "/" + n;else {
				var h = n.substr(0, 1);
				if ("/" == h)
					t.url = window.location.protocol + "//" + window.location.host + n;else {
					var d = location.href,
						u = -1 != d.indexOf("?");
					u && (d = d.substring(0, d.indexOf("?")));
					var c = d.split("/");
					c.length = c.length - 1;
					var m = c.join("/");
					t.url = m + "/" + n
				}
			}
		}
		t.Owner = window;
		var p = [];
		e(window);
		var f = p[p.length - 1];
		return t.win = f, t.beforeopen && t.beforeopen(t), i ? mini._doOpen(t) : f.mini._doOpen(t)
	}
}, mini.openTop = mini.open, mini.getData = function(t, e, i, n, s) {
	var o = mini.getText(t, e, i, n, s),
		l = mini.decode(o);
	return l
}, mini.getText = function(t, e, i, n, s) {
	var o = null;
	return mini.ajax({
			url : t,
			data : e,
			async : !1,
			type : s ? s : "get",
			cache : !1,
			success : function(t, e) {
				o = t, i && i(t, e)
			},
			error : n
		}), o
}, mini.update = function(t, e) {
	"string" == typeof t && (t = {
		url : t
	}), e && (t.el = e);
	var i = mini.loadText(t.url);
	mini.innerHTML(t.el, i), mini.parse(t.el)
}, mini.createSingle = function(t) {
	if ("string" == typeof t && (t = mini.getClass(t)), "function" == typeof t) {
		var e = t.single;
		return e || (e = t.single = new t), e
	}
}, mini.createTopSingle = function(t) {
	if ("function" == typeof t) {
		var e = t.prototype.type;
		return top && top != window && top.mini && top.mini.getClass(e) ? top.mini.createSingle(e) : mini.createSingle(t)
	}
}, mini.sortTypes = {
	string : function(t) {
		return String(t).toUpperCase()
	},
	date : function(t) {
		return t ? mini.isDate(t) ? t.getTime() : mini.parseDate(String(t)) : 0
	},
	"float" : function(t) {
		var e = parseFloat(String(t).replace(/,/g, ""));
		return isNaN(e) ? -(1 / 0) : e
	},
	"int" : function(t) {
		var e = parseInt(String(t).replace(/,/g, ""), 10);
		return isNaN(e) ? -(1 / 0) : e
	},
	currency : function(t) {
		var e = parseFloat(String(t).replace(/,/g, ""));
		return isNaN(e) ? -(1 / 0) : e
	},
	percent : function(t) {
		var e = parseFloat(String(t).replace(/,/g, ""));
		return isNaN(e) ? -(1 / 0) : e
	}
}, mini.emptyFn = function() {}, mini.clone = function(t, e) {
	function i(t) {
		for (var e = 0, n = t.length; n > e; e++) {
			var s = t[e];
			delete s._state
			,
			delete s._id
			,
			delete s._pid
			,
			delete s._uid;
			for (var o in s) {
				var l = s[o];
				l instanceof Array && i(l)
			}
		}
	}
	if (null === t || void 0 === t) return t;
	var n = mini.encode(t),
		s = mini.decode(n);
	return e !== !1 && i(s instanceof Array ? s : [ s ]), s
}, mini.append = function(t, e) {
	if (t = mini.byId(t), e && t) {
		if ("string" == typeof e) {
			if ("#" == e.charAt(0)) {
				if (e = mini.byId(e), !e) return;
				return t.appendChild(e), e
			}
			if (0 == e.indexOf("<tr")) return jQuery(t).append(e)[0].lastChild;
			var i = document.createElement("div");
			for (i.innerHTML = e, e = i.firstChild; i.firstChild;) t.appendChild(i.firstChild);
			return e
		}
		return t.appendChild(e), e
	}
}, mini.prepend = function(t, e) {
	if ("string" == typeof e)
		if ("#" == e.charAt(0))
			e = mini.byId(e);else {
			var i = document.createElement("div");
			i.innerHTML = e, e = i.firstChild
	}
	return jQuery(t).prepend(e)[0].firstChild
}, mini.after = function(t, e) {
	if ("string" == typeof e)
		if ("#" == e.charAt(0))
			e = mini.byId(e);else {
			var i = document.createElement("div");
			i.innerHTML = e, e = i.firstChild
	}
	return e && t ? (t.nextSibling ? t.parentNode.insertBefore(e, t.nextSibling) : t.parentNode.appendChild(e), e) : void 0
}, mini.before = function(t, e) {
	if ("string" == typeof e)
		if ("#" == e.charAt(0))
			e = mini.byId(e);else {
			var i = document.createElement("div");
			i.innerHTML = e, e = i.firstChild
	}
	return e && t ? (t.parentNode.insertBefore(e, t), e) : void 0
}, mini.__wrap = document.createElement("div"), mini.createElements = function(t) {
	mini.removeChilds(mini.__wrap);
	var e = 0 == t.indexOf("<tr");
	return e && (t = "<table>" + t + "</table>"), mini.__wrap.innerHTML = t, e ? mini.__wrap.firstChild.rows : mini.__wrap.childNodes
}, mini_byId = function(t, e) {
	if ("string" == typeof t) {
		"#" == t.charAt(0) && (t = t.substr(1));
		var i = document.getElementById(t);
		if (i) return i;
		if (e) {
			for (var n = e.getElementsByTagName("*"), s = 0, o = n.length; o > s; s++) {
				var i = n[s];
				if (i.id == t) return i
			}
			i = null
		}
		return i
	}
	return t
}, mini_hasClass = function(t, e) {
	if (t = mini.byId(t)) {
		if (!t.className) return !1;
		var i = String(t.className).split(" ");
		return -1 != i.indexOf(e)
	}
}, mini_addClass = function(t, e) {
	e && 0 == mini.hasClass(t, e) && jQuery(t).addClass(e)
}, mini_removeClass = function(t, e) {
	e && jQuery(t).removeClass(e)
}, mini_getMargins = function(t) {
	t = mini.byId(t);
	var e = jQuery(t);
	return {
		top : parseInt(e.css("margin-top"), 10) || 0,
		left : parseInt(e.css("margin-left"), 10) || 0,
		bottom : parseInt(e.css("margin-bottom"), 10) || 0,
		right : parseInt(e.css("margin-right"), 10) || 0
	}
}, mini_getBorders = function(t) {
	t = mini.byId(t);
	var e = jQuery(t);
	return {
		top : parseInt(e.css("border-top-width"), 10) || 0,
		left : parseInt(e.css("border-left-width"), 10) || 0,
		bottom : parseInt(e.css("border-bottom-width"), 10) || 0,
		right : parseInt(e.css("border-right-width"), 10) || 0
	}
}, mini_getPaddings = function(t) {
	t = mini.byId(t);
	var e = jQuery(t);
	return {
		top : parseInt(e.css("padding-top"), 10) || 0,
		left : parseInt(e.css("padding-left"), 10) || 0,
		bottom : parseInt(e.css("padding-bottom"), 10) || 0,
		right : parseInt(e.css("padding-right"), 10) || 0
	}
}, mini_setWidth = function(t, e) {
	if (t = mini.byId(t), e = parseInt(e), !isNaN(e) && t) {
		if (jQuery.boxModel) {
			var i = mini.getPaddings(t),
				n = mini.getBorders(t);
			e = e - i.left - i.right - n.left - n.right
		}
		0 > e && (e = 0), t.style.width = e + "px"
	}
}, mini_setHeight = function(t, e) {
	if (t = mini.byId(t), e = parseInt(e), !isNaN(e) && t) {
		if (jQuery.boxModel) {
			var i = mini.getPaddings(t),
				n = mini.getBorders(t);
			e = e - i.top - i.bottom - n.top - n.bottom
		}
		0 > e && (e = 0), t.style.height = e + "px"
	}
}, mini_getWidth = function(t, e) {
	return t = mini.byId(t), "none" == t.style.display || "text/javascript" == t.type ? 0 : e ? jQuery(t).width() : jQuery(t).outerWidth()
}, mini_getHeight = function(t, e) {
	return t = mini.byId(t), jQuery(t).is(":visible") && "text/javascript" != t.type ? e ? jQuery(t).height() : jQuery(t).outerHeight() : 0
}, mini_setBox = function(t, e, i, n, s) {
	void 0 === i && (i = e.y, n = e.width, s = e.height, e = e.x), mini.setXY(t, e, i), mini.setWidth(t, n), mini.setHeight(t, s)
}, mini_getBox = function(t) {
	var e = mini.getXY(t),
		i = mini.getWidth(t),
		n = mini.getHeight(t),
		s = {
			x : e[0],
			y : e[1],
			width : i,
			height : n
		};
	return s.left = s.x, s.top = s.y, s.right = s.x + s.width, s.bottom = s.y + s.height, s
}, mini_setStyle = function(t, e) {
	if (t = mini.byId(t), t && "string" == typeof e)
		for (var i = jQuery(t), n = e.toLowerCase().split(";"), s = 0, o = n.length; o > s; s++) {
			var l = n[s],
				r = l.split(":");
			if (r.length > 1)
				if (r.length > 2) {
					var a = r[0].trim();
					r.removeAt(0);
					var h = r.join(":").trim();
					i.css(a, h)
				} else i.css(r[0].trim(), r[1].trim())
	}
}, mini_getStyle = function() {
	var t = document.defaultView;
	return new Function("el", "style", [ "style.indexOf('-')>-1 && (style=style.replace(/-(\\w)/g,function(m,a){return a.toUpperCase()}));", "style=='float' && (style='", t ? "cssFloat" : "styleFloat", "');return el.style[style] || ", t ? "window.getComputedStyle(el, null)[style]" : "el.currentStyle[style]", " || null;" ].join(""))
}(), mini_isAncestor = function(t, e) {
	var i = !1;
	if (t = mini.byId(t), e = mini.byId(e), t === e) return !0;
	if (t && e)
		if (t.contains) try {
				return t.contains(e)
			} catch (n) {
				return !1
		} else {
			if (t.compareDocumentPosition) return !!(16 & t.compareDocumentPosition(e));
			for (; e = e.parentNode;) i = e == t || i
	}
	return i
}, mini_findParent = function(t, e, i) {
	t = mini.byId(t);
	var n,
		s = document.body,
		o = 0;
	for (i = i || 50, "number" != typeof i && (n = mini.byId(i), i = 10); t && 1 == t.nodeType && i > o && t != s && t != n;) {
		if (mini.hasClass(t, e)) return t;
		o++, t = t.parentNode
	}
	return null
}, mini.copyTo(mini, {
	byId : mini_byId,
	hasClass : mini_hasClass,
	addClass : mini_addClass,
	removeClass : mini_removeClass,
	getMargins : mini_getMargins,
	getBorders : mini_getBorders,
	getPaddings : mini_getPaddings,
	setWidth : mini_setWidth,
	setHeight : mini_setHeight,
	getWidth : mini_getWidth,
	getHeight : mini_getHeight,
	setBox : mini_setBox,
	getBox : mini_getBox,
	setStyle : mini_setStyle,
	getStyle : mini_getStyle,
	repaint : function(t) {
		t || (t = document.body), mini.addClass(t, "mini-repaint"), setTimeout(function() {
			mini.removeClass(t, "mini-repaint")
		}, 1)
	},
	getSize : function(t, e) {
		return {
			width : mini.getWidth(t, e),
			height : mini.getHeight(t, e)
		}
	},
	setSize : function(t, e, i) {
		mini.setWidth(t, e), mini.setHeight(t, i)
	},
	setX : function(t, e) {
		e = parseInt(e);
		var i = jQuery(t).offset(),
			n = parseInt(i.top);
		void 0 === n && (n = i[1]), mini.setXY(t, e, n)
	},
	setY : function(t, e) {
		e = parseInt(e);
		var i = jQuery(t).offset(),
			n = parseInt(i.left);
		void 0 === n && (n = i[0]), mini.setXY(t, n, e)
	},
	setXY : function(t, e, i) {
		var n = {
			left : parseInt(e),
			top : parseInt(i)
		};
		jQuery(t).offset(n)
	},
	getXY : function(t) {
		var e = jQuery(t).offset();
		return [ parseInt(e.left), parseInt(e.top) ]
	},
	getViewportBox : function() {
		var t = jQuery(window).width(),
			e = jQuery(window).height(),
			i = jQuery(document).scrollLeft(),
			n = jQuery(document.body).scrollTop();
		return document.documentElement && (n = document.documentElement.scrollTop), {
				x : i,
				y : n,
				top : n,
				left : i,
				width : t,
				height : e,
				right : i + t,
				bottom : n + e
		}
	},
	getChildNodes : function(t, e) {
		if (t = mini.byId(t)) {
			for (var i = t.childNodes, n = [], s = 0, o = i.length; o > s; s++) {
				var l = i[s];
				(1 == l.nodeType || e === !0) && n.push(l)
			}
			return n
		}
	},
	removeChilds : function(t, e) {
		if (t = mini.byId(t))
			for (var i = mini.getChildNodes(t, !0), n = 0, s = i.length; s > n; n++) {
				var o = i[n];
				e && o == e || t.removeChild(i[n])
		}
	},
	isAncestor : mini_isAncestor,
	findParent : mini_findParent,
	findChild : function(t, e) {
		t = mini.byId(t);
		for (var i = t.getElementsByTagName("*"), n = 0, s = i.length; s > n; n++) {
			var t = i[n];
			if (mini.hasClass(t, e)) return t
		}
	},
	isAncestor : function(t, e) {
		var i = !1;
		if (t = mini.byId(t), e = mini.byId(e), t === e) return !0;
		if (t && e)
			if (t.contains) try {
					return t.contains(e)
				} catch (n) {
					return !1
			} else {
				if (t.compareDocumentPosition) return !!(16 & t.compareDocumentPosition(e));
				for (; e = e.parentNode;) i = e == t || i
		}
		return i
	},
	getOffsetsTo : function(t, e) {
		var i = this.getXY(t),
			n = this.getXY(e);
		return [ i[0] - n[0], i[1] - n[1] ]
	},
	scrollIntoView : function(t, e, i) {
		var n = mini.byId(e) || document.body,
			s = this.getOffsetsTo(t, n),
			o = s[0] + n.scrollLeft,
			l = s[1] + n.scrollTop,
			r = l + t.offsetHeight,
			a = o + t.offsetWidth,
			h = n.clientHeight,
			d = parseInt(n.scrollTop, 10),
			u = parseInt(n.scrollLeft, 10),
			c = d + h,
			m = u + n.clientWidth;
		return t.offsetHeight > h || d > l ? n.scrollTop = l : r > c && (n.scrollTop = r - h), n.scrollTop = n.scrollTop, i !== !1 && (t.offsetWidth > n.clientWidth || u > o ? n.scrollLeft = o : a > m && (n.scrollLeft = a - n.clientWidth), n.scrollLeft = n.scrollLeft), this
	},
	setOpacity : function(t, e) {
		jQuery(t).css({
			opacity : e
		})
	},
	selectable : function(t, e) {
		t = mini.byId(t), e ? (jQuery(t).removeClass("mini-unselectable"), isIE ? t.unselectable = "off" : (t.style.MozUserSelect = "", t.style.KhtmlUserSelect = "", t.style.UserSelect = "")) : (jQuery(t).addClass("mini-unselectable"), isIE ? t.unselectable = "on" : (t.style.MozUserSelect = "none", t.style.UserSelect = "none", t.style.KhtmlUserSelect = "none"))
	},
	selectRange : function(t, e, i) {
		if (t.createTextRange) {
			var n = t.createTextRange();
			n.moveStart("character", e), n.moveEnd("character", i - t.value.length), n.select()
		} else t.setSelectionRange && t.setSelectionRange(e, i);
		try {
			t.focus()
		} catch (s) {}
	},
	getSelectRange : function(t) {
		if (t = mini.byId(t)) {
			try {
				t.focus()
			} catch (e) {}
			var i = 0,
				n = 0;
			if (t.createTextRange) {
				var s = document.selection.createRange().duplicate();
				s.moveEnd("character", t.value.length), i = "" === s.text ? t.value.length : t.value.lastIndexOf(s.text);
				var s = document.selection.createRange().duplicate();
				s.moveStart("character", -t.value.length), n = s.text.length
			} else i = t.selectionStart, n = t.selectionEnd;
			return [ i, n ]
		}
	}
}), function() {
	var t = {
			tabindex : "tabIndex",
			readonly : "readOnly",
			"for" : "htmlFor",
			"class" : "className",
			maxlength : "maxLength",
			cellspacing : "cellSpacing",
			cellpadding : "cellPadding",
			rowspan : "rowSpan",
			colspan : "colSpan",
			usemap : "useMap",
			frameborder : "frameBorder",
			contenteditable : "contentEditable"
		},
		e = document.createElement("div");
	e.setAttribute("class", "t");
	var i = "t" === e.className;
	mini.setAttr = function(e, n, s) {
		e.setAttribute(i ? n : t[n] || n, s)
	}, mini.getAttr = function(e, n) {
		if ("value" == n && (isIE6 || isIE7)) {
			var s = e.attributes[n];
			return s ? s.value : null
		}
		var o = e.getAttribute(i ? n : t[n] || n);
		if ("function" == typeof o && (o = e.attributes[n].value), !o && "onload" == n) {
			var l = e.getAttributeNode ? e.getAttributeNode(n) : null;
			l && (o = l.nodeValue)
		}
		return o
	}
}(), mini.copyTo(mini, {
	treeToArray : function(t, e, i, n, s) {
		e || (e = "children");
		for (var o = [], l = 0, r = t.length; r > l; l++) {
			var a = t[l];
			o[o.length] = a, n && (a[n] = s);var h = a[e];
			if (h && h.length > 0) {
				var d = a[i],
					u = this.treeToArray(h, e, i, n, d);
				o.addRange(u)
			}
		}
		return o
	},
	arrayToTree : function(t, e, i, n) {
		e || (e = "children"), i = i || "_id", n = n || "_pid";
		for (var s = [], o = {}, l = 0, r = t.length; r > l; l++) {
			var a = t[l];
			if (a) {
				var h = a[i];
				null !== h && void 0 !== h && (o[h] = a),
				delete a[e]
			}
		}
		for (var l = 0, r = t.length; r > l; l++) {
			var a = t[l],
				d = o[a[n]];
			d ? (d[e] || (d[e] = []), d[e].push(a)) : s.push(a)
		}
		return s
	}
}), mini.treeToList = mini.treeToArray, mini.listToTree = mini.arrayToTree, mini.copyTo(mini, {
	measureText : function(t, e, i) {
		if (this.measureEl || (this.measureEl = mini.append(document.body, "<div></div>")), this.measureEl.style.cssText = "position:absolute;left:-1000px;top:-1000px;visibility:hidden;", "string" == typeof t)
			this.measureEl.className = t;else {
			this.measureEl.className = "";
			for (var n = jQuery(t), s = jQuery(this.measureEl), o = [ "font-size", "font-style", "font-weight", "font-family", "line-height", "text-transform", "letter-spacing" ], l = 0, r = o.length; r > l; l++) {
				var a = o[l];
				s.css(a, n.css(a))
			}
		}
		return i && mini.setStyle(this.measureEl, i), this.measureEl.innerHTML = e, mini.getSize(this.measureEl)
	}
}), mini.__LastWindowWidth = document.documentElement.clientWidth, mini.__LastWindowHeight = document.documentElement.clientHeight, mini.allowLayout = !0, mini.isDisplay = function(t, e) {
	for (var i = e || document.body;;) {
		if (null == t || !t.style) return !1;
		if (t && t.style && "none" == t.style.display) return !1;
		if (t == i) return !0;
		t = t.parentNode
	}
	return !0
}, mini.isWindowDisplay = function() {
	try {
		var t = window.parent,
			e = t != window;
		if (e) {
			for (var i = t.document.getElementsByTagName("iframe"), n = t.document.getElementsByTagName("frame"), s = [], o = 0, l = i.length; l > o; o++) s.push(i[o]);
			for (var o = 0, l = n.length; l > o; o++) s.push(n[o]);
			for (var r = null, o = 0, l = s.length; l > o; o++) {
				var a = s[o];
				if (a.contentWindow == window) {
					r = a;break
				}
			}
			return r ? mini.isDisplay(r, t.document.body) : !1
		}
		return !0
	} catch (h) {
		return !0
	}
}, mini.WindowVisible = mini.isWindowDisplay(), mini.layoutIFrames = function(t) {
	if (t || (t = document.body), t) {
		var e = t.getElementsByTagName("iframe");
		setTimeout(function() {
			for (var i = 0, n = e.length; n > i; i++) {
				var s = e[i];
				try {
					mini.isDisplay(s) && mini.isAncestor(t, s) && (s.contentWindow.mini && (0 == s.contentWindow.mini.WindowVisible ? (s.contentWindow.mini.WindowVisible = s.contentWindow.mini.isWindowDisplay(), s.contentWindow.mini.layout()) : s.contentWindow.mini.layout(null, !1)), s.contentWindow.mini.layoutIFrames())
				} catch (o) {}
			}
		}, 30)
	}
}, mini.zIndex = 1e3, mini.getMaxZIndex = function() {
	return mini.zIndex++
}, mini._placeholder = function(t) {
	function e() {
		var e = t._placeholder_label;
		if (e) {
			var i = t.getAttribute("placeholder");
			i || (i = t.placeholder), t.value ? e.style.display = "none" : (e.innerHTML = i, e.style.display = "", t.disabled && (e.disabled = !0))
		}
	}
	if (t = mini.byId(t), t && isIE && !isIE10) {
		if (t._placeholder) return void e();
		t._placeholder = !0;
		var i = document.createElement("label");
		i.className = "mini-placeholder-label", t.parentNode.appendChild(i), t._placeholder_label = i, i.onmousedown = function() {
			t.focus()
		}, t.onpropertychange = function(t) {
			t = t || window.event, "value" == t.propertyName && e()
		}, e(), mini.on(t, "focus", function(e) {
			t.readOnly || (i.style.display = "none")
		}), mini.on(t, "blur", function(t) {
			e()
		})
	}
}, mini.removeChildUI = function(t, e) {
	if ("string" == typeof t && (t = document.getElementById(t)), t) {
		for (var i = mini.getChildNodes(t, !1), n = 0; n < i.length; n++) {
			var s = i[n];
			if (s.uid) {
				var o = mini.get(s);
				mini.isControl(o) && o.destroy()
			} else mini.removeChildUI(s)
		}
		e && jQuery(t).html("")
	}
}, mini.ajax = function(t) {
	return t.dataType || (t.dataType = "text"), window.jQuery.ajax(t)
}, mini.getCalculatedOffset = function(t, e, i, n) {
	return "bottom" == t ? {
		top : e.top + e.height,
		left : e.left + e.width / 2 - i / 2
	} : "top" == t ? {
		top : e.top - n,
		left : e.left + e.width / 2 - i / 2
	} : "left" == t ? {
		top : e.top + e.height / 2 - n / 2,
		left : e.left - i
	} : "bottomleft" == t ? {
		top : e.top + e.height,
		left : e.left
	} : "bottomright" == t ? {
		top : e.top + e.height,
		left : e.left + e.width - i
	} : "topleft" == t ? {
		top : e.top - n,
		left : e.left
	} : "topright" == t ? {
		top : e.top - n,
		left : e.left + e.width - i
	} : {
		top : e.top + e.height / 2 - n / 2,
		left : e.left + e.width
	}
}, mini.objToLine = function(t, e) {
	function i(t, e) {
		for (var i in t) {
			var s = t[i];
			null === s || void 0 === s ? e ? n[e + "." + i] = t[i] : n[i] = t[i] : "[object Object]" == Object.prototype.toString.call(t[i]) ? e ? arguments.callee(s, e + "." + i) : arguments.callee(s, i) : e ? n[e + "." + i] = t[i] : n[i] = t[i]
		}
	}
	var n = {};
	return null == t ? n : (i(t, e), n)
}, jQuery.ajaxSetup({
	cache : !1
}), "undefined" == typeof window.rootpath && (rootpath = "/"), "undefined" == typeof mini_debugger && (mini_debugger = !0), "undefined" == typeof mini_useShims && (mini_useShims = !1), "undefined" == typeof mini_autoRun && (mini_autoRun = !0), mini_CreateJSPath = function(t) {
	for (var e = document.getElementsByTagName("script"), i = "", n = 0, s = e.length; s > n; n++) {
		var o = e[n].src;
		if (-1 != o.indexOf(t)) {
			var l = o.split(t);
			i = l[0];break
		}
	}
	var r = location.href;
	r = r.split("#")[0], r = r.split("?")[0];
	var l = r.split("/");
	return l.length = l.length - 1, r = l.join("/"), -1 == i.indexOf("http:") && -1 == i.indexOf("file:") && (i = r + "/" + i), i
}, window.mini_JSPath || (mini_JSPath = mini_CreateJSPath("miniui.js"));
var ua = navigator.userAgent.toLowerCase(),
	check = function(t) {
		return t.test(ua)
	},
	DOC = document,
	isStrict = "CSS1Compat" == document.compatMode,
	version = function(t, e) {
		var i;
		return t && (i = e.exec(ua)) ? parseFloat(i[1]) : 0
	},
	docMode = document.documentMode,
	isOpera = check(/opera/),
	isOpera10_5 = isOpera && check(/version\/10\.5/),
	isChrome = check(/\bchrome\b/),
	isWebKit = check(/webkit/),
	isSafari = !isChrome && check(/safari/),
	isSafari2 = isSafari && check(/applewebkit\/4/),
	isSafari3 = isSafari && check(/version\/3/),
	isSafari4 = isSafari && check(/version\/4/),
	isSafari5_0 = isSafari && check(/version\/5\.0/),
	isSafari5 = isSafari && check(/version\/5/),
	isIE = !isOpera && check(/msie/),
	isIE7 = isIE && (check(/msie 7/) && 8 != docMode && 9 != docMode && 10 != docMode || 7 == docMode),
	isIE8 = isIE && (check(/msie 8/) && 7 != docMode && 9 != docMode && 10 != docMode || 8 == docMode),
	isIE9 = isIE && (check(/msie 9/) && 7 != docMode && 8 != docMode && 10 != docMode || 9 == docMode),
	isIE10 = isIE && (check(/msie 10/) && 7 != docMode && 8 != docMode && 9 != docMode || 10 == docMode),
	isIE11 = ua.indexOf("trident") > -1 && ua.indexOf("rv") > -1,
	isIE6 = !(!isIE || isIE7 || isIE8 || isIE9 || isIE10 || isIE11),
	isFirefox = navigator.userAgent.indexOf("Firefox") > 0,
	isGecko = !isWebKit && check(/gecko/),
	isGecko3 = isGecko && check(/rv:1\.9/),
	isGecko4 = isGecko && check(/rv:2\.0/),
	isGecko5 = isGecko && check(/rv:5\./),
	isGecko10 = isGecko && check(/rv:10\./),
	isFF3_0 = isGecko3 && check(/rv:1\.9\.0/),
	isFF3_5 = isGecko3 && check(/rv:1\.9\.1/),
	isFF3_6 = isGecko3 && check(/rv:1\.9\.2/),
	isWindows = check(/windows|win32/),
	isMac = check(/macintosh|mac os x/),
	isAir = check(/adobeair/),
	isLinux = check(/linux/),
	scrollbarSize = null,
	chromeVersion = version(!0, /\bchrome\/(\d+\.\d+)/),
	firefoxVersion = version(!0, /\bfirefox\/(\d+\.\d+)/),
	ieVersion = version(isIE, /msie (\d+\.\d+)/),
	operaVersion = version(isOpera, /version\/(\d+\.\d+)/),
	safariVersion = version(isSafari, /version\/(\d+\.\d+)/),
	webKitVersion = version(isWebKit, /webkit\/(\d+\.\d+)/),
	isSecure = /^https/i.test(window.location.protocol),
	isBorderBox = isIE && !isStrict;
if (isIE6) try {
		DOC.execCommand("BackgroundImageCache", !1, !0)
	} catch (e) {}
mini.boxModel = !isBorderBox, mini.isIE = isIE, mini.isIE6 = isIE6, mini.isIE7 = isIE7, mini.isIE8 = isIE8, mini.isIE9 = isIE9, mini.isFirefox = isFirefox, mini.isOpera = isOpera, mini.isSafari = isSafari, jQuery && (jQuery.boxModel = mini.boxModel), mini.noBorderBox = !1, 0 == jQuery.boxModel && isIE && 0 == isIE9 && (mini.noBorderBox = !0), mini.copyTo(Array.prototype, {
	add : Array.prototype.enqueue = function(t) {
		return this[this.length] = t, this
	},
	getRange : function(t, e) {
		for (var i = [], n = t; e >= n; n++) {
			var s = this[n];
			s && (i[i.length] = s)
		}
		return i
	},
	addRange : function(t) {
		for (var e = 0, i = t.length; i > e; e++) this[this.length] = t[e];
		return this
	},
	clear : function() {
		return this.length = 0, this
	},
	clone : function() {
		return 1 === this.length ? [ this[0] ] : Array.apply(null, this)
	},
	contains : function(t) {
		return this.indexOf(t) >= 0
	},
	indexOf : function(t, e) {
		for (var i = this.length, n = 0 > e ? Math.max(0, i + e) : e || 0; i > n; n++)
			if (this[n] === t) return n;
		return -1
	},
	dequeue : function() {
		return this.shift()
	},
	insert : function(t, e) {
		return this.splice(t, 0, e), this
	},
	insertRange : function(t, e) {
		for (var i = e.length - 1; i >= 0; i--) {
			var n = e[i];
			this.splice(t, 0, n)
		}
		return this
	},
	remove : function(t) {
		var e = this.indexOf(t);
		return e >= 0 && this.splice(e, 1), e >= 0
	},
	removeAt : function(t) {
		var e = this[t];
		return this.splice(t, 1), e
	},
	removeRange : function(t) {
		t = t.clone();
		for (var e = 0, i = t.length; i > e; e++) this.remove(t[e])
	}
}), Date.prototype.getHalfYear = function() {
	if (!this.getMonth) return null;
	var t = this.getMonth();
	return 6 > t ? 0 : 1
}, Date.prototype.getQuarter = function() {
	if (!this.getMonth) return null;
	var t = this.getMonth();
	return 3 > t ? 0 : 6 > t ? 1 : 9 > t ? 2 : 3
};
var DAY_MS = 864e5,
	HOUR_MS = 36e5,
	MINUTE_MS = 6e4;
mini.copyTo(mini, {
	clearTime : function(t) {
		return t ? new Date(t.getFullYear(), t.getMonth(), t.getDate()) : null
	},
	maxTime : function(t) {
		return t ? new Date(t.getFullYear(), t.getMonth(), t.getDate(), 23, 59, 59) : null
	},
	cloneDate : function(t) {
		return t ? new Date(t.getTime()) : null
	},
	addDate : function(t, e, i) {
		switch (i || (i = "D"), t = new Date(t.getTime()), i.toUpperCase()) {
		case "Y":
			t.setFullYear(t.getFullYear() + e);
			break;case "MO":
			t.setMonth(t.getMonth() + e);
			break;case "D":
			t.setDate(t.getDate() + e);
			break;case "H":
			t.setHours(t.getHours() + e);
			break;case "M":
			t.setMinutes(t.getMinutes() + e);
			break;case "S":
			t.setSeconds(t.getSeconds() + e);
			break;case "MS":
			t.setMilliseconds(t.getMilliseconds() + e)
		}
		return t
	},
	getWeek : function(t, e, i) {
		e += 1;
		var n = Math.floor((14 - e) / 12),
			s = t + 4800 - n,
			o = e + 12 * n - 3,
			l = i + Math.floor((153 * o + 2) / 5) + 365 * s + Math.floor(s / 4) - Math.floor(s / 100) + Math.floor(s / 400) - 32045,
			r = (l + 31741 - l % 7) % 146097 % 36524 % 1461,
			a = Math.floor(r / 1460),
			h = (r - a) % 365 + a;
		return NumberOfWeek = Math.floor(h / 7) + 1, NumberOfWeek
	},
	getWeekStartDate : function(t, e) {
		if (e || (e = 0), e > 6 || 0 > e)
			throw new Error("out of weekday");
		var i = t.getDay(),
			n = e - i;
		e > i && (n -= 7);
		var s = new Date(t.getFullYear(), t.getMonth(), t.getDate() + n);
		return s
	},
	getShortWeek : function(t) {
		var e = this.dateInfo.daysShort;
		return e[t]
	},
	getLongWeek : function(t) {
		var e = this.dateInfo.daysLong;
		return e[t];
	},
	getShortMonth : function(t) {
		var e = this.dateInfo.monthsShort;
		return e[t]
	},
	getLongMonth : function(t) {
		var e = this.dateInfo.monthsLong;
		return e[t]
	},
	dateInfo : {
		monthsLong : [ "January", "Febraury", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ],
		monthsShort : [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ],
		daysLong : [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ],
		daysShort : [ "Su", "Mo", "Tu", "We", "Th", "Fr", "Sa" ],
		quarterLong : [ "Q1", "Q2", "Q3", "Q4" ],
		quarterShort : [ "Q1", "Q2", "Q3", "Q4" ],
		halfYearLong : [ "first half", "second half" ],
		patterns : {
			d : "M/d/yyyy",
			D : "dddd, MMMM dd, yyyy",
			f : "dddd, MMMM dd, yyyy H:mm tt",
			F : "dddd, MMMM dd, yyyy H:mm:ss tt",
			g : "M/d/yyyy H:mm tt",
			G : "M/d/yyyy H:mm:ss tt",
			m : "MMMM dd",
			o : "yyyy-MM-ddTHH:mm:ss.fff",
			s : "yyyy-MM-ddTHH:mm:ss",
			t : "H:mm tt",
			T : "H:mm:ss tt",
			U : "dddd, MMMM dd, yyyy HH:mm:ss tt",
			y : "MMM, yyyy"
		},
		tt : {
			AM : "AM",
			PM : "PM"
		},
		ten : {
			Early : "Early",
			Mid : "Mid",
			Late : "Late"
		},
		today : "Today",
		clockType : 24
	}
}), mini.formatDate = function(t, e, i) {
	if (!t || !t.getFullYear || isNaN(t)) return "";
	var n = t.toString(),
		s = mini.dateInfo;
	if (s || (s = mini.dateInfo), "undefined" != typeof s) {
		var o = "undefined" != typeof s.patterns[e] ? s.patterns[e] : e,
			l = t.getFullYear(),
			r = t.getMonth(),
			a = t.getDate();
		if ("yyyy-MM-dd" == e) return r = 10 > r + 1 ? "0" + (r + 1) : r + 1, a = 10 > a ? "0" + a : a, l + "-" + r + "-" + a;
		if ("MM/dd/yyyy" == e) return r = 10 > r + 1 ? "0" + (r + 1) : r + 1, a = 10 > a ? "0" + a : a, r + "/" + a + "/" + l;
		n = o.replace(/yyyy/g, l), n = n.replace(/yy/g, (l + "").substring(2));
		var h = t.getHalfYear();
		n = n.replace(/hy/g, s.halfYearLong[h]);
		var d = t.getQuarter();
		n = n.replace(/Q/g, s.quarterLong[d]), n = n.replace(/q/g, s.quarterShort[d]), n = n.replace(/MMMM/g, s.monthsLong[r].escapeDateTimeTokens()), n = n.replace(/MMM/g, s.monthsShort[r].escapeDateTimeTokens()), n = n.replace(/MM/g, 10 > r + 1 ? "0" + (r + 1) : r + 1), n = n.replace(/(\\)?M/g, function(t, e) {
			return e ? t : r + 1
		});
		var u = t.getDay();
		n = n.replace(/dddd/g, s.daysLong[u].escapeDateTimeTokens()), n = n.replace(/ddd/g, s.daysShort[u].escapeDateTimeTokens()), n = n.replace(/dd/g, 10 > a ? "0" + a : a), n = n.replace(/(\\)?d/g, function(t, e) {
			return e ? t : a
		});
		var c = t.getHours(),
			m = c > 12 ? c - 12 : c;
		12 == s.clockType && c > 12 && (c -= 12), n = n.replace(/HH/g, 10 > c ? "0" + c : c), n = n.replace(/(\\)?H/g, function(t, e) {
			return e ? t : c
		}), n = n.replace(/hh/g, 10 > m ? "0" + m : m), n = n.replace(/(\\)?h/g, function(t, e) {
			return e ? t : m
		});
		var p = t.getMinutes();
		n = n.replace(/mm/g, 10 > p ? "0" + p : p), n = n.replace(/(\\)?m/g, function(t, e) {
			return e ? t : p
		});
		var f = t.getSeconds();
		n = n.replace(/ss/g, 10 > f ? "0" + f : f), n = n.replace(/(\\)?s/g, function(t, e) {
			return e ? t : f
		}), n = n.replace(/fff/g, t.getMilliseconds()), n = n.replace(/tt/g, t.getHours() > 12 || 0 == t.getHours() ? s.tt.PM : s.tt.AM);
		var t = t.getDate(),
			g = "";
		g = 10 >= t ? s.ten.Early : 20 >= t ? s.ten.Mid : s.ten.Late, n = n.replace(/ten/g, g)
	}
	return n.replace(/\\/g, "")
}, mini.fixDate = function(t, e) {
	if (+t)
		for (; t.getDate() != e.getDate();) t.setTime(+t + (e > t ? 1 : -1) * HOUR_MS)
}, mini.parseDate = function(s, ignoreTimezone) {
	try {
		var d = eval(s);
		if (d && d.getFullYear) return d
	} catch (ex) {}
	if ("object" == typeof s) return isNaN(s) ? null : s;
	if ("number" == typeof s) {
		var d = new Date(1e3 * s);
		return d.getTime() != s ? null : isNaN(d) ? null : d
	}
	if ("string" == typeof s) {
		if (m = s.match(/^([0-9]{4})([0-9]{2})([0-9]{0,2})$/), m) {
			var date = new Date(parseInt(m[1], 10), parseInt(m[2], 10) - 1);
			return m[3] && date.setDate(m[3]), date
		}
		if (m = s.match(/^([0-9]{4}).([0-9]*)$/), m) {
			var date = new Date(m[1], m[2] - 1);
			return date
		}
		if (s.match(/^\d+(\.\d+)?$/)) {
			var d = new Date(1e3 * parseFloat(s));
			return d.getTime() != s ? null : d
		}
		void 0 === ignoreTimezone && (ignoreTimezone = !0);
		var d = mini.parseISO8601(s, ignoreTimezone) || (s ? new Date(s) : null);
		return isNaN(d) ? null : d
	}
	return null
}, mini.parseISO8601 = function(t, e) {
	var i = t.match(/^([0-9]{4})([-\/\.]([0-9]{1,2})([-\/\.]([0-9]{1,2})([T ]([0-9]{1,2}):([0-9]{1,2})(:([0-9]{1,2})(\.([0-9]+))?)?(Z|(([-+])([0-9]{2})(:?([0-9]{2}))?))?)?)?)?$/);
	if (!i) {
		if (i = t.match(/^([0-9]{4})[-\/\.]([0-9]{2})[-\/\.]([0-9]{2})[T ]([0-9]{1,2})/)) {
			var n = new Date(i[1], i[2] - 1, i[3], i[4]);
			return n
		}
		if (i = t.match(/^([0-9]{4}).([0-9]*)/)) {
			var n = new Date(i[1], i[2] - 1);
			return n
		}
		if (i = t.match(/^([0-9]{4}).([0-9]*).([0-9]*)/)) {
			var n = new Date(i[1], i[2] - 1, i[3]);
			return n
		}
		if (i = t.match(/^([0-9]{2})-([0-9]{2})-([0-9]{4})$/)) {
			var n = new Date(i[3], i[1] - 1, i[2]);
			return n
		}
		return null
	}
	var n = new Date(i[1], 0, 1);
	if (e || !i[14]) {
		var s = new Date(i[1], 0, 1, 9, 0);
		i[3] && (n.setMonth(i[3] - 1), s.setMonth(i[3] - 1)), i[5] && (n.setDate(i[5]), s.setDate(i[5])), mini.fixDate(n, s), i[7] && n.setHours(i[7]), i[8] && n.setMinutes(i[8]), i[10] && n.setSeconds(i[10]), i[12] && n.setMilliseconds(1e3 * Number("0." + i[12])), mini.fixDate(n, s)
	} else {
		n.setUTCFullYear(i[1], i[3] ? i[3] - 1 : 0, i[5] || 1), n.setUTCHours(i[7] || 0, i[8] || 0, i[10] || 0, i[12] ? 1e3 * Number("0." + i[12]) : 0);
		var o = 60 * Number(i[16]) + (i[18] ? Number(i[18]) : 0);
		o *= "-" == i[15] ? 1 : -1, n = new Date(+n + 60 * o * 1e3)
	}
	return n
}, mini.parseTime = function(t, e) {
	if (!t) return null;
	var i = parseInt(t);
	if (i == t && e) return n = new Date(0), "H" == e[0] ? n.setHours(i) : "m" == e[0] ? n.setMinutes(i) : "s" == e[0] && n.setSeconds(i), n;
	var n = mini.parseDate(t);
	if (!n) {
		var s = t.split(":"),
			o = parseInt(parseFloat(s[0])),
			l = parseInt(parseFloat(s[1])),
			r = parseInt(parseFloat(s[2]));
		isNaN(o) || isNaN(l) || isNaN(r) || (n = new Date(0), n.setHours(o), n.setMinutes(l), n.setSeconds(r)), isNaN(o) || "H" != e && "HH" != e ? isNaN(o) || isNaN(l) || "H:mm" != e && "HH:mm" != e ? isNaN(o) || isNaN(l) || "mm:ss" != e || (n = new Date(0), n.setMinutes(o), n.setSeconds(l)) : (n = new Date(0), n.setHours(o), n.setMinutes(l)) : (n = new Date(0), n.setHours(o))
	}
	return n
}, mini.Cookie = {
	get : function(t) {
		for (var e = document.cookie.split("; "), i = null, n = 0; n < e.length; n++) {
			var s = e[n].split("=");
			t == s[0] && (i = s)
		}
		if (i) {
			var o = i[1];
			return void 0 === o ? o : unescape(o)
		}
		return null
	},
	set : function(t, e, i, n) {
		var s = new Date;
		null != i && (s = new Date(s.getTime() + 1e3 * i * 3600 * 24)), document.cookie = t + "=" + escape(e) + (null == i ? "" : "; expires=" + s.toGMTString()) + ";path=/" + (n ? "; domain=" + n : "")
	},
	del : function(t, e) {
		this.set(t, null, -100, e)
	}
}, mini.htmlEncode = function(t) {
	if ("string" != typeof t) return t;
	var e = "";
	return 0 == t.length ? "" : (e = t, e = e.replace(/</g, "&lt;"), e = e.replace(/>/g, "&gt;"), e = e.replace(/ /g, "&nbsp;"), e = e.replace(/\'/g, "&#39;"), e = e.replace(/\"/g, "&quot;"))
}, mini.htmlDecode = function(t) {
	if ("string" != typeof t) return t;
	var e = "";
	return 0 == t.length ? "" : (e = t.replace(/&gt;/g, "&"), e = e.replace(/&lt;/g, "<"), e = e.replace(/&gt;/g, ">"), e = e.replace(/&nbsp;/g, " "), e = e.replace(/&#39;/g, "'"), e = e.replace(/&quot;/g, '"'))
}, mini.JSON = new function() {
	var sb = [],
		_dateFormat = null,
		useHasOwn = !!{}.hasOwnProperty,
		replaceString = function(t, e) {
			var i = m[e];
			return i ? i : (i = e.charCodeAt(), "\\u00" + Math.floor(i / 16).toString(16) + (i % 16).toString(16))
		},
		doEncode = function(t, e) {
			if (null === t) return void (sb[sb.length] = "null");
			var i = typeof t;
			if ("undefined" == i) return void (sb[sb.length] = "null");
			if (t.push) {
				sb[sb.length] = "[";
				var n,
					s,
					o,
					l = t.length;
				for (s = 0; l > s; s += 1) o = t[s], i = typeof o, "undefined" == i || "function" == i || "unknown" == i || (n && (sb[sb.length] = ","), doEncode(o), n = !0);
				return void (sb[sb.length] = "]")
			}
			if (!t.getFullYear) {
				if ("string" == i) return strReg1.test(t) ? (sb[sb.length] = '"', sb[sb.length] = t.replace(strReg2, replaceString), void (sb[sb.length] = '"')) : void (sb[sb.length] = '"' + t + '"');
				if ("number" == i) return void (sb[sb.length] = t);
				if ("boolean" == i) return void (sb[sb.length] = String(t));
				sb[sb.length] = "{";
				var n,
					s,
					o;
				for (s in t) (!useHasOwn || t.hasOwnProperty && t.hasOwnProperty(s)) && (o = t[s], i = typeof o, "undefined" == i || "function" == i || "unknown" == i || (n && (sb[sb.length] = ","), doEncode(s), sb[sb.length] = ":", doEncode(o, s), n = !0));
				return void (sb[sb.length] = "}")
			}
			if (_dateFormat) sb[sb.length] = '"', "function" == typeof _dateFormat ? sb[sb.length] = _dateFormat(t, e) : sb[sb.length] = mini.formatDate(t, _dateFormat), sb[sb.length] = '"';else {
				var r;
				sb[sb.length] = '"', sb[sb.length] = t.getFullYear(), sb[sb.length] = "-", r = t.getMonth() + 1, sb[sb.length] = 10 > r ? "0" + r : r, sb[sb.length] = "-", r = t.getDate(), sb[sb.length] = 10 > r ? "0" + r : r, sb[sb.length] = "T", r = t.getHours(), sb[sb.length] = 10 > r ? "0" + r : r, sb[sb.length] = ":", r = t.getMinutes(), sb[sb.length] = 10 > r ? "0" + r : r, sb[sb.length] = ":", r = t.getSeconds(), sb[sb.length] = 10 > r ? "0" + r : r, sb[sb.length] = '"'
			}
		},
		m = {
			"\b" : "\\b",
			" " : "\\t",
			"\n" : "\\n",
			"\f" : "\\f",
			"\r" : "\\r",
			'"' : '\\"',
			"\\" : "\\\\"
		},
		strReg1 = /["\\\x00-\x1f]/,
		strReg2 = /([\x00-\x1f\\"])/g;
	this.encode = function() {
		return function(t, e) {
			return sb = [], _dateFormat = e, doEncode(t), _dateFormat = null, sb.join("")
		}
	}(), this.decode = function() {
		var dateRe1 = /^(\d{4})-(\d{2})-(\d{2})[T ](\d{2}):(\d{2}):(\d{2}(?:\.*\d*)?)Z*$/,
			dateRe2 = new RegExp("^/+Date\\(([0-9]+).*\\)/+$", "g"),
			re = /[\"\'](\d{4})-(\d{2})-(\d{2})[T ](\d{2}):(\d{2}):(\d{2})[\"\']/g;
		return function(json, parseDate) {
			function evalParse(json) {
				return parseDate !== !1 && (json = json.replace(__js_dateRegEx, "$1new Date($2)"), json = json.replace(re, "new Date($1,$2-1,$3,$4,$5,$6)"), json = json.replace(__js_dateRegEx2, "new Date($1)")), eval("(" + json + ")")
			}
			if ("" === json || null === json || void 0 === json) return json;
			"object" == typeof json && (json = this.encode(json));
			var data = null;
			if (window.JSON && window.JSON.parse) {
				var dateReviver = function(t, e) {
					if ("string" == typeof e) {
						dateRe1.lastIndex = 0;
						var i = dateRe1.exec(e);
						if (i) return e = new Date(i[1], i[2] - 1, i[3], i[4], i[5], i[6]);
						dateRe2.lastIndex = 0;
						var i = dateRe2.exec(e);
						if (i) return e = new Date(parseInt(i[1]))
					}
					return e
				};
				try {
					var json2 = json.replace(__js_dateRegEx, '$1"/Date($2)/"');
					data = window.JSON.parse(json2, dateReviver)
				} catch (ex) {
					data = evalParse(json)
				}
			} else
				data = evalParse(json);
			return data
		}
	}()
}, __js_dateRegEx = new RegExp('(^|[^\\\\])\\"\\\\/Date\\((-?[0-9]+)(?:[a-zA-Z]|(?:\\+|-)[0-9]{4})?\\)\\\\/\\"', "g"), __js_dateRegEx2 = new RegExp("[\"']/Date\\(([0-9]+)\\)/[\"']", "g"), mini.encode = mini.JSON.encode, mini.decode = mini.JSON.decode, mini.Keyboard = {
	Left : 37,
	Top : 38,
	Right : 39,
	Bottom : 40,
	PageUp : 33,
	PageDown : 34,
	End : 35,
	Home : 36,
	Enter : 13,
	ESC : 27,
	Space : 32,
	Tab : 9,
	Del : 46,
	F1 : 112,
	F2 : 113,
	F3 : 114,
	F4 : 115,
	F5 : 116,
	F6 : 117,
	F7 : 118,
	F8 : 119,
	F9 : 120,
	F10 : 121,
	F11 : 122,
	F12 : 123
}, mini.MouseButton = {
	Left : 0,
	Middle : 1,
	Right : 2
}, isIE && !isIE9 && (mini.MouseButton = {
	Left : 1,
	Middle : 4,
	Right : 2
}), String.format = function(t) {
	var e = Array.prototype.slice.call(arguments, 1);
	return t = t || "", t.replace(/\{(\d+)\}/g, function(t, i) {
			return e[i]
		})
}, String.prototype.trim = function() {
	var t = /^\s+|\s+$/g;
	return function() {
		return this.replace(t, "")
	}
}(), String.prototype.escapeDateTimeTokens = function() {
	return this.replace(/([dMyHmsft])/g, "\\$1")
}, mini.util = {}, mini.util.StringUtil = {}, mini.util.CookieUtil = {}, mini.util.HtmlUtil = {}, mini.util.MathUtil = {}, mini.util.StringUtil.lTrim = function(t) {
	for (var e = 0; e < t.length; e++)
		if (" " != t.charAt(e)) return t.substring(e, t.length);
	return ""
}, mini.util.StringUtil.rTrim = function(t) {
	for (var e = t.length - 1; e >= 0; e--)
		if (" " != t.charAt(e)) return t.substring(0, e + 1);
	return ""
}, mini.util.StringUtil.nvl = function(t, e) {
	return null == t || "" == t ? e : t
}, mini.util.StringUtil.trimSpace = function(t) {
	return mini.util.StringUtil.rTrim(mini.util.StringUtil.lTrim(t))
}, mini.util.StringUtil.trimAllSpace = function(t) {
	return t.replace(/\s/g, "")
}, mini.util.StringUtil.clearEnter = function(t) {
	var e = "",
		i = "",
		n = 0;
	for (n = 0; n < t.length; n++) e = t.charAt(n), "\n" != e && "\r" != e && (i += e);
	return mini.util.StringUtil.trimSpace(i)
}, mini.util.StringUtil.getLength = function(t) {
	var e,
		i;
	for (i = 0, e = 0; e < t.length; e++) i += t.charCodeAt(e) >= 0 && t.charCodeAt(e) <= 255 ? 1 : 2;
	return i
}, mini.util.StringUtil.formatMoney = function(t, e, i) {
	function n(t, e) {
		function i(t) {
			for (var e = "", i = 0; t > i; i++) e += "0";
			return e
		}
		var n = t.indexOf(".");
		if (-1 != n) {
			var s = t.substring(n + 1, t.length);
			t += i(e - s.length)
		} else e > 0 && (t += ".", t += i(e));
		for (var o = /^(-?\d+)(\d{3})(\.?\d*)/; o.test(t);) t = t.replace(o, "$1,$2$3");
		return t
	}
	if (void 0 === e && (e = 2), !mini.util.MathUtil.isNumber(t)) {
		if (void 0 == t || "" == t) return "";
		if (t = new String(t), t = t.replace(/\,/g, ""), t = new Number(t), isNaN(t)) return ""
	}
	return t = mini.util.MathUtil.toFixed(t, e), t += "", i = i || "", i + n(t, e)
}, mini.util.MathUtil.toFixed = function(t, e) {
	return mini.util.MathUtil.isNumber(t) ? mini.util.MathUtil.isNumber(e) ? (t *= Math.pow(10, e), t = Math.round(t), t /= Math.pow(10, e)) : t : null
}, mini.util.MathUtil.toFixed2 = function(t, e) {
	function i(t) {
		for (var e = "", i = 0; t > i; i++) e += "0";
		return e
	}
	t = mini.util.MathUtil.toFixed(t, e), t += "";
	var n = t.indexOf(".");
	if (-1 != n) {
		var s = t.substring(n + 1, t.length);
		t += i(e - s.length)
	} else e > 0 && (t += ".", t += i(e));
	return t
}, mini.util.MathUtil.isNumber = function(t) {
	return "[object Number]" == Object.prototype.toString.call(t)
}, mini.util.HtmlUtil.getURI = function() {
	return protocol = window.location.protocol, host = window.location.host, url = window.location.href, url.replace(protocol + "//" + host, "")
}, mini.util.CookieUtil.getCookie = function(t) {
	return $.cookie(t)
}, mini.util.CookieUtil.setCookie = function(t, e, i) {
	$.cookie(t, e, option)
}, mini.util.disableBackspaceToPreviousPage = function() {
	$(document).unbind("keydown").bind("keydown", function(t) {
		var e = !1;
		if (8 === t.keyCode) {
			var i = t.srcElement || t.target;
			e = "INPUT" === i.tagName.toUpperCase() && ("TEXT" === i.type.toUpperCase() || "PASSWORD" === i.type.toUpperCase() || "FILE" === i.type.toUpperCase() || "EMAIL" === i.type.toUpperCase() || "SEARCH" === i.type.toUpperCase() || "DATE" === i.type.toUpperCase()) || "TEXTAREA" === i.tagName.toUpperCase() ? i.readOnly || i.disabled : !0
		}
		e && t.preventDefault()
	})
}, mini.util.getMap = function(t, e) {
	return mini._getMap(t, e)
}, mini.util.setMap = function(t, e, i) {
	return mini._setMap(t, e, i)
}, mini = mini || {}, mini_onOne = function(t, e, i, n) {
	var s = "on" + e.toLowerCase();
	t[s] = function(t) {
		t = t || window.event, t.target = t.target || t.srcElement, t.preventDefault || (t.preventDefault = function() {
			window.event && (window.event.returnValue = !1)
		}), t.stopPropogation || (t.stopPropogation = function() {
			window.event && (window.event.cancelBubble = !0)
		});
		var e = i.call(n, t);
		if (window.event) try {
				t.stopPropogation = null, t.preventDefault = null
			} catch (t) {}
		return e === !1 ? !1 : void 0
	}
}, mini_on = function(t, e, i, n) {
	if (t = mini.byId(t), n = n || t, !(t && e && i && n && jQuery(t) && 0 != jQuery(t).length)) return !1;
	var s = mini.findListener(t, e, i, n);
	if (s) return !1;
	var o = mini.createDelegate(i, n);
	mini.listeners.push([ t, e, i, n, o ]), isFirefox && "mousewheel" == e && (e = "DOMMouseScroll"), jQuery(t).bind(e, o)
}, mini_un = function(t, e, i, n) {
	if (t = mini.byId(t), n = n || t, !(t && e && i && n && jQuery(t) && 0 != jQuery(t).length)) return !1;
	var s = mini.findListener(t, e, i, n);
	return s ? (mini.listeners.remove(s), isFirefox && "mousewheel" == e && (e = "DOMMouseScroll"), void jQuery(t).unbind(e, s[4])) : !1
}, mini.copyTo(mini, {
	listeners : [],
	on : mini_on,
	un : mini_un,
	findListener : function(t, e, i, n) {
		if (t = mini.byId(t), n = n || t, !(t && e && i && n && jQuery(t) && 0 != jQuery(t).length)) return !1;
		for (var s = mini.listeners, o = 0, l = s.length; l > o; o++) {
			var r = s[o];
			if (r[0] == t && r[1] == e && r[2] == i && r[3] == n) return r
		}
	},
	clearEvent : function(t, e) {
		if (t = mini.byId(t), !t || !jQuery(t) || 0 == jQuery(t).length) return !1;
		for (var i = mini.listeners, n = i.length - 1; n >= 0; n--) {
			var s = i[n];
			s[0] == t && (e && e != s[1] || mini.un(t, s[1], s[2], s[3]))
		}
		t.onmouseover = t.onmousedown = null
	}
}), mini.__windowResizes = [], mini.onWindowResize = function(t, e) {
	mini.__windowResizes.push([ t, e ])
}, mini._BindCallbacks = [], mini._BindEvents = function(t, e) {
	mini._BindCallbacks.push([ t, e ]), mini._EventTimer || mini._FireBindEvents()
}, mini._FireBindEvents = function() {
	for (var t = 0, e = mini._BindCallbacks.length; e > t; t++) {
		var i = mini._BindCallbacks[t];
		i[0].call(i[1])
	}
	mini._BindCallbacks = [], mini._EventTimer = null
}, mini = mini || {}, mini.doWindowResizeTimer = null, mini_onresize = function(t) {
	if (mini.doWindowResizeTimer && clearTimeout(mini.doWindowResizeTimer), mini.WindowVisible = mini.isWindowDisplay(), 0 != mini.WindowVisible && 0 != mini.allowLayout)
		if ("undefined" != typeof Ext)
			mini.doWindowResizeTimer = setTimeout(function() {
				var t = document.documentElement.clientWidth,
					e = document.documentElement.clientHeight;
				mini.__LastWindowWidth == t && mini.__LastWindowHeight == e || (mini.__LastWindowWidth = t, mini.__LastWindowHeight = e, mini.layout(null, !1)), mini.doWindowResizeTimer = null
			}, 300);else {
			var e = 100;
			try {
				parent && parent != window && parent.mini && (e = 0)
			} catch (i) {}
			mini.doWindowResizeTimer = setTimeout(function() {
				var t = document.documentElement.clientWidth,
					e = document.documentElement.clientHeight;
				mini.__LastWindowWidth == t && mini.__LastWindowHeight == e || (mini.__LastWindowWidth = t, mini.__LastWindowHeight = e, mini.layout(null, !1)), mini.doWindowResizeTimer = null
			}, e)
	}
}, mini_onload = function(t) {
	mini.layout(null, !1), mini.on(window, "resize", mini_onresize)
}, mini_unload = function(t) {
	try {
		var e = mini._getTopWindow();
		e[mini._WindowID] = "",
		delete e[mini._WindowID]
	} catch (i) {}
	var n = document.body.getElementsByTagName("iframe");
	if (n.length > 0) {
		for (var s = [], o = 0, l = n.length; l > o; o++) s.push(n[o]);
		for (var o = 0, l = s.length; l > o; o++) try {
				var r = s[o];
				r._ondestroy = null, r.onload = function() {}, jQuery(r).unbind("load"), r.src = "";try {
					r.contentWindow.document.write(""), r.contentWindow.document.close()
				} catch (i) {}
				r.parentNode && r.parentNode.removeChild(r)
			} catch (t) {}
	}
	for (var a = mini.getComponents(), o = 0, l = a.length; l > o; o++) {
		var h = a[o];
		h.destroyed !== !0 && h.destroy(!1)
	}
	a.length = 0, a = null, mini.un(window, "unload", mini_unload), mini.un(window, "load", mini_onload), mini.un(window, "resize", mini_onresize), mini.clearEvent(window), mini.clearEvent(document), mini.components = {}, mini.classes = {}, mini.uiClasses = {}, mini.uids = {}, mini._topWindow = null, window.Owner = null, window.CloseOwnerWindow = null,
	delete String.prototype.trim
	,
	delete String.prototype.escapeDateTimeTokens
	,
	delete String.format
	,
	delete Array.prototype.add
	,
	delete Array.prototype.enqueue
	,
	delete Array.prototype.getRange
	,
	delete Array.prototype.addRange
	,
	delete Array.prototype.clear
	,
	delete Array.prototype.clone
	,
	delete Array.prototype.contains
	,
	delete Array.prototype.indexOf
	,
	delete Array.prototype.dequeue
	,
	delete Array.prototype.insert
	,
	delete Array.prototype.insertRange
	,
	delete Array.prototype.remove
	,
	delete Array.prototype.removeAt
	,
	delete Array.prototype.removeRange
	,
	delete Date.prototype.getHalfYear
	,
	delete Date.prototype.getQuarter;
	try {
		CollectGarbage()
	} catch (t) {}
}, mini = mini || {}, mini.Drag = function(t) {
	mini.copyTo(this, t)
}, mini.Drag.prototype = {
	onStart : mini.emptyFn,
	onMove : mini.emptyFn,
	onStop : mini.emptyFn,
	capture : !1,
	fps : 20,
	event : null,
	delay : 80,
	destroy : function(t) {
		mini.clearEvent(document),
		delete this.trigger
		, this.context && (mini.clearEvent(this.context), this.context.parentNode.removeChild(this.context), this.context = null)
	},
	start : function(t) {
		t.preventDefault(), t && (this.event = t), this.now = this.init = [ this.event.pageX, this.event.pageY ];
		var e = document;
		mini.on(e, "mousemove", this.move, this), mini.on(e, "mouseup", this.stop, this), mini.on(e, "contextmenu", this.contextmenu, this), this.context && mini.on(this.context, "contextmenu", this.contextmenu, this), this.trigger = t.target, mini.selectable(this.trigger, !1), mini.selectable(e.body, !1), this.capture && (isIE ? this.trigger.setCapture(!0) : document.captureEvents && document.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP | Event.MOUSEDOWN)), this.started = !1, this.startTime = new Date
	},
	contextmenu : function(t) {
		this.context && mini.un(this.context, "contextmenu", this.contextmenu, this), mini.un(document, "contextmenu", this.contextmenu, this), t.preventDefault(), t.stopPropagation()
	},
	move : function(t) {
		if (!(this.delay && new Date - this.startTime < this.delay)) {
			this.started || (this.started = !0, this.onStart(this));
			var e = this;
			this.timer || (this.timer = setTimeout(function() {
				e.now = [ t.pageX, t.pageY ], e.event = t, e.onMove(e), e.timer = null
			}, 5))
		}
	},
	stop : function(t) {
		this.now = [ t.pageX, t.pageY ], this.event = t, this.timer && (clearTimeout(this.timer), this.timer = null);
		var e = document;
		mini.selectable(this.trigger, !0), mini.selectable(e.body, !0), isIE && (this.trigger.setCapture(!1), this.trigger.releaseCapture());
		var i = mini.MouseButton.Right != t.button;
		0 == i && t.preventDefault(), mini.un(e, "mousemove", this.move, this), mini.un(e, "mouseup", this.stop, this);
		var n = this;
		setTimeout(function() {
			mini.un(document, "contextmenu", n.contextmenu, n), n.context && mini.un(n.context, "contextmenu", n.contextmenu, n)
		}, 1), this.started && n.onStop(n, i)
	}
}, mini = mini || {}, mini.loadJS = function(t, e) {
	return t ? "function" == typeof e ? loadJS._async(t, e) : loadJS._sync(t) : void 0
}, mini.loadJS._js = {}, mini.loadJS._async = function(t, e) {
	function i() {
		for (var t = 0; t < n.callbacks.length; t++) {
			var e = n.callbacks[t];
			e && e()
		}
		n.callbacks.length = 0
	}
	var n = mini.loadJS._js[t];
	if (n || (n = mini.loadJS._js[t] = {
			create : !1,
			loaded : !1,
			callbacks : []
		}), n.loaded) return void setTimeout(function() {
			e()
		}, 1);
	if (n.callbacks.push(e), !n.create) {
		n.create = !0;
		var s = document.getElementsByTagName("head")[0],
			o = document.createElement("script");
		return o.src = t, o.type = "text/javascript", setTimeout(function() {
				document.all ? o.onreadystatechange = function() {
					("loaded" == o.readyState || "complete" == o.readyState) && (i(), n.loaded = !0)
				} : o.onload = function() {
					i(), n.loaded = !0
				}, s.appendChild(o)
			}, 1), o
	}
}, mini.loadJS._sync = function(t) {
	if (!loadJS._js[t]) {
		loadJS._js[t] = {
			create : !0,
			loaded : !0,
			callbacks : []
		};
		var e = document.getElementsByTagName("head")[0],
			i = document.createElement("script");
		return i.type = "text/javascript", i.text = loadText(t), e.appendChild(i), i
	}
}, mini.loadText = function(t) {
	function e() {
		if (4 == s.readyState) {
			var t = n ? 0 : 200;
			s.status == t && (i = s.responseText)
		}
	}
	var i = "",
		n = document.all && "file:" == location.protocol,
		s = null;
	n ? s = new ActiveXObject("Microsoft.XMLHTTP") : window.XMLHttpRequest ? s = new XMLHttpRequest : window.ActiveXObject && (s = new ActiveXObject("Microsoft.XMLHTTP")), s.onreadystatechange = e;
	var o = "_t=" + (new Date).getTime();
	return o = -1 == t.indexOf("?") ? "?" + o : "&" + o, t += o, s.open("GET", t, !1), s.send(null), i
}, mini.loadJSON = function(url) {
	var text = loadText(url),
		o = eval("(" + text + ")");
	return o
}, mini.loadCSS = function(t, e) {
	if (t && !loadCSS._css[t]) {
		var i = document.getElementsByTagName("head")[0],
			n = document.createElement("link");
		return e && (n.id = e), n.href = t, n.rel = "stylesheet", n.type = "text/css", i.appendChild(n), n
	}
}, mini.loadCSS._css = {}, mini.innerHTML = function(t, e) {
	"string" == typeof t && (t = document.getElementById(t)), t && (e = '<div style="display:none">&nbsp;</div>' + e, t.innerHTML = e, mini.__executeScripts(t), t.firstChild)
}, mini.__executeScripts = function(t) {
	for (var e = t.getElementsByTagName("script"), i = 0, n = e.length; n > i; i++) {
		var s = e[i],
			o = s.src;
		if (o) mini.loadJS(o);else {
			var l = document.createElement("script");
			l.type = "text/javascript", l.text = s.text, t.appendChild(l)
		}
	}
	for (var i = e.length - 1; i >= 0; i--) {
		var s = e[i];
		s.parentNode.removeChild(s)
	}
}, mini = mini || {}, mini._MaskID = 1, mini._MaskObjects = {}, mini.mask = function(t) {
	function e() {
		l.style.display = "block";var t = mini.getSize(l);
		l.style.marginLeft = -t.width / 2 + "px", l.style.marginTop = -t.height / 2 + "px"
	}
	var i = mini.byId(t);
	mini.isElement(i) ? t = {
		el : i
	} : "string" == typeof t && (t = {
		html : t
	}), t = mini.copyTo({
		html : "",
		cls : "",
		style : "",
		iconCls : "",
		message : "",
		backStyle : "background:#ccc"
	}, t), t.el = mini.byId(t.el), t.el || (t.el = document.body);
	var i = t.el;
	mini.unmask(t.el), i._maskid = mini._MaskID++, mini._MaskObjects[i._maskid] = t;
	var n = '<div class="' + t.iconCls + '"></div>',
		s = '<table class="mini-messagebox-table"  cellspacing="0" cellpadding="0"><tr><td>' + n + '</td><td  class="mini-messagebox-content-text">' + (t.html || t.message || "") + "</td></tr></table>",
		o = mini.append(i, '<div class="mini-mask"><div class="mini-mask-background" style="' + t.backStyle + '"></div><div class="mini-mask-msg ' + t.cls + '" style="' + t.style + '">' + s + "</div></div>");
	i == document.body && mini.addClass(o, "mini-fixed"), t.maskEl = o, mini.isNull(t.opacity) || mini.setOpacity(o.firstChild, t.opacity);
	var l = o.lastChild;
	l.style.display = "none", setTimeout(function() {
		e()
	}, 0)
}, mini.unmask = function(t) {
	t = mini.byId(t), t || (t = document.body);
	var e = mini._MaskObjects[t._maskid];
	if (e) {
		delete mini._MaskObjects[t._maskid];
		var i = e.maskEl;
		e.maskEl = null, i && i.parentNode && i.parentNode.removeChild(i)
	}
}, mini = mini || {}, mini._Columns = {}, mini._getColumn = function(t) {
	var e = mini._Columns[t.toLowerCase()];
	return e ? e() : {}
}, mini.IndexColumn = function(t) {
	return mini.copyTo({
		width : 30,
		cellCls : "",
		align : "center",
		draggable : !1,
		allowDrag : !0,
		init : function(t) {
			t.on("addrow", this.__OnIndexChanged, this), t.on("removerow", this.__OnIndexChanged, this), t.on("moverow", this.__OnIndexChanged, this), t.isTree && (t.on("loadnode", this.__OnIndexChanged, this), this._gridUID = t.uid, this._rowIdField = "_id")
		},
		getNumberId : function(t) {
			return this._gridUID + "$number$" + t[this._rowIdField]
		},
		createNumber : function(t, e) {
			return mini.isNull(t.pageIndex) ? e + 1 : t.pageIndex * t.pageSize + e + 1
		},
		renderer : function(t) {
			var e = t.sender;
			this.draggable && (t.cellStyle || (t.cellStyle = ""), t.cellStyle += ";cursor:move;");
			var i = '<div id="' + this.getNumberId(t.record) + '">';
			return i += mini.isNull(e.pageIndex) ? t.rowIndex + 1 : e.pageIndex * e.pageSize + t.rowIndex + 1, i += "</div>"
		},
		__OnIndexChanged : function(t) {
			for (var e = t.sender, i = e.toArray(), n = 0, s = i.length; s > n; n++) {
				var o = i[n],
					l = this.getNumberId(o),
					r = document.getElementById(l);
				r && (r.innerHTML = this.createNumber(e, n))
			}
		}
	}, t)
}, mini._Columns.indexcolumn = mini.IndexColumn, mini.CheckColumn = function(t) {
	return mini.copyTo({
		width : 30,
		cellCls : "mini-checkcolumn",
		headerCls : "mini-checkcolumn",
		_multiRowSelect : !0,
		header : function(t) {
			var e = this.uid + "checkall",
				i = '<input type="checkbox" id="' + e + '" />';
			return 0 == this.multiSelect && (i = ""), i
		},
		getCheckId : function(t) {
			return this._gridUID + "$checkcolumn$" + t[this._rowIdField]
		},
		init : function(t) {
			t.on("selectionchanged", this.__OnSelectionChanged, this), t.on("HeaderCellClick", this.__OnHeaderCellClick, this)
		},
		renderer : function(t) {
			var e = this.getCheckId(t.record),
				i = t.sender.isSelected ? t.sender.isSelected(t.record) : !1,
				n = "checkbox",
				s = t.sender;
			return 0 == s.multiSelect && (n = "radio"), '<input type="' + n + '" id="' + e + '" ' + (i ? "checked" : "") + ' hidefocus style="outline:none;" onclick="return false"/>'
		},
		__OnHeaderCellClick : function(t) {
			var e = t.sender;
			if (t.column == this) {
				var i = e.uid + "checkall",
					n = document.getElementById(i);
				n && t.htmlEvent.target.id == i && (e.getMultiSelect() ? n.checked ? e.selectAll() : e.deselectAll() : (e.deselectAll(), n.checked && e.select(0)), e.fire("checkall"))
			}
		},
		__OnSelectionChanged : function(t) {
			for (var e = t.sender, i = e.toArray(), n = 0, s = i.length; s > n; n++) {
				var o = i[n],
					l = e.isSelected(o),
					r = e.uid + "$checkcolumn$" + o[e._rowIdField],
					a = document.getElementById(r);
				a && (a.checked = l)
			}
		},
		_doCheckState : function(t) {
			var e = t.getData();
			if (0 != e.length) {
				var i = t.uid + "checkall",
					n = document.getElementById(i);
				if (n && t._getSelectAllCheckState) {
					var s = t._getSelectAllCheckState();
					"has" == s ? (n.indeterminate = !0, n.checked = !0) : (n.indeterminate = !1, n.checked = s)
				}
			}
		}
	}, t)
}, mini._Columns.checkcolumn = mini.CheckColumn, mini.ExpandColumn = function(t) {
	return mini.copyTo({
		width : 30,
		cellCls : "",
		align : "center",
		draggable : !1,
		cellStyle : "padding:0",
		renderer : function(t) {
			return '<a class="mini-grid-ecIcon" href="javascript:#" onclick="return false"></a>'
		},
		init : function(t) {
			t.on("cellclick", this.__OnCellClick, this)
		},
		__OnCellClick : function(t) {
			var e = t.sender;
			if (t.column == this && e.isShowRowDetail && mini.findParent(t.htmlEvent.target, "mini-grid-ecIcon")) {
				var i = e.isShowRowDetail(t.record);
				e.autoHideRowDetail && e.hideAllRowDetail(), i ? e.hideRowDetail(t.record) : e.showRowDetail(t.record)
			}
		}
	}, t)
}, mini._Columns.expandcolumn = mini.ExpandColumn, mini.CheckBoxColumn = function(t) {
	return mini.copyTo({
		_type : "checkboxcolumn",
		header : "#",
		headerAlign : "center",
		cellCls : "mini-checkcolumn",
		trueValue : !0,
		falseValue : !1,
		readOnly : !1,
		getCheckId : function(t) {
			return this._gridUID + "$checkbox$" + t[this._rowIdField]
		},
		getCheckBoxEl : function(t) {
			return document.getElementById(this.getCheckId(t))
		},
		renderer : function(t) {
			var e = this.getCheckId(t.record),
				i = mini._getMap(t.field, t.record),
				n = i == this.trueValue ? !0 : !1,
				s = "checkbox";
			return '<input type="' + s + '" id="' + e + '" ' + (n ? "checked" : "") + ' hidefocus style="outline:none;" onclick="return false;"/>'
		},
		init : function(t) {
			function e(e) {
				if (!t.isReadOnly() && !this.readOnly && (e.value = mini._getMap(e.field, e.record), t.fire("cellbeginedit", e), e.cancel !== !0)) {
					var i = mini._getMap(e.column.field, e.record),
						n = i == this.trueValue ? this.falseValue : this.trueValue;
					t._OnCellCommitEdit && t._OnCellCommitEdit(e.record, e.column, n)
				}
			}
			function i(i) {
				if (i.column == this) {
					var n = this.getCheckId(i.record),
						s = i.htmlEvent.target;
					s.id == n && (t.allowCellEdit ? (i.cancel = !1, e.call(this, i)) : t.isEditingRow && t.isEditingRow(i.record) && setTimeout(function() {
						s.checked = !s.checked
					}, 1))
				}
			}
			this.grid = t, t.on("cellclick", i, this), mini.on(this.grid.el, "keydown", function(i) {
				if (32 == i.keyCode && t.allowCellEdit) {
					var n = t.getCurrentCell();
					if (!n) return;
					var s = {
						record : n[0],
						column : n[1]
					};
					e.call(this, s), i.preventDefault()
				}
			}, this);
			var n = parseInt(this.trueValue),
				s = parseInt(this.falseValue);
			isNaN(n) || (this.trueValue = n), isNaN(s) || (this.falseValue = s)
		}
	}, t)
}, mini._Columns.checkboxcolumn = mini.CheckBoxColumn, mini.ComboBoxColumn = function(t) {
	return mini.copyTo({
		renderer : function(t) {
			var e = mini.isNull(t.value) ? "" : String(t.value),
				i = e.split(","),
				n = "id",
				s = "text",
				o = {},
				l = t.column.editor;
			if (l && "combobox" == l.type) {
				var r = this.__editor;
				r || (mini.isControl(l) ? r = l : (l = mini.clone(l), r = mini.create(l)), this.__editor = r), n = r.getValueField(), s = r.getTextField(), o = {};
				for (var a = r.getData(), h = 0, d = a.length; d > h; h++) {
					var u = a[h];
					o[u[n]] = u
				}
				this._valueMaps = o
			}
			for (var c = [], h = 0, d = i.length; d > h; h++) {
				var m = i[h],
					u = o[m];
				if (u) {
					var p = u[s];
					(null === p || void 0 === p) && (p = ""), c.push(p)
				}
			}
			return c.join(",")
		}
	}, t)
}, mini._Columns.comboboxcolumn = mini.ComboBoxColumn, mini.RadioButtonColumn = function(t) {
	return mini.copyTo({
		_type : "radiobuttoncolumn",
		header : "",
		headerAlign : "center",
		cellCls : "mini-checkcolumn",
		trueValue : !0,
		falseValue : !1,
		readOnly : !1,
		getCheckId : function(t) {
			return this._gridUID + "$radio$" + t[this._rowIdField]
		},
		getCheckBoxEl : function(t) {
			return document.getElementById(this.getCheckId(t))
		},
		renderer : function(t) {
			var e = t.sender,
				i = this.getCheckId(t.record),
				n = mini._getMap(t.field, t.record),
				s = n == this.trueValue ? !0 : !1,
				o = "radio",
				l = e._id + t.column.field,
				r = '<div style="position:relative;">';
			return r += '<input name="' + l + '" type="' + o + '" id="' + i + '" ' + (s ? "checked" : "") + ' hidefocus style="outline:none;" onclick="return false;" style="position:relative;z-index:1;"/>', e.allowCellEdit || e.isEditingRow(t.record) || (r += '<div class="mini-grid-radio-mask"></div>'), r += "</div>"
		},
		init : function(t) {
			function e(e) {
				if (!t.isReadOnly() && !this.readOnly && (e.value = mini._getMap(e.field, e.record), t.fire("cellbeginedit", e), e.cancel !== !0)) {
					var i = mini._getMap(e.column.field, e.record);
					if (i == this.trueValue) return;
					for (var n = i == this.trueValue ? this.falseValue : this.trueValue, s = t.data, o = 0, l = s.length; l > o; o++) {
						var r = s[o];
						if (r != e.record) {
							var i = mini._getMap(e.column.field, r);
							i != this.falseValue && t.updateRow(r, e.column.field, this.falseValue)
						}
					}
					t._OnCellCommitEdit && t._OnCellCommitEdit(e.record, e.column, n)
				}
			}
			function i(i) {
				if (i.column == this) {
					var n = this.getCheckId(i.record),
						s = i.htmlEvent.target;
					if (s.id == n)
						if (t.allowCellEdit) i.cancel = !1, e.call(this, i);
						else if (t.isEditingRow && t.isEditingRow(i.record)) {
							var o = this;
							setTimeout(function() {
								s.checked = !0;
								for (var e = t.getData(), n = 0, l = e.length; l > n; n++) {
									var r = e[n];
									if (r != i.record) {
										var a = i.column.field,
											h = mini._getMap(a, r);
										if (h != o.falseValue && r != i.record)
											if (t._dataSource) mini._setMap(i.column.field, o.falseValue, r), t._dataSource._setModified(r, a, h);else {
												var d = {};
												mini._setMap(a, o.falseValue, d), t._doUpdateRow(r, d)
										}
									}
								}
							}, 1)
					}
				}
			}
			this.grid = t, t.on("cellclick", i, this), mini.on(this.grid.el, "keydown", function(i) {
				if (32 == i.keyCode && t.allowCellEdit) {
					var n = t.getCurrentCell();
					if (!n) return;
					if (n[1] != this) return;
					var s = {
						record : n[0],
						column : n[1]
					};
					s.field = s.column.field, e.call(this, s), i.preventDefault()
				}
			}, this);
			var n = parseInt(this.trueValue),
				s = parseInt(this.falseValue);
			isNaN(n) || (this.trueValue = n), isNaN(s) || (this.falseValue = s)
		}
	}, t)
}, mini._Columns.radiobuttoncolumn = mini.RadioButtonColumn, mini = mini || {}, mini._firstParse = !0, mini.parse = function(t) {
	if (mini._firstParse) {
		mini._firstParse = !1;
		for (var e = document.getElementsByTagName("iframe"), i = [], n = 0, s = e.length; s > n; n++) {
			var o = e[n];
			i.push(o)
		}
		for (var n = 0, s = i.length; s > n; n++) {
			var o = i[n],
				l = $(o).attr("src");
			l && (o.loaded = !1, o._onload = o.onload, o._src = l, o.onload = function() {}, o.src = "")
		}
		setTimeout(function() {
			for (var t = 0, e = i.length; e > t; t++) {
				var n = i[t];
				n._src && "" == $(n).attr("src") && (n.loaded = !0, n.onload = n._onload, n.src = n._src, n._src = n._onload = null)
			}
		}, 20)
	}
	if ("string" == typeof t) {
		var r = t;
		t = mini.byId(r), t || (t = document.body)
	}
	t && !mini.isElement(t) && (t = t.el), t || (t = document.body);
	var a = mini.WindowVisible;
	isIE && (mini.WindowVisible = !1), mini._doParse(t), mini.WindowVisible = a, mini.layout(t)
}, mini._doParse = function(t) {
	if (t) {
		var e = t.nodeName.toLowerCase();
		if (e) {
			var i = t.className;
			if (i && i.split) {
				var n = mini.get(t);
				if (!n)
					for (var s = i.split(" "), o = 0, l = s.length; l > o; o++) {
						var r = s[o],
							a = mini.getClassByUICls(r);
						if (a) {
							mini.removeClass(t, r);
							var h = new a;
							h._allowLayout = !1, h = mini.applyTo.call(h, t), t = h.el, h._allowLayout = !0;break
						}
				}
			}
			if (!("select" == e || mini.hasClass(t, "mini-menu") || mini.hasClass(t, "mini-datagrid") || mini.hasClass(t, "mini-treegrid") || mini.hasClass(t, "mini-tree") || mini.hasClass(t, "mini-button") || mini.hasClass(t, "mini-textbox") || mini.hasClass(t, "mini-buttonedit")))
				for (var d = mini.getChildNodes(t, !0), o = 0, l = d.length; l > o; o++) {
					var u = d[o];
					1 == u.nodeType && u.parentNode == t && mini._doParse(u)
			}
		}
	}
}, jQuery(function() {
	mini_autoRun && mini.run()
}), mini.run = function() {
	mini.isReady = !0, mini.parse(), mini._FireBindEvents(), "hidden" != mini.getStyle(document.body, "overflow") && "hidden" != mini.getStyle(document.documentElement, "overflow") || !isIE6 && !isIE7 || (jQuery(document.body).css("overflow", "visible"), jQuery(document.documentElement).css("overflow", "visible")), mini.__LastWindowWidth = document.documentElement.clientWidth, mini.__LastWindowHeight = document.documentElement.clientHeight, mini_autoRun ? mini.on(window, "load", mini_onload) : mini_onload(null), mini.on(window, "resize", function(t) {
		for (var e = mini.__windowResizes, i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			s[0].call(s[1], t)
		}
	}), mini.on(window, "unload", mini_unload), isIE && setInterval(function() {
		CollectGarbage()
	}, 1e3)
}, mini = mini || {}, mini._ValidateVType = function(t, e, i, n) {
	for (var s = t.split(";"), o = 0, l = s.length; l > o; o++) {
		var t = s[o].trim(),
			r = t.split(":"),
			a = r[0],
			h = r[1];
		h = h ? h.split(",") : [];var d = mini.VTypes[a];
		if (d) {
			var u = d(e, h);
			if (u !== !0) {
				i.isValid = !1;
				var c = r[0] + "ErrorText";
				i.errorText = n[c] || mini.VTypes[c] || "", i.errorText = String.format(i.errorText, h[0], h[1], h[2], h[3], h[4]);break
			}
		}
	}
}, mini._getErrorText = function(t, e) {
	return t && t[e] ? t[e] : mini.VTypes[e]
}, mini.VTypes = {
	uniqueErrorText : "不能重复.",
	requiredErrorText : "不能为空.",
	emailErrorText : "请输入邮件格式.",
	urlErrorText : "请输入URL格式.",
	floatErrorText : "请输入数字.",
	intErrorText : "请输入整数.",
	dateErrorText : "请输入日期格式 {0}.",
	maxLengthErrorText : "不能超过 {0} 个字符.",
	minLengthErrorText : "不能少于 {0} 个字符.",
	maxErrorText : "数字不能大于 {0}.",
	minErrorText : "数字不能小于 {0}.",
	rangeLengthErrorText : "字符长度必须在 {0} 到 {1} 之间.",
	rangeCharErrorText : "字符数必须在 {0} 到 {1} 之间.",
	rangeErrorText : "数字必须在 {0} 到 {1} 之间.",
	rangeDecimalsErrorText : "请保留小数点后 {0} 位小数.",
	moneyErrorText : "金额格式应为9,999,999.00.",
	required : function(t, e) {
		return mini.isNull(t) || "" === t ? !1 : !0
	},
	email : function(t, e) {
		return mini.isNull(t) || "" === t ? !0 : -1 != t.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) ? !0 : !1
	},
	url : function(t, e) {
		function i(t) {
			t = t.toLowerCase();var e = "^((https|http|ftp|rtsp|mms)?://)?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?(([0-9]{1,3}.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z].[a-z]{2,6})(:[0-9]{1,4})?((/?)|(/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+/?)$",
				i = new RegExp(e);
			return i.test(t) ? !0 : !1
		}
		return mini.isNull(t) || "" === t ? !0 : i(t)
	},
	"int" : function(t, e) {
		function i(t) {
			0 > t && (t = -t);var e = String(t);
			return e.length > 0 && !/[^0-9]/.test(e)
		}
		return mini.isNull(t) || "" === t ? !0 : i(t)
	},
	"float" : function(t, e) {
		function i(t) {
			0 > t && (t = -t);var e = String(t),
				i = /^([-]?)([1-9]\d*(\.\d+){0,1})$|^0(\.\d+){0,1}$/;
			return e.length > 0 && i.test(e)
		}
		return mini.isNull(t) || "" === t ? !0 : i(t)
	},
	date : function(t, e) {
		if (mini.isNull(t) || "" === t) return !0;
		if (!t) return !1;
		var i = null,
			n = e[0];
		if (n) {
			if (i = mini.parseDate(t, n), i && i.getFullYear && mini.formatDate(i, n) == t) return !0
		} else if (i = mini.parseDate(t, "yyyy-MM-dd"), i || (i = mini.parseDate(t, "yyyy/MM/dd")), i || (i = mini.parseDate(t, "MM/dd/yyyy")), i && i.getFullYear) return !0;
		return !1
	},
	maxLength : function(t, e) {
		if (mini.isNull(t) || "" === t) return !0;
		var i = parseInt(e);
		return !t || isNaN(i) ? !0 : t.length <= i ? !0 : !1
	},
	minLength : function(t, e) {
		if (mini.isNull(t) || "" === t) return !0;
		var i = parseInt(e);
		return isNaN(i) ? !0 : t.length >= i ? !0 : !1
	},
	rangeLength : function(t, e) {
		if (mini.isNull(t) || "" === t) return !0;
		if (!t) return !1;
		var i = parseFloat(e[0]),
			n = parseFloat(e[1]);
		return isNaN(i) || isNaN(n) ? !0 : i <= t.length && t.length <= n ? !0 : !1
	},
	rangeChar : function(t, e) {
		function i(t) {
			var e = /[^\x00-\xff]/gi;
			return null != t.match(e) ? !0 : !1
		}
		if (mini.isNull(t) || "" === t) return !0;
		var n = parseFloat(e[0]),
			s = parseFloat(e[1]);
		if (isNaN(n) || isNaN(s)) return !0;
		for (var o = 0, l = String(t).split(""), r = 0, a = l.length; a > r; r++) o += i(l[r]) ? 2 : 1;
		return o >= n && s >= o ? !0 : !1
	},
	range : function(t, e) {
		if (0 == mini.VTypes["float"](t, e)) return !1;
		if (mini.isNull(t) || "" === t) return !0;
		if (t = parseFloat(t), isNaN(t)) return !1;
		var i = parseFloat(e[0]),
			n = parseFloat(e[1]);
		return isNaN(i) || isNaN(n) ? !0 : t >= i && n >= t ? !0 : !1
	},
	rangeDecimals : function(t, e) {
		if (mini.isNull(t) || "" === t) return !0;
		if (-1 == t.indexOf(".")) return !0;
		var i = parseInt(e);
		if (isNaN(i)) return !0;
		var n = new RegExp("^-?0\\.\\d{1," + i + "}$|^-?[1-9]\\d*\\.\\d{1," + i + "}$");
		return null != t.match(n) ? !0 : !1
	},
	money : function(t, e) {
		if (mini.isNull(t) || "" === t) return !0;
		var i;
		if (i = /^[\d|\,\.]*$/, !i.test(t)) return !1;
		var n = parseInt(e);
		return i = isNaN(n) ? "^-?([1-9]{1,3})(,\\d{3})*(\\.\\d+)?$|^-?(0\\.\\d+)$" : "^-?([1-9]{1,3})(,\\d{3})*(\\.\\d{" + n + "})$|^-?(0\\.\\d{" + n + "})$", i = new RegExp(i), null != t.match(i) ? !0 : !1
	}
}, mini.summaryTypes = {
	count : function(t) {
		return t || (t = []), t.length
	},
	max : function(t, e) {
		t || (t = []);
		for (var i = null, n = 0, s = t.length; s > n; n++) {
			var o = t[n],
				l = parseFloat(o[e]);
			null === l || void 0 === l || isNaN(l) || (null == i || l > i) && (i = l)
		}
		return i
	},
	min : function(t, e) {
		t || (t = []);
		for (var i = null, n = 0, s = t.length; s > n; n++) {
			var o = t[n],
				l = parseFloat(o[e]);
			null === l || void 0 === l || isNaN(l) || (null == i || i > l) && (i = l)
		}
		return i
	},
	avg : function(t, e) {
		if (t || (t = []), 0 == t.length) return 0;
		for (var i = 0, n = 0, s = t.length; s > n; n++) {
			var o = t[n],
				l = parseFloat(o[e]);
			null === l || void 0 === l || isNaN(l) || (i += l)
		}
		var r = i / t.length;
		return r
	},
	sum : function(t, e) {
		t || (t = []);
		for (var i = 0, n = 0, s = t.length; s > n; n++) {
			var o = t[n],
				l = parseFloat(o[e]);
			null === l || void 0 === l || isNaN(l) || (i += l)
		}
		return i
	}
}, mini.formatCurrency = function(t, e) {
	t = String(t).replace(/\$|\,/g, ""), isNaN(t) && (t = "0"), sign = t == (t = Math.abs(t)), t = Math.floor(100 * t + .50000000001), cents = t % 100, t = Math.floor(t / 100).toString(), cents < 10 && (cents = "0" + cents);
	for (var i = 0; i < Math.floor((t.length - (1 + i)) / 3); i++) t = t.substring(0, t.length - (4 * i + 3)) + "," + t.substring(t.length - (4 * i + 3));
	return e = e || "", e + ((sign ? "" : "-") + t + "." + cents)
}, mini.formatPercent = function(t, e, i) {
	t = Number(t), isNaN(t) && (t = "0");
	var n = "%";
	return e === !1 && (n = ""), parseFloat((100 * t).toFixed(i)) + n
}, mini._Resizer = function(t) {
	this.owner = t, mini.on(this.owner.el, "mousedown", this.__OnMouseDown, this)
}, mini._Resizer.prototype = {
	destroy : function(t) {
		this._resizeDragger && this._resizeDragger.destroy()
	},
	__OnMouseDown : function(t) {
		var e = mini.hasClass(t.target, "mini-resizer-trigger");
		if (e && this.owner.allowResize) {
			var i = this._getResizeDrag();
			i.start(t)
		}
	},
	_getResizeDrag : function() {
		return this._resizeDragger || (this._resizeDragger = new mini.Drag({
				capture : !0,
				onStart : mini.createDelegate(this._OnDragStart, this),
				onMove : mini.createDelegate(this._OnDragMove, this),
				onStop : mini.createDelegate(this._OnDragStop, this)
			})), this._resizeDragger
	},
	_OnDragStart : function(t) {
		this.proxy = mini.append(document.body, '<div class="mini-resizer-proxy"></div>'), this.proxy.style.cursor = "se-resize", this.elBox = mini.getBox(this.owner.el), mini.setBox(this.proxy, this.elBox)
	},
	_OnDragMove : function(t) {
		var e = this.owner,
			i = this,
			n = t.now[0] - t.init[0],
			s = t.now[1] - t.init[1],
			o = this.elBox.width + n,
			l = this.elBox.height + s;
		o < e.minWidth && (o = e.minWidth), l < e.minHeight && (l = e.minHeight), o > e.maxWidth && (o = e.maxWidth), l > e.maxHeight && (l = e.maxHeight), mini.setSize(this.proxy, o, l), this._moveTimer = setTimeout(function() {
			i._moveTimer && clearTimeout(i._moveTimer), i._moveTimer = null, i.owner.fire("move.resizer", {
				w : o,
				h : l
			})
		}, 50)
	},
	_OnDragStop : function(t, e) {
		if (this.proxy) {
			var i = mini.getBox(this.proxy);
			jQuery(this.proxy).remove(), this.proxy = null, this.elBox = null, e && (this.owner.setWidth(i.width), this.owner.setHeight(i.height), this.owner.fire("resize"))
		}
	}
}, mini = mini || {}, mini.Component = function() {
	this._events = {}, this.uid = mini.newId(this._idPre), this._id = this.uid, this.id || (this.id = this.uid), mini.reg(this)
}, mini.Component.prototype = {
	defaultValueTriggerChange : !1,
	isControl : !0,
	id : null,
	_idPre : "mini-",
	_idSet : !1,
	_canFire : !0,
	set : function(t) {
		if ("string" == typeof t) return this;
		var e = this._allowLayout;
		this._allowLayout = !1;
		var i = t.renderTo || t.render;
		delete t.renderTo
		,
		delete t.render;
		for (var n in t)
			if (0 == n.toLowerCase().indexOf("on")) {
				var s = t[n];
				this.on(n.substring(2, n.length).toLowerCase(), s),
				delete t[n]
		}
		for (var n in t) {
			var o = t[n],
				l = "set" + n.charAt(0).toUpperCase() + n.substring(1, n.length),
				r = this[l];
			r ? "value" == n ? r.call(this, o, this.defaultValueTriggerChange) : r.call(this, o) : this[n] = o
		}
		return i && this.render && this.render(i), this._allowLayout = e, this.doLayout && this.doLayout(), this
	},
	fire : function(t, e) {
		if (0 != this._canFire) {
			t = t.toLowerCase();
			var i = this._events[t];
			if (i) {
				e || (e = {}), e && e != this && (e.source = e.sender = this, e.type || (e.type = t));
				for (var n = 0, s = i.length; s > n; n++) {
					var o = i[n];
					o && o[0].apply(o[1], [ e ])
				}
			}
		}
	},
	on : function(type, fn, scope) {
		if ("string" == typeof fn) {
			var f = mini._getFunctoin(fn);
			if (f)
				fn = f;else {
				var id = mini.newId("__str_");
				window[id] = fn, eval("fn = function(e){var s = " + id + ";var fn = mini._getFunctoin(s); if(fn) {fn.call(this, e)}else{eval(s);}}")
			}
		}
		if ("function" != typeof fn || !type) return !1;
		type = type.toLowerCase();
		var event = this._events[type];
		return event || (event = this._events[type] = []), scope = scope || this, this.findListener(type, fn, scope) || event.push([ fn, scope ]), this
	},
	un : function(t, e, i) {
		if ("function" != typeof e) return !1;
		t = t.toLowerCase();
		var n = this._events[t];
		if (n) {
			i = i || this;
			var s = this.findListener(t, e, i);
			s && n.remove(s)
		}
		return this
	},
	findListener : function(t, e, i) {
		t = t.toLowerCase(), i = i || this;
		var n = this._events[t];
		if (n)
			for (var s = 0, o = n.length; o > s; s++) {
				var l = n[s];
				if (l[0] === e && l[1] === i) return l
		}
	},
	setId : function(t) {
		if (!t)
			throw new Error("id not null");
		if (this._idSet)
			throw new Error("id just set only one");
		mini.unreg(this), this.id = t, this.el && (this.el.id = t), this._textEl && (this._textEl.id = t + "$text"), this._valueEl && (this._valueEl.id = t + "$value"), this._idSet = !0, mini.reg(this)
	},
	getId : function() {
		return this.id
	},
	destroy : function() {
		mini.unreg(this), this.fire("destroy")
	}
}, mini = mini || {}, mini.Control = function() {
	mini.Control.superclass.constructor.call(this), this._create(), this.el.uid = this.uid, this._initEvents(), this._clearBorder && (this.el.style.borderWidth = "0", this.el.style.padding = "0px"), this.addCls(this.uiCls), this.setWidth(this.width), this.setHeight(this.height), this.el.style.display = this.visible ? this._displayStyle : "none"
}, mini.extend(mini.Control, mini.Component, {
	jsName : null,
	width : "",
	height : "",
	visible : !0,
	readOnly : !1,
	enabled : !0,
	tooltip : "",
	_readOnlyCls : "mini-readonly",
	_disabledCls : "mini-disabled",
	_create : function() {
		this.el = document.createElement("div")
	},
	_initEvents : function() {},
	within : function(t) {
		return mini.isAncestor(this.el, t.target) ? !0 : !1
	},
	name : "",
	setName : function(t) {
		this.name = t
	},
	getName : function() {
		return this.name
	},
	isAutoHeight : function() {
		var t = this.el.style.height;
		return "auto" == t || "" == t
	},
	isAutoWidth : function() {
		var t = this.el.style.width;
		return "auto" == t || "" == t
	},
	isFixedSize : function() {
		var t = this.width,
			e = this.height;
		return parseInt(t) + "px" == t && parseInt(e) + "px" == e ? !0 : !1
	},
	isRender : function(t) {
		return !!(this.el && this.el.parentNode && this.el.parentNode.tagName)
	},
	render : function(t, e) {
		"string" == typeof t && (t = "#body" == t ? document.body : mini.byId(t)), t && (e || (e = "append"), e = e.toLowerCase(), "before" == e ? jQuery(t).before(this.el) : "prepend" == e ? jQuery(t).prepend(this.el) : "after" == e ? jQuery(t).after(this.el) : t.appendChild(this.el), this.el.id = this.id, this.doLayout(), this.fire("render"))
	},
	getEl : function() {
		return this.el
	},
	setJsName : function(t) {
		this.jsName = t, window[t] = this
	},
	getJsName : function() {
		return this.jsName
	},
	setTooltip : function(t) {
		this.tooltip = t, this.el.title = t
	},
	getTooltip : function() {
		return this.tooltip
	},
	_sizeChaned : function() {
		this.doLayout()
	},
	setWidth : function(t) {
		parseInt(t) == t && (t += "px"), this.width = t, this.el.style.width = t, this._sizeChaned()
	},
	getWidth : function(t) {
		var e = t ? jQuery(this.el).width() : jQuery(this.el).outerWidth();
		if (t && this._borderEl) {
			var i = mini.getBorders(this._borderEl);
			e = e - i.left - i.right
		}
		return e
	},
	setHeight : function(t) {
		parseInt(t) == t && (t += "px"), this.height = t, this.el.style.height = t, this._sizeChaned()
	},
	getHeight : function(t) {
		var e = t ? jQuery(this.el).height() : jQuery(this.el).outerHeight();
		if (t && this._borderEl) {
			var i = mini.getBorders(this._borderEl);
			e = e - i.top - i.bottom
		}
		return e
	},
	getBox : function() {
		return mini.getBox(this.el)
	},
	setBorderStyle : function(t) {
		var e = this._borderEl || this.el;
		mini.setStyle(e, t), this.doLayout()
	},
	getBorderStyle : function() {
		return this.borderStyle
	},
	_clearBorder : !0,
	setStyle : function(t) {
		this.style = t, mini.setStyle(this.el, t), this._clearBorder && (this.el.style.borderWidth = "0"), this.width = this.el.style.width, this.height = this.el.style.height, this._sizeChaned()
	},
	getStyle : function() {
		return this.style
	},
	setCls : function(t) {
		this.addCls(t)
	},
	getCls : function() {
		return this.cls
	},
	addCls : function(t) {
		mini.addClass(this.el, t)
	},
	removeCls : function(t) {
		mini.removeClass(this.el, t)
	},
	_doReadOnly : function() {
		this.readOnly ? this.addCls(this._readOnlyCls) : this.removeCls(this._readOnlyCls)
	},
	setReadOnly : function(t) {
		this.readOnly = t, this._doReadOnly()
	},
	getReadOnly : function() {
		return this.readOnly
	},
	getParent : function(t) {
		for (var e = document, i = this.el.parentNode; i != e && null != i;) {
			var n = mini.get(i);
			if (n) {
				if (!mini.isControl(n)) return null;
				if (!t || n.uiCls == t) return n
			}
			i = i.parentNode
		}
		return null
	},
	isReadOnly : function() {
		if (this.readOnly || !this.enabled) return !0;
		var t = this.getParent();
		return t ? t.isReadOnly() : !1
	},
	setEnabled : function(t) {
		this.enabled = t, this.enabled ? this.removeCls(this._disabledCls) : this.addCls(this._disabledCls), this._doReadOnly()
	},
	getEnabled : function() {
		return this.enabled
	},
	enable : function() {
		this.setEnabled(!0)
	},
	disable : function() {
		this.setEnabled(!1)
	},
	_displayStyle : "",
	setVisible : function(t) {
		this.visible = t, this.el && (this.el.style.display = t ? this._displayStyle : "none", this.doLayout())
	},
	getVisible : function() {
		return this.visible
	},
	show : function() {
		this.setVisible(!0)
	},
	hide : function() {
		this.setVisible(!1)
	},
	isDisplay : function() {
		return 0 == mini.isWindowDisplay() ? !1 : jQuery(this.el).is(":visible")
	},
	_allowUpdate : !0,
	beginUpdate : function() {
		this._allowUpdate = !1
	},
	endUpdate : function() {
		this._allowUpdate = !0, this.doUpdate()
	},
	doUpdate : function() {},
	canLayout : function() {
		return 0 == this._allowLayout ? !1 : this.isDisplay()
	},
	doLayout : function() {},
	layoutChanged : function() {
		0 != this.canLayout() && this.doLayout()
	},
	_destroyChildren : function(t) {
		if (this.el)
			for (var e = mini.getChildControls(this), i = 0, n = e.length; n > i; i++) {
				var s = e[i];
				s.destroyed !== !0 && s.destroy(t)
		}
	},
	destroy : function(t) {
		if (this.destroyed !== !0 && this._destroyChildren(t), this.el && (mini.clearEvent(this.el), t !== !1)) {
			var e = this.el.parentNode;
			e && e.removeChild(this.el)
		}
		this._borderEl = null, this.el = null, mini.clearEvent(this), mini.unreg(this), this.destroyed = !0, this.fire("destroy")
	},
	parseUrl : function(urlPar) {
		if (!urlPar) return null;
		if ("#" == urlPar.substring(0, 1)) {
			var name = urlPar.substring(1, urlPar.length);
			try {
				return eval(name)
			} catch (e) {
				return null
			}
		}
		return urlPar
	},
	focus : function() {
		try {
			var t = this;
			t.el.focus()
		} catch (e) {}
	},
	blur : function() {
		try {
			var t = this;
			t.el.blur()
		} catch (e) {}
	},
	allowAnim : !0,
	setAllowAnim : function(t) {
		this.allowAnim = t
	},
	getAllowAnim : function() {
		return this.allowAnim
	},
	_getMaskWrapEl : function() {
		return this.el
	},
	mask : function(t) {
		"string" == typeof t && (t = {
			html : t
		}), t = t || {}, t.el = this._getMaskWrapEl(), t.cls || (t.cls = this._maskCls), mini.mask(t)
	},
	unmask : function() {
		mini.unmask(this._getMaskWrapEl())
	},
	_maskCls : "mini-mask-loading",
	loadingMsg : "Loading...",
	loading : function(t) {
		this.mask(t || this.loadingMsg)
	},
	setLoadingMsg : function(t) {
		this.loadingMsg = t
	},
	getLoadingMsg : function() {
		return this.loadingMsg
	},
	_getContextMenu : function(t) {
		var e = t;
		return "string" == typeof t ? (e = mini.get(t), e || (mini.parse(t), e = mini.get(t))) : mini.isArray(t) ? e = {
				type : "menu",
				items : t
			} : mini.isControl(t) || (e = mini.create(t)), e
	},
	__OnHtmlContextMenu : function(t) {
		var e = {
			popupEl : this.el,
			htmlEvent : t,
			cancel : !1
		};
		return this.contextMenu.fire("BeforeOpen", e), 1 != e.cancel && (this.contextMenu.fire("opening", e), 1 != e.cancel) ? (this.contextMenu.showAtPos(t.pageX, t.pageY), this.contextMenu.fire("Open", e), !1) : void 0
	},
	contextMenu : null,
	setContextMenu : function(t) {
		var e = this._getContextMenu(t);
		e && this.contextMenu !== e && (this.contextMenu = e, this.contextMenu.owner = this, mini.on(this.el, "contextmenu", this.__OnHtmlContextMenu, this))
	},
	getContextMenu : function() {
		return this.contextMenu
	},
	setDefaultValue : function(t) {
		this.defaultValue = t
	},
	getDefaultValue : function() {
		return this.defaultValue
	},
	setValue : function(t) {
		this.value = t
	},
	getValue : function() {
		return this.value
	},
	_afterApply : function(t) {},
	dataField : "",
	setDataField : function(t) {
		this.dataField = t
	},
	getDataField : function() {
		return this.dataField
	},
	getAttrs : function(el) {
		var attrs = {},
			cls = el.className;
		cls && (attrs.cls = cls), el.value && (attrs.value = el.value), mini._ParseString(el, attrs, [ "id", "name", "width", "height", "borderStyle", "value", "defaultValue", "contextMenu", "tooltip", "ondestroy", "data-options", "dataField" ]), mini._ParseBool(el, attrs, [ "visible", "enabled", "readOnly" ]), el.readOnly && "false" != el.readOnly && (attrs.readOnly = !0);
		var style = el.style.cssText;
		if (style && (attrs.style = style), isIE9) {
			var bg = el.style.background;
			bg && (attrs.style || (attrs.style = ""), attrs.style += ";background:" + bg)
		}
		this.style && (attrs.style ? attrs.style = this.style + ";" + attrs.style : attrs.style = this.style), this.borderStyle && (attrs.borderStyle ? attrs.borderStyle = this.borderStyle + ";" + attrs.borderStyle : attrs.borderStyle = this.borderStyle);
		var ts = mini._attrs;
		if (ts)
			for (var i = 0, l = ts.length; l > i; i++) {
				var t = ts[i],
					name = t[0],
					type = t[1];
				type || (type = "string"), "string" == type ? mini._ParseString(el, attrs, [ name ]) : "bool" == type ? mini._ParseBool(el, attrs, [ name ]) : "int" == type && mini._ParseInt(el, attrs, [ name ])
		}
		var options = attrs["data-options"];
		return options && (options = eval("(" + options + ")"), options && mini.copyTo(attrs, options)), attrs
	}
}), mini._attrs = null, mini.regHtmlAttr = function(t, e) {
	t && (e || (e = "string"), mini._attrs || (mini._attrs = []), mini._attrs.push([ t, e ]))
}, mini = mini || {}, mini.Container = function() {
	mini.Container.superclass.constructor.call(this), this._contentEl = this.el
}, mini.extend(mini.Container, mini.Control, {
	setControls : __mini_setControls,
	getContentEl : function() {
		return this._contentEl
	},
	getBodyEl : function() {
		return this._contentEl
	}
}), mini = mini || {}, mini.ValidatorBase = function() {
	mini.ValidatorBase.superclass.constructor.call(this)
}, mini.extend(mini.ValidatorBase, mini.Control, {
	required : !1,
	requiredErrorText : "不能为空.",
	_requiredCls : "mini-required",
	errorText : "",
	_errorCls : "mini-error",
	_invalidCls : "mini-invalid",
	errorMode : "icon",
	validateOnChanged : !0,
	validateOnLeave : !0,
	_IsValid : !0,
	indentSpace : !1,
	_indentCls : "mini-indent",
	setIndentSpace : function(t) {
		t ? this.addCls(this._indentCls) : this.removeCls(this._indentCls), this.indentSpace = t
	},
	getIndentSpace : function() {
		return this.indentSpace
	},
	_tryValidate : function() {
		this.validate()
	},
	validate : function() {
		if (0 == this.enabled) return this.setIsValid(!0), !0;
		var t = {
			value : this.getValue(),
			errorText : "",
			isValid : !0
		};
		return this.required && (mini.isNull(t.value) || "" === String(t.value).trim()) && (t.isValid = !1, t.errorText = this.requiredErrorText), this.fire("validation", t), this.errorText = t.errorText, this.setIsValid(t.isValid), this.isValid()
	},
	isValid : function() {
		return this._IsValid
	},
	setIsValid : function(t) {
		this._IsValid = t, this.doUpdateValid()
	},
	getIsValid : function() {
		return this._IsValid
	},
	setValidateOnChanged : function(t) {
		this.validateOnChanged = t
	},
	getValidateOnChanged : function(t) {
		return this.validateOnChanged
	},
	setValidateOnLeave : function(t) {
		this.validateOnLeave = t
	},
	getValidateOnLeave : function(t) {
		return this.validateOnLeave
	},
	setErrorMode : function(t) {
		t || (t = "none"), this.errorMode = t.toLowerCase(), 0 == this._IsValid && this.doUpdateValid()
	},
	getErrorMode : function() {
		return this.errorMode
	},
	setErrorText : function(t) {
		this.errorText = t, 0 == this._IsValid && this.doUpdateValid()
	},
	getErrorText : function() {
		return this.errorText
	},
	setRequired : function(t) {
		this.required = t, this.required ? this.addCls(this._requiredCls) : this.removeCls(this._requiredCls)
	},
	getRequired : function() {
		return this.required
	},
	setRequiredErrorText : function(t) {
		this.requiredErrorText = t
	},
	getRequiredErrorText : function() {
		return this.requiredErrorText
	},
	errorIconEl : null,
	getErrorIconEl : function() {
		return this._errorIconEl
	},
	_RemoveErrorIcon : function() {},
	doUpdateValid : function() {
		var t = this;
		this._doUpdateValidTimer = setTimeout(function() {
			t.__doUpdateValid()
		}, 1)
	},
	__doUpdateValid : function() {
		if (this.el) {
			if (this.removeCls(this._errorCls), this.removeCls(this._invalidCls), 0 == this._IsValid) switch (this.errorMode) {
				case "icon":
					this.addCls(this._errorCls);var t = this.getErrorIconEl();
					t && (t.title = this.errorText);
					break;case "border":
					this.addCls(this._invalidCls), this.el.title = this.errorText;default:
					this._RemoveErrorIcon()
			}
			else this._RemoveErrorIcon();
			this.doLayout()
		}
	},
	_OnValueChanged : function() {
		this.validateOnChanged && this._tryValidate(), this.fire("valuechanged", {
			value : this.getValue()
		})
	},
	onValueChanged : function(t, e) {
		this.on("valuechanged", t, e)
	},
	onValidation : function(t, e) {
		this.on("validation", t, e)
	},
	getAttrs : function(t) {
		var e = mini.ValidatorBase.superclass.getAttrs.call(this, t);
		mini._ParseString(t, e, [ "onvaluechanged", "onvalidation", "requiredErrorText", "errorMode" ]), mini._ParseBool(t, e, [ "validateOnChanged", "validateOnLeave", "indentSpace" ]);
		var i = t.getAttribute("required");
		if (i || (i = t.required), !i) {
			var n = t.attributes.required;
			n && (i = "null" == n.value ? null : "true")
		}
		return i && (e.required = "false" != i ? !0 : !1), e
	}
}), mini = mini || {}, mini.ListControl = function() {
	this.data = [], this._selecteds = [], mini.ListControl.superclass.constructor.call(this), this.doUpdate()
}, mini.extend(mini.ListControl, mini.ValidatorBase, {
	defaultValue : "",
	value : "",
	valueField : "id",
	textField : "text",
	delimiter : ",",
	data : null,
	url : "",
	_itemCls : "mini-list-item",
	_itemHoverCls : "mini-list-item-hover",
	_itemSelectedCls : "mini-list-item-selected",
	set : function(t) {
		if ("string" == typeof t) return this;
		var e = t.value;
		delete t.value;
		var i = t.url;
		delete t.url;
		var n = t.data;
		return delete t.data
			, mini.ListControl.superclass.set.call(this, t), mini.isNull(n) || this.setData(n), mini.isNull(i) || this.setUrl(i), mini.isNull(e) || this.setValue(e, this.defaultValueTriggerChange), this
	},
	uiCls : "mini-list",
	_create : function() {},
	_initEvents : function() {
		mini._BindEvents(function() {
			mini_onOne(this.el, "click", this.__OnClick, this), mini_onOne(this.el, "dblclick", this.__OnDblClick, this), mini_onOne(this.el, "mousedown", this.__OnMouseDown, this), mini_onOne(this.el, "mouseup", this.__OnMouseUp, this), mini_onOne(this.el, "mousemove", this.__OnMouseMove, this), mini_onOne(this.el, "mouseover", this.__OnMouseOver, this), mini_onOne(this.el, "mouseout", this.__OnMouseOut, this), mini_onOne(this.el, "keydown", this.__OnKeyDown, this), mini_onOne(this.el, "keyup", this.__OnKeyUp, this), mini_onOne(this.el, "contextmenu", this.__OnContextMenu, this)
		}, this)
	},
	destroy : function(t) {
		this.el && (this.el.onclick = null, this.el.ondblclick = null, this.el.onmousedown = null, this.el.onmouseup = null, this.el.onmousemove = null, this.el.onmouseover = null, this.el.onmouseout = null, this.el.onkeydown = null, this.el.onkeyup = null, this.el.oncontextmenu = null), this._valueEl && (mini.clearEvent(this._valueEl), this._valueEl.parentNode.removeChild(this._valueEl), this._valueEl = null),
		delete this._focusedItem
		,
		delete this.data
		,
		delete this._selecteds
		, mini.ListControl.superclass.destroy.call(this, t)
	},
	name : "",
	setName : function(t) {
		this.name = t, this._valueEl && mini.setAttr(this._valueEl, "name", this.name)
	},
	getItemByEvent : function(t) {
		var e = mini.findParent(t.target, this._itemCls);
		if (e) {
			var i = parseInt(mini.getAttr(e, "index"));
			return this.data[i]
		}
	},
	addItemCls : function(t, e) {
		var i = this.getItemEl(t);
		i && mini.addClass(i, e)
	},
	removeItemCls : function(t, e) {
		var i = this.getItemEl(t);
		i && mini.removeClass(i, e)
	},
	getItemEl : function(t) {
		t = this.getItem(t);
		var e = this.data.indexOf(t),
			i = this._createItemId(e);
		return document.getElementById(i)
	},
	_focusItem : function(t, e) {
		if (t = this.getItem(t)) {
			var i = this.getItemEl(t);
			if (e && i && this.scrollIntoView(t), this._focusedItem == t) return void (i && mini.addClass(i, this._itemHoverCls));
			this._blurItem(), this._focusedItem = t, i && mini.addClass(i, this._itemHoverCls)
		}
	},
	_blurItem : function() {
		if (this._focusedItem) {
			try {
				var t = this.getItemEl(this._focusedItem);
				t && mini.removeClass(t, this._itemHoverCls)
			} catch (e) {}
			this._focusedItem = null
		}
	},
	getFocusedItem : function() {
		return this._focusedItem
	},
	getFocusedIndex : function() {
		return this.data.indexOf(this._focusedItem)
	},
	_scrollViewEl : null,
	scrollIntoView : function(t) {
		try {
			var e = this.getItemEl(t),
				i = this._scrollViewEl || this.el;
			mini.scrollIntoView(e, i, !1)
		} catch (n) {}
	},
	getItem : function(t) {
		return "object" == typeof t ? t : "number" == typeof t ? this.data[t] : this.findItems(t)[0]
	},
	getCount : function() {
		return this.data.length
	},
	indexOf : function(t) {
		return this.data.indexOf(t)
	},
	getAt : function(t) {
		return this.data[t]
	},
	updateItem : function(t, e) {
		t = this.getItem(t), t && (mini.copyTo(t, e), this.doUpdate())
	},
	load : function(t) {
		"string" == typeof t ? this.setUrl(t) : this.setData(t)
	},
	loadData : function(t) {
		this.setData(t)
	},
	setData : function(data) {
		if ("string" == typeof data && (data = eval(data)), mini.isArray(data) || (data = []), this.data = data, this.doUpdate(), "" != this.value) {
			this.deselectAll();
			var records = this.findItems(this.value);
			this.selects(records)
		}
	},
	getData : function() {
		return this.data.clone()
	},
	setUrl : function(t) {
		this.url = this.parseUrl(t), this._doLoad({})
	},
	getUrl : function() {
		return this.url
	},
	_doLoad : function(params) {
		try {
			var url = eval(this.url);
			void 0 != url && (this.url = url)
		} catch (e) {}
		var e = {
			url : this.url,
			async : !1,
			type : "get",
			params : params,
			data : params,
			cache : !1,
			cancel : !1,
			timeout : 3e4
		};
		if (this.fire("beforeload", e), e.data != e.params && e.params != params && (e.data = e.params), 1 != e.cancel) {
			var sf = this,
				url = e.url;
			mini.copyTo(e, {
				success : function(t) {
					var e = null;
					try {
						e = mini.decode(t)
					} catch (i) {
						e = [], 1 == mini_debugger && alert(url + "\njson is error.")
					}
					sf.dataField && (e = mini._getMap(sf.dataField, e)), e || (e = []);
					var i = {
						data : e,
						cancel : !1
					};
					sf.fire("preload", i), 1 != i.cancel && (sf.setData(i.data), sf.fire("load"), setTimeout(function() {
						sf.doLayout()
					}, 100))
				},
				error : function(t, e, i) {
					var n = {
						xmlHttp : t,
						errorMsg : t.responseText,
						errorCode : t.status
					};
					1 == mini_debugger && alert(url + "\n" + n.errorCode + "\n" + n.errorMsg), sf.fire("loaderror", n)
				}
			}), this._ajaxer = mini.ajax(e)
		}
	},
	setValue : function(t, e) {
		if (mini.isNull(t) && (t = ""), !mini.isEquals(this.value, t)) {
			this.deselectAll(), this.value = t, this._valueEl && (this._valueEl.value = t);
			var i = this.findItems(this.value);
			this.selects(i), void 0 === e && (e = !0), e && this._OnValueChanged()
		}
	},
	getValue : function() {
		return this.value
	},
	getFormValue : function() {
		return this.value
	},
	setValueField : function(t) {
		this.valueField = t
	},
	getValueField : function() {
		return this.valueField
	},
	setTextField : function(t) {
		this.textField = t
	},
	getTextField : function() {
		return this.textField
	},
	getItemValue : function(t) {
		return String(mini._getMap(this.valueField, t))
	},
	getItemText : function(t) {
		var e = mini._getMap(this.textField, t);
		return mini.isNull(e) ? "" : String(e)
	},
	getValueAndText : function(t) {
		mini.isNull(t) && (t = []), mini.isArray(t) || (t = this.findItems(t));
		for (var e = [], i = [], n = 0, s = t.length; s > n; n++) {
			var o = t[n];
			o && (e.push(this.getItemValue(o)), i.push(this.getItemText(o)))
		}
		return [ e.join(this.delimiter), i.join(this.delimiter) ]
	},
	findItems : function(t) {
		mini.isNull(t) && (t = "");
		for (var e = String(t).split(this.delimiter), i = this.data, n = {}, s = 0, o = i.length; o > s; s++) {
			var l = i[s],
				r = l[this.valueField];
			n[r] = l
		}
		for (var a = [], h = 0, d = e.length; d > h; h++) {
			var r = e[h],
				l = n[r];
			l && a.push(l)
		}
		return a
	},
	removeAll : function() {
		var t = this.getData();
		this.removeItems(t)
	},
	addItems : function(t, e) {
		mini.isArray(t) && (mini.isNull(e) && (e = this.data.length), this.data.insertRange(e, t), this.doUpdate())
	},
	addItem : function(t, e) {
		t && -1 == this.data.indexOf(t) && (mini.isNull(e) && (e = this.data.length), this.data.insert(e, t), this.doUpdate())
	},
	removeItems : function(t) {
		mini.isArray(t) && (this.data.removeRange(t), this._checkSelecteds(), this.doUpdate())
	},
	removeItem : function(t) {
		var e = this.data.indexOf(t);
		-1 != e && (this.data.removeAt(e), this._checkSelecteds(), this.doUpdate())
	},
	moveItem : function(t, e) {
		t && mini.isNumber(e) && (0 > e && (e = 0), e > this.data.length && (e = this.data.length), this.data.remove(t), this.data.insert(e, t), this.doUpdate())
	},
	_selected : null,
	_selecteds : [],
	multiSelect : !1,
	_checkSelecteds : function() {
		for (var t = this._selecteds.length - 1; t >= 0; t--) {
			var e = this._selecteds[t];
			-1 == this.data.indexOf(e) && this._selecteds.removeAt(t)
		}
		var i = this.getValueAndText(this._selecteds);
		this.value = i[0], this._valueEl && (this._valueEl.value = this.value)
	},
	setMultiSelect : function(t) {
		this.multiSelect = t
	},
	getMultiSelect : function() {
		return this.multiSelect
	},
	isSelected : function(t) {
		return t ? -1 != this._selecteds.indexOf(t) : !1
	},
	getSelecteds : function() {
		var t = this._selecteds.clone(),
			e = this;
		return mini.sort(t, function(t, i) {
				var n = e.indexOf(t),
					s = e.indexOf(i);
				return n > s ? 1 : s > n ? -1 : 0
			}), t
	},
	setSelected : function(t) {
		t && (this._selected = t, this.select(t))
	},
	getSelected : function() {
		return this._selected
	},
	select : function(t) {
		t = this.getItem(t), t && (this.isSelected(t) || this.selects([ t ]))
	},
	deselect : function(t) {
		t = this.getItem(t), t && this.isSelected(t) && this.deselects([ t ])
	},
	selectAll : function() {
		var t = this.data.clone();
		this.selects(t)
	},
	deselectAll : function() {
		this.deselects(this._selecteds)
	},
	clearSelect : function() {
		this.deselectAll()
	},
	selects : function(t) {
		if (t && 0 != t.length) {
			t = t.clone();
			for (var e = 0, i = t.length; i > e; e++) {
				var n = t[e];
				this.isSelected(n) || this._selecteds.push(n)
			}
			var s = this;
			s._doSelects()
		}
	},
	deselects : function(t) {
		if (t && 0 != t.length) {
			t = t.clone();
			for (var e = t.length - 1; e >= 0; e--) {
				var i = t[e];
				this.isSelected(i) && this._selecteds.remove(i)
			}
			var n = this;
			n._doSelects()
		}
	},
	_doSelects : function() {
		var t = this.getValueAndText(this._selecteds);
		this.value = t[0], this._valueEl && (this._valueEl.value = this.value);
		for (var e = 0, i = this.data.length; i > e; e++) {
			var n = this.data[e],
				s = this.isSelected(n);
			s ? this.addItemCls(n, this._itemSelectedCls) : this.removeItemCls(n, this._itemSelectedCls);var o = this.data.indexOf(n),
				l = this._createCheckId(o),
				r = document.getElementById(l);
			r && (r.checked = !!s, r.defaultChecked = !!s)
		}
	},
	_OnSelectionChanged : function(t, e) {
		var i = this.getValueAndText(this._selecteds);
		this.value = i[0], this._valueEl && (this._valueEl.value = this.value);
		var n = {
			selecteds : this.getSelecteds(),
			selected : this.getSelected(),
			value : this.getValue()
		};
		this.fire("SelectionChanged", n)
	},
	_createCheckId : function(t) {
		return this.uid + "$ck$" + t
	},
	_createItemId : function(t) {
		return this.uid + "$" + t
	},
	__OnClick : function(t) {
		this._fireEvent(t, "Click")
	},
	__OnDblClick : function(t) {
		this._fireEvent(t, "Dblclick")
	},
	__OnMouseDown : function(t) {
		this._fireEvent(t, "MouseDown")
	},
	__OnMouseUp : function(t) {
		this._fireEvent(t, "MouseUp")
	},
	__OnMouseMove : function(t) {
		this._fireEvent(t, "MouseMove")
	},
	__OnMouseOver : function(t) {
		this._fireEvent(t, "MouseOver")
	},
	__OnMouseOut : function(t) {
		this._fireEvent(t, "MouseOut")
	},
	__OnKeyDown : function(t) {
		this._fireEvent(t, "KeyDown"), this.__OnInputKeyDown && this.__OnInputKeyDown(t)
	},
	__OnKeyUp : function(t) {
		this._fireEvent(t, "KeyUp")
	},
	__OnContextMenu : function(t) {
		this._fireEvent(t, "ContextMenu")
	},
	_fireEvent : function(t, e) {
		if (this.enabled) {
			var i = this.getItemByEvent(t);
			if (i) {
				var n = this["_OnItem" + e];
				if (n) n.call(this, i, t);else {
					var s = {
						item : i,
						htmlEvent : t
					};
					this.fire("item" + e, s)
				}
			}
		}
	},
	_OnItemClick : function(t, e) {
		if (this.isReadOnly() || 0 == this.enabled || t.enabled === !1) return void e.preventDefault();
		var i = this.getValue();
		this.multiSelect ? (this.isSelected(t) ? (this.deselect(t), this._selected == t && (this._selected = null)) : (this.select(t), this._selected = t), this._OnSelectionChanged()) : this.isSelected(t) || (this.deselectAll(), this.select(t), this._selected = t, this._OnSelectionChanged()), i != this.getValue() && this._OnValueChanged();
		var e = {
			item : t,
			htmlEvent : e
		};
		this.fire("itemclick", e)
	},
	_blurOnOut : !0,
	_OnItemMouseOut : function(t, e) {
		if (mini.repaint(this.el), this.enabled) {
			this._blurOnOut && this._blurItem();
			var e = {
				item : t,
				htmlEvent : e
			};
			this.fire("itemmouseout", e)
		}
	},
	_OnItemMouseMove : function(t, e) {
		if (mini.repaint(this.el), this.enabled && t.enabled !== !1) {
			this._focusItem(t);
			var e = {
				item : t,
				htmlEvent : e
			};
			this.fire("itemmousemove", e)
		}
	},
	onItemClick : function(t, e) {
		this.on("itemclick", t, e)
	},
	onItemMouseDown : function(t, e) {
		this.on("itemmousedown", t, e)
	},
	onBeforeLoad : function(t, e) {
		this.on("beforeload", t, e)
	},
	onLoad : function(t, e) {
		this.on("load", t, e)
	},
	onLoadError : function(t, e) {
		this.on("loaderror", t, e)
	},
	onPreLoad : function(t, e) {
		this.on("preload", t, e)
	},
	getAttrs : function(t) {
		var e = mini.ListControl.superclass.getAttrs.call(this, t);
		mini._ParseString(t, e, [ "url", "data", "value", "textField", "valueField", "onitemclick", "onitemmousemove", "onselectionchanged", "onitemdblclick", "onbeforeload", "onload", "onloaderror", "ondataload" ]), mini._ParseBool(t, e, [ "multiSelect" ]);
		var i = e.valueField || this.valueField,
			n = e.textField || this.textField;
		if ("select" == t.nodeName.toLowerCase()) {
			for (var s = [], o = 0, l = t.length; l > o; o++) {
				var r = t.options[o],
					a = {};
				a[n] = r.text, a[i] = r.value, s.push(a)
			}
			s.length > 0 && (e.data = s)
		}
		return e
	}
}), mini.CheckBox = function() {
	mini.CheckBox.superclass.constructor.call(this)
}, mini.extend(mini.CheckBox, mini.Control, {
	formField : !0,
	_clearText : !1,
	text : "",
	checked : !1,
	defaultValue : !1,
	trueValue : !0,
	falseValue : !1,
	uiCls : "mini-checkbox",
	_create : function() {
		var t = this.uid + "$check";
		this.el = document.createElement("span"), this.el.className = "mini-checkbox", this.el.innerHTML = '<input id="' + t + '" name="' + this.id + '" type="checkbox" class="mini-checkbox-check"><label for="' + t + '" onclick="return false;">' + this.text + "</label>", this._checkEl = this.el.firstChild, this._labelEl = this.el.lastChild
	},
	destroy : function(t) {
		this._checkEl && (this._checkEl.onmouseup = null, this._checkEl.onclick = null, mini.clearEvent(this._checkEl), this.el.removeChild(this._checkEl), this._checkEl = null), this._labelEl && (mini.clearEvent(this._labelEl), this.el.removeChild(this._labelEl), this._labelEl = null), mini.CheckBox.superclass.destroy.call(this, t)
	},
	_initEvents : function() {
		mini._BindEvents(function() {
			mini.on(this.el, "click", this.__onClick, this), this._checkEl.onmouseup = function() {
				return !1
			};
			var t = this;
			this._checkEl.onclick = function() {
				return t.isReadOnly() ? !1 : void 0
			}, mini.on(this._checkEl, "keydown", this.__OnInputKeyDown, this)
		}, this)
	},
	setName : function(t) {
		this.name = t, mini.setAttr(this._checkEl, "name", this.name)
	},
	setText : function(t) {
		this.text !== t && (this.text = t, this._labelEl.innerHTML = t)
	},
	getText : function() {
		return this.text
	},
	setChecked : function(t, e) {
		t = t === !0 ? !0 : t == this.trueValue ? !0 : "true" == t ? !0 : 1 === t ? !0 : "Y" == t ? !0 : !1, this.checked !== t && (this.checked = !!t, this._checkEl.checked = this.checked, this.value = this.getValue(), void 0 === e && (e = !0), e && (this.fire("checkedchanged", {
			checked : this.checked
		}), this.fire("valuechanged", {
			value : this.getValue()
		})))
	},
	getChecked : function() {
		return this.checked
	},
	setValue : function(t, e) {
		this.checked != t && (this.setChecked(t, e), this.value = this.getValue())
	},
	getValue : function() {
		return String(1 == this.checked ? this.trueValue : this.falseValue)
	},
	getFormValue : function() {
		return this.getValue()
	},
	setTrueValue : function(t) {
		this._checkEl.value = t, this.trueValue = t
	},
	getTrueValue : function() {
		return this.trueValue
	},
	setFalseValue : function(t) {
		this.falseValue = t
	},
	getFalseValue : function() {
		return this.falseValue
	},
	__onClick : function(t) {
		this.isReadOnly() || (this.setChecked(!this.checked), this.fire("click", t, this))
	},
	focus : function() {
		this._checkEl.focus()
	},
	__OnInputKeyDown : function(t) {
		var e = {
			htmlEvent : t
		};
		13 == t.keyCode && this.fire("enter", e), 27 == t.keyCode && t.preventDefault()
	},
	getAttrs : function(t) {
		var e = mini.CheckBox.superclass.getAttrs.call(this, t),
			i = jQuery(t);
		e.text = t.innerHTML, mini._ParseString(t, e, [ "text", "oncheckedchanged", "onclick", "onvaluechanged" ]), mini._ParseBool(t, e, [ "enabled" ]);
		var n = mini.getAttr(t, "checked");
		n && (e.checked = "true" == n || "checked" == n ? !0 : !1);
		var s = i.attr("trueValue");
		s && (e.trueValue = s, s = parseInt(s), isNaN(s) || (e.trueValue = s));
		var o = i.attr("falseValue");
		return o && (e.falseValue = o, o = parseInt(o), isNaN(o) || (e.falseValue = o)), e
	}
}), mini.regClass(mini.CheckBox, "checkbox"), mini.CheckBoxList = function() {
	mini.CheckBoxList.superclass.constructor.call(this)
}, mini.extend(mini.CheckBoxList, mini.ListControl, {
	formField : !0,
	multiSelect : !0,
	repeatItems : 0,
	repeatLayout : "none",
	repeatDirection : "horizontal",
	_itemCls : "mini-checkboxlist-item",
	_itemHoverCls : "mini-checkboxlist-item-hover",
	_itemSelectedCls : "mini-checkboxlist-item-selected",
	_tableCls : "mini-checkboxlist-table",
	_tdCls : "mini-checkboxlist-td",
	_checkType : "checkbox",
	uiCls : "mini-checkboxlist",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = this.uiCls, this.el.innerHTML = '<div class="mini-list-inner"></div><div class="mini-errorIcon"></div><input type="hidden" />', this._innerEl = this.el.firstChild, this._valueEl = this.el.lastChild, this._errorIconEl = this.el.childNodes[1]
	},
	_getRepeatTable : function() {
		var t = [];
		if (this.repeatItems > 0)
			if ("horizontal" == this.repeatDirection) {
				for (var e = [], i = 0, n = this.data.length; n > i; i++) {
					var s = this.data[i];
					e.length == this.repeatItems && (t.push(e), e = []), e.push(s)
				}
				t.push(e)
			} else {
				for (var o = this.repeatItems > this.data.length ? this.data.length : this.repeatItems, i = 0, n = o; n > i; i++) t.push([]);
				for (var i = 0, n = this.data.length; n > i; i++) {
					var s = this.data[i],
						l = i % this.repeatItems;
					t[l].push(s)
				}
		}
		else
			t = [ this.data.clone() ];
		return t
	},
	doUpdate : function() {
		for (var t = this.data, e = "", i = 0, n = t.length; n > i; i++) {
			var s = t[i];
			s._i = i
		}
		if ("flow" == this.repeatLayout)
			for (var o = this._getRepeatTable(), i = 0, n = o.length; n > i; i++) {
				for (var l = o[i], r = 0, a = l.length; a > r; r++) {
					var s = l[r];
					e += this._createItemHtml(s, s._i)
				}
				i != n - 1 && (e += "<br/>")
		}
		else if ("table" == this.repeatLayout) {
			var o = this._getRepeatTable();
			e += '<table class="' + this._tableCls + '" cellpadding="0" cellspacing="1">';
			for (var i = 0, n = o.length; n > i; i++) {
				var l = o[i];
				e += "<tr>";
				for (var r = 0, a = l.length; a > r; r++) {
					var s = l[r];
					e += '<td class="' + this._tdCls + '">', e += this._createItemHtml(s, s._i), e += "</td>"
				}
				e += "</tr>"
			}
			e += "</table>"
		} else
			for (var i = 0, n = t.length; n > i; i++) {
				var s = t[i];
				e += this._createItemHtml(s, i)
		}
		this._innerEl.innerHTML = e;
		for (var i = 0, n = t.length; n > i; i++) {
			var s = t[i];
			delete s._i
		}
	},
	destroy : function(t) {
		this._valueEl && (this._valueEl = null), this._errorIconEl && (this._errorIconEl = null), this._innerEl && (this._innerEl = null), mini.CheckBoxList.superclass.destroy.call(this, t)
	},
	_createItemHtml : function(t, e) {
		var i = this._OnDrawItem(t, e),
			n = this._createItemId(e),
			s = this._createCheckId(e),
			o = this.getItemValue(t),
			l = "",
			r = '<div id="' + n + '" index="' + e + '" class="' + this._itemCls + " ";
		t.enabled === !1 && (r += " mini-disabled ", l = "disabled");
		var a = 'onclick="return false"';
		return a = 'onmousedown="this._checked = this.checked;" onclick="this.checked = this._checked"', r += i.itemCls + '" style="' + i.itemStyle + '"><input ' + a + " " + l + ' value="' + o + '" id="' + s + '" type="' + this._checkType + '" /><label for="' + s + '" onclick="return false;">', r += i.itemHtml + "</label></div>"
	},
	_OnDrawItem : function(t, e) {
		var i = this.getItemText(t),
			n = {
				index : e,
				item : t,
				itemHtml : i,
				itemCls : "",
				itemStyle : ""
			};
		return this.fire("drawitem", n), (null === n.itemHtml || void 0 === n.itemHtml) && (n.itemHtml = ""), n
	},
	focus : function() {
		jQuery(this._innerEl).find("input:checked:enabled").length > 0 ? jQuery(this._innerEl).find("input:checked:enabled:first").focus() : jQuery(this._innerEl).find("input:first").focus()
	},
	__OnInputKeyDown : function(t) {
		var e = {
			htmlEvent : t
		};
		13 == t.keyCode && this.fire("enter", e), 27 == t.keyCode && t.preventDefault()
	},
	setRepeatItems : function(t) {
		t = parseInt(t), isNaN(t) && (t = 0), this.repeatItems != t && (this.repeatItems = t, this.doUpdate())
	},
	getRepeatItems : function() {
		return this.repeatItems
	},
	setRepeatLayout : function(t) {
		"flow" != t && "table" != t && (t = "none"), this.repeatLayout != t && (this.repeatLayout = t, this.doUpdate())
	},
	getRepeatLayout : function() {
		return this.repeatLayout
	},
	setRepeatDirection : function(t) {
		"vertical" != t && (t = "horizontal"), this.repeatDirection != t && (this.repeatDirection = t, this.doUpdate())
	},
	getRepeatDirection : function() {
		return this.repeatDirection
	},
	getAttrs : function(t) {
		var e = mini.CheckBoxList.superclass.getAttrs.call(this, t),
			i = jQuery(t),
			n = parseInt(i.attr("repeatItems"));
		isNaN(n) || (e.repeatItems = n);
		var s = i.attr("repeatLayout");
		s && (e.repeatLayout = s);
		var o = i.attr("repeatDirection");
		o && (e.repeatDirection = o);
		var l = i.attr("ondrawitem");
		return l && (e.ondrawitem = l), e
	}
}), mini.regClass(mini.CheckBoxList, "checkboxlist"), mini.Box = function() {
	mini.Box.superclass.constructor.call(this)
}, mini.extend(mini.Box, mini.Container, {
	style : "",
	borderStyle : "",
	bodyStyle : "",
	uiCls : "mini-box",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-box", this.el.innerHTML = '<div class="mini-box-border"></div>', this._bodyEl = this._borderEl = this.el.firstChild, this._contentEl = this._bodyEl
	},
	_initEvents : function() {},
	doLayout : function() {
		if (this.canLayout()) {
			var t = this.isAutoHeight(),
				e = (this.isAutoWidth(), mini.getPaddings(this._bodyEl)),
				i = mini.getMargins(this._bodyEl);
			if (t)
				this._bodyEl.style.height = "";else {
				var n = this.getHeight(!0);
				jQuery.boxModel && (n = n - e.top - e.bottom), n = n - i.top - i.bottom, 0 > n && (n = 0), this._bodyEl.style.height = n + "px"
			}
			var s = this.getWidth(!0);
			s = s - i.left - i.right, jQuery.boxModel && (s = s - e.left - e.right), 0 > s && (s = 0), this._bodyEl.style.width = s + "px", mini.layout(this._borderEl), this.fire("layout")
		}
	},
	setBody : function(t) {
		if (t) {
			mini.isArray(t) || (t = [ t ]);
			for (var e = 0, i = t.length; i > e; e++) mini.append(this._bodyEl, t[e]);
			mini.parse(this._bodyEl), this.doLayout()
		}
	},
	set_bodyParent : function(t) {
		if (t) {
			for (var e = this._bodyEl, i = t; i.firstChild;) e.appendChild(i.firstChild);
			this.doLayout()
		}
	},
	setBodyStyle : function(t) {
		mini.setStyle(this._bodyEl, t), this.doLayout()
	},
	getAttrs : function(t) {
		var e = mini.Box.superclass.getAttrs.call(this, t);
		return e._bodyParent = t, mini._ParseString(t, e, [ "bodyStyle" ]), e
	}
}), mini.regClass(mini.Box, "box"), mini = mini || {}, mini.Button = function() {
	mini.Button.superclass.constructor.call(this)
}, mini.extend(mini.Button, mini.Control, {
	text : "",
	iconCls : "",
	iconStyle : "",
	plain : !1,
	checkOnClick : !1,
	checked : !1,
	groupName : "",
	_plainCls : "mini-button-plain",
	_hoverCls : "mini-button-hover",
	_pressedCls : "mini-button-pressed",
	_checkedCls : "mini-button-checked",
	_disabledCls : "mini-button-disabled",
	allowCls : "",
	_clearBorder : !1,
	set : function(t) {
		return "string" == typeof t ? this : (this._allowUpdate = t.text || t.iconStyle || t.iconCls || t.iconPosition, mini.Button.superclass.set.call(this, t), this._allowUpdate === !1 && (this._allowUpdate = !0, this.doUpdate()), this)
	},
	uiCls : "mini-button",
	_create : function() {
		this.el = document.createElement("a"), this.el.className = "mini-button", this.el.hideFocus = !0, this.el.href = "javascript:void(0)", this.doUpdate()
	},
	_initEvents : function() {
		mini._BindEvents(function() {
			mini_onOne(this.el, "mousedown", this.__OnMouseDown, this), mini_onOne(this.el, "click", this.__OnClick, this)
		}, this)
	},
	destroy : function(t) {
		this.el && (this.el.onclick = null, this.el.onmousedown = null), this.menu && (this.menu.owner = null), this.menu = null, mini.Button.superclass.destroy.call(this, t)
	},
	doUpdate : function() {
		if (this._allowUpdate !== !1) {
			var t = "",
				e = this.text;
			this.iconCls && e ? t = " mini-button-icon " + this.iconCls : this.iconCls && "" === e ? (t = " mini-button-iconOnly " + this.iconCls, e = "&nbsp;") : "" == e && (e = "&nbsp;");
			var i = '<span class="mini-button-text ' + t + '">' + e + "</span>";
			this.allowCls && (i = i + '<span class="mini-button-allow ' + this.allowCls + '"></span>'), this.el.innerHTML = i
		}
	},
	href : "",
	setHref : function(t) {
		this.href = t, this.el.href = t;
		var e = this.el;
		setTimeout(function() {
			e.onclick = null
		}, 100)
	},
	getHref : function() {
		return this.href
	},
	target : "",
	setTarget : function(t) {
		this.target = t, this.el.target = t
	},
	getTarget : function() {
		return this.target
	},
	setText : function(t) {
		this.text != t && (this.text = t, this.doUpdate())
	},
	getText : function() {
		return this.text
	},
	setIconCls : function(t) {
		this.iconCls = t, this.doUpdate()
	},
	getIconCls : function() {
		return this.iconCls
	},
	setIconStyle : function(t) {
		this.iconStyle = t, this.doUpdate()
	},
	getIconStyle : function() {
		return this.iconStyle
	},
	setIconPosition : function(t) {
		this.iconPosition = "left", this.doUpdate()
	},
	getIconPosition : function() {
		return this.iconPosition
	},
	setPlain : function(t) {
		this.plain = t, t ? this.addCls(this._plainCls) : this.removeCls(this._plainCls)
	},
	getPlain : function() {
		return this.plain
	},
	setGroupName : function(t) {
		this.groupName = t
	},
	getGroupName : function() {
		return this.groupName
	},
	setCheckOnClick : function(t) {
		this.checkOnClick = t
	},
	getCheckOnClick : function() {
		return this.checkOnClick
	},
	setChecked : function(t) {
		var e = this.checked != t;
		this.checked = t, t ? this.addCls(this._checkedCls) : this.removeCls(this._checkedCls), e && this.fire("CheckedChanged")
	},
	getChecked : function() {
		return this.checked
	},
	doClick : function() {
		this.__OnClick(null)
	},
	__OnClick : function(t) {
		if (!this.readOnly && 0 != this.enabled) {
			if (this.focus(), this.checkOnClick)
				if (this.groupName) {
					var e = this.groupName,
						i = mini.findControls(function(t) {
							return "button" == t.type && t.groupName == e ? !0 : void 0
						});
					if (i.length > 0) {
						for (var n = 0, s = i.length; s > n; n++) {
							var o = i[n];
							o != this && o.setChecked(!1)
						}
						this.setChecked(!0)
					} else this.setChecked(!this.checked)
				} else this.setChecked(!this.checked);
			return this.fire("click", {
					htmlEvent : t
				}), !1
		}
	},
	__OnMouseDown : function(t) {
		this.isReadOnly() || (this.addCls(this._pressedCls), mini.on(document, "mouseup", this.__OnDocMouseUp, this))
	},
	__OnDocMouseUp : function(t) {
		this.removeCls(this._pressedCls), mini.un(document, "mouseup", this.__OnDocMouseUp, this)
	},
	onClick : function(t, e) {
		this.on("click", t, e)
	},
	getAttrs : function(t) {
		var e = mini.Button.superclass.getAttrs.call(this, t);
		return e.text = t.innerHTML, mini._ParseString(t, e, [ "text", "href", "iconCls", "iconStyle", "iconPosition", "groupName", "menu", "onclick", "oncheckedchanged", "target" ]), mini._ParseBool(t, e, [ "plain", "checkOnClick", "checked" ]), e
	}
}), mini.regClass(mini.Button, "button"), mini = mini || {}, mini.ButtonEdit = function() {
	mini.ButtonEdit.superclass.constructor.call(this);
	var t = this.isReadOnly();
	(t || 0 == this.allowInput) && (this._textEl.readOnly = !0), 0 == this.enabled && this.addCls(this._disabledCls), t && this.addCls(this._readOnlyCls), this.required && this.addCls(this._requiredCls)
}, mini.extend(mini.ButtonEdit, mini.ValidatorBase, {
	name : "",
	formField : !0,
	selectOnFocus : !1,
	showClose : !1,
	emptyText : "",
	defaultValue : "",
	value : "",
	text : "",
	maxLength : 1e3,
	minLength : 0,
	width : 125,
	height : 21,
	delimiter : ",",
	inputAsValue : !1,
	allowInput : !0,
	_noInputCls : "mini-buttonedit-noInput",
	_readOnlyCls : "mini-buttonedit-readOnly",
	_disabledCls : "mini-buttonedit-disabled",
	_emptyCls : "mini-buttonedit-empty",
	_focusCls : "mini-buttonedit-focus",
	_buttonCls : "mini-buttonedit-button",
	_buttonHoverCls : "mini-buttonedit-button-hover",
	_buttonPressedCls : "mini-buttonedit-button-pressed",
	_closeCls : "mini-buttonedit-close",
	showToolTip : !0,
	set : function(t) {
		if ("string" == typeof t) return this;
		var e = t.value;
		delete t.value;
		var i = t.text;
		return delete t.text
			, this._allowUpdate = !(0 == t.enabled || 0 == t.allowInput || t.readOnly), mini.ButtonEdit.superclass.set.call(this, t), this._allowUpdate === !1 && (this._allowUpdate = !0, this.doUpdate()), mini.isNull(i) || this.setText(i), mini.isNull(e) || this.setValue(e, this.defaultValueTriggerChange), t.showClose || this.setShowClose(this.showClose), t.showToolTip || this.setShowToolTip(this.showToolTip), this
	},
	uiCls : "mini-buttonedit",
	_getButtonsHTML : function() {
		var t = '<span class="mini-buttonedit-close"></span>' + this._getButtonHtml();
		return '<span class="mini-buttonedit-buttons">' + t + "</span>"
	},
	_getButtonHtml : function() {
		var t = "onmouseover=\"mini.addClass(this, '" + this._buttonHoverCls + "');\" onmouseout=\"mini.removeClass(this, '" + this._buttonHoverCls + "');\"";
		return '<span class="mini-buttonedit-button" ' + t + '><span class="mini-buttonedit-icon"></span></span>'
	},
	_create : function() {
		this.el = document.createElement("span"), this.el.className = "mini-buttonedit";
		var t = this._getButtonsHTML();
		this.el.innerHTML = '<span class="mini-buttonedit-border"><input type="input" class="mini-buttonedit-input" autocomplete="off"/>' + t + '</span><input name="' + this.name + '" type="hidden"/>', this._borderEl = this.el.firstChild, this._textEl = this._borderEl.firstChild, this._valueEl = this.el.lastChild, this._buttonsEl = this._borderEl.lastChild, this._buttonEl = this._buttonsEl.lastChild, this._closeEl = this._buttonEl.previousSibling, this._doEmpty()
	},
	_addTooltip : function(t) {
		this.tooltip = new mini.ButtonEditTip(this._textEl)
	},
	_destroyTooltip : function(t) {
		this.tooltip && (mini.clearEvent(this.tooltip), this.tooltip.destroy(t), this.tooltip = null)
	},
	destroy : function(t) {
		this.el && (this.el.onmousedown = null, this.el.onmousewheel = null, this.el.onmouseover = null, this.el.onmouseout = null), this._destroyTooltip(t), this._textEl && (this._textEl.readOnly = null, this._textEl.onchange = null, this._textEl.onfocus = null, this._textEl.onmouseover = null, this._textEl.onmouseout = null, this._textEl.placeholder = null, this._textEl.onpropertychange = null, this._textEl._placeholder_label && (this._textEl._placeholder_label.onmousedown = null, this._textEl._placeholder_label.parentNode.removeChild(this._textEl._placeholder_label), this._textEl._placeholder_label = null), mini.clearEvent(this._textEl), this._textEl.parentNode.removeChild(this._textEl), this._textEl = null), this._buttonEl && (this._buttonEl.onmouseover = null, this._buttonEl.onmouseout = null, mini.clearEvent(this._buttonEl), this._buttonEl.parentNode.removeChild(this._buttonEl), this._buttonEl = null), this._closeEl && (this._closeEl.onclick = null, mini.clearEvent(this._closeEl), this._closeEl.parentNode.removeChild(this._closeEl), this._closeEl = null), this._buttonsEl && (mini.clearEvent(this._buttonsEl), this._buttonsEl.parentNode.removeChild(this._buttonsEl), this._buttonsEl = null), this._borderEl && (mini.clearEvent(this._borderEl), this._borderEl.parentNode.removeChild(this._borderEl), this._borderEl = null), this._valueEl && (mini.clearEvent(this._valueEl), this._valueEl.parentNode.removeChild(this._valueEl), this._valueEl = null), mini.ButtonEdit.superclass.destroy.call(this, t)
	},
	_initEvents : function() {
		mini._BindEvents(function() {
			mini_onOne(this.el, "mousedown", this.__OnMouseDown, this), mini_onOne(this._textEl, "focus", this.__OnFocus, this), mini_onOne(this._textEl, "change", this.__OnInputTextChanged, this), mini_onOne(this._closeEl, "click", this._onClearClick, this);
			var t = this.text;
			this.text = null, this.setText(t)
		}, this)
	},
	_onClearClick : function() {
		this.enabled && !this.readOnly && (this.setValue(""), this.setText(""))
	},
	_inputEventsInited : !1,
	_initInputEvents : function() {
		this._inputEventsInited || (this._inputEventsInited = !0, mini.on(this.el, "click", this.__OnClick, this), mini.on(this._textEl, "blur", this.__OnBlur, this), mini.on(this._textEl, "keydown", this.__OnInputKeyDown, this), mini.on(this._textEl, "keyup", this.__OnInputKeyUp, this), mini.on(this._textEl, "keypress", this.__OnInputKeyPress, this))
	},
	_buttonWidth : 20,
	_closeWidth : 20,
	_doInputLayout : function() {
		this.doLayout()
	},
	doLayout : function() {
		this.showClose && (this.value ? this._closeEl.style.display = "inline-block" : this._closeEl.style.display = "none");
		var t = this._buttonsEl.offsetWidth + 2;
		this._borderEl.style.paddingRight = t + "px"
	},
	setHeight : function(t) {
		parseInt(t) == t && (t += "px"), this.height = t
	},
	focus : function() {
		if (0 != this.enabled) try {
				this._textEl.focus();var t = this;
				setTimeout(function() {
					t._focused && t._textEl.focus()
				}, 10)
			} catch (e) {}
	},
	blur : function() {
		try {
			this._textEl.blur()
		} catch (t) {}
	},
	selectText : function() {
		this._textEl.select()
	},
	getTextEl : function() {
		return this._textEl
	},
	setName : function(t) {
		this.name = t, this._valueEl && mini.setAttr(this._valueEl, "name", this.name)
	},
	setText : function(t) {
		(null === t || void 0 === t) && (t = ""), this.text !== t, this.text = t, this._textEl.value = t, this._doEmpty()
	},
	getText : function() {
		var t = this._textEl.value;
		return t
	},
	setValue : function(t, e) {
		var i = this.getValue();
		(null === t || void 0 === t) && (t = ""), this.value !== t, this.value = t, this._valueEl.value = this.getFormValue(), mini.isEquals(this.value, i) || (void 0 === e && (e = !0), e && this._OnValueChanged())
	},
	setShowToolTip : function(t) {
		this.showToolTip = t, this.showToolTip && this._addTooltip(this.el)
	},
	_OnValueChanged : function() {
		mini.ButtonEdit.superclass._OnValueChanged.call(this), this._doInputLayout()
	},
	getValue : function() {
		return this.value
	},
	getFormValue : function() {
		return value = this.value, (null === value || void 0 === value) && (value = ""), String(value)
	},
	_doEmpty : function() {
		this._textEl.placeholder = this.emptyText, this.emptyText && mini._placeholder(this._textEl)
	},
	setEmptyText : function(t) {
		this.emptyText != t && (this.emptyText = t, this._doEmpty())
	},
	getEmptyText : function() {
		return this.emptyText
	},
	setMaxLength : function(t) {
		t = parseInt(t), isNaN(t) || (this.maxLength = t, this._textEl.maxLength = t)
	},
	getMaxLength : function() {
		return this.maxLength
	},
	setMinLength : function(t) {
		t = parseInt(t), isNaN(t) || (this.minLength = t)
	},
	getMinLength : function() {
		return this.minLength
	},
	setEnabled : function(t) {
		mini.ButtonEdit.superclass.setEnabled.call(this, t), this._textEl._placeholder_label && (this._textEl._placeholder_label.disabled = !0), this._tryValidate()
	},
	_doReadOnly : function() {
		var t = this.isReadOnly();
		t || 0 == this.allowInput ? this._textEl.readOnly = !0 : this._textEl.readOnly = !1, t ? this.addCls(this._readOnlyCls) : this.removeCls(this._readOnlyCls), this.allowInput ? this.removeCls(this._noInputCls) : this.addCls(this._noInputCls), this.enabled ? this._textEl.disabled = !1 : this._textEl.disabled = !0
	},
	setAllowInput : function(t) {
		this.allowInput = t, this._doReadOnly()
	},
	getAllowInput : function() {
		return this.allowInput
	},
	setInputAsValue : function(t) {
		this.inputAsValue = t
	},
	getInputAsValue : function() {
		return this.inputAsValue
	},
	_errorIconEl : null,
	getErrorIconEl : function() {
		return this._errorIconEl || (this._errorIconEl = mini.append(this.el, '<span class="mini-errorIcon"></span>')), this._errorIconEl
	},
	_RemoveErrorIcon : function() {
		if (this._errorIconEl) {
			var t = this._errorIconEl;
			jQuery(t).remove()
		}
		this._errorIconEl = null
	},
	__OnClick : function(t) {
		!this.isReadOnly() && 0 != this.enabled && mini.isAncestor(this._borderEl, t.target) && (new Date, mini.isAncestor(this._buttonEl, t.target) && this._OnButtonClick(t), mini.findParent(t.target, this._closeCls) && this.fire("closeclick", {
			htmlEvent : t
		}))
	},
	__OnMouseDown : function(t) {
		if (!this.isReadOnly() && 0 != this.enabled && mini.isAncestor(this._borderEl, t.target) && !mini.isAncestor(this._textEl, t.target)) {
			this._clickTarget = t.target;
			var e = this;
			if (setTimeout(function() {
					e.focus(), mini.selectRange(e._textEl, 1e3, 1e3)
				}, 1), mini.isAncestor(this._buttonEl, t.target)) {
				var i = mini.findParent(t.target, "mini-buttonedit-up"),
					n = mini.findParent(t.target, "mini-buttonedit-down");
				i ? (mini.addClass(i, this._buttonPressedCls), this._OnButtonMouseDown(t, "up")) : n ? (mini.addClass(n, this._buttonPressedCls), this._OnButtonMouseDown(t, "down")) : (mini.addClass(this._buttonEl, this._buttonPressedCls), this._OnButtonMouseDown(t)), mini.on(document, "mouseup", this.__OnDocMouseUp, this)
			}
		}
	},
	__OnDocMouseUp : function(t) {
		this._clickTarget = null;
		var e = this;
		setTimeout(function() {
			for (var t = e._buttonEl.getElementsByTagName("*"), i = 0, n = t.length; n > i; i++) mini.removeClass(t[i], e._buttonPressedCls);
			mini.removeClass(e._buttonEl, e._buttonPressedCls), mini.removeClass(e.el, e._pressedCls)
		}, 80), mini.un(document, "mouseup", this.__OnDocMouseUp, this)
	},
	__OnFocus : function(t) {
		this.doUpdate(), this._initInputEvents(), this.isReadOnly() || (this._focused = !0, this.addCls(this._focusCls), this.selectOnFocus && this.selectText(), this.fire("focus", {
			htmlEvent : t
		}))
	},
	__doFocusCls : function() {
		0 == this._focused && this.removeCls(this._focusCls)
	},
	__fireBlur : function(t) {
		function e() {
			0 == i._focused && (i.removeCls(i._focusCls), i.validateOnLeave && i._tryValidate(), this.fire("blur", {
				htmlEvent : t
			}))
		}
		var i = this;
		setTimeout(function() {
			e.call(i)
		}, 2)
	},
	__OnBlur : function(t) {
		this._focused = !1;
		var e = this;
		setTimeout(function() {
			e.__fireBlur(t)
		}, 10)
	},
	__OnInputKeyDown : function(t) {
		var e = {
			htmlEvent : t
		};
		if (this.fire("keydown", e), 8 == t.keyCode && (this.isReadOnly() || 0 == this.allowInput)) return !1;
		if (27 == t.keyCode || 13 == t.keyCode || 9 == t.keyCode) {
			var i = this;
			if (i.__OnInputTextChanged(null), 13 == t.keyCode) {
				var n = this;
				n.fire("enter", e)
			}
		}
		27 == t.keyCode && t.preventDefault()
	},
	__OnInputTextChanged : function() {
		var t = this._textEl.value;
		this.getValue(), this.setValue(t)
	},
	__OnInputKeyUp : function(t) {
		this.fire("keyup", {
			htmlEvent : t
		})
	},
	__OnInputKeyPress : function(t) {
		this.fire("keypress", {
			htmlEvent : t
		})
	},
	_OnButtonClick : function(t) {
		var e = {
			htmlEvent : t,
			cancel : !1
		};
		this.fire("beforebuttonclick", e), 1 != e.cancel && this.fire("buttonclick", e)
	},
	_OnButtonMouseDown : function(t, e) {
		this.focus(), this.addCls(this._focusCls), this.fire("buttonmousedown", {
			htmlEvent : t,
			spinType : e
		})
	},
	onButtonClick : function(t, e) {
		this.on("buttonclick", t, e)
	},
	onButtonMouseDown : function(t, e) {
		this.on("buttonmousedown", t, e)
	},
	onTextChanged : function(t, e) {
		this.on("textchanged", t, e)
	},
	textName : "",
	setTextName : function(t) {
		this.textName = t, this._textEl && mini.setAttr(this._textEl, "name", this.textName)
	},
	getTextName : function() {
		return this.textName
	},
	setSelectOnFocus : function(t) {
		this.selectOnFocus = t
	},
	getSelectOnFocus : function(t) {
		return this.selectOnFocus
	},
	setShowClose : function(t) {
		this.showClose = t
	},
	getShowClose : function(t) {
		return this.showClose
	},
	inputStyle : "",
	setInputStyle : function(t) {
		this.inputStyle = t, mini.setStyle(this._textEl, t)
	},
	getAttrs : function(t) {
		var e = mini.ButtonEdit.superclass.getAttrs.call(this, t);
		return jQuery(t), mini._ParseString(t, e, [ "value", "text", "textName", "emptyText", "inputStyle", "onenter", "onkeydown", "onkeyup", "onkeypress", "onbuttonclick", "onbuttonmousedown", "ontextchanged", "onfocus", "onblur", "oncloseclick" ]), mini._ParseBool(t, e, [ "allowInput", "inputAsValue", "selectOnFocus", "showClose", "showToolTip" ]), mini._ParseInt(t, e, [ "maxLength", "minLength" ]), e
	}
}), mini.regClass(mini.ButtonEdit, "buttonedit"), mini.ButtonEditTip = function(t) {
	this.textEl = t, this.attr = "", this.attrDelimiter = ",", this._create()
}, mini.ButtonEditTip.prototype = {
	delimiter : "<br/>",
	attrDelimiter : ",",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-buttonedittip", this.el.innerHTML = '<div class="mini-buttonedittip-colortip"><div class="mini-buttonedittip-content"></div></div>', this._contentEl = this.el.firstChild.childNodes[0];
		var t = document.getElementById("lengthspan");
		if (t)
			this._lengthspanEl = t;else {
			var e = document.createElement("span");
			e.className = "lengthspan", e.id = "lengthspan", document.body.appendChild(e), this._lengthspanEl = e
		}
		document.body.appendChild(this.el), mini_on(this.textEl, "mouseenter", this.show, this), mini_on(document, "mousemove", this.hide, this)
	},
	destroy : function(t) {
		this.textEl && (this.textEl.onmouseenter = null, this.textEl.onmouseleave = null, mini.clearEvent(this.textEl), mini_un(document, "mousemove", this.hide, this)), this.el = null, this._lengthspanEl = null, this._contentEl = null
	},
	_doUpdate : function(t) {
		t = mini.htmlEncode(t).split(mini.htmlEncode(this.attrDelimiter)).join(this.delimiter), this._contentEl.innerHTML = t
	},
	isOverFlow : function(t, e) {
		if (mini.isNull(e) || "" === e) return !1;
		e.length > 300 && (e = e.substring(0, 300));
		var i;
		i = document.defaultView ? document.defaultView.getComputedStyle(t, null) : t.currentStyle;
		var n = i.fontSize,
			s = i.fontFamily;
		return this._lengthspanEl.innerHTML = e, this._lengthspanEl.style.fontSize = n, this._lengthspanEl.style.fontFamily = s, this._lengthspanEl.offsetWidth - 2 > t.clientWidth ? !0 : !1
	},
	show : function() {
		var t = this.textEl.value;
		if (this.isOverFlow(this.textEl, t)) {
			this._doUpdate(t);
			var e = mini.getBox(this.textEl);
			this._contentEl.height = "auto";
			var i = Math.max(parseInt(this.textEl.clientWidth) + 10, 200),
				n = e.x + e.width / 2 - i / 2,
				s = e.y + e.height + 1;
			n + i > jQuery(window).width() && (n = jQuery(window).width() - i), 0 > n && (n = 0), this.el.style.left = n + 5 + "px", this.el.style.top = s + "px", this.el.style.display = "block", this._contentEl.style.height = "auto", mini.setWidth(this._contentEl, i), mini.getHeight(this._contentEl) > 200 && mini.setHeight(this._contentEl, 188), this.el.focus(), this.isshow = !0
		}
	},
	hide : function(t) {
		mini.findParent(t.target, "mini-buttonedittip") || mini.findParent(t.target, "mini-buttonedit-input") || (this.el.style.display = "none")
	},
	setIsshow : function(t) {
		this.isshow != t && (this.isshow = t, this.isshow ? this.show() : this.hide())
	},
	getIsshow : function() {
		return this.isshow
	}
}, mini.Calendar = function() {
	this.viewDate = new Date, this._selectedDates = [], mini.Calendar.superclass.constructor.call(this)
}, mini.extend(mini.Calendar, mini.Control, {
	width : 220,
	height : 160,
	monthPicker : !1,
	_clearBorder : !1,
	viewDate : null,
	_selectedDate : "",
	_selectedDates : [],
	multiSelect : !1,
	firstDayOfWeek : 0,
	yesterdayText : "Yesterday",
	todayText : "Today",
	clearText : "Clear",
	okText : "OK",
	cancelText : "Cancel",
	daysShort : [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ],
	format : "MMM, yyyy",
	timeFormat : "H:mm",
	showTime : !1,
	currentTime : !0,
	rows : 1,
	columns : 1,
	headerCls : "",
	bodyCls : "",
	footerCls : "",
	_todayCls : "mini-calendar-today",
	_weekendCls : "mini-calendar-weekend",
	_otherMonthCls : "mini-calendar-othermonth",
	_selectedDateCls : "mini-calendar-selected",
	showHeader : !0,
	showFooter : !0,
	showWeekNumber : !1,
	showDaysHeader : !0,
	showMonthButtons : !0,
	showYearButtons : !0,
	showTodayButton : !0,
	showClearButton : !0,
	showOkButton : !1,
	showYesterdayButton : !1,
	isWeekend : function(t) {
		var e = t.getDay();
		return 0 == e || 6 == e
	},
	getFirstDateOfMonth : function(t) {
		var t = new Date(t.getFullYear(), t.getMonth(), 1);
		return mini.getWeekStartDate(t, this.firstDayOfWeek)
	},
	getShortWeek : function(t) {
		return this.daysShort[t]
	},
	uiCls : "mini-calendar",
	_create : function() {
		var t = '<tr style="width:100%;"><td style="width:100%;"></td></tr>';
		t += '<tr ><td><div class="mini-calendar-footer"><span style="display:inline-block;"><input name="time" class="mini-timespinner" style="width:80px" format="' + this.timeFormat + '"/><span class="mini-calendar-footerSpace"></span></span><span class="mini-calendar-tadayButton">' + this.todayText + '</span><span class="mini-calendar-footerSpace"></span><span class="mini-calendar-clearButton">' + this.clearText + '</span><span class="mini-calendar-okButton">' + this.okText + '</span><a href="#" class="mini-calendar-focus" style="position:absolute;left:-10px;top:-10px;width:0px;height:0px;outline:none" hideFocus></a></div></td></tr>';
		var e = '<table class="mini-calendar" cellpadding="0" cellspacing="0">' + t + "</table>",
			i = document.createElement("div");
		i.innerHTML = e, this.el = i.firstChild;
		var n = (this.el.getElementsByTagName("tr"), this.el.getElementsByTagName("td"));
		this._innerEl = n[0], this._footerEl = mini.byClass("mini-calendar-footer", this.el), this.timeWrapEl = this._footerEl.childNodes[0], this.todayButtonEl = this._footerEl.childNodes[1], this.footerSpaceEl = this._footerEl.childNodes[2], this.closeButtonEl = this._footerEl.childNodes[3], this.okButtonEl = this._footerEl.childNodes[4], this._focusEl = this._footerEl.lastChild, this.yesterdayButtonEl = mini.after(this.todayButtonEl, '<span class="mini-calendar-tadayButton yesterday">' + this.yesterdayText + "</span>"), mini.parse(this._footerEl), this.timeSpinner = mini.getbyName("time", this.el), this.doUpdate()
	},
	focus : function() {
		try {
			this._focusEl.focus()
		} catch (t) {}
	},
	destroy : function(t) {
		this._innerEl = this._footerEl = this.timeWrapEl = this.todayButtonEl = this.footerSpaceEl = this.closeButtonEl = null, mini.Calendar.superclass.destroy.call(this, t)
	},
	_initEvents : function() {
		this.timeSpinner && this.timeSpinner.on("valuechanged", this.__OnTimeChanged, this), mini._BindEvents(function() {
			mini.on(this.el, "click", this.__OnClick, this), mini.on(this.el, "mousedown", this.__OnMouseDown, this), mini.on(this.el, "keydown", this.__OnKeyDown, this)
		}, this)
	},
	getDateEl : function(t) {
		if (!t) return null;
		var e = this.uid + "$" + mini.clearTime(t).getTime();
		return document.getElementById(e)
	},
	within : function(t) {
		return mini.isAncestor(this.el, t.target) ? !0 : this.menuEl && mini.isAncestor(this.menuEl, t.target) ? !0 : !1
	},
	setShowHeader : function(t) {
		this.showHeader = t, this.doUpdate()
	},
	getShowHeader : function() {
		return this.showHeader
	},
	setShowFooter : function(t) {
		this.showFooter = t, this.doUpdate()
	},
	getShowFooter : function() {
		return this.showFooter
	},
	setShowWeekNumber : function(t) {
		this.showWeekNumber = t, this.doUpdate()
	},
	getShowWeekNumber : function() {
		return this.showWeekNumber
	},
	setShowDaysHeader : function(t) {
		this.showDaysHeader = t, this.doUpdate()
	},
	getShowDaysHeader : function() {
		return this.showDaysHeader
	},
	setShowMonthButtons : function(t) {
		this.showMonthButtons = t, this.doUpdate()
	},
	getShowMonthButtons : function() {
		return this.showMonthButtons
	},
	setShowYearButtons : function(t) {
		this.showYearButtons = t, this.doUpdate()
	},
	getShowYearButtons : function() {
		return this.showYearButtons
	},
	setShowTodayButton : function(t) {
		this.showTodayButton = t, this.todayButtonEl.style.display = this.showTodayButton ? "" : "none", this.doUpdate()
	},
	getShowTodayButton : function() {
		return this.showTodayButton
	},
	setShowYesterdayButton : function(t) {
		this.showYesterdayButton = t, this.yesterdayButtonEl.style.display = this.showYesterdayButton ? "" : "none", this.doUpdate()
	},
	getShowYesterdayButton : function() {
		return this.showYesterdayButton
	},
	setShowClearButton : function(t) {
		this.showClearButton = t, this.closeButtonEl.style.display = this.showClearButton ? "" : "none", this.doUpdate()
	},
	getShowClearButton : function() {
		return this.showClearButton
	},
	setShowOkButton : function(t) {
		this.showOkButton = t, this.okButtonEl.style.display = this.showOkButton ? "" : "none", this.doUpdate()
	},
	getShowOkButton : function() {
		return this.showOkButton
	},
	setViewDate : function(t) {
		t = mini.parseDate(t), t || (t = new Date), mini.isDate(t) && (t = new Date(t.getTime())), this.viewDate = t, this.doUpdate()
	},
	getViewDate : function() {
		return this.viewDate
	},
	setSelectedDate : function(t) {
		t = mini.parseDate(t), t = mini.isDate(t) ? new Date(t.getTime()) : "";
		var e = this.getDateEl(this._selectedDate);
		e && mini.removeClass(e, this._selectedDateCls), this._selectedDate = t, this._selectedDate && (this._selectedDate = mini.cloneDate(this._selectedDate));
		var e = this.getDateEl(this._selectedDate);
		e && mini.addClass(e, this._selectedDateCls), this.fire("datechanged")
	},
	setSelectedDates : function(t) {
		mini.isArray(t) || (t = []), this._selectedDates = t, this.doUpdate()
	},
	getSelectedDate : function() {
		return this._selectedDate ? this._selectedDate : ""
	},
	setTime : function(t) {
		this.timeSpinner.setValue(t)
	},
	getTime : function() {
		return this.timeSpinner.getFormValue()
	},
	setValue : function(t) {
		this.setSelectedDate(t), t || (t = new Date), this.setTime(t)
	},
	getValue : function() {
		var t = this._selectedDate;
		if (t && (t = mini.clearTime(t), this.showTime)) {
			var e = this.timeSpinner.getValue();
			e && (t.setHours(e.getHours()), t.setMinutes(e.getMinutes()), t.setSeconds(e.getSeconds()))
		}
		return t ? t : ""
	},
	getFormValue : function() {
		var t = this.getValue();
		return t ? mini.formatDate(t, "yyyy-MM-dd HH:mm:ss") : ""
	},
	isSelectedDate : function(t) {
		return t && this._selectedDate ? mini.clearTime(t).getTime() == mini.clearTime(this._selectedDate).getTime() : !1
	},
	setMultiSelect : function(t) {
		this.multiSelect = t, this.doUpdate()
	},
	getMultiSelect : function() {
		return this.multiSelect
	},
	setRows : function(t) {
		isNaN(t) || (1 > t && (t = 1), this.rows = t, this.doUpdate())
	},
	getRows : function() {
		return this.rows
	},
	setColumns : function(t) {
		isNaN(t) || (1 > t && (t = 1), this.columns = t, this.doUpdate())
	},
	getColumns : function() {
		return this.columns
	},
	setShowTime : function(t) {
		this.showTime != t && (this.showTime = t, this.timeWrapEl.style.display = this.showTime ? "" : "none", this.doLayout())
	},
	getShowTime : function() {
		return this.showTime
	},
	setTimeFormat : function(t) {
		this.timeFormat != t && (this.timeSpinner.setFormat(t), this.timeFormat = this.timeSpinner.format)
	},
	getTimeFormat : function() {
		return this.timeFormat
	},
	doLayout : function() {
		if (this.canLayout()) {
			this.timeWrapEl.style.display = this.showTime ? "" : "none", this.todayButtonEl.style.display = this.showTodayButton ? "" : "none", this.closeButtonEl.style.display = this.showClearButton ? "" : "none", this.yesterdayButtonEl.style.display = this.showYesterdayButton ? "" : "none", this.okButtonEl.style.display = this.showOkButton ? "" : "none", this.footerSpaceEl.style.display = this.showClearButton && this.showTodayButton ? "" : "none", this._footerEl.style.display = this.showFooter ? "" : "none";
			var t = this._innerEl.firstChild,
				e = this.isAutoHeight();
			e ? t.parentNode.style.height = "" : (t.parentNode.style.height = "100px", h = jQuery(this.el).height(), h -= jQuery(this._footerEl).outerHeight(), t.parentNode.style.height = h + "px"), mini.layout(this._footerEl), this.monthPicker && this._tryShowMenu()
		}
	},
	doUpdate : function() {
		if (this._allowUpdate) {
			for (var t = new Date(this.viewDate.getTime()), e = (1 == this.rows && 1 == this.columns, 100 / this.rows), i = '<table class="mini-calendar-views" border="0" cellpadding="0" cellspacing="0">', n = 0, s = this.rows; s > n; n++) {
				i += "<tr >";
				for (var o = 0, l = this.columns; l > o; o++) i += '<td style="height:' + e + '%">', i += this._CreateView(t, n, o), i += "</td>", t = new Date(t.getFullYear(), t.getMonth() + 1, 1);
				i += "</tr>"
			}
			i += "</table>", this._innerEl.innerHTML = i;
			var r = this.el;
			setTimeout(function() {
				mini.repaint(r)
			}, 100), this.doLayout()
		}
	},
	_CreateView : function(t, e, i) {
		var n = t.getMonth(),
			s = this.getFirstDateOfMonth(t),
			o = new Date(s.getTime()),
			l = mini.clearTime(new Date).getTime(),
			r = (this.value ? mini.clearTime(this.value).getTime() : -1, this.rows > 1 || this.columns > 1),
			a = "";
		if (a += '<table class="mini-calendar-view" border="0" cellpadding="0" cellspacing="0">', this.showHeader && (a += '<tr ><td colSpan="10" class="mini-calendar-header"><div class="mini-calendar-headerInner">', 0 == e && 0 == i && (a += '<div class="mini-calendar-prev">', this.showYearButtons && (a += '<span class="mini-calendar-yearPrev"></span>'), this.showMonthButtons && (a += '<span class="mini-calendar-monthPrev"></span>'), a += "</div>"), 0 == e && i == this.columns - 1 && (a += '<div class="mini-calendar-next">', this.showMonthButtons && (a += '<span class="mini-calendar-monthNext"></span>'), this.showYearButtons && (a += '<span class="mini-calendar-yearNext"></span>'), a += "</div>"), a += '<span class="mini-calendar-title">' + mini.formatDate(t, this.format), a += "</div></td></tr>"), this.showDaysHeader) {
			a += '<tr class="mini-calendar-daysheader"><td class="mini-calendar-space"></td>', this.showWeekNumber && (a += '<td sclass="mini-calendar-weeknumber"></td>');
			for (var h = this.firstDayOfWeek, d = h + 7; d > h; h++) {
				var u = this.getShortWeek(h);
				a += '<td yAlign="middle">', a += u, a += "</td>", s = new Date(s.getFullYear(), s.getMonth(), s.getDate() + 1)
			}
			a += '<td class="mini-calendar-space"></td></tr>'
		}
		s = o;
		for (var c = 0; 5 >= c; c++) {
			if (a += '<tr class="mini-calendar-days"><td class="mini-calendar-space"></td>', this.showWeekNumber) {
				var m = mini.getWeek(s.getFullYear(), s.getMonth() + 1, s.getDate());
				1 == String(m).length && (m = "0" + m), a += '<td class="mini-calendar-weeknumber" yAlign="middle">' + m + "</td>"
			}
			for (var h = this.firstDayOfWeek, d = h + 7; d > h; h++) {
				var p = this.isWeekend(s),
					f = mini.clearTime(s).getTime(),
					g = f == l,
					_ = this.isSelectedDate(s);
				n != s.getMonth() && r && (f = -1);var v = this._OnDrawDate(s);
				a += '<td yAlign="middle" id="', a += this.uid + "$" + f, a += '" class="mini-calendar-date ', p && (a += " mini-calendar-weekend "), 0 == v.allowSelect && (a += " mini-calendar-disabled "), n != s.getMonth() && r || (_ && (a += " " + this._selectedDateCls + " "), g && (a += " mini-calendar-today ")), n != s.getMonth() && (a += " mini-calendar-othermonth "), v.dateCls && (a += " " + v.dateCls), a += '" style="', v.dateStyle && (a += v.dateStyle), a += '">', n != s.getMonth() && r || (a += v.dateHtml), a += "</td>", s = new Date(s.getFullYear(), s.getMonth(), s.getDate() + 1)
			}
			a += '<td class="mini-calendar-space"></td></tr>'
		}
		return a += '<tr class="mini-calendar-bottom" colSpan="10"><td ></td></tr>', a += "</table>"
	},
	_OnDrawDate : function(t) {
		var e = {
			date : t,
			dateCls : "",
			dateStyle : "",
			dateHtml : t.getDate(),
			allowSelect : !0
		};
		return this.fire("drawdate", e), e
	},
	_OnDateClick : function(t, e) {
		this.hideMenu();
		var i = {
			date : t,
			action : e
		};
		this.fire("dateclick", i), this._OnValueChanged()
	},
	menuEl : null,
	menuYear : null,
	menuSelectMonth : null,
	menuSelectYear : null,
	_tryShowMenu : function() {
		if (!this.menuEl) {
			var t = this;
			setTimeout(function() {
				t.showMenu()
			}, 1)
		}
	},
	showMenu : function() {
		this.hideMenu(), this.menuYear = 10 * parseInt(this.viewDate.getFullYear() / 10), this._menuselectMonth = this.viewDate.getMonth(), this._menuselectYear = this.viewDate.getFullYear();
		var t = '<div class="mini-calendar-menu"></div>';
		this.menuEl = mini.append(document.body, t), this.updateMenu(this.viewDate);
		var e = this.getBox();
		"0px" == this.el.style.borderWidth && (this.menuEl.style.border = "0"), mini.setBox(this.menuEl, e), mini.on(this.menuEl, "click", this.__OnMenuClick, this), mini.on(this.menuEl, "dblclick", this.__OnMenuDblClick, this), mini.on(document, "mousedown", this.__OnBodyMenuMouseDown, this)
	},
	hideMenu : function() {
		this.menuEl && (mini.un(this.menuEl, "click", this.__OnMenuClick, this), mini.un(document, "mousedown", this.__OnBodyMenuMouseDown, this), jQuery(this.menuEl).remove(), this.menuEl = null)
	},
	updateMenu : function() {
		if (this.menuEl) {
			for (var t = '<div class="mini-calendar-menu-months">', e = 0, i = 12; i > e; e++) {
				var n = mini.getShortMonth(e),
					s = "";
				this._menuselectMonth == e && (s = "mini-calendar-menu-selected"), t += '<a id="' + e + '" class="mini-calendar-menu-month ' + s + '" href="javascript:void(0);" hideFocus onclick="return false">' + n + "</a>"
			}
			t += '<div style="clear:both;"></div></div>', t += '<div class="mini-calendar-menu-years">';
			for (var e = this.menuYear, i = this.menuYear + 10; i > e; e++) {
				var n = e,
					s = "";
				this._menuselectYear == e && (s = "mini-calendar-menu-selected"), t += '<a id="' + e + '" class="mini-calendar-menu-year ' + s + '" href="javascript:void(0);" hideFocus onclick="return false">' + n + "</a>"
			}
			t += '<div class="mini-calendar-menu-prevYear"></div><div class="mini-calendar-menu-nextYear"></div><div style="clear:both;"></div></div>', t += '<div class="mini-calendar-footer"><span class="mini-calendar-okButton">' + this.okText + '</span><span class="mini-calendar-footerSpace"></span><span class="mini-calendar-cancelButton">' + this.cancelText + '</span></div><div style="clear:both;"></div>', this.menuEl.innerHTML = t
		}
	},
	__OnMenuClick : function(t) {
		function e() {
			setTimeout(function() {
				i.updateMenu()
			}, 30)
		}
		var i = this,
			n = t.target,
			s = mini.findParent(n, "mini-calendar-menu-month"),
			o = mini.findParent(n, "mini-calendar-menu-year");
		s ? (this._menuselectMonth = parseInt(s.id), e()) : o ? (this._menuselectYear = parseInt(o.id), e()) : mini.findParent(n, "mini-calendar-menu-prevYear") ? (this.menuYear = this.menuYear - 1, this.menuYear = 10 * parseInt(this.menuYear / 10), e()) : mini.findParent(n, "mini-calendar-menu-nextYear") ? (this.menuYear = this.menuYear + 11, this.menuYear = 10 * parseInt(this.menuYear / 10), e()) : mini.findParent(n, "mini-calendar-okButton") ? this.__getMonthYear() : mini.findParent(n, "mini-calendar-cancelButton") && (this.monthPicker ? this._OnDateClick(null, "cancel") : this.hideMenu())
	},
	__OnMenuDblClick : function(t) {
		var e = mini.findParent(t.target, "mini-calendar-menu-year"),
			i = mini.findParent(t.target, "mini-calendar-menu-month"),
			n = mini.findParent(t.target, "mini-calendar-date ");
		(e || i || n) && (!this.monthPicker || i || e) && this.__getMonthYear()
	},
	__getMonthYear : function() {
		var t = new Date(this._menuselectYear, this._menuselectMonth, 1);
		this.monthPicker ? (this.setViewDate(t), this.setSelectedDate(t), this._OnDateClick(t)) : (this.setViewDate(t), this.hideMenu())
	},
	__OnBodyMenuMouseDown : function(t) {
		mini.findParent(t.target, "mini-calendar-menu") || mini.findParent(t.target, "mini-monthpicker") || this.hideMenu()
	},
	__OnClick : function(t) {
		var e = this.viewDate;
		if (0 != this.enabled) {
			var i = t.target,
				n = mini.findParent(t.target, "mini-calendar-title");
			if (mini.findParent(i, "mini-calendar-monthNext")) e.setDate(1), e.setMonth(e.getMonth() + 1), this.setViewDate(e);
			else if (mini.findParent(i, "mini-calendar-yearNext")) e.setDate(1), e.setFullYear(e.getFullYear() + 1), this.setViewDate(e);
			else if (mini.findParent(i, "mini-calendar-monthPrev")) e.setMonth(e.getMonth() - 1), this.setViewDate(e);
			else if (mini.findParent(i, "mini-calendar-yearPrev")) e.setFullYear(e.getFullYear() - 1), this.setViewDate(e);
			else if (mini.findParent(i, "mini-calendar-tadayButton")) {
				var s = !!mini.findParent(i, "yesterday"),
					o = new Date;
				if (s && o.setDate(o.getDate() - 1), this.setViewDate(o), this.setSelectedDate(o), this.currentTime) {
					var l = new Date;
					this.setTime(l)
				}
				this._OnDateClick(o, "today")
			} else
				mini.findParent(i, "mini-calendar-clearButton") ? (this.setSelectedDate(null), this.setTime(null), this._OnDateClick(null, "clear")) : mini.findParent(i, "mini-calendar-okButton") ? this._OnDateClick(null, "ok") : n && this.showMenu();
			var r = mini.findParent(t.target, "mini-calendar-date");
			if (r && !mini.hasClass(r, "mini-calendar-disabled")) {
				var a = r.id.split("$"),
					h = parseInt(a[a.length - 1]);
				if (-1 == h) return;
				var d = new Date(h);
				this._OnDateClick(d)
			}
		}
	},
	__OnMouseDown : function(t) {
		if (0 != this.enabled) {
			var e = mini.findParent(t.target, "mini-calendar-date");
			if (e && !mini.hasClass(e, "mini-calendar-disabled")) {
				var i = e.id.split("$"),
					n = parseInt(i[i.length - 1]);
				if (-1 == n) return;
				var s = new Date(n);
				this.setSelectedDate(s)
			}
		}
	},
	__OnTimeChanged : function(t) {
		this.fire("timechanged"), this._OnValueChanged()
	},
	__OnKeyDown : function(t) {
		if (0 != this.enabled) {
			var e = this.getSelectedDate();
			switch (e || (e = new Date(this.viewDate.getTime())), t.keyCode) {
			case 27:
				break;case 13:
				return void (e && this._OnDateClick(e));case 37:
				e = mini.addDate(e, -1, "D");
				break;case 38:
				e = mini.addDate(e, -7, "D");
				break;case 39:
				e = mini.addDate(e, 1, "D");
				break;case 40:
				e = mini.addDate(e, 7, "D")
			}
			var i = this;
			e.getMonth() != i.viewDate.getMonth() && (i.setViewDate(mini.cloneDate(e)), i.focus());
			var n = this.getDateEl(e);
			n && mini.hasClass(n, "mini-calendar-disabled") || (i.setSelectedDate(e), (37 == t.keyCode || 38 == t.keyCode || 39 == t.keyCode || 40 == t.keyCode) && t.preventDefault())
		}
	},
	_OnValueChanged : function() {
		this.fire("valuechanged")
	},
	getAttrs : function(t) {
		var e = mini.Calendar.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "viewDate", "rows", "columns", "ondateclick", "ondrawdate", "ondatechanged", "timeFormat", "ontimechanged", "onvaluechanged" ]), mini._ParseBool(t, e, [ "multiSelect", "showHeader", "showFooter", "showWeekNumber", "showDaysHeader", "showMonthButtons", "showYearButtons", "showTodayButton", "showClearButton", "showYesterdayButton", "showTime", "showOkButton" ]), e
	}
}), mini.regClass(mini.Calendar, "calendar"), mini.CalendarYear = function() {
	this.viewDate = new Date, this._selectedDates = [], mini.CalendarYear.superclass.constructor.call(this)
}, mini.extend(mini.CalendarYear, mini.Control, {
	width : 220,
	_clearBorder : !1,
	uiCls : "mini-calendaryear",
	_create : function() {
		this.el = document.createElement("div"), this.startYear = 10 * parseInt(this.viewDate.getFullYear() / 10), this.selectYear = this.viewDate.getFullYear(), s = '<div class="mini-calendaryear-years"></div>', this.el.innerHTML = s, this.yearsEl = this.el.childNodes[0], this.updateYears()
	},
	_initEvents : function() {
		mini.on(this.el, "click", this.__OnClick, this)
	},
	updateYears : function() {
		for (var t = "", e = this.startYear, i = this.startYear + 20; i > e; e++) {
			var n = e,
				s = "";
			this.selectYear == e && (s = "mini-calendaryear-year-selected"), t += '<a id="' + e + '" class="mini-calendaryear-year ' + s + '" href="javascript:void(0);" hideFocus onclick="return false">' + n + "</a>"
		}
		t += '<div class="mini-calendaryear-prevYear"></div><div class="mini-calendaryear-nextYear"></div><div style="clear:both;"></div>', this.yearsEl.innerHTML = t
	},
	__OnClick : function(t) {
		var e = t.target,
			i = mini.findParent(e, "mini-calendaryear-year");
		i ? (this.selectYear = parseInt(i.id), this.setValue(this.selectYear), this.updateYears(), this._OnDateClick(this.selectYear)) : mini.findParent(e, "mini-calendaryear-prevYear") ? (this.startYear = this.startYear - 20, this.updateYears()) : mini.findParent(e, "mini-calendaryear-nextYear") && (this.startYear = this.startYear + 20, this.updateYears())
	},
	_OnDateClick : function(t, e) {
		var i = {
			year : t,
			action : e
		};
		this.fire("dateclick", i)
	},
	setValue : function(t) {
		this.value = t, this.selectYear = t, this.startYear = 10 * parseInt(this.selectYear / 10)
	},
	getValue : function() {
		return this.value
	}
}), mini.regClass(mini.CalendarYear, "calendaryear"), mini.DataSet = function() {
	this._sources = {}, this._data = {}, this._links = [], this._originals = {}, mini.DataSet.superclass.constructor.call(this)
}, mini.extend(mini.DataSet, mini.Component, {
	add : function(t, e) {
		t && e && (this._sources[t] = e, this._data[t] = [], e.autoCreateNewID = !0, e._originalIdField = e.getIdField(), e._clearOriginals = !1, e.on("addrow", this.__OnRowChanged, this), e.on("updaterow", this.__OnRowChanged, this), e.on("deleterow", this.__OnRowChanged, this), e.on("removerow", this.__OnRowChanged, this), e.on("preload", this.__OnDataPreLoad, this), e.on("selectionchanged", this.__OnDataSelectionChanged, this))
	},
	addLink : function(t, e, i) {
		if (t && e && i && this._sources[t] && this._sources[e]) {
			var n = {
				parentName : t,
				childName : e,
				parentField : i
			};
			this._links.push(n)
		}
	},
	clearData : function() {
		this._data = {}, this._originals = {};
		for (var t in this._sources) this._data = []
	},
	getData : function() {
		return this._data
	},
	_getNameByListControl : function(t) {
		for (var e in this._sources) {
			var i = this._sources[e];
			if (i == t) return e
		}
	},
	_getRecord : function(t, e, i) {
		var n = this._data[t];
		if (!n) return !1;
		for (var s = 0, o = n.length; o > s; s++) {
			var l = n[s];
			if (l[i] == e[i]) return l
		}
		return null
	},
	__OnRowChanged : function(t) {
		var e = t.type,
			i = t.record,
			n = this._getNameByListControl(t.sender),
			s = this._getRecord(n, i, t.sender.getIdField()),
			o = this._data[n];
		if (s) {
			var o = this._data[n];
			o.remove(s)
		}
		if ("removerow" == e && "added" == i._state || o.push(i), this._originals[n] = t.sender._originals, "added" == i._state) {
			var l = this._getParentSource(t.sender);
			if (l) {
				var r = l.getSelected();
				r ? i._parentId = r[l.getIdField()] : o.remove(i)
			}
		}
	},
	__OnDataPreLoad : function(t) {
		for (var e = t.sender, i = this._getNameByListControl(e), n = t.sender.getIdField(), s = this._data[i], o = {}, l = 0, r = s.length; r > l; l++) {
			var a = s[l];
			o[a[n]] = a
		}
		var h = this._originals[i];
		h && (e._originals = h);
		for (var d = t.data || [], l = 0, r = d.length; r > l; l++) {
			var a = d[l],
				u = o[a[n]];
			u && (
			delete u._uid
			, mini.copyTo(a, u))
		}
		var c = this._getParentSource(e);
		if (e.getPageIndex && 0 == e.getPageIndex()) {
			for (var m = [], l = 0, r = s.length; r > l; l++) {
				var a = s[l];
				if ("added" == a._state)
					if (c) {
						var p = c.getSelected();
						p && p[c.getIdField()] == a._parentId && m.push(a)
					} else m.push(a)
			}
			m.reverse(), d.insertRange(0, m)
		}
		for (var f = [], l = d.length - 1; l >= 0; l--) {
			var a = d[l],
				u = o[a[n]];
			u && "removed" == u._state && (d.removeAt(l), f.push(u))
		}
	},
	_getParentSource : function(t) {
		for (var e = this._getNameByListControl(t), i = 0, n = this._links.length; n > i; i++) {
			var s = this._links[i];
			if (s.childName == e) return this._sources[s.parentName]
		}
	},
	_getLinks : function(t) {
		for (var e = this._getNameByListControl(t), i = [], n = 0, s = this._links.length; s > n; n++) {
			var o = this._links[n];
			o.parentName == e && i.push(o)
		}
		return i
	},
	__OnDataSelectionChanged : function(t) {
		for (var e = t.sender, i = e.getSelected(), n = this._getLinks(e), s = 0, o = n.length; o > s; s++) {
			var l = n[s],
				r = this._sources[l.childName];
			if (i) {
				var a = {};
				a[l.parentField] = i[e.getIdField()], r.load(a)
			} else r.loadData([])
		}
	}
}), mini.regClass(mini.DataSet, "dataset"), mini.FileUpload = function(t) {
	this.postParam = {}, mini.FileUpload.superclass.constructor.call(this, t), this.on("validation", this.__OnValidation, this)
}, mini.extend(mini.FileUpload, mini.ButtonEdit, {
	width : 180,
	buttonText : "浏览...",
	_buttonWidth : 56,
	limitTypeErrorText : "上传文件格式为：",
	readOnly : !0,
	_cellSpacing : 0,
	limitSize : "",
	limitType : "",
	typesDescription : "上传文件格式",
	uploadLimit : 0,
	queueLimit : "",
	flashUrl : "",
	uploadUrl : "",
	showUploadProgress : !0,
	usequerystring : !1,
	postParam : null,
	uploadOnSelect : !1,
	updateFileName : "flashPlayerSetup.zip",
	uiCls : "mini-fileupload",
	_create : function() {
		mini.FileUpload.superclass._create.call(this), mini.addClass(this.el, "mini-htmlfile"), this._progressbarEl = mini.append(this._borderEl, '<div id="' + this._id + '$progressbar"  class="mini-fileupload-progressbar"><div id="' + this._id + '$complete" class="mini-fileupload-complete"></div></div>'), this._completeEl = this._progressbarEl.firstChild, this._uploadId = this.uid + "$button_placeholder", this._fileEl = mini.append(this.el, '<span id="' + this._uploadId + '"></span>'), this.uploadEl = this._fileEl, mini.on(this._borderEl, "mousemove", this.__OnMouseMove, this), mini.on(this._borderEl, "click", this.__OnClick, this)
	},
	_getButtonHtml : function() {
		var t = "onmouseover=\"mini.addClass(this, '" + this._buttonHoverCls + "');\" onmouseout=\"mini.removeClass(this, '" + this._buttonHoverCls + "');\"";
		return '<span class="mini-buttonedit-button" ' + t + ">" + this.buttonText + "</span>"
	},
	destroy : function(t) {
		this._innerEl && (mini.clearEvent(this._innerEl), this._innerEl = null), mini.FileUpload.superclass.destroy.call(this, t)
	},
	doLayout : function() {
		if (mini.FileUpload.superclass.doLayout.call(this), this.swfUpload) {
			var t = this.swfUpload.movieElement;
			t.style.width = this._borderEl.style.width
		}
	},
	flashChecker : function() {
		var t = 0,
			e = 0;
		if (document.all) try {
				var i = new ActiveXObject("ShockwaveFlash.ShockwaveFlash");
				i && (t = 1, VSwf = i.GetVariable("$version"), e = parseInt(VSwf.split(" ")[1].split(",")[0]))
			} catch (n) {}
		else if (navigator.plugins && navigator.plugins.length > 0) {
			var i = navigator.plugins["Shockwave Flash"];
			if (i) {
				t = 1;
				for (var s = i.description.split(" "), o = 0; o < s.length; ++o) isNaN(parseInt(s[o])) || (e = parseInt(s[o]))
			}
		}
		return {
			hasFlash : t,
			version : e
		}
	},
	__OnClick : function(t) {
		if (!this.flashChecker().hasFlash) {
			var e = mini_CreateJSPath("swfupload.js");
			return void mini.showMessageBox({
				width : 250,
				title : "Flash Player安装",
				buttons : [],
				message : "Flash Player安装",
				html : "<a href='" + e + this.updateFileName + "' target='freshme'>Flash Player未安装，请点击此处安装，安装完后请重启浏览器。</a><iframe style='width:0px;height:0px;border:none;' name='freshme'></iframe>"
			})
		}
		if (this.flashChecker().version < 10) {
			var e = mini_CreateJSPath("swfupload.js");
			return void mini.showMessageBox({
				width : 250,
				title : "Flash Player升级",
				buttons : [],
				message : "Flash Player升级",
				html : "<a href='" + e + this.updateFileName + "' target='freshme'>您的Flash Player版本太低，请点击此处升级，升级完后请重启浏览器。</a><iframe style='width:0px;height:0px;border:none;' name='freshme'></iframe>"
			})
		}
	},
	__OnMouseMove : function(t) {
		if (0 != this.enabled) {
			var e = this;
			if (!this.swfUpload) {
				if (!this.flashChecker().hasFlash) return;
				if (this.flashChecker().version < 10) return;
				var i = new SWFUpload({
					file_post_name : this.name,
					upload_url : e.uploadUrl,
					flash_url : e.flashUrl,
					file_size_limit : e.limitSize,
					file_types : e.limitType,
					file_types_description : e.typesDescription,
					file_upload_limit : parseInt(e.uploadLimit),
					file_queue_limit : e.queueLimit,
					use_query_string : e.usequerystring,
					file_queued_handler : mini.createDelegate(this.__on_file_queued, this),
					file_queue_error_handler : mini.createDelegate(this.__on_file_queued_error, this),
					upload_error_handler : mini.createDelegate(this.__on_upload_error, this),
					upload_success_handler : mini.createDelegate(this.__on_upload_success, this),
					upload_complete_handler : mini.createDelegate(this.__on_upload_complete, this),
					upload_progress_handler : mini.createDelegate(this.__on_upload_progress, this),
					button_placeholder_id : this._uploadId,
					button_width : 1e3,
					button_height : 50,
					button_window_mode : "transparent",
					button_action : SWFUpload.BUTTON_ACTION.SELECT_FILE,
					debug : !1
				});
				i.flashReady(), this.swfUpload = i;
				var n = this.swfUpload.movieElement;
				n.style.zIndex = 1e3, n.style.position = "absolute", n.style.left = "0px", n.style.top = "0px", n.style.width = "100%", n.style.height = "50px"
			}
		}
	},
	setLimitSize : function(t) {
		this.limitSize = t
	},
	addPostParam : function(t) {
		mini.copyTo(this.postParam, t)
	},
	getPostParam : function() {
		return this.postParam
	},
	setLimitType : function(t) {
		this.limitType = t, this.typesDescription = "上传文件格式 " + t, this.swfUpload && this.swfUpload.setFileTypes(this.limitType, this.typesDescription)
	},
	getLimitType : function() {
		return this.limitType
	},
	setTypesDescription : function(t) {
		this.typesDescription = t, this.swfUpload && this.swfUpload.setFileTypes(this.limitType, this.typesDescription)
	},
	getTypesDescription : function() {
		return this.typesDescription
	},
	setButtonText : function(t) {
		this.buttonText = t, this._buttonEl.innerHTML = t
	},
	getButtonText : function() {
		return this.buttonText
	},
	setUploadLimit : function(t) {
		this.uploadLimit = t
	},
	setQueueLimit : function(t) {
		this.queueLimit = t
	},
	setUseQueryString : function(t) {
		this.usequerystring = t
	},
	setFlashUrl : function(t) {
		this.flashUrl = t
	},
	setUploadUrl : function(t) {
		this.swfUpload && this.swfUpload.setUploadURL(t), this.uploadUrl = t
	},
	getUploadUrl : function() {
		return this.uploadUrl
	},
	setPostParam : function(t) {
		this.swfUpload && this.swfUpload.setPostParams(t), this.postParam = t
	},
	setName : function(t) {
		this.name = t
	},
	setUpdateFileName : function(t) {
		this.updateFileName = t
	},
	startUpload : function(t) {
		if ("" == this.getValue()) return void mini.alert("请选择上传文件。");
		var e = {
			cancel : !1
		};
		if (this.fire("beforeupload", e), 1 != e.cancel && this.swfUpload) {
			this.swfUpload.setPostParams(this.postParam);
			var i = this.swfUpload.getStats(),
				n = this.swfUpload.getFile(i.files_queued + i.successful_uploads + i.upload_errors + i.queue_errors - 1);
			this.swfUpload.startUpload(n.id)
		}
	},
	setShowUploadProgress : function(t) {
		this.showUploadProgress = t, this._progressbarEl.style.display = t ? "block" : "none"
	},
	getShowUploadProgress : function() {
		return this.showUploadProgress
	},
	__on_upload_progress : function(t, e, i) {
		if (this.showUploadProgress) {
			var n = mini.getWidth(this._progressbarEl),
				s = n * e / i;
			mini.setWidth(this._completeEl, s)
		}
		this._progressbarEl.style.display = this.showUploadProgress ? "block" : "none";
		var o = {
			file : t,
			complete : e,
			total : i
		};
		this.fire("uploadprogress", o)
	},
	__on_file_queued : function(t) {
		var e = {
			file : t
		};
		this.uploadOnSelect && this.startUpload(), this.setText(t.name), this.setValue(t.name), this.fire("fileselect", e)
	},
	__on_file_queued_error : function(t, e, i) {
		switch (e) {
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			var n = t.size;
			n > 0 && (n = parseInt(n / 1024 / 1024 * 10), n /= 10), mini.alert("上传文件太大, 文件名: " + t.name + ", 大小: " + n + "MB"), this.setValue("");
			break;case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			mini.alert("文件大小为0, 文件名: " + t.name), this.setValue("");
			break;case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
			mini.alert("文件类型不符, 文件名: " + t.name), this.setValue("")
		}
	},
	__on_upload_success : function(t, e) {
		var i = {
			file : t,
			serverData : e
		};
		this.fire("uploadsuccess", i), this._progressbarEl.style.display = "none"
	},
	__on_upload_error : function(t, e, i) {
		if ("File Cancelled" != i) {
			this._progressbarEl.style.display = "none";
			var n = {
				file : t,
				code : e,
				message : i
			};
			this.fire("uploaderror", n)
		}
	},
	__on_upload_complete : function(t) {
		this._progressbarEl.style.display = "none", this.fire("uploadcomplete", t)
	},
	__fileError : function() {},
	setValue : function(t, e) {
		mini.FileUpload.superclass.setValue.call(this, t, e), mini.FileUpload.superclass.setText.call(this, t)
	},
	getAttrs : function(t) {
		var e = mini.FileUpload.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "limitType", "limitSize", "flashUrl", "uploadUrl", "uploadLimit", "buttonText", "showUploadProgress", "onuploadsuccess", "onuploaderror", "onuploadcomplete", "onfileselect", "onuploadprogress", "usequerystring", "updateFileName" ]), mini._ParseBool(t, e, [ "uploadOnSelect" ]), e
	}
}), mini.regClass(mini.FileUpload, "fileupload"), mini.Fit = function() {
	mini.Fit.superclass.constructor.call(this)
}, mini.extend(mini.Fit, mini.Container, {
	style : "",
	_clearBorder : !1,
	uiCls : "mini-fit",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-fit", this._bodyEl = this.el
	},
	_initEvents : function() {},
	isFixedSize : function() {
		return !1
	},
	doLayout : function() {
		if (this.canLayout()) {
			var t = this.el.parentNode,
				e = mini.getChildNodes(t);
			t == document.body && (this.el.style.height = "0px");
			for (var i = mini.getHeight(t, !0), n = 0, s = e.length; s > n; n++) {
				var o = e[n],
					l = o.tagName ? o.tagName.toLowerCase() : "";
				if (o != this.el && "style" != l && "script" != l) {
					var r = mini.getStyle(o, "position");
					if ("absolute" != r && "fixed" != r) {
						var a = mini.getHeight(o),
							h = mini.getMargins(o);
						i = i - a - h.top - h.bottom
					}
				}
			}
			var d = mini.getBorders(this.el),
				u = mini.getPaddings(this.el),
				h = mini.getMargins(this.el);
			i = i - h.top - h.bottom, jQuery.boxModel && (i = i - u.top - u.bottom - d.top - d.bottom), 0 > i && (i = 0), this.el.style.height = i + "px";try {
				e = mini.getChildNodes(this.el);
				for (var n = 0, s = e.length; s > n; n++) {
					var o = e[n];
					mini.layout(o)
				}
			} catch (c) {}
		}
	},
	set_bodyParent : function(t) {
		if (t) {
			for (var e = this._bodyEl, i = t; i.firstChild;) try {
					e.appendChild(i.firstChild)
				} catch (n) {}
			this.doLayout()
		}
	},
	getAttrs : function(t) {
		var e = mini.Fit.superclass.getAttrs.call(this, t);
		return e._bodyParent = t, e
	}
}), mini.regClass(mini.Fit, "fit"), mini.Form = function(t) {
	if (this.el = mini.byId(t), !this.el)
		throw new Error("form element not null");
	mini.Form.superclass.constructor.call(this)
}, mini.extend(mini.Form, mini.Component, {
	el : null,
	getFields : function() {
		if (!this.el) return [];
		var t = mini.findControls(function(t) {
			return t.el && 1 == t.formField && mini.isAncestor(this.el, t.el) ? !0 : !1
		}, this);
		return t
	},
	getFieldsMap : function() {
		for (var t = this.getFields(), e = {}, i = 0, n = t.length; n > i; i++) {
			var s = t[i];
			s.name && (e[s.name] = s)
		}
		return e
	},
	getField : function(t) {
		return this.el ? mini.getbyName(t, this.el) : null
	},
	getData : function(t, e, i) {
		mini.isNull(e) && (e = !0);
		for (var n = t ? "getFormValue" : "getValue", s = this.getFields(), o = {}, l = {}, r = 0, a = s.length; a > r; r++) {
			var h = s[r],
				d = h[n];
			d && (h.name && (l[h.name] = h.name, 1 == e ? mini._setMap(h.name, d.call(h), o) : o[h.name] = d.call(h)), h.textName && h.getText && (1 == e ? o[h.textName] = h.getText() : mini._setMap(h.textName, h.getText(), o)))
		}
		if (i)
			for (var u = jQuery(this.el).find(":input:hidden"), c = 0; c < u.length; c++) {
				var m = mini.getAttr(u[c], "name"),
					p = u[c].value;
				m && !l[m] && (1 == e ? l[m] || mini._setMap(m, u[c].value, o) : o[m] = p)
		}
		return o
	},
	setData : function(t, e, i, n) {
		mini.isNull(i) && (i = !0), "object" != typeof t && (t = {});
		var s = this.getFieldsMap();
		for (var o in s) {
			var l = s[o];
			if (l) {
				if (l.setValue) {
					var r = t[o];
					if (1 == i && (r = mini._getMap(o, t)), void 0 === r && !e) continue;
					null === r && (r = ""), l.setValue(r, n)
				}
				if (l.setText && l.textName) {
					var a = t[l.textName];
					1 == i && (a = mini._getMap(l.textName, t)), mini.isNull(a) && (a = ""), l.setText(a)
				}
			}
		}
	},
	getChanges : function(t, e) {
		function i(t) {
			return "" == t ? null : t
		}
		for (var n, s, o = this.getFields(), l = t ? "getFormValue" : "getValue", r = {}, a = {}, h = 0, d = o.length; d > h; h++) {
			var u = o[h],
				c = u[l],
				m = u.getValue,
				p = u.getDefaultValue;
			if (c && p && m) {
				if (n = p.call(u), s = m.call(u), "mini-datepicker" == u.uiCls) {
					if (!n && !s) continue;
					if (n && s && (n = mini.parseDate(n), s - n == 0)) continue
				} else if ("mini-timespinner" == u.uiCls) {
					if (!n && !s) continue;
					if (n && s && (n = mini.parseTime(n, u.format), mini.formatDate(s, "H:mm:ss") == mini.formatDate(n, "H:mm:ss"))) continue
				} else if (i(n) == i(s)) continue;
				u.name && (a[u.name] = u.name, 1 == e ? mini._setMap(u.name, c.call(u), r) : r[u.name] = c.call(u)), u.textName && u.getText && (1 == e ? r[u.textName] = u.getText() : mini._setMap(u.textName, u.getText(), r))
			}
		}
		return r
	},
	reset : function() {
		for (var t = this.getFields(), e = 0, i = t.length; i > e; e++) {
			var n = t[e];
			!n.destroyed && n.setValue && (n.setText && n._clearText !== !1 && n.setText(""), n.setValue(n.defaultValue, !0))
		}
		this.setIsValid(!0)
	},
	clear : function() {
		for (var t = this.getFields(), e = 0, i = t.length; i > e; e++) {
			var n = t[e];
			n.setValue && (n.setText && n._clearText !== !1 && n.setText(""), n.setValue("", !0))
		}
		this.setIsValid(!0)
	},
	validate : function(t, e) {
		for (var i = this.getFields(), n = 0, s = i.length; s > n; n++) {
			var o = i[n];
			if (o.validate && (void 0 === e && (e = !1), o.isDisplay && o.isDisplay() || e)) {
				var l = o.validate();
				if (0 == l && t === !1) break
			}
		}
		return this.isValid(e)
	},
	setIsValid : function(t) {
		for (var e = this.getFields(), i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			!s.destroyed && s.setIsValid && s.setIsValid(t)
		}
	},
	isValid : function(t) {
		for (var e = this.getFields(), i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			if (s.isValid && (void 0 === t && (t = !1), (s.isDisplay && s.isDisplay() || t) && 0 == s.isValid())) return !1
		}
		return !0
	},
	getErrorTexts : function() {
		for (var t = [], e = this.getErrors(), i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			t.push(s.errorText)
		}
		return t
	},
	getErrors : function() {
		for (var t = [], e = this.getFields(), i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			s.isValid && 0 == s.isValid() && t.push(s)
		}
		return t
	},
	mask : function(t) {
		"string" == typeof t && (t = {
			html : t
		}), t = t || {}, t.el = this.el, t.cls || (t.cls = this._maskCls), mini.mask(t)
	},
	unmask : function() {
		mini.unmask(this.el)
	},
	_maskCls : "mini-mask-loading",
	loadingMsg : "数据加载中，请稍后...",
	loading : function(t) {
		this.mask(t || this.loadingMsg)
	},
	__OnValueChanged : function(t) {
		this._changed = !0
	},
	_changed : !1,
	setChanged : function(t) {
		this._changed = t;
		for (var e = this.getFields(), i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			s.on("valuechanged", this.__OnValueChanged, this)
		}
	},
	isChanged : function() {
		return this._changed
	},
	setEnabled : function(t) {
		for (var e = this.getFields(), i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			s.setEnabled(t)
		}
	},
	setEnterKeyNext : function() {
		function t(t) {
			function i(t) {
				function i(t) {
					var n = e[t + 1];
					if (n)
						if ("mini-textbox" == n.uiCls || "mini-textarea" == n.uiCls || "mini-password" == n.uiCls || "mini-treeselect" == n.uiCls || "mini-combobox" == n.uiCls && "pagesize" != n.name || "mini-datepicker" == n.uiCls || "mini-monthpicker" == n.uiCls || "mini-yearpicker" == n.uiCls || "mini-timespinner" == n.uiCls || "mini-spinner" == n.uiCls || "mini-checkbox" == n.uiCls || "mini-radiobuttonlist" == n.uiCls || "mini-checkboxlist" == n.uiCls || "mini-autocomplete" == n.uiCls) {
							if (n.isShowPopup && n.isShowPopup()) return;
							n.focus(), n.showPopup && "mini-autocomplete" != n.uiCls && setTimeout(function() {
								n.showPopup()
							}, 1)
						} else t++, i(t)
				}
				var n = t.sender,
					s = e.indexOf(n);
				i(s)
			}
			t.on("enter", i)
		}
		for (var e = this.getFields(), i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			t(s)
		}
	}
}), mini = mini || {}, mini.Hidden = function() {
	mini.Hidden.superclass.constructor.call(this)
}, mini.extend(mini.Hidden, mini.Control, {
	_clearBorder : !1,
	formField : !0,
	value : "",
	uiCls : "mini-hidden",
	_create : function() {
		this.el = document.createElement("input"), this.el.type = "hidden", this.el.className = "mini-hidden"
	},
	setName : function(t) {
		this.name = t, this.el.name = t
	},
	setValue : function(t) {
		if ((null === t || void 0 === t) && (t = ""), this.value = t, mini.isDate(t)) {
			var e = t.getFullYear(),
				i = t.getMonth() + 1,
				n = t.getDate();
			i = 10 > i ? "0" + i : i, n = 10 > n ? "0" + n : n, this.el.value = e + "-" + i + "-" + n
		} else
			this.el.value = t
	},
	getValue : function() {
		return this.value
	},
	getFormValue : function() {
		return this.el.value
	}
}), mini.regClass(mini.Hidden, "hidden"), mini.HtmlFile = function() {
	mini.HtmlFile.superclass.constructor.call(this), this.on("validation", this.__OnValidation, this)
}, mini.extend(mini.HtmlFile, mini.ButtonEdit, {
	width : 180,
	buttonText : "浏览...",
	_buttonWidth : 56,
	limitType : "",
	limitTypeErrorText : "上传文件格式为：",
	allowInput : !1,
	readOnly : !0,
	_cellSpacing : 0,
	uiCls : "mini-htmlfile",
	_create : function() {
		mini.HtmlFile.superclass._create.call(this), this._fileEl = mini.append(this.el, '<input type="file" hideFocus class="mini-htmlfile-file" name="' + this.name + '" ContentEditable=false/>'), mini.on(this._borderEl, "mousemove", this.__OnMouseMove, this), mini.on(this._fileEl, "change", this.__OnFileChange, this)
	},
	_getButtonHtml : function() {
		var t = "onmouseover=\"mini.addClass(this, '" + this._buttonHoverCls + "');\" onmouseout=\"mini.removeClass(this, '" + this._buttonHoverCls + "');\"";
		return '<span class="mini-buttonedit-button" ' + t + ">" + this.buttonText + "</span>"
	},
	__OnFileChange : function(t) {
		this.value = this._textEl.value = this._fileEl.value, this._OnValueChanged(), t = {
			htmlEvent : t
		}, this.fire("fileselect", t)
	},
	__OnMouseMove : function(t) {
		var e = t.pageX,
			i = t.pageY,
			n = mini.getBox(this.el);
		e = e - n.x - 5, i = i - n.y - 5, 0 == this.enabled && (e = -20, i = -20), this._fileEl.style.display = "", this._fileEl.style.left = e + "px", this._fileEl.style.top = i + "px"
	},
	__OnValidation : function(t) {
		if (this.limitType) {
			var e = t.value.split("."),
				i = "*." + e[e.length - 1],
				n = this.limitType.split(";");
			n.length > 0 && -1 == n.indexOf(i) && (t.errorText = this.limitTypeErrorText + this.limitType, t.isValid = !1)
		}
	},
	setName : function(t) {
		this.name = t, mini.setAttr(this._fileEl, "name", this.name)
	},
	getValue : function() {
		return this._textEl.value
	},
	setButtonText : function(t) {
		this.buttonText = t
	},
	getButtonText : function() {
		return this.buttonText
	},
	setLimitType : function(t) {
		this.limitType = t
	},
	getLimitType : function() {
		return this.limitType
	},
	getAttrs : function(t) {
		var e = mini.HtmlFile.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "limitType", "buttonText", "limitTypeErrorText", "onfileselect" ]), e
	}
}), mini.regClass(mini.HtmlFile, "htmlfile"), mini.Include = function() {
	mini.Include.superclass.constructor.call(this)
}, mini.extend(mini.Include, mini.Control, {
	url : "",
	uiCls : "mini-include",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-include"
	},
	_initEvents : function() {},
	doLayout : function() {
		if (this.canLayout()) {
			var t = this.el.childNodes;
			if (t)
				for (var e = 0, i = t.length; i > e; e++) {
					var n = t[e];
					mini.layout(n)
			}
		}
	},
	setUrl : function(t) {
		this.url = this.parseUrl(t), mini.update({
			url : this.url,
			el : this.el,
			async : this.async
		}), this.doLayout()
	},
	getUrl : function(t) {
		return this.url
	},
	getAttrs : function(t) {
		var e = mini.Include.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "url" ]), e
	}
}), mini.regClass(mini.Include, "include"), mini.Layout = function() {
	this.regions = [], this.regionMap = {}, mini.Layout.superclass.constructor.call(this)
}, mini.extend(mini.Layout, mini.Control, {
	regions : [],
	splitSize : 5,
	collapseWidth : 28,
	collapseHeight : 25,
	regionWidth : 150,
	regionHeight : 80,
	regionMinWidth : 50,
	regionMinHeight : 25,
	regionMaxWidth : 2e3,
	regionMaxHeight : 2e3,
	uiCls : "mini-layout",
	destroy : function(t) {
		mini.un(document, "mousedown", this.__OnDocMouseDown, this), this._borderEl && (mini.clearEvent(this._borderEl), this._borderEl.parentNode.removeChild(this._borderEl), this._borderEl = null), this.drag && (mini.clearEvent(this.drag), this.drag.destroy(t), this.drag = null);
		var e = this;
		$.each(this.regions, function() {
			e._destroyRegionEl(this)
		}),
		delete this.regions
		,
		delete this.regionMap
		, mini.Layout.superclass.destroy.call(this, t)
	},
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-layout", this.el.innerHTML = '<div class="mini-layout-border"></div>', this._borderEl = this.el.firstChild, this.doUpdate()
	},
	_initEvents : function() {
		mini._BindEvents(function() {
			mini.on(this.el, "click", this.__OnClick, this), mini.on(this.el, "mousedown", this.__OnMouseDown, this), mini.on(this.el, "mouseover", this.__OnMouseOver, this), mini.on(this.el, "mouseout", this.__OnMouseOut, this), mini.on(document, "mousedown", this.__OnDocMouseDown, this)
		}, this)
	},
	getRegionEl : function(t) {
		var t = this.getRegion(t);
		return t ? t._el : null
	},
	getRegionHeaderEl : function(t) {
		var t = this.getRegion(t);
		return t ? t._header : null
	},
	getRegionBodyEl : function(t) {
		var t = this.getRegion(t);
		return t ? t._body : null
	},
	getRegionSplitEl : function(t) {
		var t = this.getRegion(t);
		return t ? t._split : null
	},
	getRegionProxyEl : function(t) {
		var t = this.getRegion(t);
		return t ? t._proxy : null
	},
	getRegionBox : function(t) {
		var e = this.getRegionEl(t);
		return e ? mini.getBox(e) : null
	},
	getRegion : function(t) {
		return "string" == typeof t ? this.regionMap[t] : t
	},
	_getButton : function(t, e) {
		for (var i = t.buttons, n = 0, s = i.length; s > n; n++) {
			var o = i[n];
			if (o.name == e) return o
		}
	},
	_createRegion : function(t) {
		var e = mini.copyTo({
			region : "",
			title : "",
			iconCls : "",
			iconStyle : "",
			showCloseButton : !1,
			showCollapseButton : !0,
			buttons : [ {
				name : "close",
				cls : "mini-tools-close",
				html : "",
				visible : !1
			}, {
				name : "collapse",
				cls : "mini-tools-collapse",
				html : "",
				visible : !0
			} ],
			showSplitIcon : !1,
			showSplit : !0,
			showHeader : !0,
			splitSize : this.splitSize,
			collapseSize : this.collapseWidth,
			width : this.regionWidth,
			height : this.regionHeight,
			minWidth : this.regionMinWidth,
			minHeight : this.regionMinHeight,
			maxWidth : this.regionMaxWidth,
			maxHeight : this.regionMaxHeight,
			allowResize : !0,
			cls : "",
			style : "",
			headerCls : "",
			headerStyle : "",
			bodyCls : "",
			bodyStyle : "",
			visible : !0,
			expanded : !0
		}, t);
		return e
	},
	_CreateRegionEl : function(t) {
		var t = this.getRegion(t);
		t && (mini.append(this._borderEl, '<div id="' + t.region + '" class="mini-layout-region"><div class="mini-layout-region-header" style="' + t.headerStyle + '"></div><div class="mini-layout-region-body ' + t.bodyCls + '" style="' + t.bodyStyle + '"></div></div>'), t._el = this._borderEl.lastChild, t._header = t._el.firstChild, t._body = t._el.lastChild, mini.on(t._body, "scroll", function() {
			$("body").trigger("mousedown")
		}, this), t.cls && mini.addClass(t._el, t.cls), t.style && mini.setStyle(t._el, t.style), mini.addClass(t._el, "mini-layout-region-" + t.region), "center" != t.region && (mini.append(this._borderEl, '<div uid="' + this.uid + '" id="' + t.region + '" class="mini-layout-split"><div class="mini-layout-spliticon"></div></div>'), t._split = this._borderEl.lastChild, mini.addClass(t._split, "mini-layout-split-" + t.region)), "center" != t.region && (mini.append(this._borderEl, '<div id="' + t.region + '" class="mini-layout-proxy"></div>'), t._proxy = this._borderEl.lastChild, mini.addClass(t._proxy, "mini-layout-proxy-" + t.region)))
	},
	_destroyRegionEl : function(t) {
		t && (t._header && (mini.clearEvent(t._header), t._header.parentNode.removeChild(t._header), t._header = null), t._body && (mini.clearEvent(t._body), t._body.parentNode.removeChild(t._body), t._body = null), t._el && (mini.clearEvent(t._el), t._el.parentNode.removeChild(t._el), t._el = null), t._split && (mini.clearEvent(t._split), t._split.parentNode.removeChild(t._split), t._split = null), t._proxy && (mini.clearEvent(t._proxy), t._proxy.parentNode.removeChild(t._proxy), t._proxy = null), mini.clearEvent(t), t = null)
	},
	setRegionControls : function(t, e) {
		var t = this.getRegion(t);
		if (t) {
			var i = this.getRegionBodyEl(t);
			__mini_setControls(e, i, this)
		}
	},
	setRegions : function(t) {
		if (mini.isArray(t))
			for (var e = 0, i = t.length; i > e; e++) this.addRegion(t[e])
	},
	addRegion : function(t, e) {
		var i = t;
		t = this._createRegion(t), t.region || (t.region = "center"), t.region = t.region.toLowerCase(), "center" == t.region && i && !i.showHeader && (t.showHeader = !1), ("north" == t.region || "south" == t.region) && (i.collapseSize || (t.collapseSize = this.collapseHeight)), this._measureRegion(t), "number" != typeof e && (e = this.regions.length);
		var n = this.regionMap[t.region];
		if (!n) {
			this.regions.insert(e, t), this.regionMap[t.region] = t, this._CreateRegionEl(t);
			var s = this.getRegionBodyEl(t),
				o = t.body;
			if (
				delete t.body
				, o) {
				mini.isArray(o) || (o = [ o ]);
				for (var l = 0, r = o.length; r > l; l++) mini.append(s, o[l])
			}
			if (t.bodyParent)
				for (var a = t.bodyParent; a.firstChild;) s.appendChild(a.firstChild);
			delete t.bodyParent
			, t.controls && (this.setRegionControls(t, t.controls),
			delete t.controls
			), this.doUpdate()
		}
	},
	removeRegion : function(t) {
		var t = this.getRegion(t);
		t && (this.regions.remove(t),
		delete this.regionMap[t.region]
		, jQuery(t._el).remove(), jQuery(t._split).remove(), jQuery(t._proxy).remove(), this.doUpdate())
	},
	moveRegion : function(t, e) {
		var t = this.getRegion(t);
		if (t) {
			var i = this.regions[e];
			if (i && i != t) {
				this.regions.remove(t);
				var e = this.region.indexOf(i);
				this.regions.insert(e, t), this.doUpdate()
			}
		}
	},
	_measureRegion : function(t) {
		var e = this._getButton(t, "close");
		e.visible = t.showCloseButton;
		var e = this._getButton(t, "collapse");
		e.visible = t.showCollapseButton, t.width < t.minWidth && (t.width = t.minWidth), t.width > t.maxWidth && (t.width = t.maxWidth), t.height < t.minHeight && (t.height = t.minHeight), t.height > t.maxHeight && (t.height = t.maxHeight)
	},
	updateRegion : function(t, e) {
		t = this.getRegion(t), t && (e &&
		delete e.region
		, mini.copyTo(t, e), this._measureRegion(t), this.doUpdate())
	},
	expandRegion : function(t) {
		t = this.getRegion(t), t && (t.expanded = !0, this.doUpdate())
	},
	collapseRegion : function(t) {
		t = this.getRegion(t), t && (t.expanded = !1, this.doUpdate())
	},
	toggleRegion : function(t) {
		t = this.getRegion(t), t && (t.expanded ? this.collapseRegion(t) : this.expandRegion(t))
	},
	showRegion : function(t) {
		t = this.getRegion(t), t && (t.visible = !0, this.doUpdate())
	},
	hideRegion : function(t) {
		t = this.getRegion(t), t && (t.visible = !1, this.doUpdate())
	},
	isExpandRegion : function(t) {
		return t = this.getRegion(t), t ? this.region.expanded : null
	},
	isVisibleRegion : function(t) {
		return t = this.getRegion(t), t ? this.region.visible : null
	},
	_tryToggleRegion : function(t) {
		t = this.getRegion(t);
		var e = {
			region : t,
			cancel : !1
		};
		t.expanded ? (this.fire("BeforeCollapse", e), 0 == e.cancel && this.collapseRegion(t)) : (this.fire("BeforeExpand", e), 0 == e.cancel && this.expandRegion(t))
	},
	_getProxyElByEvent : function(t) {
		var e = mini.findParent(t.target, "mini-layout-proxy");
		return e
	},
	_getRegionElByEvent : function(t) {
		var e = mini.findParent(t.target, "mini-layout-region");
		return e
	},
	__OnClick : function(t) {
		if (!this._inAniming) {
			var e = this._getProxyElByEvent(t);
			if (e) {
				var i = e.id,
					n = mini.findParent(t.target, "mini-tools-collapse");
				n ? this._tryToggleRegion(i) : this._VirtualToggle(i)
			}
			var s = this._getRegionElByEvent(t);
			if (s && mini.findParent(t.target, "mini-layout-region-header")) {
				var i = s.id,
					n = mini.findParent(t.target, "mini-tools-collapse");
				n && this._tryToggleRegion(i);
				var o = mini.findParent(t.target, "mini-tools-close");
				o && this.updateRegion(i, {
					visible : !1
				})
			}
			if (mini.hasClass(t.target, "mini-layout-spliticon")) {
				var i = t.target.parentNode.id;
				this._tryToggleRegion(i)
			}
		}
	},
	_OnButtonClick : function(t, e, i) {
		this.fire("buttonclick", {
			htmlEvent : i,
			region : t,
			button : e,
			index : this.buttons.indexOf(e),
			name : e.name
		})
	},
	_OnButtonMouseDown : function(t, e, i) {
		this.fire("buttonmousedown", {
			htmlEvent : i,
			region : t,
			button : e,
			index : this.buttons.indexOf(e),
			name : e.name
		})
	},
	hoverProxyEl : null,
	__OnMouseOver : function(t) {
		var e = this._getProxyElByEvent(t);
		e && (mini.addClass(e, "mini-layout-proxy-hover"), this.hoverProxyEl = e)
	},
	__OnMouseOut : function(t) {
		this.hoverProxyEl && mini.removeClass(this.hoverProxyEl, "mini-layout-proxy-hover"), this.hoverProxyEl = null
	},
	onButtonClick : function(t, e) {
		this.on("buttonclick", t, e)
	},
	onButtonMouseDown : function(t, e) {
		this.on("buttonmousedown", t, e)
	}
}), mini.copyTo(mini.Layout.prototype, {
	_createHeader : function(t, e) {
		var i = '<div class="mini-tools">';
		if (e)
			i += '<span class="mini-tools-collapse"></span>';else
			for (var n = t.buttons.length - 1; n >= 0; n--) {
				var s = t.buttons[n];
				i += '<span class="' + s.cls + '" style="', i += s.style + ";" + (s.visible ? "" : "display:none;") + '">' + s.html + "</span>"
		}
		return i += "</div>", i += '<div class="mini-layout-region-icon ' + t.iconCls + '" style="' + t.iconStyle + ";" + (t.iconStyle || t.iconCls ? "" : "display:none;") + '"></div>', i += '<div class="mini-layout-region-title">' + t.title + "</div>"
	},
	doUpdate : function() {
		for (var t = 0, e = this.regions.length; e > t; t++) {
			var i = this.regions[t],
				n = (i.region, i._el),
				s = i._split;
			i._proxy, i.cls && mini.addClass(n, i.cls), i._header.style.display = i.showHeader ? "" : "none", i._header.innerHTML = this._createHeader(i), i._proxy && (i._proxy.innerHTML = this._createHeader(i, !0)), s && (mini.removeClass(s, "mini-layout-split-nodrag"), 0 != i.expanded && i.allowResize || mini.addClass(s, "mini-layout-split-nodrag"))
		}
		this.doLayout()
	},
	doLayout : function() {
		if (this.canLayout() && !this._inAniming) {
			var t = mini.getHeight(this.el, !0),
				e = mini.getWidth(this.el, !0),
				i = {
					x : 0,
					y : 0,
					width : e,
					height : t
				},
				n = this.regions.clone(),
				s = this.getRegion("center");
			n.remove(s), s && n.push(s);
			for (var o = 0, l = n.length; l > o; o++) {
				var r = n[o];
				r._Expanded = !1, mini.removeClass(r._el, "mini-layout-popup");var a = r.region,
					h = r._el,
					d = r._split,
					u = r._proxy;
				if (0 != r.visible) {
					h.style.display = "", "center" != a && (d.style.display = u.style.display = "");
					var c = i.x,
						m = i.y,
						e = i.width,
						t = i.height,
						p = r.width,
						f = r.height;
					switch (r.expanded || ("west" == a || "east" == a ? (p = r.collapseSize, mini.setWidth(h, r.width)) : ("north" == a || "south" == a) && (f = r.collapseSize, mini.setHeight(h, r.height))), a) {
					case "north":
						t = f, i.y += f, i.height -= f;
						break;case "south":
						t = f, m = i.y + i.height - f, i.height -= f;
						break;case "west":
						e = p, i.x += p, i.width -= p;
						break;case "east":
						e = p, c = i.x + i.width - p, i.width -= p;
						break;case "center":
						break;default:
						continue
					}
					0 > e && (e = 0), 0 > t && (t = 0), ("west" == a || "east" == a) && mini.setHeight(h, t), ("north" == a || "south" == a) && mini.setWidth(h, e);
					var g = h;
					r.expanded ? u && (u.style.left = "-1500px", u.style.top = "-100px") : (g = u, h.style.top = "-100px", h.style.left = "-1500px"), g.style.left = c + "px", g.style.top = m + "px", mini.setWidth(g, e), mini.setHeight(g, t), isIE6 && mini.setWidth(r._body, e);
					var _ = jQuery(r._el).height(),
						v = r.showHeader ? jQuery(r._header).outerHeight() : 0;
					if (mini.setHeight(r._body, _ - v), "center" != a) {
						p = f = r.splitSize;
						var c = i.x,
							m = i.y,
							e = i.width,
							t = i.height;
						switch (a) {
						case "north":
							t = f, i.y += f, i.height -= f;
							break;case "south":
							t = f, m = i.y + i.height - f, i.height -= f;
							break;case "west":
							e = p, i.x += p, i.width -= p;
							break;case "east":
							e = p, c = i.x + i.width - p, i.width -= p;
							break;case "center":
						}
						0 > e && (e = 0), 0 > t && (t = 0), d.style.left = c + "px", d.style.top = m + "px", mini.setWidth(d, e), mini.setHeight(d, t), r.showSplit && r.expanded && 1 == r.allowResize ? mini.removeClass(d, "mini-layout-split-nodrag") : mini.addClass(d, "mini-layout-split-nodrag"), d.firstChild.style.display = r.showSplitIcon ? "block" : "none", r.expanded ? mini.removeClass(d.firstChild, "mini-layout-spliticon-collapse") : mini.addClass(d.firstChild, "mini-layout-spliticon-collapse")
					}
				} else h.style.display = "none", "center" != a && (d.style.display = u.style.display = "none")
			}
			mini.layout(this._borderEl), this.fire("layout")
		}
	},
	__OnMouseDown : function(t) {
		if (!this._inAniming && mini.findParent(t.target, "mini-layout-split")) {
			var e = jQuery(t.target).attr("uid");
			if (e != this.uid) return;
			var i = this.getRegion(t.target.id);
			if (0 == i.expanded || !i.allowResize || !i.showSplit) return;
			this.dragRegion = i;
			var n = this._getDrag();
			n.start(t)
		}
	},
	_getDrag : function() {
		return this.drag || (this.drag = new mini.Drag({
				capture : !0,
				onStart : mini.createDelegate(this._OnDragStart, this),
				onMove : mini.createDelegate(this._OnDragMove, this),
				onStop : mini.createDelegate(this._OnDragStop, this)
			})), this.drag
	},
	_OnDragStart : function(t) {
		this._maskProxy = mini.append(document.body, '<div class="mini-resizer-mask"></div>'), this._dragProxy = mini.append(document.body, '<div class="mini-proxy"></div>'), this._dragProxy.style.cursor = "n-resize", ("west" == this.dragRegion.region || "east" == this.dragRegion.region) && (this._dragProxy.style.cursor = "w-resize"), this.splitBox = mini.getBox(this.dragRegion._split), mini.setBox(this._dragProxy, this.splitBox), this.elBox = mini.getBox(this.el, !0)
	},
	_OnDragMove : function(t) {
		var e = t.now[0] - t.init[0],
			i = this.splitBox.x + e,
			n = t.now[1] - t.init[1],
			s = this.splitBox.y + n,
			o = (i + this.splitBox.width, s + this.splitBox.height, this.getRegion("west")),
			l = this.getRegion("east"),
			r = this.getRegion("north"),
			a = this.getRegion("south"),
			h = this.getRegion("center"),
			d = o && o.visible ? o.width : 0,
			u = l && l.visible ? l.width : 0,
			c = r && r.visible ? r.height : 0,
			m = a && a.visible ? a.height : 0,
			p = o && o.showSplit ? mini.getWidth(o._split) : 0,
			f = l && l.showSplit ? mini.getWidth(l._split) : 0,
			g = r && r.showSplit ? mini.getHeight(r._split) : 0,
			_ = a && a.showSplit ? mini.getHeight(a._split) : 0,
			v = this.dragRegion,
			y = v.region;
		if ("west" == y) {
			var C = this.elBox.width - u - f - p - h.minWidth;
			i - this.elBox.x > C && (i = C + this.elBox.x), i - this.elBox.x < v.minWidth && (i = v.minWidth + this.elBox.x), i - this.elBox.x > v.maxWidth && (i = v.maxWidth + this.elBox.x), mini.setX(this._dragProxy, i)
		} else if ("east" == y) {
			var C = this.elBox.width - d - p - f - h.minWidth;
			this.elBox.right - (i + this.splitBox.width) > C && (i = this.elBox.right - C - this.splitBox.width), this.elBox.right - (i + this.splitBox.width) < v.minWidth && (i = this.elBox.right - v.minWidth - this.splitBox.width), this.elBox.right - (i + this.splitBox.width) > v.maxWidth && (i = this.elBox.right - v.maxWidth - this.splitBox.width), mini.setX(this._dragProxy, i)
		} else if ("north" == y) {
			var w = this.elBox.height - m - _ - g - h.minHeight;
			s - this.elBox.y > w && (s = w + this.elBox.y), s - this.elBox.y < v.minHeight && (s = v.minHeight + this.elBox.y), s - this.elBox.y > v.maxHeight && (s = v.maxHeight + this.elBox.y), mini.setY(this._dragProxy, s)
		} else if ("south" == y) {
			var w = this.elBox.height - c - g - _ - h.minHeight;
			this.elBox.bottom - (s + this.splitBox.height) > w && (s = this.elBox.bottom - w - this.splitBox.height), this.elBox.bottom - (s + this.splitBox.height) < v.minHeight && (s = this.elBox.bottom - v.minHeight - this.splitBox.height), this.elBox.bottom - (s + this.splitBox.height) > v.maxHeight && (s = this.elBox.bottom - v.maxHeight - this.splitBox.height), mini.setY(this._dragProxy, s)
		}
	},
	_OnDragStop : function(t) {
		var e = mini.getBox(this._dragProxy),
			i = this.dragRegion,
			n = i.region;
		if ("west" == n) {
			var s = e.x - this.elBox.x;
			this.updateRegion(i, {
				width : s
			})
		} else if ("east" == n) {
			var s = this.elBox.right - e.right;
			this.updateRegion(i, {
				width : s
			})
		} else if ("north" == n) {
			var o = e.y - this.elBox.y;
			this.updateRegion(i, {
				height : o
			})
		} else if ("south" == n) {
			var o = this.elBox.bottom - e.bottom;
			this.updateRegion(i, {
				height : o
			})
		}
		jQuery(this._dragProxy).remove(), this._dragProxy = null, this.elBox = this.handlerBox = null, jQuery(this._maskProxy).remove(), this._maskProxy = null
	},
	_VirtualToggle : function(t) {
		t = this.getRegion(t), t._Expanded === !0 ? this._VirtualCollapse(t) : this._VirtualExpand(t)
	},
	_VirtualExpand : function(t) {
		if (!this._inAniming) {
			this.doLayout();
			var e = t.region,
				i = t._el;
			t._Expanded = !0, mini.addClass(i, "mini-layout-popup");
			var n = mini.getBox(t._proxy),
				s = mini.getBox(t._el),
				o = {};
			if ("east" == e) {
				var l = n.x,
					r = n.y,
					a = n.height;
				mini.setHeight(i, a), mini.setX(i, l), i.style.top = t._proxy.style.top;
				var h = parseInt(i.style.left);
				o = {
					left : h - s.width
				}
			} else if ("west" == e) {
				var l = n.right - s.width,
					r = n.y,
					a = n.height;
				mini.setHeight(i, a), mini.setX(i, l), i.style.top = t._proxy.style.top;
				var h = parseInt(i.style.left);
				o = {
					left : h + s.width
				}
			} else if ("north" == e) {
				var l = n.x,
					r = n.bottom - s.height,
					d = n.width;
				mini.setWidth(i, d), mini.setXY(i, l, r);
				var u = parseInt(i.style.top);
				o = {
					top : u + s.height
				}
			} else if ("south" == e) {
				var l = n.x,
					r = n.y,
					d = n.width;
				mini.setWidth(i, d), mini.setXY(i, l, r);
				var u = parseInt(i.style.top);
				o = {
					top : u - s.height
				}
			}
			mini.addClass(t._proxy, "mini-layout-maxZIndex"), this._inAniming = !0;
			var c = this,
				m = jQuery(i);
			m.animate(o, 250, function() {
				mini.removeClass(t._proxy, "mini-layout-maxZIndex"), c._inAniming = !1
			})
		}
	},
	_VirtualCollapse : function(t) {
		if (!this._inAniming) {
			t._Expanded = !1;
			var e = t.region,
				i = t._el,
				n = mini.getBox(i),
				s = {};
			if ("east" == e) {
				var o = parseInt(i.style.left);
				s = {
					left : o + n.width
				}
			} else if ("west" == e) {
				var o = parseInt(i.style.left);
				s = {
					left : o - n.width
				}
			} else if ("north" == e) {
				var l = parseInt(i.style.top);
				s = {
					top : l - n.height
				}
			} else if ("south" == e) {
				var l = parseInt(i.style.top);
				s = {
					top : l + n.height
				}
			}
			mini.addClass(t._proxy, "mini-layout-maxZIndex"), this._inAniming = !0;
			var r = this,
				a = jQuery(i);
			a.animate(s, 250, function() {
				mini.removeClass(t._proxy, "mini-layout-maxZIndex"), r._inAniming = !1, r.doLayout()
			})
		}
	},
	__OnDocMouseDown : function(t) {
		if (!this._inAniming)
			for (var e = 0, i = this.regions.length; i > e; e++) {
				var n = this.regions[e];
				n._Expanded && (mini.isAncestor(n._el, t.target) || mini.isAncestor(n._proxy, t.target) || this._VirtualCollapse(n))
		}
	},
	getAttrs : function(t) {
		var e = mini.Layout.superclass.getAttrs.call(this, t),
			i = jQuery(t),
			n = parseInt(i.attr("splitSize"));
		isNaN(n) || (e.splitSize = n);
		for (var s = [], o = mini.getChildNodes(t), l = 0, r = o.length; r > l; l++) {
			var a = o[l],
				h = {};
			s.push(h), h.cls = a.className, h.style = a.style.cssText, mini._ParseString(a, h, [ "region", "title", "iconCls", "iconStyle", "cls", "headerCls", "headerStyle", "bodyCls", "bodyStyle" ]), mini._ParseBool(a, h, [ "allowResize", "visible", "showCloseButton", "showCollapseButton", "showSplit", "showHeader", "expanded", "showSplitIcon" ]), mini._ParseInt(a, h, [ "splitSize", "collapseSize", "width", "height", "minWidth", "minHeight", "maxWidth", "maxHeight" ]), h.bodyParent = a
		}
		return e.regions = s, e
	}
}), mini.regClass(mini.Layout, "layout"), mini.ListBox = function() {
	mini.ListBox.superclass.constructor.call(this)
}, mini.extend(mini.ListBox, mini.ListControl, {
	formField : !0,
	width : 200,
	columns : null,
	columnWidth : 80,
	showNullItem : !1,
	nullItemText : "",
	showEmpty : !1,
	emptyText : "",
	showCheckBox : !1,
	showAllCheckBox : !0,
	multiSelect : !1,
	_itemCls : "mini-listbox-item",
	_itemHoverCls : "mini-listbox-item-hover",
	_itemSelectedCls : "mini-listbox-item-selected",
	uiCls : "mini-listbox",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-listbox", this.el.innerHTML = '<div class="mini-listbox-border"><div class="mini-listbox-header"></div><div class="mini-listbox-view"></div><input type="hidden"/></div><div class="mini-errorIcon"></div>', this._borderEl = this.el.firstChild, this._headerEl = this._borderEl.firstChild, this._viewEl = this._borderEl.childNodes[1], this._valueEl = this._borderEl.childNodes[2], this._errorIconEl = this.el.lastChild, this._scrollViewEl = this._viewEl, this._viewEl.innerHTML = '<div class="mini-listbox-content"></div>'
	},
	destroy : function(t) {
		this._viewEl && (this._viewEl.onscroll = null, mini.clearEvent(this._viewEl), this._borderEl.removeChild(this._viewEl), this._scrollViewEl = null, this._viewEl = null), this._headerEl && (mini.clearEvent(this._headerEl), this._borderEl.removeChild(this._headerEl), this._headerEl = null), this._valueEl && (mini.clearEvent(this._valueEl), this._borderEl.removeChild(this._valueEl), this._valueEl = null), this._borderEl && (mini.clearEvent(this._borderEl), this.el.removeChild(this._borderEl), this._borderEl = null), this._errorIconEl && (mini.clearEvent(this._errorIconEl), this.el.removeChild(this._errorIconEl), this._errorIconEl = null),
		delete this.data
		,
		delete this.columns
		, mini.ListBox.superclass.destroy.call(this, t)
	},
	_initEvents : function() {
		mini.ListBox.superclass._initEvents.call(this), mini._BindEvents(function() {
			mini_onOne(this._viewEl, "scroll", this.__OnScroll, this)
		}, this)
	},
	setColumns : function(t) {
		mini.isArray(t) || (t = []), this.columns = t;
		for (var e = 0, i = this.columns.length; i > e; e++) {
			var n = this.columns[e];
			if (n.type) {
				mini.isNull(n.header) || "function" == typeof n.header || "" == n.header.trim() &&
				delete n.header;
				var s = mini._getColumn(n.type);
				if (s) {
					var o = mini.copyTo({}, n);
					mini.copyTo(n, s), mini.copyTo(n, o)
				}
			}
			var l = parseInt(n.width);
			mini.isNumber(l) && String(l) == n.width && (n.width = l + "px"), mini.isNull(n.width) && (n.width = this.columnWidth + "px")
		}
		this.doUpdate()
	},
	getColumns : function() {
		return this.columns
	},
	__OnMouseMove : function(t) {
		mini.ListBox.superclass.__OnMouseMove.call(this, t);
		var e = t.target;
		if ("TD" == t.target.parentNode.tagName && (e = t.target.parentNode), "TD" == e.tagName)
			if (e.scrollWidth > e.clientWidth) {
				var i = e.innerText || e.textContent || "";
				e.title = i.trim()
			} else
				e.title = ""
	},
	__OnMouseOut : function(t) {
		mini.ListBox.superclass.__OnMouseOut.call(this, t);
		var e = t.target;
		"TD" == t.target.parentNode.tagName && (e = t.target.parentNode), e.title = ""
	},
	doUpdate : function() {
		if (this._allowUpdate !== !1) {
			var t = this.columns && this.columns.length > 0;
			t ? mini.addClass(this.el, "mini-listbox-showColumns") : mini.removeClass(this.el, "mini-listbox-showColumns"), this._headerEl.style.display = t ? "" : "none";
			var e = [];
			if (t && this.showColumns) {
				e[e.length] = '<table class="mini-listbox-headerInner" cellspacing="0" cellpadding="0"><tr>';
				var i = this.uid + "$ck$all";
				e[e.length] = '<td class="mini-listbox-checkbox"><input type="checkbox" id="' + i + '"></td>';
				for (var n = 0, s = this.columns.length; s > n; n++) {
					var o = this.columns[n],
						l = o.header;
					mini.isNull(l) && (l = "&nbsp;");var r = o.width;
					mini.isNumber(r) && (r += "px"), e[e.length] = '<td class="', o.headerCls && (e[e.length] = o.headerCls), e[e.length] = '" style="', o.headerStyle && (e[e.length] = o.headerStyle + ";"), r && (e[e.length] = "width:" + r + ";"), o.headerAlign && (e[e.length] = "text-align:" + o.headerAlign + ";"), e[e.length] = '">', e[e.length] = l, e[e.length] = "</td>"
				}
				e[e.length] = "</tr></table>"
			}
			this._headerEl.innerHTML = e.join("");
			var e = [],
				a = this.data;
			if (e[e.length] = '<table class="mini-listbox-items" cellspacing="0" cellpadding="0">', this.showEmpty && 0 == a.length)
				e[e.length] = '<tr><td colspan="20">' + this.emptyText + "</td></tr>";else {
				this._doNullItem();
				for (var h = 0, d = a.length; d > h; h++) {
					var u = a[h],
						c = -1,
						m = " ",
						p = -1,
						f = " ";
					e[e.length] = '<tr id="', e[e.length] = this._createItemId(h), e[e.length] = '" index="', e[e.length] = h, e[e.length] = '" class="mini-listbox-item ', u.enabled === !1 && (e[e.length] = " mini-disabled "), c = e.length, e[e.length] = m, e[e.length] = '" style="', p = e.length, e[e.length] = f, e[e.length] = '">';var g = this._createCheckId(h),
						_ = (this.name, this.getItemValue(u), "");
					if (u.enabled === !1 && (_ = "disabled"), e[e.length] = '<td class="mini-listbox-checkbox"><input ' + _ + ' id="' + g + '" type="checkbox" ></td>', t)
						for (var n = 0, s = this.columns.length; s > n; n++) {
							var o = this.columns[n],
								v = this._OnDrawCell(u, h, o),
								r = o.width;
							"number" == typeof r && (r += "px"), e[e.length] = '<td class="', v.cellCls && (e[e.length] = v.cellCls), e[e.length] = '" style="', v.cellStyle && (e[e.length] = v.cellStyle + ";"), r && (e[e.length] = "width:" + r + ";"), o.align && (e[e.length] = "text-align:" + o.align + ";"), e[e.length] = '">', e[e.length] = v.cellHtml, e[e.length] = "</td>", v.rowCls && (m = v.rowCls), v.rowStyle && (f = v.rowStyle)
					}else {
						var v = this._OnDrawCell(u, h, null);
						e[e.length] = '<td class="', v.cellCls && (e[e.length] = v.cellCls), e[e.length] = '" style="', v.cellStyle && (e[e.length] = v.cellStyle), e[e.length] = '">', e[e.length] = v.cellHtml, e[e.length] = "</td>", v.rowCls && (m = v.rowCls), v.rowStyle && (f = v.rowStyle)
					}
					e[c] = m, e[p] = f, e[e.length] = "</tr>"
				}
			}
			e[e.length] = "</table>";
			var y = e.join("");
			this._viewEl.firstChild.innerHTML = y, this._doSelects(), this.doLayout()
		}
	},
	doLayout : function() {
		if (this.canLayout()) {
			this.columns && this.columns.length > 0 ? mini.addClass(this.el, "mini-listbox-showcolumns") : mini.removeClass(this.el, "mini-listbox-showcolumns"), this.showCheckBox ? mini.removeClass(this.el, "mini-listbox-hideCheckBox") : mini.addClass(this.el, "mini-listbox-hideCheckBox");
			var t = this.uid + "$ck$all",
				e = document.getElementById(t);
			e && (e.style.display = this.showAllCheckBox ? "" : "none");
			var i = this.isAutoHeight();
			h = this.getHeight(!0), a = this.getWidth(!0);
			var n = a,
				s = this._viewEl;
			if (s.style.width = a + "px", i)
				s.style.height = "auto";else {
				var o = mini.getHeight(this._headerEl);
				h -= o, s.style.height = h + "px"
			}
			if (isIE) {
				var l = this._headerEl.firstChild,
					r = this._viewEl.firstChild.firstChild;
				if (this._viewEl.offsetHeight >= this._viewEl.scrollHeight) r.style.width = "100%", l && (l.style.width = "100%");else {
					var a = parseInt(r.parentNode.offsetWidth - 17) + "px";
					r.style.width = a, l && (l.style.width = a)
				}
			}
			this._viewEl.offsetHeight < this._viewEl.scrollHeight ? this._headerEl.style.width = n - 17 + "px" : this._headerEl.style.width = "100%"
		}
	},
	setShowCheckBox : function(t) {
		this.showCheckBox = t, this.doLayout()
	},
	getShowCheckBox : function() {
		return this.showCheckBox
	},
	setShowAllCheckBox : function(t) {
		this.showAllCheckBox = t, this.doLayout()
	},
	getShowAllCheckBox : function() {
		return this.showAllCheckBox
	},
	setShowColumns : function(t) {
		this.showColumns = t, this.doUpdate()
	},
	getShowColumns : function() {
		return this.showColumns
	},
	setShowNullItem : function(t) {
		this.showNullItem != t && (this.showNullItem = t, this._doNullItem(), this.doUpdate())
	},
	getShowNullItem : function() {
		return this.showNullItem
	},
	setNullItemText : function(t) {
		this.nullItemText != t && (this.nullItemText = t, this._doNullItem(), this.doUpdate())
	},
	getNullItemText : function() {
		return this.nullItemText
	},
	_doNullItem : function() {
		for (var t = 0, e = this.data.length; e > t; t++) {
			var i = this.data[t];
			if (i.__NullItem) {
				this.data.removeAt(t);break
			}
		}
		if (this.showNullItem) {
			var i = {
				__NullItem : !0
			};
			i[this.textField] = this.nullItemText, i[this.valueField] = "", this.data.insert(0, i)
		}
	},
	_OnDrawCell : function(t, e, i) {
		var n = i ? t[i.field] : this.getItemText(t),
			s = {
				sender : this,
				index : e,
				rowIndex : e,
				record : t,
				item : t,
				column : i,
				field : i ? i.field : null,
				value : n,
				cellHtml : n,
				rowCls : null,
				cellCls : i ? i.cellCls || "" : "",
				rowStyle : null,
				cellStyle : i ? i.cellStyle || "" : ""
			},
			o = this.columns && this.columns.length > 0;
		if (o || 0 == e && this.showNullItem && (s.cellHtml = this.nullItemText), s.cellHtml = mini.htmlEncode(s.cellHtml), i) {
			i.dateFormat && (mini.isDate(s.value) ? s.cellHtml = mini.formatDate(n, i.dateFormat) : s.cellHtml = n);
			var l = i.renderer;
			l && (fn = "function" == typeof l ? l : window[l], fn && (s.cellHtml = fn.call(i, s)))
		}
		return this.fire("drawcell", s), (null === s.cellHtml || void 0 === s.cellHtml || "" === s.cellHtml) && (s.cellHtml = "&nbsp;"), s
	},
	__OnScroll : function(t) {
		this._headerEl.scrollLeft = this._viewEl.scrollLeft
	},
	__OnClick : function(t) {
		var e = this.uid + "$ck$all";
		if (t.target.id != e) this._fireEvent(t, "Click");else {
			var i = document.getElementById(e);
			if (i) {
				var n = i.checked,
					s = this.getValue();
				n ? this.selectAll() : this.deselectAll(), this._OnSelectionChanged(), s != this.getValue() && (this._OnValueChanged(), this.fire("itemclick", {
					htmlEvent : t
				}))
			}
		}
	},
	getAttrs : function(t) {
		var e = mini.ListBox.superclass.getAttrs.call(this, t);
		if (mini._ParseString(t, e, [ "nullItemText", "ondrawcell", "emptyText" ]), mini._ParseBool(t, e, [ "showCheckBox", "showAllCheckBox", "showNullItem", "showColumns", "showEmpty" ]), "select" != t.nodeName.toLowerCase())
			for (var i = mini.getChildNodes(t), n = 0, s = i.length; s > n; n++) {
				var o = i[n],
					l = jQuery(o).attr("property");
				l && (l = l.toLowerCase(), "columns" == l ? e.columns = mini._ParseColumns(o) : "data" == l && (e.data = o.innerHTML))
		}
		return e
	}
}), mini.regClass(mini.ListBox, "listbox"), mini.Popup = function() {
	mini.Popup.superclass.constructor.call(this), this.setVisible(!1), this.setAllowDrag(this.allowDrag), this.setAllowResize(this.allowResize)
}, mini.extend(mini.Popup, mini.Container, {
	_clearBorder : !1,
	uiCls : "mini-popup",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-popup", this._contentEl = this.el
	},
	_initEvents : function() {
		mini._BindEvents(function() {
			mini_onOne(this.el, "mouseover", this.__OnMouseOver, this)
		}, this)
	},
	doLayout : function() {
		if (this.canLayout()) {
			mini.Popup.superclass.doLayout.call(this), this._doShadow();
			var t = this.el.childNodes;
			if (t)
				for (var e = 0, i = t.length; i > e; e++) {
					var n = t[e];
					mini.layout(n)
			}
		}
	},
	destroy : function(t) {
		this.el && (this.el.onmouseover = null), this._contentEl = null, mini.un(document, "mousedown", this.__OnBodyMouseDown, this), mini.un(window, "resize", this.__OnWindowResize, this), this._modalEl && (this._modalEl.parentNode.removeChild(this._modalEl), this._modalEl = null), this.shadowEl && (this.shadowEl.parentNode.removeChild(this.shadowEl), this.shadowEl = null), this.popupEl && (this._unbindPopupEl(), this.popupEl = null), mini.Popup.superclass.destroy.call(this, t)
	},
	setWidth : function(t) {
		if (parseInt(t) == t && (t += "px"), this.width = t, -1 != t.indexOf("px")) {
			if (isIE) {
				var e = mini.getBorders(this.el);
				e.left || (t = t.substring(0, t.indexOf("px")) - 2 + "px")
			}
			mini.setWidth(this.el, t)
		} else
			this.el.style.width = t;
		this._sizeChaned()
	},
	setHeight : function(t) {
		parseInt(t) == t && (t += "px"), this.height = t, -1 != t.indexOf("px") ? mini.setHeight(this.el, t) : this.el.style.height = t, this._sizeChaned()
	},
	setBody : function(t) {
		if (t) {
			mini.isArray(t) || (t = [ t ]);
			for (var e = 0, i = t.length; i > e; e++) mini.append(this._contentEl, t[e])
		}
	},
	getAttrs : function(t) {
		var e = mini.Popup.superclass.getAttrs.call(this, t);
		mini._ParseString(t, e, [ "popupEl", "popupCls", "showAction", "hideAction", "xAlign", "yAlign", "modalStyle", "onbeforeopen", "open", "onbeforeclose", "onclose" ]), mini._ParseBool(t, e, [ "showModal", "showShadow", "allowDrag", "allowResize" ]), mini._ParseInt(t, e, [ "showDelay", "hideDelay", "xOffset", "yOffset", "minWidth", "minHeight", "maxWidth", "maxHeight" ]);
		var i = mini.getChildNodes(t, !0);
		return e.body = i, e
	}
}), mini.regClass(mini.Popup, "popup"), mini.Popup_prototype = {
	isPopup : !1,
	popupEl : null,
	popupCls : "",
	showAction : "mouseover",
	hideAction : "outerclick",
	showDelay : 300,
	hideDelay : 500,
	xAlign : "left",
	yAlign : "below",
	xOffset : 0,
	yOffset : 0,
	minWidth : 50,
	minHeight : 25,
	maxWidth : 2e3,
	maxHeight : 2e3,
	showModal : !1,
	showShadow : !0,
	modalStyle : "opacity:0.2",
	_dragCls : "mini-popup-drag",
	_resizeCls : "mini-popup-resize",
	allowDrag : !1,
	allowResize : !1,
	_unbindPopupEl : function() {
		this.popupEl && (mini.un(this.popupEl, "click", this.__OnLeftClick, this), mini.un(this.popupEl, "contextmenu", this.__OnRightClick, this), mini.un(this.popupEl, "mouseover", this.__OnMouseOver, this))
	},
	_bindPopupEl : function() {
		this.popupEl && (mini.on(this.popupEl, "click", this.__OnLeftClick, this), mini.on(this.popupEl, "contextmenu", this.__OnRightClick, this), mini.on(this.popupEl, "mouseover", this.__OnMouseOver, this))
	},
	_doShim : function() {
		function t() {
			this._shimEl.style.display = "";var t = mini.getBox(this.el),
				e = this._shimEl.style;
			e.width = t.width + "px", e.height = t.height + "px", e.left = t.x + "px", e.top = t.y + "px";var i = mini.getStyle(this.el, "zIndex");
			isNaN(i) || (this._shimEl.style.zIndex = i - 3)
		}
		if (mini.isIE && mini_useShims) {
			if (!this._shimEl) {
				var e = "<iframe frameborder='0' style='position: absolute; z-index: -1; width: 0; height: 0; top: 0;left:0;scrolling:no;'></iframe>";
				this._shimEl = mini.append(document.body, e)
			}
			this._shimEl.style.display = "none", this._doShimTimer && (clearTimeout(this._doShimTimer), this._doShimTimer = null);
			var i = this;
			this._doShimTimer = setTimeout(function() {
				i._doShimTimer = null, t.call(i)
			}, 20)
		}
	},
	doShow : function(t) {
		var e = {
			popupEl : this.popupEl,
			htmlEvent : t,
			cancel : !1
		};
		if (this.fire("BeforeOpen", e), 1 != e.cancel && (this.fire("opening", e), 1 != e.cancel))
			if (this.popupEl) {
				var i = {};
				t && (i.xy = [ t.pageX, t.pageY ]), this.showAtEl(this.popupEl, i)
			} else this.show()
	},
	doHide : function(t) {
		var e = {
			popupEl : this.popupEl,
			htmlEvent : t,
			cancel : !1
		};
		this.fire("BeforeClose", e), 1 != e.cancel && this.close()
	},
	show : function(t, e) {
		this.showAtPos(t, e)
	},
	showAtPos : function(t, e) {
		this.render(document.body), t || (t = "center"), e || (e = "middle"), this.el.style.position = "absolute", this.el.style.left = "-2000px", this.el.style.top = "-2000px", this.el.style.display = "", this._measureSize();
		var i = mini.getViewportBox(),
			n = mini.getBox(this.el);
		"left" == t && (t = 0), "center" == t && (t = i.width / 2 - n.width / 2), "right" == t && (t = i.width - n.width), "top" == e && (e = 0), "middle" == e && (e = i.y + i.height / 2 - n.height / 2), "bottom" == e && (e = i.height - n.height), t + n.width > i.right && (t = i.right - n.width), e + n.height > i.bottom && (e = i.bottom - n.height - 20), this._Show(t, e)
	},
	_doModal : function() {
		if (jQuery(this._modalEl).remove(), this.showModal && 0 != this.visible) {
			var t = document.documentElement,
				e = parseInt(Math.max(document.body.scrollWidth, t ? t.scrollWidth : 0)),
				i = parseInt(Math.max(document.body.scrollHeight, t ? t.scrollHeight : 0)),
				n = mini.getViewportBox(),
				s = n.height;
			i > s && (s = i);
			var o = n.width;
			e > o && (o = e), this._modalEl = mini.append(document.body, '<div class="mini-modal"></div>'), this._modalEl.style.height = s + "px", this._modalEl.style.width = o + "px", this._modalEl.style.zIndex = mini.getStyle(this.el, "zIndex") - 1, mini.setStyle(this._modalEl, this.modalStyle)
		}
	},
	_doShadow : function() {
		function t() {
			this.shadowEl.style.display = "";var t = mini.getBox(this.el),
				e = this.shadowEl.style;
			e.width = t.width + "px", e.height = t.height + "px", e.left = t.x + "px", e.top = t.y + "px";var i = mini.getStyle(this.el, "zIndex");
			isNaN(i) || (this.shadowEl.style.zIndex = i - 2)
		}
		if (this.shadowEl || (this.shadowEl = mini.append(document.body, '<div class="mini-shadow"></div>')), this.shadowEl.style.display = this.showShadow ? "" : "none", this.showShadow) {
			this.shadowEl.style.display = "none", this._doShadowTimer && (clearTimeout(this._doShadowTimer), this._doShadowTimer = null);
			var e = this;
			this._doShadowTimer = setTimeout(function() {
				e._doShadowTimer = null, t.call(e)
			}, 20)
		}
	},
	_measureSize : function() {
		this.el.style.display = "";
		var t = mini.getBox(this.el);
		t.width > this.maxWidth && (mini.setWidth(this.el, this.maxWidth), t = mini.getBox(this.el)), t.height > this.maxHeight && (mini.setHeight(this.el, this.maxHeight), t = mini.getBox(this.el)), t.width < this.minWidth && (mini.setWidth(this.el, this.minWidth), t = mini.getBox(this.el)), t.height < this.minHeight && (mini.setHeight(this.el, this.minHeight), t = mini.getBox(this.el))
	},
	showAtEl : function(t, e) {
		if (t = mini.byId(t)) {
			this.isRender() && this.el.parentNode == document.body || this.render(document.body);
			var i = {
				xAlign : this.xAlign,
				yAlign : this.yAlign,
				xOffset : this.xOffset,
				yOffset : this.yOffset,
				popupCls : this.popupCls
			};
			mini.copyTo(i, e), mini.addClass(t, i.popupCls), t.popupCls = i.popupCls, this._popupEl = t, this.el.style.position = "absolute", this.el.style.left = "-2000px", this.el.style.top = "-2000px", this.el.style.display = "", this.doLayout(), this._measureSize();
			var n = mini.getViewportBox(),
				s = mini.getBox(this.el),
				o = mini.getBox(t),
				l = i.xy,
				r = (i.xAlign, i.yAlign, n.width / 2 - s.width / 2),
				a = 0;
			switch (l && (r = l[0], a = l[1]), i.xAlign) {
			case "outleft":
				r = o.x - s.width;
				break;case "left":
				r = o.x;
				break;case "center":
				r = o.x + o.width / 2 - s.width / 2;
				break;case "right":
				r = o.right - s.width;
				break;case "outright":
				r = o.right
			}
			switch (i.yAlign) {
			case "above":
				a = o.y - s.height;
				break;case "top":
				a = o.y;
				break;case "middle":
				a = o.y + o.height / 2 - s.height / 2;
				break;case "bottom":
				a = o.bottom - s.height;
				break;case "below":
				a = o.bottom
			}
			if (r = parseInt(r), a = parseInt(a), i.outYAlign || i.outXAlign) {
				if ("above" == i.outYAlign && a + s.height > n.bottom && (a = o.y - s.height, 0 > a && (a = o.y - this.minHeight, this.setHeight(this.minHeight))), "outleft" == i.outXAlign && r + s.width > n.right) {
					var h = o.x - n.x,
						d = n.right - o.right;
					h > d && (r = o.x - s.width)
				}
				"right" == i.outXAlign && r + s.width > n.right && (r = o.right - s.width), this._Show(r, a)
			} else this.showAtPos(r + i.xOffset, a + i.yOffset)
		}
	},
	_Show : function(t, e) {
		this.el.style.display = "", this.el.style.zIndex = mini.getMaxZIndex(), mini.setX(this.el, t), mini.setY(this.el, e), this.setVisible(!0), "mouseout" == this.hideAction && mini.on(document, "mousemove", this.__OnBodyMouseMove, this), this._doShadow(), this._doModal(), this._doShim(), mini.layoutIFrames(this.el), this.isPopup = !0, mini.on(document, "mousedown", this.__OnBodyMouseDown, this), mini.on(window, "resize", this.__OnWindowResize, this), this.fire("Open")
	},
	open : function() {
		this.show()
	},
	close : function() {
		this.hide()
	},
	hide : function() {
		this.el && (this.popupEl && mini.removeClass(this.popupEl, this.popupEl.popupCls), this._popupEl && mini.removeClass(this._popupEl, this._popupEl.popupCls), this._popupEl = null, jQuery(this._modalEl).remove(), this.shadowEl && (this.shadowEl.style.display = "none"), this._shimEl && (this._shimEl.style.display = "none"), mini.un(document, "mousemove", this.__OnBodyMouseMove, this), mini.un(document, "mousedown", this.__OnBodyMouseDown, this), mini.un(window, "resize", this.__OnWindowResize, this), this.setVisible(!1), this.isPopup = !1, this.fire("Close"))
	},
	setPopupEl : function(t) {
		t = mini.byId(t), t && (this._unbindPopupEl(), this.popupEl = t, this._bindPopupEl())
	},
	setPopupCls : function(t) {
		this.popupCls = t
	},
	setShowAction : function(t) {
		this.showAction = t
	},
	setHideAction : function(t) {
		this.hideAction = t
	},
	setShowDelay : function(t) {
		this.showDelay = t
	},
	setHideDelay : function(t) {
		this.hideDelay = t
	},
	setXAlign : function(t) {
		this.xAlign = t
	},
	setYAlign : function(t) {
		this.yAlign = t
	},
	setxOffset : function(t) {
		t = parseInt(t), isNaN(t) && (t = 0), this.xOffset = t
	},
	setyOffset : function(t) {
		t = parseInt(t), isNaN(t) && (t = 0), this.yOffset = t
	},
	setShowModal : function(t) {
		this.showModal = t
	},
	setShowShadow : function(t) {
		this.showShadow = t
	},
	setMinWidth : function(t) {
		isNaN(t) || (this.minWidth = t)
	},
	setMinHeight : function(t) {
		isNaN(t) || (this.minHeight = t)
	},
	setMaxWidth : function(t) {
		isNaN(t) || (this.maxWidth = t)
	},
	setMaxHeight : function(t) {
		isNaN(t) || (this.maxHeight = t)
	},
	setAllowDrag : function(t) {
		this.allowDrag = t, mini.removeClass(this.el, this._dragCls), t && mini.addClass(this.el, this._dragCls)
	},
	setAllowResize : function(t) {
		this.allowResize = t, mini.removeClass(this.el, this._resizeCls), t && mini.addClass(this.el, this._resizeCls)
	},
	__OnLeftClick : function(t) {
		if (!this._inAniming && "leftclick" == this.showAction) {
			var e = jQuery(this.popupEl).attr("allowPopup");
			"false" != String(e) && this.doShow(t)
		}
	},
	__OnRightClick : function(t) {
		if (!this._inAniming && "rightclick" == this.showAction) {
			var e = jQuery(this.popupEl).attr("allowPopup");
			"false" != String(e) && (t.preventDefault(), this.doShow(t))
		}
	},
	__OnMouseOver : function(t) {
		if (!this._inAniming && "mouseover" == this.showAction) {
			var e = jQuery(this.popupEl).attr("allowPopup");
			if ("false" != String(e) && (clearTimeout(this._hideTimer), this._hideTimer = null, !this.isPopup)) {
				var i = this;
				this._showTimer = setTimeout(function() {
					i.doShow(t)
				}, this.showDelay)
			}
		}
	},
	__OnBodyMouseMove : function(t) {
		"mouseout" == this.hideAction && this._tryHide(t)
	},
	__OnBodyMouseDown : function(t) {
		"outerclick" == this.hideAction && this.isPopup && (this.within(t) || this.popupEl && mini.isAncestor(this.popupEl, t.target) || this.doHide(t))
	},
	_tryHide : function(t) {
		if (mini.isAncestor(this.el, t.target) || this.popupEl && mini.isAncestor(this.popupEl, t.target))
			;else {
			if (clearTimeout(this._showTimer), this._showTimer = null, this._hideTimer) return;
			var e = this;
			this._hideTimer = setTimeout(function() {
				e.doHide(t)
			}, this.hideDelay)
		}
	},
	__OnWindowResize : function(t) {
		this.isDisplay() && !mini.isIE6 && this._doModal()
	},
	within : function(t) {
		if (mini.isAncestor(this.el, t.target)) return !0;
		for (var e = mini.getChildControls(this), i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			if (s.within(t)) return !0
		}
		return !1
	}
}, mini.copyTo(mini.Popup.prototype, mini.Popup_prototype), mini.OutlookBar = function() {
	this._initGroups(), mini.OutlookBar.superclass.constructor.call(this)
}, mini.extend(mini.OutlookBar, mini.Control, {
	width : 180,
	expandOnLoad : !0,
	activeIndex : -1,
	autoCollapse : !1,
	groupCls : "",
	groupStyle : "",
	groupHeaderCls : "",
	groupHeaderStyle : "",
	groupBodyCls : "",
	groupBodyStyle : "",
	groupHoverCls : "",
	groupActiveCls : "",
	allowAnim : !0,
	set : function(t) {
		if ("string" == typeof t) return this;
		var e = this._allowLayout;
		this._allowLayout = !1;
		var i = t.activeIndex;
		return delete t.activeIndex
			, mini.OutlookBar.superclass.set.call(this, t), mini.isNumber(i) && this.setActiveIndex(i), this._allowLayout = e, this.doLayout(), this
	},
	uiCls : "mini-outlookbar",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-outlookbar", this.el.innerHTML = '<div class="mini-outlookbar-border"></div>', this._borderEl = this.el.firstChild
	},
	destroy : function(t) {
		this._borderEl && (mini.clearEvent(this._borderEl), this.el.removeChild(this._borderEl), this._borderEl = null), mini.OutlookBar.superclass.destroy.call(this, t)
	},
	_initEvents : function() {
		mini._BindEvents(function() {
			mini.on(this.el, "click", this.__OnClick, this)
		}, this)
	},
	_createGroupId : function(t) {
		return this.uid + "$" + t._id
	},
	_GroupId : 1,
	_initGroups : function() {
		this.groups = []
	},
	_createGroupEl : function(t) {
		var e = this._createGroupId(t),
			i = '<div id="' + e + '" class="mini-outlookbar-group ' + t.cls + '" style="' + t.style + '"><div class="mini-outlookbar-groupHeader ' + t.headerCls + '" style="' + t.headerStyle + ';"></div><div class="mini-outlookbar-groupBody ' + t.bodyCls + '" style="' + t.bodyStyle + ';"></div></div>',
			n = mini.append(this._borderEl, i),
			s = n.lastChild,
			o = t.body;
		if (
			delete t.body
			, o) {
			mini.isArray(o) || (o = [ o ]);
			for (var l = 0, r = o.length; r > l; l++) {
				var a = o[l];
				mini.append(s, a)
			}
			o.length = 0
		}
		if (t.bodyParent)
			for (var h = t.bodyParent; h.firstChild;) s.appendChild(h.firstChild);
		return delete t.bodyParent
			, n
	},
	createGroup : function(t) {
		var e = mini.copyTo({
			_id : this._GroupId++,
			name : "",
			title : "",
			cls : "",
			style : "",
			iconCls : "",
			iconStyle : "",
			headerCls : "",
			headerStyle : "",
			bodyCls : "",
			bodyStyle : "",
			visible : !0,
			enabled : !0,
			showCollapseButton : !0,
			expanded : this.expandOnLoad
		}, t);
		return e
	},
	setGroups : function(t) {
		if (mini.isArray(t)) {
			this.removeAll();
			for (var e = 0, i = t.length; i > e; e++) this.addGroup(t[e])
		}
	},
	getGroups : function() {
		return this.groups
	},
	addGroup : function(t, e) {
		"string" == typeof t && (t = {
			title : t
		}), t = this.createGroup(t), "number" != typeof e && (e = this.groups.length), this.groups.insert(e, t);
		var i = this._createGroupEl(t);
		t._el = i;
		var e = this.groups.indexOf(t),
			n = this.groups[e + 1];
		if (n) {
			var s = this.getGroupEl(n);
			jQuery(s).before(i)
		}
		return this.doUpdate(), t
	},
	updateGroup : function(t, e) {
		var t = this.getGroup(t);
		t && (mini.copyTo(t, e), this.doUpdate())
	},
	removeGroup : function(t) {
		if (t = this.getGroup(t)) {
			var e = this.getGroupEl(t);
			e && e.parentNode.removeChild(e), this.groups.remove(t), this.doUpdate()
		}
	},
	removeAll : function() {
		for (var t = this.groups.length - 1; t >= 0; t--) this.removeGroup(t)
	},
	moveGroup : function(t, e) {
		if (t = this.getGroup(t)) {
			target = this.getGroup(e);
			var i = this.getGroupEl(t);
			if (this.groups.remove(t), target) {
				e = this.groups.indexOf(target), this.groups.insert(e, t);
				var n = this.getGroupEl(target);
				jQuery(n).before(i)
			} else this.groups.add(t), this._borderEl.appendChild(i);
			this.doUpdate()
		}
	},
	doUpdate : function() {
		for (var t = 0, e = this.groups.length; e > t; t++) {
			var i = this.groups[t],
				n = i._el,
				s = n.firstChild,
				o = n.lastChild,
				l = '<div class="mini-outlookbar-icon ' + i.iconCls + '" style="' + i.iconStyle + ';"></div>',
				r = "";
			i.showCollapseButton && (r += '<div class="mini-tools"><span class="mini-tools-collapse"></span></div>'), r += (i.iconStyle || i.iconCls ? l : "") + '<div class="mini-outlookbar-groupTitle">' + i.title + '</div><div style="clear:both;"></div>', s.innerHTML = r, i.enabled ? mini.removeClass(n, "mini-disabled") : mini.addClass(n, "mini-disabled"), mini.addClass(n, i.cls), mini.setStyle(n, i.style), mini.addClass(o, i.bodyCls), mini.setStyle(o, i.bodyStyle), mini.addClass(s, i.headerCls), mini.setStyle(s, i.headerStyle), mini.removeClass(n, "mini-outlookbar-firstGroup"), mini.removeClass(n, "mini-outlookbar-lastGroup"), 0 == t && mini.addClass(n, "mini-outlookbar-firstGroup"), t == e - 1 && mini.addClass(n, "mini-outlookbar-lastGroup")
		}
		this.doLayout()
	},
	doLayout : function() {
		if (this.canLayout() && !this._inAniming) {
			this._doLayoutInner();
			for (var t = 0, e = this.groups.length; e > t; t++) {
				var i = this.groups[t],
					n = i._el,
					s = n.lastChild;
				if (i.expanded ? (mini.addClass(n, "mini-outlookbar-expand"), mini.removeClass(n, "mini-outlookbar-collapse")) : (mini.removeClass(n, "mini-outlookbar-expand"), mini.addClass(n, "mini-outlookbar-collapse")), s.style.height = "auto", s.style.display = i.expanded ? "block" : "none", n.style.display = i.visible ? "" : "none", !isIE || isIE6) {
					var o = mini.getWidth(n, !0),
						l = mini.getPaddings(s),
						r = mini.getBorders(s);
					jQuery.boxModel && (o = o - l.left - l.right - r.left - r.right), s.style.width = o + "px"
				}
			}
			var a = this.isAutoHeight(),
				h = this.getActiveGroup();
			if (!a && this.autoCollapse && h) {
				var n = this.getGroupEl(this.activeIndex);
				n.lastChild.style.height = this._getFillGroupBodyHeight() + "px"
			}
			if (isIE) {
				var l = mini.getPaddings(this.el.parentNode);
				this._borderEl.offsetHeight > this.el.parentNode.offsetHeight - l.top - l.bottom ? this.el.style.width = this.el.parentNode.clientWidth - 20 + "px" : this.el.style.width = this.width
			}
			mini.layout(this._borderEl)
		}
	},
	_doLayoutInner : function() {
		if (this.isAutoHeight())
			this._borderEl.style.height = "auto";else {
			var t = this.getHeight(!0);
			if (!jQuery.boxModel) {
				var e = mini.getBorders(this._borderEl);
				t = t + e.top + e.bottom
			}
			0 > t && (t = 0), this._borderEl.style.height = t + "px"
		}
	},
	_getFillGroupBodyHeight : function() {
		var t = jQuery(this.el).height(),
			e = mini.getBorders(this._borderEl);
		t = t - e.top - e.bottom;
		for (var i = this.getActiveGroup(), n = 0, s = 0, o = this.groups.length; o > s; s++) {
			var l = this.groups[s],
				r = this.getGroupEl(l);
			if (0 != l.visible && l != i) {
				var a = r.lastChild.style.display;
				r.lastChild.style.display = "none";
				var h = jQuery(r).outerHeight();
				r.lastChild.style.display = a;
				var d = mini.getMargins(r);
				h = h + d.top + d.bottom, n += h
			}
		}
		t -= n;
		var u = this.getGroupEl(this.activeIndex);
		if (!u) return 0;
		if (t -= jQuery(u.firstChild).outerHeight(), jQuery.boxModel) {
			var c = mini.getPaddings(u.lastChild),
				m = mini.getBorders(u.lastChild);
			t = t - c.top - c.bottom - m.top - m.bottom
		}
		var c = mini.getPaddings(u),
			m = mini.getBorders(u),
			d = mini.getMargins(u);
		return t = t - d.top - d.bottom, t = t - c.top - c.bottom - m.top - m.bottom, 0 > t && (t = 0), t
	},
	getGroup : function(t) {
		if ("object" == typeof t) return t;
		if ("number" == typeof t) return this.groups[t];
		for (var e = 0, i = this.groups.length; i > e; e++) {
			var n = this.groups[e];
			if (n.name == t) return n
		}
	},
	_getGroupById : function(t) {
		for (var e = 0, i = this.groups.length; i > e; e++) {
			var n = this.groups[e];
			if (n._id == t) return n
		}
	},
	getGroupEl : function(t) {
		var e = this.getGroup(t);
		return e ? e._el : null
	},
	getGroupBodyEl : function(t) {
		var e = this.getGroupEl(t);
		return e ? e.lastChild : null
	},
	setAutoCollapse : function(t) {
		this.autoCollapse = t
	},
	getAutoCollapse : function() {
		return this.autoCollapse
	},
	setExpandOnLoad : function(t) {
		this.expandOnLoad = t
	},
	getExpandOnLoad : function() {
		return this.expandOnLoad
	},
	setActiveIndex : function(t) {
		var e = this.getGroup(t);
		this.getGroup(this.activeIndex), e ? this.activeIndex = this.groups.indexOf(e) : this.activeIndex = -1;
		var e = this.getGroup(this.activeIndex);
		if (e) {
			var i = this.allowAnim;
			this.allowAnim = !1, this.expandGroup(e), this.allowAnim = i
		}
	},
	getActiveIndex : function() {
		return this.activeIndex
	},
	getActiveGroup : function() {
		return this.getGroup(this.activeIndex)
	},
	showGroup : function(t) {
		t = this.getGroup(t), t && 1 != t.visible && (t.visible = !0, this.doUpdate())
	},
	hideGroup : function(t) {
		t = this.getGroup(t), t && 0 != t.visible && (t.visible = !1, this.doUpdate())
	},
	toggleGroup : function(t) {
		t = this.getGroup(t), t && (this._allowLayout = !1, t.expanded ? this.collapseGroup(t) : this.expandGroup(t), this._allowLayout = !0, this.doLayout())
	},
	collapseGroup : function(t) {
		if (t = this.getGroup(t)) {
			var e = t.expanded,
				i = 0;
			this.autoCollapse && !this.isAutoHeight() && (i = this._getFillGroupBodyHeight());
			var n = !1;
			t.expanded = !1;
			var s = this.groups.indexOf(t);
			s == this.activeIndex && (this.activeIndex = -1, n = !0);
			var o = this.getGroupBodyEl(t);
			if (this.allowAnim && e) {
				this._inAniming = !0, o.style.display = "block", o.style.height = "auto", this.autoCollapse && !this.isAutoHeight() && (o.style.height = i + "px");
				var l = {
					height : "1px"
				};
				mini.addClass(o, "mini-outlookbar-overflow");
				var r = this,
					a = jQuery(o);
				a.animate(l, 180, function() {
					r._inAniming = !1, mini.removeClass(o, "mini-outlookbar-overflow"), r.doLayout()
				})
			} else this.doLayout();
			var h = {
				group : t,
				index : this.groups.indexOf(t),
				name : t.name
			};
			this.fire("Collapse", h), n && this.fire("activechanged")
		}
	},
	expandGroup : function(t) {
		if (t = this.getGroup(t)) {
			var e = t.expanded;
			if (t.expanded = !0, this.activeIndex = this.groups.indexOf(t), fire = !0, this.autoCollapse)
				for (var i = 0, n = this.groups.length; n > i; i++) {
					var s = this.groups[i];
					s.expanded && s != t && this.collapseGroup(s)
			}
			var o = this.getGroupBodyEl(t);
			if (this.allowAnim && 0 == e) {
				if (this._inAniming = !0, o.style.display = "block", this.autoCollapse && !this.isAutoHeight()) {
					var l = this._getFillGroupBodyHeight();
					o.style.height = l + "px"
				} else
					o.style.height = "auto";
				var r = mini.getHeight(o);
				o.style.height = "1px";
				var a = {
						height : r + "px"
					},
					h = o.style.overflow;
				o.style.overflow = "hidden", mini.addClass(o, "mini-outlookbar-overflow");
				var d = this,
					u = jQuery(o);
				u.animate(a, 180, function() {
					o.style.overflow = h, mini.removeClass(o, "mini-outlookbar-overflow"), d._inAniming = !1, d.doLayout()
				})
			} else this.doLayout();
			var c = {
				group : t,
				index : this.groups.indexOf(t),
				name : t.name
			};
			this.fire("Expand", c), fire && this.fire("activechanged")
		}
	},
	_tryToggleGroup : function(t) {
		t = this.getGroup(t);
		var e = {
			group : t,
			groupIndex : this.groups.indexOf(t),
			groupName : t.name,
			cancel : !1
		};
		t.expanded ? (this.fire("BeforeCollapse", e), 0 == e.cancel && this.collapseGroup(t)) : (this.fire("BeforeExpand", e), 0 == e.cancel && this.expandGroup(t))
	},
	_getGroupByEvent : function(t) {
		var e = mini.findParent(t.target, "mini-outlookbar-group");
		if (!e) return null;
		var i = e.id.split("$"),
			n = i[i.length - 1];
		return this._getGroupById(n)
	},
	__OnClick : function(t) {
		if (!this._inAniming) {
			var e = mini.findParent(t.target, "mini-outlookbar-groupHeader");
			if (e) {
				var i = this._getGroupByEvent(t);
				i && this._tryToggleGroup(i)
			}
		}
	},
	parseGroups : function(t) {
		for (var e = [], i = 0, n = t.length; n > i; i++) {
			var s = t[i],
				o = {};
			e.push(o), o.style = s.style.cssText, mini._ParseString(s, o, [ "name", "title", "cls", "iconCls", "iconStyle", "headerCls", "headerStyle", "bodyCls", "bodyStyle" ]), mini._ParseBool(s, o, [ "visible", "enabled", "showCollapseButton", "expanded" ]), o.bodyParent = s
		}
		return e
	},
	getAttrs : function(t) {
		var e = mini.OutlookBar.superclass.getAttrs.call(this, t);
		mini._ParseString(t, e, [ "onactivechanged", "oncollapse", "onexpand" ]), mini._ParseBool(t, e, [ "autoCollapse", "allowAnim", "expandOnLoad" ]), mini._ParseInt(t, e, [ "activeIndex" ]);
		var i = mini.getChildNodes(t);
		return e.groups = this.parseGroups(i), e
	}
}), mini.regClass(mini.OutlookBar, "outlookbar"), mini.MenuItem = function() {
	mini.MenuItem.superclass.constructor.call(this)
}, mini.extend(mini.MenuItem, mini.Control, {
	text : "",
	iconCls : "",
	iconStyle : "",
	iconPosition : "left",
	showIcon : !0,
	showAllow : !0,
	checked : !1,
	checkOnClick : !1,
	groupName : "",
	_hoverCls : "mini-menuitem-hover",
	_pressedCls : "mini-menuitem-pressed",
	_checkedCls : "mini-menuitem-checked",
	_clearBorder : !1,
	menu : null,
	uiCls : "mini-menuitem",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-menuitem", this.el.innerHTML = '<div class="mini-menuitem-inner"><div class="mini-menuitem-icon"></div><div class="mini-menuitem-text"></div><div class="mini-menuitem-allow"></div></div>', this._innerEl = this.el.firstChild, this._iconEl = this._innerEl.firstChild, this._textEl = this._innerEl.childNodes[1], this.allowEl = this._innerEl.lastChild
	},
	_initEvents : function() {
		mini._BindEvents(function() {
			mini_onOne(this.el, "mouseover", this.__OnMouseOver, this)
		}, this)
	},
	_inputEventsInited : !1,
	_initInputEvents : function() {
		this._inputEventsInited || (this._inputEventsInited = !0, mini_onOne(this.el, "click", this.__OnClick, this), mini_onOne(this.el, "mouseup", this.__OnMouseUp, this), mini_onOne(this.el, "mouseout", this.__OnMouseOut, this))
	},
	destroy : function(t) {
		this.el && (this.el.onmouseover = null), this.menu = this._innerEl = this._iconEl = this._textEl = this.allowEl = null, mini.MenuItem.superclass.destroy.call(this, t)
	},
	within : function(t) {
		return mini.isAncestor(this.el, t.target) ? !0 : this.menu && this.menu.within(t) ? !0 : !1
	},
	_doUpdateIcon : function() {
		var t = this.iconStyle || this.iconCls || this.checkOnClick;
		this._iconEl && (mini.setStyle(this._iconEl, this.iconStyle), mini.addClass(this._iconEl, this.iconCls), this._iconEl.style.display = t ? "block" : "none"), "top" == this.iconPosition ? mini.addClass(this.el, "mini-menuitem-icontop") : mini.removeClass(this.el, "mini-menuitem-icontop")
	},
	doUpdate : function() {
		this._textEl && (this._textEl.innerHTML = this.text), this._doUpdateIcon(), this.checked ? mini.addClass(this.el, this._checkedCls) : mini.removeClass(this.el, this._checkedCls), this.allowEl && (this.menu && this.menu.items.length > 0 ? this.allowEl.style.display = "block" : this.allowEl.style.display = "none")
	},
	setText : function(t) {
		this.text = t, this._textEl && (this._textEl.innerHTML = this.text)
	},
	getText : function() {
		return this.text
	},
	setIconCls : function(t) {
		mini.removeClass(this._iconEl, this.iconCls), this.iconCls = t, this._doUpdateIcon()
	},
	getIconCls : function() {
		return this.iconCls
	},
	setIconStyle : function(t) {
		this.iconStyle = t, this._doUpdateIcon()
	},
	getIconStyle : function() {
		return this.iconStyle
	},
	setIconPosition : function(t) {
		this.iconPosition = t, this._doUpdateIcon()
	},
	getIconPosition : function() {
		return this.iconPosition
	},
	setCheckOnClick : function(t) {
		this.checkOnClick = t, t ? mini.addClass(this.el, "mini-menuitem-showcheck") : mini.removeClass(this.el, "mini-menuitem-showcheck"), this.doUpdate()
	},
	getCheckOnClick : function() {
		return this.checkOnClick
	},
	setChecked : function(t) {
		this.checked != t && (this.checked = t, this.doUpdate(), this.fire("checkedchanged"))
	},
	getChecked : function() {
		return this.checked
	},
	setGroupName : function(t) {
		this.groupName != t && (this.groupName = t)
	},
	getGroupName : function() {
		return this.groupName
	},
	setChildren : function(t) {
		this.setMenu(t)
	},
	setMenu : function(t) {
		mini.isArray(t) && (t = {
			type : "menu",
			items : t
		}), this.menu !== t && (this.menu = mini.getAndCreate(t), this.menu.hide(), this.menu.ownerItem = this, this.doUpdate(), this.menu.on("itemschanged", this.__OnItemsChanged, this))
	},
	getMenu : function() {
		return this.menu
	},
	getMenuItems : function() {
		return this.menu.items
	},
	showMenu : function() {
		if (this.menu && 0 == this.menu.isDisplay()) {
			this.menu.setHideAction("outerclick");
			var t = {
				xAlign : "outright",
				yAlign : "top",
				outXAlign : "outleft",
				popupCls : "mini-menu-popup"
			};
			this.ownerMenu && 0 == this.ownerMenu.vertical && (t.xAlign = "left", t.yAlign = "below", t.outXAlign = null), this.menu.showAtEl(this.el, t)
		}
	},
	hideMenu : function() {
		this.menu && this.menu.hide()
	},
	hide : function() {
		this.hideMenu(), this.setVisible(!1)
	},
	__OnItemsChanged : function(t) {
		this.doUpdate()
	},
	getTopMenu : function() {
		return this.ownerMenu ? this.ownerMenu.ownerItem ? this.ownerMenu.ownerItem.getTopMenu() : this.ownerMenu : null
	},
	__OnClick : function(t) {
		if (!this.isReadOnly()) {
			if (this.checkOnClick)
				if (this.ownerMenu && this.groupName) {
					var e = this.ownerMenu.getGroupItems(this.groupName);
					if (e.length > 0) {
						if (0 == this.checked) {
							for (var i = 0, n = e.length; n > i; i++) {
								var s = e[i];
								s != this && s.setChecked(!1)
							}
							this.setChecked(!0)
						}
					} else this.setChecked(!this.checked)
				} else this.setChecked(!this.checked);
			this.fire("click");
			var o = this.getTopMenu();
			o && o._OnItemClick(this, t)
		}
	},
	__OnMouseUp : function(t) {
		if (!this.isReadOnly() && this.ownerMenu) {
			var e = this;
			setTimeout(function() {
				e.isDisplay() && e.ownerMenu.showItemMenu(e)
			}, 1)
		}
	},
	__OnMouseOver : function(t) {
		this.isReadOnly() || (this._initInputEvents(), mini.addClass(this.el, this._hoverCls), this.el.title = this.text, this._textEl.scrollWidth > this._textEl.clientWidth ? this.el.title = this.text : this.el.title = "", this.ownerMenu && (1 == this.ownerMenu.isVertical() ? this.ownerMenu.showItemMenu(this) : this.ownerMenu.hasShowItemMenu() && this.ownerMenu.showItemMenu(this)))
	},
	__OnMouseOut : function(t) {
		mini.removeClass(this.el, this._hoverCls)
	},
	onClick : function(t, e) {
		this.on("click", t, e)
	},
	onCheckedChanged : function(t, e) {
		this.on("checkedchanged", t, e)
	},
	getAttrs : function(t) {
		var e = mini.MenuItem.superclass.getAttrs.call(this, t);
		return jQuery(t), e.text = t.innerHTML, mini._ParseString(t, e, [ "text", "iconCls", "iconStyle", "iconPosition", "groupName", "onclick", "oncheckedchanged" ]), mini._ParseBool(t, e, [ "checkOnClick", "checked" ]), e
	}
}), mini.regClass(mini.MenuItem, "menuitem"), mini.MenuButton = function() {
	mini.MenuButton.superclass.constructor.call(this)
}, mini.extend(mini.MenuButton, mini.Button, {
	uiCls : "mini-menubutton",
	allowCls : "mini-button-menu",
	setMenu : function(t) {
		if (mini.isArray(t) && (t = {
				type : "menu",
				items : t
			}), "string" == typeof t) {
			var e = mini.byId(t);
			if (!e) return;
			mini.parse(t), t = mini.get(t)
		}
		this.menu !== t && (this.menu = mini.getAndCreate(t), this.menu.setPopupEl(this.el), this.menu.setPopupCls("mini-button-popup"), this.menu.setShowAction("leftclick"), this.menu.setHideAction("outerclick"), this.menu.setXAlign("left"), this.menu.setYAlign("below"), this.menu.hide(), this.menu.owner = this)
	},
	setEnabled : function(t) {
		this.enabled = t, t ? this.removeCls(this._disabledCls) : this.addCls(this._disabledCls), jQuery(this.el).attr("allowPopup", !!t)
	}
}), mini.regClass(mini.MenuButton, "menubutton"), mini.Menu = function() {
	this.items = [], mini.Menu.superclass.constructor.call(this)
}, mini.extend(mini.Menu, mini.Control), mini.copyTo(mini.Menu.prototype, mini.Popup_prototype);
var mini_Popup_prototype_hide = mini.Popup_prototype.hide;
mini.copyTo(mini.Menu.prototype, {
	height : "auto",
	width : "auto",
	minWidth : 140,
	vertical : !0,
	allowSelectItem : !1,
	_selectedItem : null,
	_itemSelectedCls : "mini-menuitem-selected",
	textField : "text",
	resultAsTree : !1,
	idField : "id",
	parentField : "pid",
	itemsField : "children",
	showNavArrow : !0,
	_clearBorder : !1,
	showAction : "none",
	hideAction : "outerclick",
	getbyName : function(t) {
		for (var e = 0, i = this.items.length; i > e; e++) {
			var n = this.items[e];
			if (n.name == t) return n;
			if (n.menu) {
				var s = n.menu.getbyName(t);
				if (s) return s
			}
		}
		return null
	},
	set : function(t) {
		if ("string" == typeof t) return this;
		var e = t.url;
		return delete t.url
			, mini.Menu.superclass.set.call(this, t), e && this.setUrl(e), this
	},
	uiCls : "mini-menu",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-menu", this.el.innerHTML = '<div class="mini-menu-border"><a class="mini-menu-topArrow" href="#" onclick="return false"></a><div class="mini-menu-inner"></div><a class="mini-menu-bottomArrow" href="#" onclick="return false"></a></div>', this._borderEl = this.el.firstChild, this._topArrowEl = this._borderEl.childNodes[0], this._bottomArrowEl = this._borderEl.childNodes[2], this._innerEl = this._borderEl.childNodes[1], this._innerEl.innerHTML = '<div class="mini-menu-float"></div><div class="mini-menu-toolbar"></div><div style="clear:both;"></div>', this._contentEl = this._innerEl.firstChild, this._toolbarEl = this._innerEl.childNodes[1], 0 == this.isVertical() && mini.addClass(this.el, "mini-menu-horizontal")
	},
	destroy : function(t) {
		this._topArrowEl && (this._topArrowEl.onmousedown = this._bottomArrowEl.onmousedown = null), this._popupEl = this.popupEl = this._borderEl = this._innerEl = this._contentEl = null, this._topArrowEl = this._bottomArrowEl = null, this.owner = null, mini.un(document, "mousedown", this.__OnBodyMouseDown, this), mini.un(window, "resize", this.__OnWindowResize, this), this.el.onmouseover = null, this.el.oncontextmenu = null, mini.Menu.superclass.destroy.call(this, t)
	},
	_disableContextMenu : !1,
	_initEvents : function() {
		mini._BindEvents(function() {
			mini.on(document, "mousedown", this.__OnBodyMouseDown, this), mini_onOne(this.el, "mouseover", this.__OnMouseOver, this), mini.on(window, "resize", this.__OnWindowResize, this), this._disableContextMenu && mini_onOne(this.el, "contextmenu", function(t) {
				t.preventDefault()
			}, this), mini_onOne(this._topArrowEl, "mousedown", this.__OnTopMouseDown, this), mini_onOne(this._bottomArrowEl, "mousedown", this.__OnBottomMouseDown, this)
		}, this)
	},
	within : function(t) {
		if (mini.isAncestor(this.el, t.target)) return !0;
		for (var e = 0, i = this.items.length; i > e; e++) {
			var n = this.items[e];
			if (n.within(t)) return !0
		}
		return !1
	},
	setVertical : function(t) {
		this.vertical = t, t ? mini.removeClass(this.el, "mini-menu-horizontal") : mini.addClass(this.el, "mini-menu-horizontal")
	},
	getVertical : function() {
		return this.vertical
	},
	isVertical : function() {
		return this.vertical
	},
	show : function() {
		this.setVisible(!0)
	},
	hide : function() {
		this.hideItems(), mini_Popup_prototype_hide.call(this)
	},
	hideItems : function() {
		for (var t = 0, e = this.items.length; e > t; t++) {
			var i = this.items[t];
			i.hideMenu()
		}
	},
	showItemMenu : function(t) {
		for (var e = 0, i = this.items.length; i > e; e++) {
			var n = this.items[e];
			n == t ? n.showMenu() : n.hideMenu()
		}
	},
	hasShowItemMenu : function() {
		for (var t = 0, e = this.items.length; e > t; t++) {
			var i = this.items[t];
			if (i && i.menu && i.menu.isPopup) return !0
		}
		return !1
	},
	showAllItems : function(t) {
		function e(t) {
			for (var i = 0; i < t.length; i++) {
				var n = t[i];
				if (n.show(), n.enable(), n.menu && n.menu.items) {
					var s = n.menu.items;
					e(s)
				}
			}
		}
		var i;
		t ? (t.show(), t.enable(), i = t.getMenuItems()) : i = this.getItems(), e(i)
	},
	hideAllItems : function(t) {
		function e(t) {
			for (var i = 0; i < t.length; i++) {
				var n = t[i];
				if (n.hide(), n.menu && n.menu.items) {
					var s = n.menu.items;
					e(s)
				}
			}
		}
		var i;
		t ? (t.hide(), i = t.getMenuItems()) : i = this.getItems(), e(i)
	},
	setData : function(t) {
		mini.isArray(t) || (t = []), this.setItems(t)
	},
	getData : function() {
		return this.getItems()
	},
	setItems : function(t) {
		mini.isArray(t) || (t = []), this.removeAll();
		for (var e = (new Date, 0), i = t.length; i > e; e++) this.addItem(t[e])
	},
	getItems : function() {
		return this.items
	},
	addItem : function(t) {
		return "-" == t || "|" == t || "separator" == t.type ? void mini.append(this._contentEl, '<span class="mini-separator"></span>') : (mini.isControl(t) || mini.getClass(t.type) || (t.type = "menuitem"), t = mini.getAndCreate(t), this.items.push(t), this._contentEl.appendChild(t.el), t.ownerMenu = this, void this.fire("itemschanged"))
	},
	removeItem : function(t) {
		t = mini.get(t), t && (this.items.remove(t), this._contentEl.removeChild(t.el), this.fire("itemschanged"))
	},
	removeItemAt : function(t) {
		var e = this.items[t];
		this.removeItem(e)
	},
	removeAll : function() {
		for (var t = this.items.clone(), e = t.length - 1; e >= 0; e--) this.removeItem(t[e]);
		this._contentEl.innerHTML = ""
	},
	getGroupItems : function(t) {
		if (!t) return [];
		for (var e = [], i = 0, n = this.items.length; n > i; i++) {
			var s = this.items[i];
			s.groupName == t && e.push(s)
		}
		return e
	},
	getItem : function(t) {
		if ("number" == typeof t) return this.items[t];
		if ("string" == typeof t) {
			for (var e = 0, i = this.items.length; i > e; e++) {
				var n = this.items[e];
				if (n.id == t) return n
			}
			return null
		}
		return t && -1 != this.items.indexOf(t) ? t : null
	},
	setAllowSelectItem : function(t) {
		this.allowSelectItem = t
	},
	getAllowSelectItem : function() {
		return this.allowSelectItem
	},
	setSelectedItem : function(t) {
		t = this.getItem(t), this._OnItemSelect(t)
	},
	getSelectedItem : function(t) {
		return this._selectedItem
	},
	setShowNavArrow : function(t) {
		this.showNavArrow = t
	},
	getShowNavArrow : function() {
		return this.showNavArrow
	},
	setTextField : function(t) {
		this.textField = t
	},
	getTextField : function() {
		return this.textField
	},
	setResultAsTree : function(t) {
		this.resultAsTree = t
	},
	getResultAsTree : function() {
		return this.resultAsTree
	},
	setIdField : function(t) {
		this.idField = t
	},
	getIdField : function() {
		return this.idField
	},
	setParentField : function(t) {
		this.parentField = t
	},
	getParentField : function() {
		return this.parentField
	},
	doLayout : function() {
		if (this.canLayout())
			if (this.isAutoHeight()) this._borderEl.style.height = "auto", this._contentEl.style.height = "auto";else {
				var t = mini.getHeight(this.el, !0);
				if (mini.setHeight(this._borderEl, t), this._topArrowEl.style.display = this._bottomArrowEl.style.display = "none", this._contentEl.style.height = "auto", this.showNavArrow && this._borderEl.scrollHeight > this._borderEl.clientHeight) {
					this._topArrowEl.style.display = this._bottomArrowEl.style.display = "block", t = mini.getHeight(this._borderEl, !0);
					var e = mini.getHeight(this._topArrowEl),
						i = mini.getHeight(this._bottomArrowEl),
						n = t - e - i;
					0 > n && (n = 0), mini.setHeight(this._contentEl, n)
				} else
					this._contentEl.style.height = "auto"
		}
	},
	_measureSize : function() {
		if ("auto" == this.height) {
			this.el.style.height = "auto", this._borderEl.style.height = "auto", this._contentEl.style.height = "auto", this._topArrowEl.style.display = this._bottomArrowEl.style.display = "none";
			var t = mini.getViewportBox(),
				e = mini.getBox(this.el);
			if (this.maxHeight = t.height - 25, this.ownerItem) {
				var e = mini.getBox(this.ownerItem.el),
					i = e.top,
					n = t.height - e.bottom,
					s = i > n ? i : n;
				s -= 10, this.maxHeight = s
			}
		}
		this.el.style.display = "";
		var e = mini.getBox(this.el);
		e.width > this.maxWidth && (mini.setWidth(this.el, this.maxWidth), e = mini.getBox(this.el)), e.height > this.maxHeight && (mini.setHeight(this.el, this.maxHeight), e = mini.getBox(this.el)), e.width < this.minWidth && (mini.setWidth(this.el, this.minWidth), e = mini.getBox(this.el)), e.height < this.minHeight && (mini.setHeight(this.el, this.minHeight), e = mini.getBox(this.el))
	},
	url : "",
	_doLoad : function() {
		var t = mini.getData(this.url);
		this.dataField && (t = mini._getMap(this.dataField, t)), t || (t = []), 0 == this.resultAsTree && (t = mini.arrayToTree(t, this.itemsField, this.idField, this.parentField));
		for (var e = mini.treeToArray(t, this.itemsField, this.idField, this.parentField), i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			s.text = mini._getMap(this.textField, s), mini.isNull(s.text) && (s.text = "")
		}
		new Date, this.setItems(t), this.fire("load")
	},
	loadList : function(t, e, i) {
		if (t) {
			e = e || this.idField, i = i || this.parentField;
			for (var n = 0, s = t.length; s > n; n++) {
				var o = t[n];
				o.text = mini._getMap(this.textField, o), mini.isNull(o.text) && (o.text = "")
			}
			var l = mini.arrayToTree(t, this.itemsField, e, i);
			this.load(l)
		}
	},
	load : function(t) {
		"string" == typeof t ? this.setUrl(t) : this.setItems(t)
	},
	setUrl : function(t) {
		this.url = this.parseUrl(t), this._doLoad()
	},
	getUrl : function() {
		return this.url
	},
	hideOnClick : !0,
	setHideOnClick : function(t) {
		this.hideOnClick = t
	},
	getHideOnClick : function() {
		return this.hideOnClick
	},
	_OnItemClick : function(t, e) {
		var i = {
			item : t,
			isLeaf : !t.menu,
			htmlEvent : e
		};
		this.hideOnClick && (this.isPopup ? this.hide() : this.hideItems()), this.allowSelectItem && this._selectedItem != t && this.setSelectedItem(t), this.fire("itemclick", i), this.ownerItem
	},
	_OnItemSelect : function(t) {
		this._selectedItem && this._selectedItem.removeCls(this._itemSelectedCls), this._selectedItem = t, this._selectedItem && this._selectedItem.addCls(this._itemSelectedCls);
		var e = {
			item : this._selectedItem
		};
		this.fire("itemselect", e)
	},
	onItemClick : function(t, e) {
		this.on("itemclick", t, e)
	},
	onItemSelect : function(t, e) {
		this.on("itemselect", t, e)
	},
	__OnTopMouseDown : function(t) {
		this._startScrollMove(-20)
	},
	__OnBottomMouseDown : function(t) {
		this._startScrollMove(20)
	},
	_startScrollMove : function(t) {
		clearInterval(this._scrollTimer);
		var e = function() {
			clearInterval(i._scrollTimer), mini.un(document, "mouseup", e)
		};
		mini.on(document, "mouseup", e);
		var i = this;
		this._scrollTimer = setInterval(function() {
			i._contentEl.scrollTop += t
		}, 50)
	},
	setToolbar : function(t) {
		__mini_setControls(t, this._toolbarEl, this)
	},
	parseItems : function(t) {
		for (var e = [], i = 0, n = t.length; n > i; i++) {
			var s = t[i];
			if ("separator" != s.className) {
				var o = mini.getChildNodes(s),
					l = o[0],
					r = o[1],
					a = new mini.MenuItem;
				if (r) {
					mini.applyTo.call(a, l), a.render(document.body);
					var h = new mini.Menu;
					mini.applyTo.call(h, r), a.setMenu(h), h.render(document.body), e.add(a)
				} else mini.applyTo.call(a, s), e.add(a)
			} else e.add("-")
		}
		return e.clone()
	},
	getAttrs : function(t) {
		var e = mini.Menu.superclass.getAttrs.call(this, t),
			i = jQuery(t);
		mini._ParseString(t, e, [ "popupEl", "popupCls", "showAction", "hideAction", "xAlign", "yAlign", "modalStyle", "onbeforeopen", "open", "onbeforeclose", "onclose", "url", "onitemclick", "onitemselect", "textField", "idField", "parentField" ]), mini._ParseBool(t, e, [ "resultAsTree", "hideOnClick", "showNavArrow" ]);
		for (var n = mini.getChildNodes(t), s = n.length - 1; s >= 0; s--) {
			var o = n[s],
				l = jQuery(o).attr("property");
			l && (l = l.toLowerCase(), "toolbar" == l && (e.toolbar = o, o.parentNode.removeChild(o)))
		}
		var n = mini.getChildNodes(t),
			r = this.parseItems(n);
		r.length > 0 && (e.items = r);
		var a = i.attr("vertical");
		a && (e.vertical = "true" == a ? !0 : !1);
		var h = i.attr("allowSelectItem");
		return h && (e.allowSelectItem = "true" == h ? !0 : !1), e
	}
}), mini.regClass(mini.Menu, "menu"), mini.MenuBar = function() {
	mini.MenuBar.superclass.constructor.call(this)
}, mini.extend(mini.MenuBar, mini.Menu, {
	uiCls : "mini-menubar",
	vertical : !1,
	setVertical : function(t) {
		this.vertical = !1
	}
}), mini.regClass(mini.MenuBar, "menubar"), mini.OutlookMenu = function() {
	mini.OutlookMenu.superclass.constructor.call(this), this.data = []
}, mini.extend(mini.OutlookMenu, mini.OutlookBar, {
	url : "",
	textField : "text",
	iconField : "iconCls",
	urlField : "url",
	resultAsTree : !1,
	itemsField : "children",
	idField : "id",
	parentField : "pid",
	style : "width:100%;height:100%;",
	set : function(t) {
		if ("string" == typeof t) return this;
		var e = t.url;
		delete t.url;
		var i = t.activeIndex;
		return delete t.activeIndex
			, mini.OutlookMenu.superclass.set.call(this, t), e && this.setUrl(e), mini.isNumber(i) && this.setActiveIndex(i), this
	},
	uiCls : "mini-outlookmenu",
	destroy : function(t) {
		if (this._menus) {
			for (var e = this._menus.clone(), i = 0, n = e.length; n > i; i++) {
				var s = e[i];
				s.destroy()
			}
			this._menus.length = 0
		}
		mini.OutlookMenu.superclass.destroy.call(this, t)
	},
	_doParseFields : function(t) {
		for (var e = 0, i = t.length; i > e; e++) {
			var n = t[e];
			n.text = n[this.textField], n.url = n[this.urlField], n.iconCls = n[this.iconField]
		}
	},
	_doLoad : function() {
		var t = [];
		try {
			t = mini.getData(this.url)
		} catch (e) {
			1 == mini_debugger && alert("outlooktree json is error.")
		}
		this.dataField && (t = mini._getMap(this.dataField, t)), t || (t = []), 0 == this.resultAsTree && (t = mini.arrayToTree(t, this.itemsField, this.idField, this.parentField));
		var i = mini.treeToArray(t, this.itemsField, this.idField, this.parentField);
		this._doParseFields(i), this.createNavBarMenu(t), this.fire("load")
	},
	loadList : function(t, e, i) {
		e = e || this.idField, i = i || this.parentField, this._doParseFields(t);
		var n = mini.arrayToTree(t, this.nodesField, e, i);
		this.load(n)
	},
	load : function(t) {
		if ("string" == typeof t) this.setUrl(t);else {
			0 == this.resultAsTree && (t = mini.arrayToTree(t, this.itemsField, this.idField, this.parentField));
			var e = mini.treeToArray(t, this.itemsField, this.idField, this.parentField);
			this._doParseFields(e), this.createNavBarMenu(t)
		}
	},
	setData : function(t) {
		this.load(t)
	},
	setUrl : function(t) {
		this.url = this.parseUrl(t), this._doLoad()
	},
	getUrl : function() {
		return this.url
	},
	setTextField : function(t) {
		this.textField = t
	},
	getTextField : function() {
		return this.textField
	},
	setIconField : function(t) {
		this.iconField = t
	},
	getIconField : function() {
		return this.iconField
	},
	setUrlField : function(t) {
		this.urlField = t
	},
	getUrlField : function() {
		return this.urlField
	},
	setResultAsTree : function(t) {
		this.resultAsTree = t
	},
	getResultAsTree : function() {
		return this.resultAsTree
	},
	setNodesField : function(t) {
		this.nodesField = t
	},
	getNodesField : function() {
		return this.nodesField
	},
	setIdField : function(t) {
		this.idField = t
	},
	getIdField : function() {
		return this.idField
	},
	setParentField : function(t) {
		this.parentField = t
	},
	getParentField : function() {
		return this.parentField
	},
	_selected : null,
	getSelected : function() {
		return this._selected
	},
	selectNode : function(t) {
		if (t = this.getNode(t)) {
			var e = this._getOwnerMenu(t);
			e && (this.expandGroup(e._ownerGroup), setTimeout(function() {
				try {
					e.setSelectedItem(t)
				} catch (i) {}
			}, 100))
		}
	},
	findNodes : function(t, e) {
		var i = [];
		e = e || this;
		for (var n = 0, s = this._menus.length; s > n; n++) {
			for (var o = this._menus[n].getItems(), l = [], r = 0, a = o.length; a > r; r++) {
				var h = o[r];
				t && t.call(e, h) === !0 && l.push(h)
			}
			i.addRange(l)
		}
		return i
	},
	getNode : function(t) {
		for (var e = 0, i = this._menus.length; i > e; e++) {
			var n = this._menus[e],
				s = n.getItem(t);
			if (s) return s
		}
		return null
	},
	getList : function() {
		for (var t = [], e = 0, i = this._menus.length; i > e; e++) {
			var n = this._menus[e],
				s = n.getItems();
			t.addRange(s)
		}
		return t
	},
	_getOwnerMenu : function(t) {
		if (t)
			for (var e = 0, i = this._menus.length; i > e; e++) {
				var n = this._menus[e],
					s = n.getItem(t);
				if (s) return n
		}
	},
	getAttrs : function(t) {
		var e = mini.OutlookMenu.superclass.getAttrs.call(this, t);
		return e.text = t.innerHTML, mini._ParseString(t, e, [ "url", "textField", "urlField", "idField", "parentField", "itemsField", "iconField", "onitemclick", "onitemselect" ]), mini._ParseBool(t, e, [ "resultAsTree" ]), e
	},
	autoCollapse : !0,
	activeIndex : 0,
	createNavBarMenu : function(t) {
		mini.isArray(t) || (t = []), this.data = t;
		for (var e = [], i = 0, n = this.data.length; n > i; i++) {
			var s = this.data[i],
				o = {};
			o.title = s.text, o.iconCls = s.iconCls, e.push(o), o._children = s[this.itemsField]
		}
		this.setGroups(e), this.getExpandOnLoad() && this.setActiveIndex(this.activeIndex), this._menus = [];
		for (var i = 0, n = this.groups.length; n > i; i++) {
			var o = this.groups[i],
				l = this.getGroupBodyEl(o),
				r = new mini.Menu;
			r._ownerGroup = o, r.set({
				showNavArrow : !1,
				style : "width:100%;height:100%;border:0;background:none",
				borderStyle : "border:0",
				allowSelectItem : !0,
				items : o._children
			}), r.render(l), r.on("itemclick", this.__OnItemClick, this), r.on("itemselect", this.__OnItemSelect, this), this._menus.push(r),
			delete o._children
		}
	},
	__OnItemClick : function(t) {
		var e = {
			item : t.item,
			htmlEvent : t.htmlEvent
		};
		this.fire("itemclick", e)
	},
	__OnItemSelect : function(t) {
		if (t.item) {
			for (var e = 0, i = this._menus.length; i > e; e++) {
				var n = this._menus[e];
				n != t.sender && n.setSelectedItem(null)
			}
			var s = {
				item : t.item,
				htmlEvent : t.htmlEvent
			};
			this._selected = t.item, this.fire("itemselect", s)
		}
	}
}), mini.regClass(mini.OutlookMenu, "outlookmenu"), mini.ContextMenu = function() {
	mini.ContextMenu.superclass.constructor.call(this)
}, mini.extend(mini.ContextMenu, mini.Menu, {
	uiCls : "mini-contextmenu",
	vertical : !0,
	visible : !1,
	_disableContextMenu : !0,
	setVertical : function(t) {
		this.vertical = !0
	}
}), mini.regClass(mini.ContextMenu, "contextmenu"), mini.DataBinding = function() {
	this._bindFields = [], this._bindForms = [], mini.DataBinding.superclass.constructor.call(this)
}, mini.extend(mini.DataBinding, mini.Component, {
	bindField : function(t, e, i, n, s) {
		if (t = mini.get(t), e = mini.get(e), t && e && i) {
			var o = {
				control : t,
				source : e,
				field : i,
				convert : s,
				mode : n
			};
			this._bindFields.push(o), e.on("currentchanged", this.__OnCurrentChanged, this), t.on("valuechanged", this.__OnValueChanged, this)
		}
	},
	bindForm : function(t, e, i, n) {
		if (t = mini.byId(t), e = mini.get(e), t && e)
			for (var t = new mini.Form(t), s = t.getFields(), o = 0, l = s.length; l > o; o++) {
				var r = s[o];
				this.bindField(r, e, r.getName(), i, n)
		}
	},
	__OnCurrentChanged : function(t) {
		if (!this._doSetting) {
			this._doSetting = !0;
			for (var e = t.sender, i = t.record, n = 0, s = this._bindFields.length; s > n; n++) {
				var o = this._bindFields[n];
				if (o.source == e) {
					var l = o.control,
						r = o.field;
					if (l.setValue)
						if (i) {
							var a = i[r];
							l.setValue(a)
						} else l.setValue("");
					l.setText && l.textName && (i ? l.setText(i[l.textName]) : l.setText(""))
				}
			}
			var h = this;
			setTimeout(function() {
				h._doSetting = !1
			}, 10)
		}
	},
	__OnValueChanged : function(t) {
		if (!this._doSetting) {
			this._doSetting = !0;
			for (var e = t.sender, i = e.getValue(), n = 0, s = this._bindFields.length; s > n; n++) {
				var o = this._bindFields[n];
				if (o.control == e && o.mode !== !1) {
					var l = o.source,
						r = l.getCurrent();
					if (r) {
						var a = {};
						a[o.field] = i, e.getText && e.textName && (a[e.textName] = e.getText()), l.updateRow(r, a)
					}
				}
			}
			var h = this;
			setTimeout(function() {
				h._doSetting = !1
			}, 10)
		}
	}
}), mini.regClass(mini.DataBinding, "databinding"), mini.MessageBox = {
	alertTitle : "提醒",
	confirmTitle : "确认",
	prompTitle : "输入",
	prompMessage : "请输入内容：",
	buttonText : {
		ok : "确定",
		cancel : "取消",
		yes : "是",
		no : "否"
	},
	show : function(t) {
		t = mini.copyTo({
			width : "auto",
			height : "auto",
			showModal : !0,
			minWidth : 150,
			maxWidth : 800,
			minHeight : 100,
			maxHeight : 350,
			showHeader : !0,
			title : "",
			titleIcon : "",
			iconCls : "",
			iconStyle : "",
			message : "",
			html : "",
			spaceStyle : "margin-right:15px",
			showCloseButton : !0,
			buttons : null,
			buttonWidth : 58,
			callback : null
		}, t);
		var e = t.callback,
			i = new mini.Window;
		i.setShowModal(t.showModal), i.setShowFooter(!0), i.setTitle(t.title || ""), i.setIconCls(t.titleIcon), i.setShowHeader(t.showHeader), i.setCls("mini-messagebox"), i.setShowCloseButton(t.showCloseButton);
		var n = i.uid + "$table",
			s = i.uid + "$content",
			o = '<div class="' + t.iconCls + '" style="' + t.iconStyle + '"></div>',
			l = '<table class="mini-messagebox-table" id="' + n + '" style="" cellspacing="0" cellpadding="0"><tr><td>' + o + '</td><td id="' + s + '" class="mini-messagebox-content-text">' + (t.message || "") + "</td></tr></table>",
			r = '<div class="mini-messagebox-content"></div>';
		i._bodyEl.innerHTML = r, i._footerEl.innerHTML = '<div class="mini-messagebox-buttons"></div>';
		var a = i._bodyEl.firstChild;
		t.html ? "string" == typeof t.html ? a.innerHTML = t.html : mini.isElement(t.html) && a.appendChild(t.html) : a.innerHTML = l, i._Buttons = [];
		var h = i._footerEl.firstChild;
		if (t.buttons && t.buttons.length > 0)
			for (var d = 0, u = t.buttons.length; u > d; d++) {
				var c = t.buttons[d],
					m = mini.MessageBox.buttonText[c];
				m || (m = c);var p = new mini.Button;
				p.setText(m), p.setWidth(t.buttonWidth), p.render(h), p.action = c, p.on("click", function(t) {
					var n = t.sender;
					e && e(n.action), mini && mini.MessageBox.hide(i)
				}), d != u - 1 && p.setStyle(t.spaceStyle), i._Buttons.push(p)
		}
		else
			h.style.display = "none";
		i.setMinWidth(t.minWidth), i.setMinHeight(t.minHeight), i.setMaxWidth(t.maxWidth), i.setMaxHeight(t.maxHeight), i.setWidth(t.width), i.setHeight(t.height), i.show();
		var f = i.getWidth();
		i.setWidth(f);
		var g = i.getHeight();
		i.setHeight(g);
		var _ = document.getElementById(n);
		_ && (_.style.width = "100%");
		var v = document.getElementById(s);
		v && (v.style.width = "100%");
		var y = i._Buttons[0];
		return y ? setTimeout(function() {
				y.focus()
			}, 100) : i.focus(), i.on("beforebuttonclick", function(t) {
				e && e("close"), t.cancel = !0, mini.MessageBox.hide(i)
			}), mini.on(i.el, "keydown", function(t) {
				27 == t.keyCode && (e && e("close"), t.cancel = !0, mini.MessageBox.hide(i))
			}), i.uid
	},
	hide : function(t) {
		if (t) {
			var e = "object" == typeof t ? t : mini.getbyUID(t);
			if (e) {
				for (var i = 0, n = e._Buttons.length; n > i; i++) {
					var s = e._Buttons[i];
					s.destroy()
				}
				e._Buttons = null, e.destroy()
			}
		}
	},
	alert : function(t, e, i) {
		return mini.MessageBox.show({
			maxWidth : 400,
			minWidth : 250,
			title : e || mini.MessageBox.alertTitle,
			buttons : [ "ok" ],
			message : t,
			iconCls : "mini-messagebox-warning",
			callback : i
		})
	},
	confirm : function(t, e, i) {
		return mini.MessageBox.show({
			maxWidth : 400,
			minWidth : 250,
			title : e || mini.MessageBox.confirmTitle,
			buttons : [ "ok", "cancel" ],
			message : t,
			iconCls : "mini-messagebox-question",
			callback : i
		})
	},
	prompt : function(t, e, i, n) {
		var s,
			o,
			l = ("prompt$" + (new Date).getTime(), t || mini.MessageBox.promptMessage);
		jQuery("<div></div>"), n ? (s = new mini.TextArea, s.setWidth("230"), s.setHeight("70"), o = "190") : (s = new mini.TextBox, s.setWidth("230"), o = "140", l += "<br/>");
		var r = mini.MessageBox.show({
			title : e || mini.MessageBox.promptTitle,
			buttons : [ "ok", "cancel" ],
			width : 280,
			height : o,
			html : '<div id="pzf" style="overflow:auto;padding:5px;padding-left:10px;">' + l + "</div>",
			callback : function(t) {
				i && i(t, s.getValue())
			}
		});
		return s.render(jQuery("#pzf")[0]), s.focus(), r
	},
	loading : function(t, e) {
		return mini.MessageBox.show({
			maxWidth : 400,
			minHeight : 50,
			title : e,
			showCloseButton : !1,
			message : t,
			iconCls : "mini-messagebox-waiting"
		})
	},
	showTips : function(t) {
		var e = jQuery;
		t = e.extend({
			content : "",
			state : "",
			x : "center",
			y : "top",
			offset : [ 10, 10 ],
			fixed : !0,
			timeout : 2e3
		}, t);
		var i = "mini-tips-" + t.state,
			n = '<div class="mini-tips ' + i + '">' + t.content + "</div>",
			s = e(n).appendTo(document.body);
		t.el = s[0], t.timeoutHandler = function() {
			s.slideUp(), setTimeout(function() {
				s.remove()
			}, 2e3)
		}, mini.showAt(t), s.hide().slideDown()
	}
}, mini.alert = mini.MessageBox.alert, mini.confirm = mini.MessageBox.confirm, mini.prompt = mini.MessageBox.prompt, mini.loading = mini.MessageBox.loading, mini.showMessageBox = mini.MessageBox.show, mini.hideMessageBox = mini.MessageBox.hide, mini.showTips = mini.MessageBox.showTips, mini.NavBar = function() {
	mini.NavBar.superclass.constructor.call(this)
}, mini.extend(mini.NavBar, mini.OutlookBar, {
	uiCls : "mini-navbar"
}), mini.regClass(mini.NavBar, "navbar"), mini.NavBarMenu = function() {
	mini.NavBarMenu.superclass.constructor.call(this)
}, mini.extend(mini.NavBarMenu, mini.OutlookMenu, {
	uiCls : "mini-navbarmenu"
}), mini.regClass(mini.NavBarMenu, "navbarmenu"), mini.Panel = function() {
	this._initButtons(), mini.Panel.superclass.constructor.call(this), this.url && this.setUrl(this.url), this._contentEl = this._bodyEl, this._doVisibleEls(), this._Resizer = new mini._Resizer(this), this._doTools()
}, mini.extend(mini.Panel, mini.Container, {
	width : 250,
	title : "",
	iconCls : "",
	iconStyle : "",
	allowResize : !1,
	url : "",
	refreshOnExpand : !1,
	maskOnLoad : !0,
	showCollapseButton : !1,
	showCloseButton : !1,
	closeAction : "display",
	showHeader : !0,
	showToolbar : !1,
	showFooter : !1,
	headerCls : "",
	headerStyle : "",
	bodyCls : "",
	bodyStyle : "",
	footerCls : "",
	footerStyle : "",
	toolbarCls : "",
	toolbarStyle : "",
	minWidth : 180,
	minHeight : 100,
	maxWidth : 5e3,
	maxHeight : 3e3,
	set : function(t) {
		if ("string" == typeof t) return this;
		var e = this._allowLayout;
		this._allowLayout = !1;
		var i = t.toolbar;
		delete t.toolbar;
		var n = t.footer;
		delete t.footer;
		var s = t.url;
		return delete t.url
			, mini.Panel.superclass.set.call(this, t), i && this.setToolbar(i), n && this.setFooter(n), s && this.setUrl(s), this._allowLayout = e, this.doLayout(), this
	},
	uiCls : "mini-panel",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-panel";
		var t = '<div class="mini-panel-border"><div class="mini-panel-header" ><div class="mini-panel-header-inner" ><span class="mini-panel-icon"></span><div class="mini-panel-title" ></div><div class="mini-tools" ></div></div></div><div class="mini-panel-viewport"><div class="mini-panel-toolbar"></div><div class="mini-panel-body" ></div><div class="mini-panel-footer"></div><div class="mini-resizer-trigger"></div></div></div>';
		this.el.innerHTML = t, this._borderEl = this.el.firstChild, this._headerEl = this._borderEl.firstChild, this._viewportEl = this._borderEl.lastChild, this._toolbarEl = mini.byClass("mini-panel-toolbar", this.el), this._bodyEl = mini.byClass("mini-panel-body", this.el), this._footerEl = mini.byClass("mini-panel-footer", this.el), this._resizeGridEl = mini.byClass("mini-resizer-trigger", this.el), mini.byClass("mini-panel-header-inner", this.el), this._iconEl = mini.byClass("mini-panel-icon", this.el), this._titleEl = mini.byClass("mini-panel-title", this.el), this._toolsEl = mini.byClass("mini-tools", this.el), mini.setStyle(this._bodyEl, this.bodyStyle), this._doTitle()
	},
	destroy : function(t) {
		this._doRemoveIFrame(), this._iframeEl = null, this._headerEl && (mini.clearEvent(this._headerEl), this._borderEl.removeChild(this._headerEl), this._headerEl = null), this._viewportEl && (mini.clearEvent(this._viewportEl), this._borderEl.removeChild(this._viewportEl), this._viewportEl = null), this._borderEl && (mini.clearEvent(this._borderEl), this.el.removeChild(this._borderEl), this._borderEl = null), this._toolbarEl && ($(this._toolbarEl).remove(), this._toolbarEl = null), this._bodyEl && ($(this._bodyEl).remove(), this._bodyEl = null), this._footerEl && ($(this._footerEl).remove(), this._footerEl = null), this._resizeGridEl && ($(this._resizeGridEl).remove(), this._resizeGridEl = null), this._iconEl && ($(this._iconEl).remove(), this._iconEl = null), this._titleEl && ($(this._titleEl).remove(), this._titleEl = null), this._toolsEl && ($(this._toolsEl).remove(), this._toolsEl = null), mini.Panel.superclass.destroy.call(this, t)
	},
	_initEvents : function() {
		mini._BindEvents(function() {
			mini.on(this.el, "click", this.__OnClick, this)
		}, this)
	},
	_doVisibleEls : function() {
		this._headerEl.style.display = this.showHeader ? "" : "none", this._toolbarEl.style.display = this.showToolbar ? "" : "none", this._footerEl.style.display = this.showFooter ? "" : "none"
	},
	doLayout : function() {
		if (this.canLayout()) {
			this._resizeGridEl.style.display = this.allowResize ? "" : "none";
			var t = this.isAutoHeight();
			if (this.isAutoWidth(), mini.getWidth(this._viewportEl, !0), t) this._viewportEl.style.height = "auto", this._bodyEl.style.height = "auto";else {
				var e = this.getViewportHeight();
				mini.setHeight(this._viewportEl, e);
				var i = this.getBodyHeight(!0);
				mini.setHeight(this._bodyEl, i)
			}
			mini.layout(this._borderEl), this.fire("layout")
		}
	},
	deferLayout : function(t) {
		if (t || (t = 10), !this._layoutTimer) {
			var e = this;
			this._layoutTimer = setTimeout(function() {
				e._layoutTimer = null, e.doLayout()
			}, t)
		}
	},
	_stopLayout : function() {
		clearTimeout(this._layoutTimer), this._layoutTimer = null
	},
	getViewportWidth : function(t) {
		return mini.getWidth(this._viewportEl, t)
	},
	getViewportHeight : function(t) {
		var e = this.getHeight(!0) - this.getHeaderHeight();
		if (t) {
			var i = mini.getPaddings(this._viewportEl),
				n = mini.getBorders(this._viewportEl),
				s = mini.getMargins(this._viewportEl);
			jQuery.boxModel && (e = e - i.top - i.bottom - n.top - n.bottom), e = e - s.top - s.bottom
		}
		return e
	},
	getBodyHeight : function(t) {
		var e = this.getViewportHeight(),
			e = e - this.getToolbarHeight() - this.getFooterHeight();
		if (t) {
			var i = mini.getPaddings(this._viewportEl),
				n = mini.getBorders(this._viewportEl),
				s = mini.getMargins(this._viewportEl);
			jQuery.boxModel && (e = e - i.top - i.bottom - n.top - n.bottom), e = e - s.top - s.bottom
		}
		return 0 > e && (e = 0), e
	},
	getHeaderHeight : function() {
		var t = this.showHeader ? jQuery(this._headerEl).outerHeight() : 0;
		return t
	},
	getToolbarHeight : function() {
		var t = this.showToolbar ? jQuery(this._toolbarEl).outerHeight() : 0;
		return t
	},
	getFooterHeight : function() {
		var t = this.showFooter ? jQuery(this._footerEl).outerHeight() : 0;
		return t
	},
	setHeaderStyle : function(t) {
		this.headerStyle = t, mini.setStyle(this._headerEl, t), this.doLayout()
	},
	getHeaderStyle : function() {
		return this.headerStyle
	},
	setBodyStyle : function(t) {
		this.bodyStyle = t, mini.setStyle(this._bodyEl, t), this.doLayout()
	},
	getBodyStyle : function() {
		return this.bodyStyle
	},
	setToolbarStyle : function(t) {
		this.toolbarStyle = t, mini.setStyle(this._toolbarEl, t), this.doLayout()
	},
	getToolbarStyle : function() {
		return this.toolbarStyle
	},
	setFooterStyle : function(t) {
		this.footerStyle = t, mini.setStyle(this._footerEl, t), this.doLayout()
	},
	getFooterStyle : function() {
		return this.footerStyle
	},
	setHeaderCls : function(t) {
		jQuery(this._headerEl).removeClass(this.headerCls), jQuery(this._headerEl).addClass(t), this.headerCls = t, this.doLayout()
	},
	getHeaderCls : function() {
		return this.headerCls
	},
	setBodyCls : function(t) {
		jQuery(this._bodyEl).removeClass(this.bodyCls), jQuery(this._bodyEl).addClass(t), this.bodyCls = t, this.doLayout()
	},
	getBodyCls : function() {
		return this.bodyCls
	},
	setToolbarCls : function(t) {
		jQuery(this._toolbarEl).removeClass(this.toolbarCls), jQuery(this._toolbarEl).addClass(t), this.toolbarCls = t, this.doLayout()
	},
	getToolbarCls : function() {
		return this.toolbarCls
	},
	setFooterCls : function(t) {
		jQuery(this._footerEl).removeClass(this.footerCls), jQuery(this._footerEl).addClass(t), this.footerCls = t, this.doLayout()
	},
	getFooterCls : function() {
		return this.footerCls
	},
	_doTitle : function() {
		this._titleEl.innerHTML = this.title, this._iconEl.style.display = this.iconCls || this.iconStyle ? "inline" : "none", this._iconEl.className = "mini-panel-icon " + this.iconCls, mini.setStyle(this._iconEl, this.iconStyle)
	},
	setTitle : function(t) {
		this.title = t, this._doTitle()
	},
	getTitle : function() {
		return this.title
	},
	setIconCls : function(t) {
		this.iconCls = t, this._doTitle()
	},
	getIconCls : function() {
		return this.iconCls
	},
	_doTools : function() {
		for (var t = "", e = this.buttons.length - 1; e >= 0; e--) {
			var i = this.buttons[e];
			t += '<span id="' + e + '" class="' + i.cls + " " + (i.enabled ? "" : "mini-disabled") + '" style="' + i.style + ";" + (i.visible ? "" : "display:none;") + '"></span>'
		}
		this._toolsEl.innerHTML = t
	},
	setShowCloseButton : function(t) {
		this.showCloseButton = t;
		var e = this.getButton("close");
		e.visible = t, this._doTools()
	},
	getShowCloseButton : function() {
		return this.showCloseButton
	},
	setCloseAction : function(t) {
		this.closeAction = t
	},
	getCloseAction : function() {
		return this.closeAction
	},
	setShowCollapseButton : function(t) {
		this.showCollapseButton = t;
		var e = this.getButton("collapse");
		e.visible = t, this._doTools()
	},
	getShowCollapseButton : function() {
		return this.showCollapseButton
	},
	setShowHeader : function(t) {
		this.showHeader = t, this._doVisibleEls(), this.deferLayout()
	},
	getShowHeader : function() {
		return this.showHeader
	},
	setShowToolbar : function(t) {
		this.showToolbar = t, this._doVisibleEls(), this.deferLayout()
	},
	getShowToolbar : function() {
		return this.showToolbar
	},
	setShowFooter : function(t) {
		this.showFooter = t, this._doVisibleEls(), this.deferLayout()
	},
	getShowFooter : function() {
		return this.showFooter
	},
	__OnClick : function(t) {
		if (mini.isAncestor(this._headerEl, t.target)) {
			var e = mini.findParent(t.target, "mini-tools");
			if (e) {
				var i = this.getButton(parseInt(t.target.id));
				i && this._OnButtonClick(i, t)
			}
		}
	},
	_OnButtonClick : function(t, e) {
		var i = {
			button : t,
			index : this.buttons.indexOf(t),
			name : t.name.toLowerCase(),
			htmlEvent : e,
			cancel : !1
		};
		this.fire("beforebuttonclick", i);
		var n = !0;
		try {
			"close" == i.name && "destroy" == this.closeAction && this._iframeEl && this._iframeEl.contentWindow && (n = this._iframeEl.contentWindow.CloseWindow ? this._iframeEl.contentWindow.CloseWindow("close") : this._iframeEl.contentWindow.CloseOwnerWindow ? this._iframeEl.contentWindow.CloseOwnerWindow("close") : this._CloseOwnerWindow("close"))
		} catch (s) {
			n = this._CloseOwnerWindow("close")
		}
		return n === !1 && (i.cancel = !0), 1 == i.cancel ? i : (this.fire("buttonclick", i), "close" == i.name && ("destroy" == this.closeAction ? (this.__HideAction = "close", this.destroy()) : this.hide()), "collapse" == i.name && (this.toggle(), this.refreshOnExpand && this.expanded && this.url && this.reload()), i)
	},
	onButtonClick : function(t, e) {
		this.on("buttonclick", t, e)
	},
	_initButtons : function() {
		this.buttons = [];
		var t = this.createButton({
			name : "close",
			cls : "mini-tools-close",
			visible : this.showCloseButton
		});
		this.buttons.push(t);
		var e = this.createButton({
			name : "collapse",
			cls : "mini-tools-collapse",
			visible : this.showCollapseButton
		});
		this.buttons.push(e)
	},
	createButton : function(t) {
		var e = mini.copyTo({
			name : "",
			cls : "",
			style : "",
			visible : !0,
			enabled : !0,
			html : ""
		}, t);
		return e
	},
	addButton : function(t, e) {
		"string" == typeof t && (t = {
			iconCls : t
		}), t = this.createButton(t), "number" != typeof e && (e = this.buttons.length), this.buttons.insert(e, t), this._doTools()
	},
	updateButton : function(t, e) {
		var i = this.getButton(t);
		i && (mini.copyTo(i, e), this._doTools())
	},
	removeButton : function(t) {
		var e = this.getButton(t);
		e && (this.buttons.remove(e), this._doTools())
	},
	getButton : function(t) {
		if ("number" == typeof t) return this.buttons[t];
		for (var e = 0, i = this.buttons.length; i > e; e++) {
			var n = this.buttons[e];
			if (n.name == t) return n
		}
	},
	setBody : function(t) {
		__mini_setControls(t, this._bodyEl, this)
	},
	set_bodyParent : function(t) {},
	setToolbar : function(t) {
		__mini_setControls(t, this._toolbarEl, this)
	},
	setFooter : function(t) {
		__mini_setControls(t, this._footerEl, this)
	},
	getHeaderEl : function() {
		return this._headerEl
	},
	getToolbarEl : function() {
		return this._toolbarEl
	},
	getBodyEl : function() {
		return this._bodyEl
	},
	getFooterEl : function() {
		return this._footerEl
	},
	getIFrameEl : function(t) {
		return this._iframeEl
	},
	_getMaskWrapEl : function() {
		return this._bodyEl
	},
	_doRemoveIFrame : function(t) {
		if (this._iframeEl) {
			var e = this._iframeEl;
			e._ondestroy && e._ondestroy();try {
				this._iframeEl.parentNode.removeChild(this._iframeEl), this._iframeEl.removeNode(!0)
			} catch (i) {}
		}
		this._iframeEl = null, t === !0 && mini.removeChilds(this._bodyEl)
	},
	_deferLoadingTime : 80,
	_doLoad : function() {
		function t(t) {
			i.__HideAction = t;var e = !0;
			if (i.__onDestroy && (e = i.__onDestroy(t)), e === !1) return !1;
			var n = {
				iframe : i._iframeEl,
				action : t
			};
			i.fire("unload", n), setTimeout(function() {
				i.destroy()
			}, 10)
		}
		this._doRemoveIFrame(!0);
		var e = new Date,
			i = this;
		this.loadedUrl = this.url, this.maskOnLoad && this.loading(), jQuery(this._bodyEl).css("overflow", "hidden"), i._CloseOwnerWindow = t;
		var n = mini.createIFrame(this.url, function(n, s) {
			var o = e - new Date + i._deferLoadingTime;
			0 > o && (o = 0), setTimeout(function() {
				i.unmask()
			}, o);try {
				i._iframeEl.contentWindow.Owner = i.Owner, i._iframeEl.contentWindow.CloseOwnerWindow = t
			} catch (l) {}
			i.__onLoad && i.__onLoad();
			var l = {
				iframe : i._iframeEl
			};
			i.fire("load", l)
		});
		this._bodyEl.appendChild(n), this._iframeEl = n
	},
	load : function(t, e, i) {
		this.setUrl(t, e, i)
	},
	reload : function() {
		this.setUrl(this.parseUrl(this.url))
	},
	setUrl : function(t, e, i) {
		this.url = t, this.__onLoad = e, this.__onDestroy = i, this.expanded && this._doLoad()
	},
	getUrl : function() {
		return this.url
	},
	setRefreshOnExpand : function(t) {
		this.refreshOnExpand = t
	},
	getRefreshOnExpand : function() {
		return this.refreshOnExpand
	},
	setMaskOnLoad : function(t) {
		this.maskOnLoad = t
	},
	getMaskOnLoad : function(t) {
		return this.maskOnLoad
	},
	setAllowResize : function(t) {
		this.allowResize != t && (this.allowResize = t, this.doLayout())
	},
	getAllowResize : function() {
		return this.allowResize
	},
	expanded : !0,
	setExpanded : function(t) {
		this.expanded != t && (this.expanded = t, this.expanded ? this.expand() : this.collapse())
	},
	toggle : function() {
		this.expanded ? this.collapse() : this.expand()
	},
	collapse : function() {
		this.expanded = !1, this._height = this.el.style.height, this.el.style.height = "auto", this._viewportEl.style.display = "none", mini.addClass(this.el, "mini-panel-collapse"), this.doLayout()
	},
	expand : function() {
		this.expanded = !0, this.el.style.height = this._height, this._viewportEl.style.display = "block",
		delete this._height
		, mini.removeClass(this.el, "mini-panel-collapse"), this.url && this.url != this.loadedUrl && this._doLoad(), this.doLayout()
	},
	getAttrs : function(t) {
		var e = mini.Panel.superclass.getAttrs.call(this, t);
		mini._ParseString(t, e, [ "title", "iconCls", "iconStyle", "headerCls", "headerStyle", "bodyCls", "bodyStyle", "footerCls", "footerStyle", "toolbarCls", "toolbarStyle", "footer", "toolbar", "url", "closeAction", "loadingMsg", "onbeforebuttonclick", "onbuttonclick", "onload" ]), mini._ParseBool(t, e, [ "allowResize", "showCloseButton", "showHeader", "showToolbar", "showFooter", "showCollapseButton", "refreshOnExpand", "maskOnLoad", "expanded" ]);
		for (var i = mini.getChildNodes(t, !0), n = i.length - 1; n >= 0; n--) {
			var s = i[n],
				o = jQuery(s).attr("property");
			o && (o = o.toLowerCase(), "toolbar" == o ? e.toolbar = s : "footer" == o && (e.footer = s))
		}
		return e.body = i, e
	}
}), mini.regClass(mini.Panel, "panel"), mini = mini || {}, mini.TextBox = function() {
	mini.TextBox.superclass.constructor.call(this)
}, mini.extend(mini.TextBox, mini.ValidatorBase, {
	name : "",
	formField : !0,
	selectOnFocus : !1,
	minWidth : 10,
	minHeight : 15,
	maxLength : 5e3,
	emptyText : "",
	text : "",
	value : "",
	defaultValue : "",
	width : 125,
	height : 21,
	_emptyCls : "mini-textbox-empty",
	_focusCls : "mini-textbox-focus",
	_disabledCls : "mini-textbox-disabled",
	uiCls : "mini-textbox",
	_InputType : "text",
	_create : function() {
		var t = '<input type="' + this._InputType + '" class="mini-textbox-input" autocomplete="off"/>';
		"textarea" == this._InputType && (t = '<textarea class="mini-textbox-input" autocomplete="off"/></textarea>'), t = '<span class="mini-textbox-border">' + t + "</span>", t += '<input type="hidden"/>', this.el = document.createElement("span"), this.el.className = "mini-textbox", this.el.innerHTML = t, this._borderEl = this.el.firstChild, this._textEl = this._borderEl.firstChild, this._valueEl = this.el.lastChild, this._doEmpty()
	},
	_initEvents : function() {
		mini._BindEvents(function() {
			mini_onOne(this._textEl, "drop", this.__OnDropText, this), mini_onOne(this._textEl, "change", this.__OnInputTextChanged, this), mini_onOne(this._textEl, "focus", this.__OnFocus, this), mini_onOne(this.el, "mousedown", this.__OnMouseDown, this), mini_onOne(this._textEl, "paste", this.__OnPaste, this);
			var t = this.value;
			this.value = "", this.setValue(t)
		}, this), this.on("validation", this.__OnValidation, this)
	},
	_inputEventsInited : !1,
	_initInputEvents : function() {
		this._inputEventsInited || (this._inputEventsInited = !0, mini.on(this._textEl, "blur", this.__OnBlur, this), mini.on(this._textEl, "keydown", this.__OnInputKeyDown, this), mini.on(this._textEl, "keyup", this.__OnInputKeyUp, this), mini.on(this._textEl, "keypress", this.__OnInputKeyPress, this))
	},
	destroy : function(t) {
		this.el && (this.el.onmousedown = null), this._textEl && (this._textEl.ondrop = null, this._textEl.onchange = null, this._textEl.onfocus = null, this._textEl.placeholder = null, this._textEl.onpropertychange = null, this._textEl._placeholder_label && (this._textEl._placeholder_label.onmousedown = null, this._textEl._placeholder_label.parentNode.removeChild(this._textEl._placeholder_label), this._textEl._placeholder_label = null), mini.clearEvent(this._textEl), this._textEl.parentNode.removeChild(this._textEl), this._textEl = null), this._borderEl && (mini.clearEvent(this._borderEl), this._borderEl.parentNode.removeChild(this._borderEl), this._borderEl = null), this._valueEl && (mini.clearEvent(this._valueEl), this._valueEl.parentNode.removeChild(this._valueEl), this._valueEl = null), this._errorIconEl && (mini.clearEvent(this._errorIconEl), this._errorIconEl.parentNode.removeChild(this._errorIconEl), this._errorIconEl = null), mini.TextBox.superclass.destroy.call(this, t)
	},
	doLayout : function() {},
	setHeight : function(t) {
		parseInt(t) == t && (t += "px"), this.height = t, "textarea" == this._InputType && (this.el.style.height = t, this.doLayout())
	},
	setName : function(t) {
		this.name != t && (this.name = t, this._valueEl && mini.setAttr(this._valueEl, "name", this.name))
	},
	setValue : function(t, e) {
		(null === t || void 0 === t) && (t = ""), t = String(t), t.length > this.maxLength && (t = t.substring(0, this.maxLength), this._textEl.value = t), this.value !== t && (this.value = t, this._valueEl.value = this._textEl.value = t, this._doEmpty(), void 0 === e && (e = !0), e && this._OnValueChanged())
	},
	getValue : function() {
		return this.value
	},
	getFormValue : function() {
		return value = this.value, (null === value || void 0 === value) && (value = ""), String(value)
	},
	setAllowInput : function(t) {
		this.allowInput != t && (this.allowInput = t, this.doUpdate())
	},
	getAllowInput : function() {
		return this.allowInput
	},
	_placeholdered : !1,
	_doEmpty : function() {
		this._textEl.placeholder = this.emptyText, this.emptyText && mini._placeholder(this._textEl)
	},
	setEmptyText : function(t) {
		this.emptyText != t && (this.emptyText = t, this._doEmpty())
	},
	getEmptyText : function() {
		return this.emptyText
	},
	setMaxLength : function(t) {
		this.maxLength = t, mini.setAttr(this._textEl, "maxLength", t), "textarea" == this._InputType && mini.isIE && mini.on(this._textEl, "keypress", this.__OnMaxLengthKeyUp, this)
	},
	__OnMaxLengthKeyUp : function(t) {
		this._textEl.value.length >= this.maxLength && t.preventDefault()
	},
	getMaxLength : function() {
		return this.maxLength
	},
	setReadOnly : function(t) {
		this.readOnly != t && (this.readOnly = t, this.doUpdate())
	},
	setEnabled : function(t) {
		this.enabled != t && (this.enabled = t, this.doUpdate(), this._tryValidate())
	},
	doUpdate : function() {
		this.enabled ? this.removeCls(this._disabledCls) : this.addCls(this._disabledCls), this.isReadOnly() || 0 == this.allowInput ? (this._textEl.readOnly = !0, mini.addClass(this.el, "mini-textbox-readOnly")) : (this._textEl.readOnly = !1, mini.removeClass(this.el, "mini-textbox-readOnly")), this.required ? this.addCls(this._requiredCls) : this.removeCls(this._requiredCls), this.enabled ? this._textEl.disabled = !1 : this._textEl.disabled = !0
	},
	focus : function() {
		try {
			this._textEl.focus()
		} catch (t) {}
	},
	blur : function() {
		try {
			this._textEl.blur()
		} catch (t) {}
	},
	selectText : function() {
		function t() {
			try {
				e._textEl.select()
			} catch (t) {}
		}
		var e = this;
		t(), setTimeout(function() {
			t()
		}, 30)
	},
	getTextEl : function() {
		return this._textEl
	},
	getInputText : function() {
		return this._textEl.value
	},
	setInputText : function(t) {
		return this._textEl.value = t
	},
	setSelectOnFocus : function(t) {
		this.selectOnFocus = t
	},
	getSelectOnFocus : function(t) {
		return this.selectOnFocus
	},
	_errorIconEl : null,
	getErrorIconEl : function() {
		return this._errorIconEl || (this._errorIconEl = mini.append(this.el, '<span class="mini-errorIcon"></span>')), this._errorIconEl
	},
	_RemoveErrorIcon : function() {
		if (this._errorIconEl) {
			var t = this._errorIconEl;
			jQuery(t).remove()
		}
		this._errorIconEl = null
	},
	__OnMouseDown : function(t) {
		var e = this;
		mini.isAncestor(this._textEl, t.target) ? setTimeout(function() {
			try {
				e._textEl.focus()
			} catch (t) {}
		}, 1) : setTimeout(function() {
			e.focus(), mini.selectRange(e._textEl, 1e3, 1e3)
		}, 1)
	},
	__OnPaste : function(t) {
		var e = this;
		setTimeout(function() {
			e.fire("paste", {
				htmlEvent : t,
				inputText : e.getInputText()
			})
		}, 1)
	},
	__OnInputTextChanged : function(t, e) {
		var i = this.value;
		this.setValue(this._textEl.value), i !== this.getValue() || e === !0
	},
	__OnDropText : function(t) {
		var e = this;
		setTimeout(function() {
			e.__OnInputTextChanged(t)
		}, 0)
	},
	__OnInputKeyDown : function(t) {
		var e = {
			htmlEvent : t
		};
		if (this.fire("keydown", e), 8 == t.keyCode && (this.isReadOnly() || 0 == this.allowInput)) return !1;
		if (13 == t.keyCode || 9 == t.keyCode)
			if ("textarea" == this._InputType && 13 == t.keyCode)
				;
			else if (this.__OnInputTextChanged(null, !0), 13 == t.keyCode) {
				var i = this;
				i.fire("enter", e)
		}
	},
	__OnInputKeyUp : function(t) {
		this.fire("keyup", {
			htmlEvent : t
		})
	},
	__OnInputKeyPress : function(t) {
		this.fire("keypress", {
			htmlEvent : t
		})
	},
	__OnFocus : function(t) {
		this.doUpdate(), this.isReadOnly() || (this._focused = !0, this.addCls(this._focusCls), this._initInputEvents(), this.selectOnFocus && this.selectText(), this.fire("focus", {
			htmlEvent : t
		}))
	},
	__OnBlur : function(t) {
		this._focused = !1;
		var e = this;
		setTimeout(function() {
			0 == e._focused && e.removeCls(e._focusCls)
		}, 2), this.fire("blur", {
			htmlEvent : t
		}), this.validateOnLeave && this._tryValidate()
	},
	inputStyle : "",
	setInputStyle : function(t) {
		this.inputStyle = t, mini.setStyle(this._textEl, t)
	},
	getAttrs : function(t) {
		var e = mini.TextBox.superclass.getAttrs.call(this, t);
		return jQuery(t), mini._ParseString(t, e, [ "value", "text", "emptyText", "inputStyle", "onenter", "onkeydown", "onkeyup", "onkeypress", "onpaste", "maxLengthErrorText", "minLengthErrorText", "onfocus", "onblur", "vtype", "emailErrorText", "urlErrorText", "floatErrorText", "intErrorText", "dateErrorText", "minErrorText", "maxErrorText", "rangeLengthErrorText", "rangeErrorText", "rangeCharErrorText" ]), isIE7 && jQuery(t).attr("width") && (e.width = jQuery(t).attr("width")), mini._ParseBool(t, e, [ "allowInput", "selectOnFocus" ]), mini._ParseInt(t, e, [ "maxLength", "minLength", "minHeight", "minWidth" ]), e
	},
	vtype : "",
	setVtype : function(t) {
		this.vtype = t
	},
	getVtype : function() {
		return this.vtype
	},
	__OnValidation : function(t) {
		0 != t.isValid && mini._ValidateVType(this.vtype, t.value, t, this)
	},
	setEmailErrorText : function(t) {
		this.emailErrorText = t
	},
	getEmailErrorText : function() {
		return this.emailErrorText
	},
	setUrlErrorText : function(t) {
		this.urlErrorText = t
	},
	getUrlErrorText : function() {
		return this.urlErrorText
	},
	setFloatErrorText : function(t) {
		this.floatErrorText = t
	},
	getFloatErrorText : function() {
		return this.floatErrorText
	},
	setIntErrorText : function(t) {
		this.intErrorText = t
	},
	getIntErrorText : function() {
		return this.intErrorText
	},
	setDateErrorText : function(t) {
		this.dateErrorText = t
	},
	getDateErrorText : function() {
		return this.dateErrorText
	},
	setMaxLengthErrorText : function(t) {
		this.maxLengthErrorText = t
	},
	getMaxLengthErrorText : function() {
		return this.maxLengthErrorText
	},
	setMinLengthErrorText : function(t) {
		this.minLengthErrorText = t
	},
	getMinLengthErrorText : function() {
		return this.minLengthErrorText
	},
	setMaxErrorText : function(t) {
		this.maxErrorText = t
	},
	getMaxErrorText : function() {
		return this.maxErrorText
	},
	setMinErrorText : function(t) {
		this.minErrorText = t
	},
	getMinErrorText : function() {
		return this.minErrorText
	},
	setRangeLengthErrorText : function(t) {
		this.rangeLengthErrorText = t
	},
	getRangeLengthErrorText : function() {
		return this.rangeLengthErrorText
	},
	setRangeCharErrorText : function(t) {
		this.rangeCharErrorText = t
	},
	getRangeCharErrorText : function() {
		return this.rangeCharErrorText
	},
	setRangeErrorText : function(t) {
		this.rangeErrorText = t
	},
	getRangeErrorText : function() {
		return this.rangeErrorText
	}
}), mini.regClass(mini.TextBox, "textbox"), mini.MoneyBox = function() {
	mini.MoneyBox.superclass.constructor.call(this)
}, mini.extend(mini.MoneyBox, mini.TextBox, {
	digit : 2,
	minValue : NaN,
	maxValue : NaN,
	uiCls : "mini-moneybox",
	setText : function(t) {
		t = this._formatText(this.value), (null === t || void 0 === t) && (t = ""), this.text = t, this._textEl.value = t
	},
	setValue : function(t, e) {
		(null === t || void 0 === t) && (t = ""), t = String(t), t.length > this.maxLength && (t = t.substring(0, this.maxLength)), this.value !== t && (t = this._formatValue(t), this.value = t, this._valueEl.value = t, this.setText(t), this._doEmpty(), void 0 === e && (e = !0), e && this._OnValueChanged())
	},
	_formatText : function(t) {
		return mini.util.StringUtil.formatMoney(t, this.digit)
	},
	_formatValue : function(t) {
		if (void 0 == t || "" == t || !t) return "";
		t = t.replace(/\,/g, "");
		var e = new Number(t);
		return isNaN(e) ? "" : (e = new Number(this._ValueLimit(t)), e = mini.util.MathUtil.toFixed(e, this.digit))
	},
	_ValueLimit : function(t) {
		return isNaN(this.minValue) && isNaN(this.maxValue) ? t : this.minValue > this.maxValue ? t : (!isNaN(this.minValue) && t < this.minValue && (t = this.minValue), !isNaN(this.maxValue) && t > this.maxValue && (t = this.maxValue), t)
	},
	getAttrs : function(t) {
		var e = mini.MoneyBox.superclass.getAttrs.call(this, t);
		return mini._ParseInt(t, e, [ "digit", "minValue", "maxValue" ]), e
	}
}), mini.regClass(mini.MoneyBox, "moneybox"), mini = mini || {}, mini.Password = function() {
	mini.Password.superclass.constructor.call(this)
}, mini.extend(mini.Password, mini.TextBox, {
	uiCls : "mini-password",
	_InputType : "password",
	setEmptyText : function(t) {
		this.emptyText = ""
	}
}), mini.regClass(mini.Password, "password"), mini = mini || {}, mini.PopupEdit = function() {
	mini.PopupEdit.superclass.constructor.call(this), this._createPopup(), this.el.className += " mini-popupedit"
}, mini.extend(mini.PopupEdit, mini.ButtonEdit, {
	uiCls : "mini-popupedit",
	popup : null,
	popupCls : "mini-buttonedit-popup",
	_hoverCls : "mini-buttonedit-hover",
	_pressedCls : "mini-buttonedit-pressed",
	destroy : function(t) {
		this.isShowPopup() && this.hidePopup(), this.el && (this.el.onmouseover = null, this.el.onmouseout = null), this._popupInner && (this._popupInner.owner = null, this._popupInner = null), this.popup && (mini.clearEvent(this.popup.el), mini.clearEvent(this.popup), this.popup.owner = null, this.popup.destroy(t), this.popup = null), this._clickTarget = null, mini.un(document, "mouseup", this.__OnDocMouseUp, this), mini.PopupEdit.superclass.destroy.call(this, t)
	},
	_initEvents : function() {
		mini.PopupEdit.superclass._initEvents.call(this), mini._BindEvents(function() {
			mini_onOne(this.el, "mouseover", this.__OnMouseOver, this), mini_onOne(this.el, "mouseout", this.__OnMouseOut, this)
		}, this)
	},
	_initButtons : function() {
		this.buttons = [];
		var t = this.createButton({
			cls : "mini-buttonedit-popup",
			iconCls : "mini-buttonedit-icons-popup",
			name : "popup"
		});
		this.buttons.push(t)
	},
	__OnBlur : function(t) {
		this._focused = !1, this._clickTarget && mini.isAncestor(this.el, this._clickTarget) || this.isShowPopup() || mini.PopupEdit.superclass.__OnBlur.call(this, t)
	},
	__OnMouseOver : function(t) {
		this.isReadOnly() || this.allowInput || mini.findParent(t.target, "mini-buttonedit-border") && this.addCls(this._hoverCls)
	},
	__OnMouseOut : function(t) {
		this.isReadOnly() || this.allowInput || this.removeCls(this._hoverCls)
	},
	__OnMouseDown : function(t) {
		this.isReadOnly() || (mini.PopupEdit.superclass.__OnMouseDown.call(this, t), 0 == this.allowInput && mini.findParent(t.target, "mini-buttonedit-border") && (mini.addClass(this.el, this._pressedCls), mini.on(document, "mouseup", this.__OnDocMouseUp, this)))
	},
	__OnInputKeyDown : function(t) {
		return this.fire("keydown", {
				htmlEvent : t
			}), 8 != t.keyCode || !this.isReadOnly() && 0 != this.allowInput ? 9 == t.keyCode ? void this.hidePopup() : 27 == t.keyCode ? void this.hidePopup() : (13 == t.keyCode && this.fire("enter"), void (this.isShowPopup() && (13 == t.keyCode || 27 == t.keyCode) && t.stopPropagation())) : !1
	},
	within : function(t) {
		return mini.isAncestor(this.el, t.target) ? !0 : this.popup.within(t) ? !0 : !1
	},
	popupWidth : "100%",
	popupMinWidth : 50,
	popupMaxWidth : 2e3,
	popupHeight : "",
	popupMinHeight : 100,
	popupMaxHeight : 2e3,
	setPopup : function(t) {
		"string" == typeof t && (mini.parse(t), t = mini.get(t));
		var e = mini.getAndCreate(t);
		e && (e.setVisible(!0), e.render(this.popup._contentEl), e.owner = this, e.on("beforebuttonclick", this.__OnPopupButtonClick, this))
	},
	getPopup : function() {
		return this.popup || this._createPopup(), this.popup
	},
	_createPopup : function() {
		this.popup = new mini.Popup, this.popup.setShowAction("none"), this.popup.setHideAction("outerclick"), this.popup.setPopupEl(this.el), this.popup.on("BeforeClose", this.__OnPopupBeforeClose, this), this.popup.on("close", this.__OnPopupClose, this), mini.on(this.popup.el, "keydown", this.__OnPopupKeyDown, this)
	},
	__OnPopupClose : function(t) {},
	__OnPopupBeforeClose : function(t) {
		this.within(t.htmlEvent) && (t.cancel = !0)
	},
	__OnPopupKeyDown : function(t) {},
	showPopup : function() {
		var t = {
			cancel : !1
		};
		if (this.fire("beforeshowpopup", t), 1 == t.cancel) return !1;
		var e = this.getPopup();
		this._syncShowPopup(), e.on("Close", this.__OnPopupHide, this), this.fire("showpopup")
	},
	doLayout : function() {
		mini.PopupEdit.superclass.doLayout.call(this), this.isShowPopup()
	},
	_syncShowPopup : function() {
		var t = this.getPopup();
		this._popupInner && this._popupInner.el.parentNode != this.popup._contentEl && (this.popup._contentEl.appendChild(this._popupInner.el), this._popupInner.setVisible(!0));
		var e = this.getBox(),
			i = this.popupWidth;
		this.popupWidth && "string" == typeof this.popupWidth && -1 != this.popupWidth.indexOf("%") && (i = parseInt(e.width * this.popupWidth.substring(0, this.popupWidth.length - 1) / 100)), t.setWidth(i);
		var n = parseInt(this.popupHeight);
		isNaN(n) ? t.setHeight("auto") : t.setHeight(n), t.setMinWidth(this.popupMinWidth), t.setMinHeight(this.popupMinHeight), t.setMaxWidth(this.popupMaxWidth), t.setMaxHeight(this.popupMaxHeight), t.showAtEl(this.el, {
			xAlign : "left",
			yAlign : "below",
			outYAlign : "above",
			outXAlign : "right",
			popupCls : this.popupCls
		})
	},
	__OnPopupHide : function(t) {
		this.__doFocusCls(), this.fire("hidepopup")
	},
	hidePopup : function() {
		if (this.isShowPopup()) {
			var t = this.getPopup();
			t.close()
		}
	},
	isShowPopup : function() {
		return this.popup && this.popup.isDisplay() ? !0 : !1
	},
	setPopupWidth : function(t) {
		this.popupWidth = t
	},
	setPopupMaxWidth : function(t) {
		this.popupMaxWidth = t
	},
	setPopupMinWidth : function(t) {
		this.popupMinWidth = t
	},
	getPopupWidth : function(t) {
		return this.popupWidth
	},
	getPopupMaxWidth : function(t) {
		return this.popupMaxWidth
	},
	getPopupMinWidth : function(t) {
		return this.popupMinWidth
	},
	setPopupHeight : function(t) {
		this.popupHeight = t
	},
	setPopupMaxHeight : function(t) {
		this.popupMaxHeight = t
	},
	setPopupMinHeight : function(t) {
		this.popupMinHeight = t
	},
	getPopupHeight : function(t) {
		return this.popupHeight
	},
	getPopupMaxHeight : function(t) {
		return this.popupMaxHeight
	},
	getPopupMinHeight : function(t) {
		return this.popupMinHeight
	},
	__OnClick : function(t) {
		if (!this.isReadOnly()) {
			if (mini.isAncestor(this._buttonEl, t.target) && this._OnButtonClick(t), mini.findParent(t.target, this._closeCls)) return this.isShowPopup() && this.hidePopup(), void this.fire("closeclick", {
						htmlEvent : t
					});
			if (0 == this.allowInput || mini.isAncestor(this._buttonEl, t.target))
				if (this.isShowPopup()) this.hidePopup();else {
					var e = this;
					setTimeout(function() {
						e.showPopup(), e.focus()
					}, 1)
			}
		}
	},
	__OnPopupButtonClick : function(t) {
		"close" == t.name && this.hidePopup(), t.cancel = !0
	},
	getAttrs : function(t) {
		var e = mini.PopupEdit.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "popupWidth", "popupHeight", "popup", "onshowpopup", "onhidepopup", "onbeforeshowpopup" ]), mini._ParseInt(t, e, [ "popupMinWidth", "popupMaxWidth", "popupMinHeight", "popupMaxHeight" ]), e
	}
}), mini.regClass(mini.PopupEdit, "popupedit"), mini.DatePicker = function() {
	mini.DatePicker.superclass.constructor.call(this), mini.addClass(this.el, "mini-datepicker"), this.on("validation", this.__OnValidation, this)
}, mini.extend(mini.DatePicker, mini.PopupEdit, {
	valueFormat : "",
	format : "yyyy-MM-dd",
	maxDate : null,
	minDate : null,
	popupWidth : "",
	viewDate : new Date,
	showTime : !1,
	timeFormat : "H:mm",
	showTodayButton : !0,
	showClearButton : !0,
	showOkButton : !1,
	uiCls : "mini-datepicker",
	_getCalendar : function() {
		if (!mini.DatePicker._Calendar) {
			var t = mini.DatePicker._Calendar = new mini.Calendar;
			t.setStyle("border:0;")
		}
		return mini.DatePicker._Calendar
	},
	_createPopup : function() {
		mini.DatePicker.superclass._createPopup.call(this), this._calendar = this._getCalendar()
	},
	__OnPopupClose : function(t) {
		this._calendar && this._calendar.hideMenu()
	},
	destroy : function(t) {
		delete this._calendar
		, mini.DatePicker.superclass.destroy.call(this, t)
	},
	_monthPicker : !1,
	showPopup : function() {
		function t() {
			if (this._calendar.hideMenu(), this._calendar._target) {
				var t = this._calendar._target;
				this._calendar.un("timechanged", t.__OnTimeChanged, t), this._calendar.un("dateclick", t.__OnDateClick, t), this._calendar.un("drawdate", t.__OnDrawDate, t)
			}
			this._calendar.on("timechanged", this.__OnTimeChanged, this), this._calendar.on("dateclick", this.__OnDateClick, this), this._calendar.on("drawdate", this.__OnDrawDate, this), this._calendar.endUpdate(), this._calendar._allowLayout = !0, this._calendar.doLayout(), this._calendar.focus(), this._calendar._target = this
		}
		if (this._calendar = this._getCalendar(), this._calendar.beginUpdate(), this._calendar._allowLayout = !1, this._calendar.el.parentNode != this.popup._contentEl && this._calendar.render(this.popup._contentEl), this._calendar.set({
				monthPicker : this._monthPicker,
				showTime : this.showTime,
				timeFormat : this.timeFormat,
				showClearButton : this.showClearButton,
				showTodayButton : this.showTodayButton,
				showOkButton : this.showOkButton
			}), this._calendar.setValue(this.value), this.value ? this._calendar.setViewDate(this.value) : this._calendar.setViewDate(this.viewDate), mini.DatePicker.superclass.showPopup.call(this) !== !1) {
			var e = this;
			t.call(e)
		}
	},
	hidePopup : function() {
		mini.DatePicker.superclass.hidePopup.call(this), this._calendar && (this._calendar.un("timechanged", this.__OnTimeChanged, this), this._calendar.un("dateclick", this.__OnDateClick, this), this._calendar.un("drawdate", this.__OnDrawDate, this))
	},
	within : function(t) {
		return mini.isAncestor(this.el, t.target) ? !0 : this._calendar.within(t) ? !0 : !1
	},
	__OnPopupKeyDown : function(t) {
		13 == t.keyCode && this.__OnDateClick(), 27 == t.keyCode && (this.hidePopup(), this.focus())
	},
	minDateErrorText : "",
	maxDateErrorText : "",
	__OnValidation : function(t) {
		if (0 != t.isValid) {
			var e = this.value;
			if (mini.isDate(e)) {
				var i = mini.parseDate(this.maxDate),
					n = mini.parseDate(this.minDate),
					s = this.maxDateErrorText || mini.VTypes.maxDateErrorText,
					o = this.minDateErrorText || mini.VTypes.minDateErrorText;
				mini.isDate(i) && e.getTime() > i.getTime() && (t.isValid = !1, t.errorText = String.format(s, mini.formatDate(i, this.format))), mini.isDate(n) && e.getTime() < n.getTime() && (t.isValid = !1, t.errorText = String.format(o, mini.formatDate(n, this.format)))
			}
		}
	},
	__OnDrawDate : function(t) {
		var e = t.date,
			i = mini.parseDate(this.maxDate),
			n = mini.parseDate(this.minDate);
		mini.isDate(i) && e.getTime() > i.getTime() && (t.allowSelect = !1), mini.isDate(n) && e.getTime() < n.getTime() && (t.allowSelect = !1), this.fire("drawdate", t)
	},
	__OnDateClick : function(t) {
		if (!this.showOkButton || "ok" == t.action) {
			var e = this._calendar.getValue();
			this.getFormValue("U"), this.setValue(e), this.hidePopup(), this.focus()
		}
	},
	__OnTimeChanged : function(t) {
		if (!this.showOkButton) {
			var e = this._calendar.getValue();
			this.setValue(e)
		}
	},
	setFormat : function(t) {
		"string" == typeof t && this.format != t && (this.format = t, this._textEl.value = this._valueEl.value = this.getFormValue())
	},
	getFormat : function() {
		return this.format
	},
	setValueFormat : function(t) {
		"string" == typeof t && this.valueFormat != t && (this.valueFormat = t)
	},
	getValueFormat : function() {
		return this.valueFormat
	},
	setValue : function(t, e) {
		t = mini.parseDate(t), mini.isNull(t) && (t = ""), mini.isDate(t) && (t = new Date(t.getTime())), mini.isEquals(this.value, t) || (this.value = t, this.text = this._textEl.value = this._valueEl.value = this.getFormValue(), void 0 === e && (e = !0), e && this._OnValueChanged())
	},
	nullValue : "",
	setNullValue : function(t) {
		"null" == t && (t = null), this.nullValue = t
	},
	getNullValue : function() {
		return this.nullValue
	},
	getValue : function() {
		if (!mini.isDate(this.value)) return this.nullValue;
		var t = this.value;
		return this.valueFormat && (t = mini.formatDate(t, this.valueFormat)), t
	},
	getFormValue : function(t) {
		return mini.isDate(this.value) ? (t = t || this.format, mini.formatDate(this.value, t)) : ""
	},
	setViewDate : function(t) {
		t = mini.parseDate(t), mini.isDate(t) && (this.viewDate = t)
	},
	getViewDate : function() {
		return this._calendar.getViewDate()
	},
	setShowTime : function(t) {
		this.showTime != t && (this.showTime = t)
	},
	getShowTime : function() {
		return this.showTime
	},
	setTimeFormat : function(t) {
		this.timeFormat != t && (this.timeFormat = t)
	},
	getTimeFormat : function() {
		return this.timeFormat
	},
	setShowTodayButton : function(t) {
		this.showTodayButton = t
	},
	getShowTodayButton : function() {
		return this.showTodayButton
	},
	setShowClearButton : function(t) {
		this.showClearButton = t
	},
	getShowClearButton : function() {
		return this.showClearButton
	},
	setShowOkButton : function(t) {
		this.showOkButton = t
	},
	getShowOkButton : function() {
		return this.showOkButton
	},
	setMaxDate : function(t) {
		this.maxDate = t
	},
	getMaxDate : function() {
		return this.maxDate
	},
	setMinDate : function(t) {
		this.minDate = t
	},
	getMinDate : function() {
		return this.minDate
	},
	setMaxDateErrorText : function(t) {
		this.maxDateErrorText = t
	},
	getMaxDateErrorText : function() {
		return this.maxDateErrorText
	},
	setMinDateErrorText : function(t) {
		this.minDateErrorText = t
	},
	getMinDateErrorText : function() {
		return this.minDateErrorText
	},
	__OnInputTextChanged : function(t) {
		var e = this._textEl.value,
			i = mini.parseDate(e);
		(!i || isNaN(i) || 1970 == i.getFullYear()) && (i = null), this.getFormValue("U"), this.setValue(i), null == i && (this._textEl.value = "")
	},
	__OnInputKeyDown : function(t) {
		var e = {
			htmlEvent : t
		};
		if (this.fire("keydown", e), 8 == t.keyCode && (this.isReadOnly() || 0 == this.allowInput)) return !1;
		if (9 == t.keyCode) return void (this.isShowPopup() && this.hidePopup());
		if (!this.isReadOnly()) switch (t.keyCode) {
			case 27:
				t.preventDefault(), this.isShowPopup() && t.stopPropagation(), this.hidePopup();
				break;case 9:
			case 13:
				if (this.isShowPopup()) t.preventDefault(), t.stopPropagation(), this.hidePopup();else {
					this.__OnInputTextChanged(null);
					var i = this;
					setTimeout(function() {
						i.fire("enter", e)
					}, 10)
				}
				break;case 37:
				break;case 38:
				t.preventDefault();
				break;case 39:
				break;case 40:
				t.preventDefault(), this.showPopup()
		}
	},
	getAttrs : function(t) {
		var e = mini.DatePicker.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "format", "viewDate", "timeFormat", "ondrawdate", "minDate", "maxDate", "valueFormat", "nullValue", "minDateErrorText", "maxDateErrorText" ]), mini._ParseBool(t, e, [ "showTime", "showTodayButton", "showClearButton", "showOkButton" ]), e
	}
}), mini.regClass(mini.DatePicker, "datepicker"), mini.MonthPicker = function() {
	mini.MonthPicker.superclass.constructor.call(this)
}, mini.extend(mini.MonthPicker, mini.DatePicker, {
	uiCls : "mini-monthpicker",
	valueFormat : "",
	format : "yyyy-MM",
	_monthPicker : !0
}), mini.regClass(mini.MonthPicker, "monthpicker"), mini.YearPicker = function() {
	mini.YearPicker.superclass.constructor.call(this), mini.addClass(this.el, "mini-datepicker"), this.on("validation", this.__OnValidation, this)
}, mini.extend(mini.YearPicker, mini.PopupEdit, {
	uiCls : "mini-yearpicker",
	popupWidth : "",
	_getCalendar : function() {
		if (!mini.YearPicker._Calendar) {
			var t = mini.YearPicker._Calendar = new mini.CalendarYear;
			t.setStyle("border:0;")
		}
		return mini.YearPicker._Calendar
	},
	_createPopup : function() {
		mini.YearPicker.superclass._createPopup.call(this), this._calendar = this._getCalendar()
	},
	showPopup : function() {
		function t() {
			if (this._checkYear(this.value) ? (this._calendar.setValue(this.value), this._calendar.updateYears()) : (this._calendar.setValue(mini.formatDate(new Date, "yyyy")), this._calendar.updateYears()), this._calendar._target) {
				var t = this._calendar._target;
				this._calendar.un("dateclick", t.__OnDateClick, t)
			}
			this._calendar.on("dateclick", this.__OnDateClick, this), this._calendar.endUpdate(), this._calendar._allowLayout = !0, this._calendar.focus(), this._calendar._target = this
		}
		if (this._calendar = this._getCalendar(), this._calendar.beginUpdate(), this._calendar._allowLayout = !1, this._calendar.el.parentNode != this.popup._contentEl && this._calendar.render(this.popup._contentEl), mini.YearPicker.superclass.showPopup.call(this) !== !1) {
			var e = this;
			t.call(e)
		}
	},
	hidePopup : function() {
		mini.YearPicker.superclass.hidePopup.call(this), this._calendar.un("dateclick", this.__OnDateClick, this)
	},
	setValue : function(t) {
		this.value != t && (this.value = t, this.text = this._textEl.value = this._valueEl.value = this.value, this._calendar.setValue(this.value), this._calendar.updateYears(), this._OnValueChanged())
	},
	__OnDateClick : function(t) {
		if (!this.showOkButton || "ok" == t.action) {
			var e = this._calendar.getValue();
			this.setValue(e), this.hidePopup(), this.focus()
		}
	},
	__OnValidation : function(t) {
		0 != t.isValid && "" != this.value && (this._checkYear(this.value) || (t.isValid = !1, t.errorText = "格式错误"))
	},
	_checkYear : function(t) {
		var e = /^[1-9]\d{3}$/;
		return e.test(t)
	}
}), mini.regClass(mini.YearPicker, "yearpicker"), mini.ComboBox = function() {
	this.data = [], this.columns = [], mini.ComboBox.superclass.constructor.call(this);
	var t = this;
	isFirefox && (this._textEl.oninput = function() {
		t._tryQuery()
	})
}, mini.extend(mini.ComboBox, mini.PopupEdit, {
	text : "",
	value : "",
	valueField : "id",
	textField : "text",
	delimiter : ",",
	showColumns : !1,
	multiSelect : !1,
	data : [],
	url : "",
	columns : [],
	allowInput : !1,
	valueFromSelect : !1,
	popupMaxHeight : 200,
	set : function(t) {
		if ("string" == typeof t) return this;
		var e = t.value;
		delete t.value;
		var i = t.url;
		delete t.url;
		var n = t.data;
		return delete t.data
			, t.onvaluechanged || (this.defaultValueTriggerChange = !1), mini.ComboBox.superclass.set.call(this, t), mini.isNull(n) || (this.setData(n), t.data = n), mini.isNull(i) || (this.setUrl(i), t.url = i), mini.isNull(e) || (this.setValue(e, this.defaultValueTriggerChange), t.value = e), this
	},
	uiCls : "mini-combobox",
	destroy : function(t) {
		this._listbox && (mini.clearEvent(this._listbox), this._listbox.destroy(t), this._listbox = null),
		delete this.data
		,
		delete this.columns
		, mini.ComboBox.superclass.destroy.call(this, t)
	},
	_createPopup : function() {
		mini.ComboBox.superclass._createPopup.call(this), this._listbox = new mini.ListBox, this._listbox.setBorderStyle("border:0;"), this._listbox.setStyle("width:100%;height:auto;"), this._listbox.render(this.popup._contentEl), this._listbox.on("itemclick", this.__OnItemClick, this), this._listbox.on("drawcell", this.__OnItemDrawCell, this);
		var t = this;
		this._listbox.on("beforeload", function(e) {
			t.fire("beforeload", e)
		}, this), this._listbox.on("load", function(e) {
			t.fire("load", e)
		}, this), this._listbox.on("loaderror", function(e) {
			t.fire("loaderror", e)
		}, this)
	},
	showPopup : function() {
		if (this._listbox.setHeight("auto"), mini.ComboBox.superclass.showPopup.call(this) !== !1) {
			var t = this.popup.el.style.height;
			"" == t || "auto" == t ? this._listbox.setHeight("auto") : this._listbox.setHeight("100%"), this._listbox.setValue(this.value)
		}
	},
	select : function(t) {
		this._listbox.deselectAll(), t = this.getItem(t), t && (this._listbox.select(t), this.__OnItemClick(), this._listbox.setValue(""))
	},
	getItem : function(t) {
		return "object" == typeof t ? t : this.data[t]
	},
	indexOf : function(t) {
		return this.data.indexOf(t)
	},
	getAt : function(t) {
		return this.data[t]
	},
	load : function(t) {
		"string" == typeof t ? this.setUrl(t) : this.setData(t)
	},
	setData : function(data) {
		if ("string" == typeof data && (data = eval("(" + data + ")")), mini.isArray(data) || (data = []), this._listbox.setData(mini.clone(data)), this.data = this._listbox.data, this.valueFromSelect) this.setValue(this.tempvalue, !1);else {
			var vts = this._listbox.getValueAndText(this.value);
			this.text = this._textEl.value = vts[1]
		}
	},
	getData : function() {
		return this.data
	},
	setUrl : function(t) {
		this.getPopup(), this._listbox.setUrl(this.parseUrl(t)), this.url = this._listbox.url, this.data = this._listbox.data;
		var e = this._listbox.getValueAndText(this.value);
		this.text = this._textEl.value = e[1]
	},
	getUrl : function() {
		return this.url
	},
	setValueField : function(t) {
		this.valueField = t, this._listbox && this._listbox.setValueField(t)
	},
	getValueField : function() {
		return this.valueField
	},
	setTextField : function(t) {
		this._listbox && this._listbox.setTextField(t), this.textField = t
	},
	getTextField : function() {
		return this.textField
	},
	setShowColumns : function(t) {
		this._listbox && this._listbox.setShowColumns(t), this.showColumns = t
	},
	getShowColumns : function() {
		return this.showColumns
	},
	setDisplayField : function(t) {
		this.setTextField(t)
	},
	setDataField : function(t) {
		this._listbox && this._listbox.setDataField(t), this.dataField = t
	},
	setValue : function(t, e) {
		var i = this.value,
			n = this._listbox.getValueAndText(t);
		this.valueFromSelect ? (this.value = n[0], this.tempvalue = t) : this.value = t, this._valueEl.value = this.value, this.setText(n[1]), mini.isEquals(i, this.value) || (void 0 === e && (e = !0), e && this._OnValueChanged())
	},
	setText : function(t) {
		mini.isEquals(this.emptyText, t) ? mini.ComboBox.superclass.setText.call(this, "") : mini.ComboBox.superclass.setText.call(this, t)
	},
	setMultiSelect : function(t) {
		this.multiSelect != t && (this.multiSelect = t, this._listbox && (this._listbox.setMultiSelect(t), this._listbox.setShowCheckBox(t)))
	},
	getMultiSelect : function() {
		return this.multiSelect
	},
	setColumns : function(t) {
		mini.isArray(t) || (t = []), this.columns = t, this._listbox.setColumns(t)
	},
	getColumns : function() {
		return this.columns
	},
	showNullItem : !1,
	setShowNullItem : function(t) {
		this.showNullItem != t && (this.showNullItem = t, this._listbox.setShowNullItem(t))
	},
	getShowNullItem : function() {
		return this.showNullItem
	},
	setNullItemText : function(t) {
		this.nullItemText != t && (this.nullItemText = t, this.emptyText = t, this._listbox.setNullItemText(t))
	},
	getNullItemText : function() {
		return this.nullItemText
	},
	setValueFromSelect : function(t) {
		this.valueFromSelect = t
	},
	getValueFromSelect : function() {
		return this.valueFromSelect
	},
	_OnValueChanged : function() {
		this.validateOnChanged && this.validate();
		var t = this.getValue(),
			e = this.getSelecteds(),
			i = e[0],
			n = this;
		n.fire("valuechanged", {
			value : t,
			selecteds : e,
			selected : i
		})
	},
	getSelecteds : function() {
		return this._listbox.findItems(this.value)
	},
	getSelected : function() {
		return this.getSelecteds()[0]
	},
	__OnItemDrawCell : function(t) {
		this.fire("drawcell", t)
	},
	__OnItemClick : function(t) {
		var e = this._listbox.getSelecteds(),
			i = this._listbox.getValueAndText(e);
		this.getValue(), this.setValue(i[0]), t && (this.multiSelect || this.hidePopup(), this.focus(), this.fire("itemclick", {
			item : t.item
		}))
	},
	__OnInputKeyDown : function(t) {
		if (this.fire("keydown", {
				htmlEvent : t
			}), 8 == t.keyCode && (this.isReadOnly() || 0 == this.allowInput)) return !1;
		if (9 == t.keyCode) return void this.hidePopup();
		if (!this.isReadOnly()) switch (t.keyCode) {
			case 27:
				t.preventDefault(), this.isShowPopup() && t.stopPropagation(), this.hidePopup();
				break;case 13:
				if (this.isShowPopup()) {
					t.preventDefault(), t.stopPropagation();
					var e = this._listbox.getFocusedIndex();
					if (-1 != e) {
						var i = this._listbox.getAt(e);
						this.multiSelect || (this._listbox.deselectAll(), this._listbox.select(i));
						var n = this._listbox.getSelecteds(),
							s = this._listbox.getValueAndText(n);
						this.setValue(s[0]), this.setText(s[1])
					}
					this.hidePopup()
				} else this.fire("enter");
				break;case 37:
				break;case 38:
				t.preventDefault();var e = this._listbox.getFocusedIndex();
				if (-1 == e && (e = 0, !this.multiSelect)) {
					var i = this._listbox.findItems(this.value)[0];
					i && (e = this._listbox.indexOf(i))
				}
				this.isShowPopup() && (this.multiSelect || (e -= 1, 0 > e && (e = 0), this._listbox._focusItem(e, !0)));
				break;case 39:
				break;case 40:
				t.preventDefault();var e = this._listbox.getFocusedIndex();
				if (-1 == e && (e = 0, !this.multiSelect)) {
					var i = this._listbox.findItems(this.value)[0];
					i && (e = this._listbox.indexOf(i))
				}
				this.isShowPopup() ? this.multiSelect || (e += 1, e > this._listbox.getCount() - 1 && (e = this._listbox.getCount() - 1), this._listbox._focusItem(e, !0)) : (this.showPopup(), this.multiSelect || this._listbox._focusItem(e, !0));
				break;default:
				this._tryQuery(this._textEl.value)
		}
	},
	__OnInputKeyUp : function(t) {
		this.fire("keyup", {
			htmlEvent : t
		})
	},
	__OnInputKeyPress : function(t) {
		this.fire("keypress", {
			htmlEvent : t
		})
	},
	_tryQuery : function(t) {
		var e = this;
		setTimeout(function() {
			var i = e._textEl.value;
			i != t && e._doQuery(i)
		}, 10)
	},
	_doQuery : function(t) {
		if (1 != this.multiSelect) {
			for (var e = [], i = 0, n = this.data.length; n > i; i++) {
				var s = this.data[i],
					o = mini._getMap(this.textField, s),
					l = mini._getMap(this.valueField, s);
				"string" == typeof o && (o = o.toUpperCase(), l = l.toUpperCase(), t = t.toUpperCase(), (-1 != o.indexOf(t) || -1 != l.indexOf(t)) && e.push(s))
			}
			if (this._listbox.setData(e), this._filtered = !0, "" !== t || this.isShowPopup()) {
				this.showPopup();
				var r = 0;
				this._listbox.getShowNullItem() && (r = 1);
				var a = this;
				a._listbox._focusItem(r, !0)
			}
		}
	},
	__OnPopupHide : function(t) {
		this._filtered && (this._filtered = !1, this._listbox.el && this._listbox.setData(this.data)), this.fire("hidepopup")
	},
	findItems : function(t) {
		return this._listbox.findItems(t)
	},
	__OnInputTextChanged : function(t) {
		if (0 == this.multiSelect) {
			for (var e = this._textEl.value, i = this.getData(), n = null, s = 0, o = i.length; o > s; s++) {
				var l = i[s],
					r = l[this.textField];
				if (r == e) {
					n = l;break
				}
			}
			if (n) {
				this._listbox.setValue(n ? n[this.valueField] : "");
				var a = this._listbox.getValue(),
					h = this._listbox.getValueAndText(a);
				this.getValue(), this.setValue(a), this.setText(h[1])
			} else
				this.valueFromSelect ? (this.setValue(""), this.setText("")) : (this.setValue(e), this.setText(e))
		}
	},
	getAttrs : function(t) {
		var e = mini.ComboBox.superclass.getAttrs.call(this, t);
		mini._ParseString(t, e, [ "url", "data", "textField", "valueField", "displayField", "nullItemText", "ondrawcell", "onbeforeload", "onload", "onloaderror", "onitemclick" ]), mini._ParseBool(t, e, [ "multiSelect", "showNullItem", "valueFromSelect", "showColumns" ]), e.displayField && (e.textField = e.displayField);
		var i = e.valueField || this.valueField,
			n = e.textField || this.textField;
		if ("select" == t.nodeName.toLowerCase()) {
			for (var s = [], o = 0, l = t.length; l > o; o++) {
				var r = t.options[o],
					a = {};
				a[n] = r.text, a[i] = r.value, s.push(a)
			}
			s.length > 0 && (e.data = s)
		} else
			for (var h = mini.getChildNodes(t), o = 0, l = h.length; l > o; o++) {
				var d = h[o],
					u = jQuery(d).attr("property");
				u && (u = u.toLowerCase(), "columns" == u ? e.columns = mini._ParseColumns(d) : "data" == u && (e.data = d.innerHTML))
		}
		return e
	}
}), mini.regClass(mini.ComboBox, "combobox"), mini.AutoComplete = function() {
	mini.AutoComplete.superclass.constructor.call(this);
	var t = this;
	t._ValueChangeTimer = null, this._buttonEl.style.display = "none", this._doInputLayout()
}, mini.extend(mini.AutoComplete, mini.ComboBox, {
	url : "",
	allowInput : !0,
	delay : 150,
	searchField : "key",
	minChars : 0,
	_buttonWidth : 0,
	uiCls : "mini-autocomplete",
	setUrl : function(t) {
		this.url = this.parseUrl(t)
	},
	setValue : function(t) {
		mini.isNull(t) && (t = "");
		var e = this.value;
		if (this.value = t, !mini.isEquals(e, this.value)) {
			this.value = t, this._valueEl.value = this.value;
			var i = this._listbox.getValueAndText(t);
			i[0] && i[1] && this.setText(i[1]), this._OnValueChanged()
		}
	},
	setText : function(t) {
		mini.isNull(t) && (t = ""), this.text != t && (this.text = t, this._LastInputText = t), this._textEl.value = this.text
	},
	__OnItemClick : function(t) {
		var e = this._listbox.getSelecteds(),
			i = this._listbox.getValueAndText(e);
		this.getValue(), this.setValue(i[0]), this.setText(i[1]), t && (this.multiSelect || this.hidePopup(), this.focus(), this.fire("itemclick", {
			item : t.item
		}))
	},
	setMinChars : function(t) {
		this.minChars = t
	},
	getMinChars : function() {
		return this.minChars
	},
	setSearchField : function(t) {
		this.searchField = t
	},
	getSearchField : function() {
		return this.searchField
	},
	popupLoadingText : "<span class='mini-textboxlist-popup-loading'>Loading...</span>",
	popupErrorText : "<span class='mini-textboxlist-popup-error'>Error</span>",
	popupEmptyText : "<span class='mini-textboxlist-popup-noresult'>No Result</span>",
	showPopup : function(t) {
		var e = (this.getPopup(), this._listbox);
		e.showEmpty = !0, e.emptyText = this.popupEmptyText, "loading" == t ? (e.emptyText = this.popupLoadingText, this._listbox.setData([])) : "error" == t && (e.emptyText = this.popupLoadingText, this._listbox.setData([])), this._listbox.doUpdate(), mini.AutoComplete.superclass.showPopup.call(this)
	},
	__OnInputKeyDown : function(t) {
		if (this.fire("keydown", {
				htmlEvent : t
			}), 8 == t.keyCode && (this.isReadOnly() || 0 == this.allowInput)) return !1;
		if (9 == t.keyCode) return void this.hidePopup();
		if (!this.isReadOnly()) switch (t.keyCode) {
			case 17:
				break;case 27:
				this.isShowPopup() && t.stopPropagation(), this.hidePopup();
				break;case 13:
				if (this.isShowPopup()) {
					t.preventDefault(), t.stopPropagation();
					var e = this._listbox.getFocusedIndex();
					if (-1 != e) {
						var i = this._listbox.getAt(e),
							n = this._listbox.getValueAndText([ i ]),
							s = n[0];
						this.setText(n[1]), mini.isFirefox && (this.blur(), this.focus()), this.setValue(s, !1), this.hidePopup()
					}
				} else this.fire("enter");
				break;case 37:
				break;case 38:
				var e = this._listbox.getFocusedIndex();
				if (-1 == e && (e = 0, !this.multiSelect)) {
					var i = this._listbox.findItems(this.value)[0];
					i && (e = this._listbox.indexOf(i))
				}
				this.isShowPopup() && (this.multiSelect || (e -= 1, 0 > e && (e = 0), this._listbox._focusItem(e, !0)));
				break;case 39:
				break;case 40:
				var e = this._listbox.getFocusedIndex();
				this.isShowPopup() ? this.multiSelect || (e += 1, e > this._listbox.getCount() - 1 && (e = this._listbox.getCount() - 1), this._listbox._focusItem(e, !0)) : this._tryQuery(this._textEl.value);
				break;default:
				this._tryQuery(this._textEl.value)
		}
	},
	doQuery : function() {
		this._tryQuery()
	},
	_tryQuery : function(t) {
		var e = this;
		this._queryTimer && (clearTimeout(this._queryTimer), this._queryTimer = null), this._queryTimer = setTimeout(function() {
			var t = e._textEl.value;
			e._doQuery(t)
		}, this.delay), this.showPopup("loading")
	},
	_doQuery : function(t) {
		if (this.url) {
			this._ajaxer && this._ajaxer.abort();
			var e = this.url,
				i = "post";
			e && (-1 != e.indexOf(".txt") || -1 != e.indexOf(".json")) && (i = "get");
			var n = {};
			n[this.searchField] = t;
			var s = {
				url : e,
				async : !0,
				params : n,
				data : n,
				type : i,
				cache : !1,
				cancel : !1
			};
			if (this.fire("beforeload", s), s.data != s.params && s.params != n && (s.data = s.params), !s.cancel) {
				var o = sf = this;
				mini.copyTo(s, {
					success : function(t) {
						try {
							var e = mini.decode(t)
						} catch (i) {
							throw new Error("autocomplete json is error")
						}
						sf.dataField && (e = mini._getMap(sf.dataField, e)), e || (e = []), o._listbox.setData(e), o.showPopup(), o._listbox._focusItem(0, !0), o.data = e, o.fire("load", {
							data : e
						})
					},
					error : function(t, e, i) {
						o.showPopup("error")
					}
				}), this._ajaxer = mini.ajax(s)
			}
		}
	},
	getAttrs : function(t) {
		var e = mini.AutoComplete.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "searchField" ]), e
	}
}), mini.regClass(mini.AutoComplete, "autocomplete"), mini.Lookup = function() {
	this.data = [], mini.Lookup.superclass.constructor.call(this), mini.on(this._textEl, "mouseup", this.__OnMouseUp, this), this.on("showpopup", this.__OnShowPopup, this)
}, mini.extend(mini.Lookup, mini.PopupEdit, {
	allowInput : !0,
	valueField : "id",
	textField : "text",
	delimiter : ",",
	multiSelect : !1,
	data : [],
	grid : null,
	uiCls : "mini-lookup",
	destroy : function(t) {
		this.grid && (this.grid.un("rowclick", this.__OnGridRowClickChanged, this), this.grid.un("load", this.__OnGridLoad, this), this.grid = null), mini.Lookup.superclass.destroy.call(this, t)
	},
	setMultiSelect : function(t) {
		this.multiSelect = t, this.grid && this.grid.setMultiSelect(t)
	},
	setGrid : function(t) {
		"string" == typeof t && (mini.parse(t), t = mini.get(t)), this.grid = mini.getAndCreate(t), this.grid && (this.grid.setMultiSelect(this.multiSelect), this.grid.setCheckSelectOnLoad(!1), this.grid.on("rowclick", this.__OnGridRowClickChanged, this), this.grid.on("load", this.__OnGridLoad, this), this.grid.on("checkall", this.__OnGridRowClickChanged, this))
	},
	getGrid : function() {
		return this.grid
	},
	setValueField : function(t) {
		this.valueField = t
	},
	getValueField : function() {
		return this.valueField
	},
	setTextField : function(t) {
		this.textField = t
	},
	getTextField : function() {
		return this.textField
	},
	deselectAll : function() {
		this.data = [], this.setValue(""), this.setText(""), this.grid && this.grid.deselectAll()
	},
	getItemValue : function(t) {
		return String(t[this.valueField])
	},
	getItemText : function(t) {
		var e = t[this.textField];
		return mini.isNull(e) ? "" : String(e)
	},
	getValueAndText : function(t) {
		mini.isNull(t) && (t = []);
		for (var e = [], i = [], n = 0, s = t.length; s > n; n++) {
			var o = t[n];
			o && (e.push(this.getItemValue(o)), i.push(this.getItemText(o)))
		}
		return [ e.join(this.delimiter), i.join(this.delimiter) ]
	},
	_createData : function() {
		"string" != typeof this.value && (this.value = ""), "string" != typeof this.text && (this.text = "");
		var t = [],
			e = this.value.split(this.delimiter),
			i = this.text.split(this.delimiter),
			n = e.length;
		if (this.value)
			for (var s = 0, o = n; o > s; s++) {
				var l = {},
					r = e[s],
					a = i[s];
				l[this.valueField] = r ? r : "", l[this.textField] = a ? a : "", t.push(l)
		}
		this.data = t
	},
	_getValueMaps : function(t) {
		for (var e = {}, i = 0, n = t.length; n > i; i++) {
			var s = t[i],
				o = s[this.valueField];
			e[o] = s
		}
		return e
	},
	setValue : function(t) {
		mini.Lookup.superclass.setValue.call(this, t), this._createData()
	},
	setText : function(t) {
		mini.Lookup.superclass.setText.call(this, t), this._createData()
	},
	__OnGridRowClickChanged : function(t) {
		var e = this._getValueMaps(this.grid.getData()),
			i = this._getValueMaps(this.grid.getSelecteds()),
			n = this._getValueMaps(this.data);
		0 == this.multiSelect && (n = {}, this.data = []);
		var s = {};
		for (var o in n) {
			var l = n[o];
			e[o] && (i[o] || (s[o] = l))
		}
		for (var r = this.data.length - 1; r >= 0; r--) {
			var l = this.data[r],
				o = l[this.valueField];
			s[o] && this.data.removeAt(r)
		}
		for (var o in i) {
			var l = i[o];
			n[o] || this.data.push(l)
		}
		var a = this.getValueAndText(this.data);
		this.setValue(a[0]), this.setText(a[1]), this._OnValueChanged()
	},
	__OnGridLoad : function(t) {
		this.__OnShowPopup(t)
	},
	__OnShowPopup : function(t) {
		for (var e = String(this.value).split(this.delimiter), i = {}, n = 0, s = e.length; s > n; n++) {
			var o = e[n];
			i[o] = 1
		}
		for (var l = this.grid.getData(), r = [], n = 0, s = l.length; s > n; n++) {
			var a = l[n],
				h = a[this.valueField];
			i[h] && r.push(a)
		}
		this.grid.selects(r)
	},
	doUpdate : function() {
		mini.Lookup.superclass.doUpdate.call(this), this._textEl.readOnly = !0, this.el.style.cursor = "default"
	},
	__OnInputKeyDown : function(t) {
		switch (mini.Lookup.superclass.__OnInputKeyDown.call(this, t), t.keyCode) {
		case 46:
		case 8:
			break;case 37:
			break;case 39:
		}
	},
	__OnMouseUp : function(t) {
		if (!this.isReadOnly()) {
			var e = mini.getSelectRange(this._textEl),
				i = e[0];
			e[1], this._findTextIndex(i)
		}
	},
	_findTextIndex : function(t) {
		var e = -1;
		if ("" == this.text) return e;
		for (var i = String(this.text).split(this.delimiter), n = 0, s = 0, o = i.length; o > s; s++) {
			var l = i[s];
			if (t > n && t <= n + l.length) {
				e = s;break
			}
			n = n + l.length + 1
		}
		return e
	},
	getAttrs : function(t) {
		var e = mini.Lookup.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "grid", "valueField", "textField" ]), mini._ParseBool(t, e, [ "multiSelect" ]), e
	}
}), mini.regClass(mini.Lookup, "lookup"), mini.Pager = function() {
	mini.Pager.superclass.constructor.call(this)
}, mini.extend(mini.Pager, mini.Control, {
	pageIndex : 0,
	pageSize : 10,
	totalCount : 0,
	totalPage : 0,
	showPageIndex : !0,
	showPageSize : !0,
	showTotalCount : !0,
	showPageInfo : !0,
	showReloadButton : !0,
	_clearBorder : !1,
	showButtonText : !1,
	showButtonIcon : !0,
	firstText : "首页",
	prevText : "上一页",
	nextText : "下一页",
	lastText : "尾页",
	pageInfoText : "每页 {0} 条, 共 {1} 条",
	sizeList : [ 10, 20, 50, 100 ],
	uiCls : "mini-pager",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-pager";
		var t = '<div class="mini-pager-left"></div><div class="mini-pager-right"></div>';
		this.el.innerHTML = t, this.buttonsEl = this._leftEl = this.el.childNodes[0], this._rightEl = this.el.childNodes[1], this.sizeEl = mini.append(this.buttonsEl, '<span class="mini-pager-size"></span>'), this.sizeCombo = new mini.ComboBox, this.sizeCombo.setName("pagesize"), this.sizeCombo.setWidth(48), this.sizeCombo.render(this.sizeEl), mini.append(this.sizeEl, '<span class="separator"></span>'), this.firstButton = new mini.Button, this.firstButton.render(this.buttonsEl), this.prevButton = new mini.Button, this.prevButton.render(this.buttonsEl), this.indexEl = document.createElement("span"), this.indexEl.className = "mini-pager-index", this.indexEl.innerHTML = '<input id="" type="text" class="mini-pager-num"/><span class="mini-pager-pages">/ 0</span>', this.buttonsEl.appendChild(this.indexEl), this.numInput = this.indexEl.firstChild, this.pagesLabel = this.indexEl.lastChild, this.nextButton = new mini.Button, this.nextButton.render(this.buttonsEl), this.lastButton = new mini.Button, this.lastButton.render(this.buttonsEl), mini.append(this.buttonsEl, '<span class="separator"></span>'), this.reloadButton = new mini.Button, this.reloadButton.render(this.buttonsEl), this.firstButton.setPlain(!0), this.prevButton.setPlain(!0), this.nextButton.setPlain(!0), this.lastButton.setPlain(!0), this.reloadButton.setPlain(!0), this.update()
	},
	destroy : function(t) {
		this.pageSelect && (mini.clearEvent(this.pageSelect), this.pageSelect = null), this.sizeCombo && (mini.clearEvent(this.sizeCombo), this.sizeCombo.destroy(t), this.sizeCombo = null), this.sizeEl && (mini.clearEvent(this.sizeEl), this.buttonsEl.removeChild(this.sizeEl), this.sizeEl = null), this.firstButton && (mini.clearEvent(this.firstButton), this.firstButton.destroy(t), this.firstButton = null), this.prevButton && (mini.clearEvent(this.prevButton), this.prevButton.destroy(t), this.prevButton = null), this.numInput && (mini.clearEvent(this.numInput), this.indexEl.removeChild(this.numInput), this.numInput = null), this.pagesLabel && (mini.clearEvent(this.pagesLabel), this.indexEl.removeChild(this.pagesLabel), this.pagesLabel = null), this.indexEl && (mini.clearEvent(this.indexEl), this.buttonsEl.removeChild(this.indexEl), this.indexEl = null), this.nextButton && (mini.clearEvent(this.nextButton), this.nextButton.destroy(t), this.nextButton = null), this.lastButton && (mini.clearEvent(this.lastButton), this.lastButton.destroy(t), this.lastButton = null), this.reloadButton && (mini.clearEvent(this.reloadButton), this.reloadButton.destroy(t), this.reloadButton = null), this.buttonsEl && (mini.clearEvent(this.buttonsEl), this.el.removeChild(this.buttonsEl), this.buttonsEl = null, this._leftEl = null), this._rightEl && (mini.clearEvent(this._rightEl), this.el.removeChild(this._rightEl), this._rightEl = null), mini.Pager.superclass.destroy.call(this, t)
	},
	_initEvents : function() {
		function t() {
			if (!e) {
				e = !0;
				var t = parseInt(this.numInput.value);
				isNaN(t) ? this.update() : this._OnPageChanged(t - 1), setTimeout(function() {
					e = !1
				}, 100)
			}
		}
		mini.Pager.superclass._initEvents.call(this), this.firstButton.on("click", function(t) {
			this._OnPageChanged(0)
		}, this), this.prevButton.on("click", function(t) {
			this._OnPageChanged(this.pageIndex - 1)
		}, this), this.nextButton.on("click", function(t) {
			this._OnPageChanged(this.pageIndex + 1)
		}, this), this.lastButton.on("click", function(t) {
			this._OnPageChanged(this.totalPage)
		}, this), this.reloadButton.on("click", function(t) {
			this._OnPageChanged()
		}, this);
		var e = !1;
		mini.on(this.numInput, "change", function(e) {
			t.call(this)
		}, this), mini.on(this.numInput, "keydown", function(e) {
			13 == e.keyCode && (t.call(this), e.stopPropagation())
		}, this), this.sizeCombo.on("valuechanged", this.__OnPageSelectChanged, this)
	},
	doLayout : function() {
		this.canLayout() && (mini.layout(this._leftEl), mini.layout(this._rightEl))
	},
	setPageIndex : function(t) {
		isNaN(t) || (this.pageIndex = t, this.update())
	},
	getPageIndex : function() {
		return this.pageIndex
	},
	setPageSize : function(t) {
		isNaN(t) || (this.pageSize = t, this.update())
	},
	getPageSize : function() {
		return this.pageSize
	},
	setTotalCount : function(t) {
		t = parseInt(t), isNaN(t) || (this.totalCount = t, this.update())
	},
	getTotalCount : function() {
		return this.totalCount
	},
	setSizeList : function(t) {
		mini.isArray(t) && (this.sizeList = t, this.update())
	},
	getSizeList : function() {
		return this.sizeList
	},
	setShowPageSize : function(t) {
		this.showPageSize = t, this.update()
	},
	getShowPageSize : function() {
		return this.showPageSize
	},
	setShowPageIndex : function(t) {
		this.showPageIndex = t, this.update()
	},
	getShowPageIndex : function() {
		return this.showPageIndex
	},
	setShowTotalCount : function(t) {
		this.showTotalCount = t, this.update()
	},
	getShowTotalCount : function() {
		return this.showTotalCount
	},
	setShowPageInfo : function(t) {
		this.showPageInfo = t, this.update()
	},
	getShowPageInfo : function() {
		return this.showPageInfo
	},
	setShowReloadButton : function(t) {
		this.showReloadButton = t, this.update()
	},
	getShowReloadButton : function() {
		return this.showReloadButton
	},
	getTotalPage : function() {
		return this.totalPage
	},
	update : function(t, e, i) {
		mini.isNumber(t) && (this.pageIndex = parseInt(t)), mini.isNumber(e) && (this.pageSize = parseInt(e)), mini.isNumber(i) && (this.totalCount = parseInt(i)), this.totalPage = parseInt(this.totalCount / this.pageSize) + 1, (this.totalPage - 1) * this.pageSize == this.totalCount && (this.totalPage -= 1), 0 == this.totalCount && (this.totalPage = 0), this.pageIndex > this.totalPage - 1 && (this.pageIndex = this.totalPage - 1), this.pageIndex <= 0 && (this.pageIndex = 0), this.totalPage <= 0 && (this.totalPage = 0), this.firstButton.enable(), this.prevButton.enable(), this.nextButton.enable(), this.lastButton.enable(), 0 == this.pageIndex && (this.firstButton.disable(), this.prevButton.disable()), this.pageIndex >= this.totalPage - 1 && (this.nextButton.disable(), this.lastButton.disable()), this.numInput.value = this.pageIndex > -1 ? this.pageIndex + 1 : 0, this.pagesLabel.innerHTML = "/ " + this.totalPage;
		var n = this.sizeList.clone();
		-1 == n.indexOf(this.pageSize) && (n.push(this.pageSize), n = n.sort(function(t, e) {
			return t > e
		}));
		for (var s = [], o = 0, l = n.length; l > o; o++) {
			var r = n[o],
				a = {};
			a.text = r, a.id = r, s.push(a)
		}
		this.sizeCombo.setData(s), this.sizeCombo.setValue(this.pageSize);
		var h = this.firstText,
			d = this.prevText,
			u = this.nextText,
			c = this.lastText;
		0 == this.showButtonText && (h = d = u = c = ""), this.firstButton.setText(h), this.prevButton.setText(d), this.nextButton.setText(u), this.lastButton.setText(c);
		var h = this.firstText,
			d = this.prevText,
			u = this.nextText,
			c = this.lastText;
		1 == this.showButtonText && (h = d = u = c = ""), this.firstButton.setTooltip(h), this.prevButton.setTooltip(d), this.nextButton.setTooltip(u), this.lastButton.setTooltip(c), this.firstButton.setIconCls(this.showButtonIcon ? "mini-pager-first" : ""), this.prevButton.setIconCls(this.showButtonIcon ? "mini-pager-prev" : ""), this.nextButton.setIconCls(this.showButtonIcon ? "mini-pager-next" : ""), this.lastButton.setIconCls(this.showButtonIcon ? "mini-pager-last" : ""), this.reloadButton.setIconCls(this.showButtonIcon ? "mini-pager-reload" : ""), this.reloadButton.setVisible(this.showReloadButton);
		var m = this.reloadButton.el.previousSibling;
		m && (m.style.display = this.showReloadButton ? "" : "none"), this._rightEl.innerHTML = String.format(this.pageInfoText, this.pageSize, this.totalCount), this.indexEl.style.display = this.showPageIndex ? "" : "none", this.sizeEl.style.display = this.showPageSize ? "" : "none", this._rightEl.style.display = this.showPageInfo ? "" : "none"
	},
	__OnPageSelectChanged : function(t) {
		var e = parseInt(this.sizeCombo.getValue());
		this._OnPageChanged(0, e)
	},
	_OnPageChanged : function(t, e) {
		var i = {
			pageIndex : mini.isNumber(t) ? t : this.pageIndex,
			pageSize : mini.isNumber(e) ? e : this.pageSize,
			totalCount : this.totalCount,
			cancel : !1,
			isreload : void 0 === t && void 0 === e
		};
		i.pageIndex > this.totalPage - 1 && (i.pageIndex = this.totalPage - 1), i.pageIndex < 0 && (i.pageIndex = 0), this.fire("beforepagechanged", i), 1 != i.cancel && (this.fire("pagechanged", i), this.update(i.pageIndex, i.pageSize))
	},
	onPageChanged : function(t, e) {
		this.on("pagechanged", t, e)
	},
	getAttrs : function(el) {
		var attrs = mini.Pager.superclass.getAttrs.call(this, el);
		return mini._ParseString(el, attrs, [ "onpagechanged", "sizeList", "onbeforepagechanged" ]), mini._ParseBool(el, attrs, [ "showPageIndex", "showPageSize", "showTotalCount", "showPageInfo", "showReloadButton", "showButtonText", "showButtonIcon" ]), mini._ParseInt(el, attrs, [ "pageIndex", "pageSize", "totalCount" ]), "string" == typeof attrs.sizeList && (attrs.sizeList = eval(attrs.sizeList)), attrs
	}
}), mini.regClass(mini.Pager, "pager"), mini.PagerNoTotal = function() {
	mini.PagerNoTotal.superclass.constructor.call(this)
}, mini.extend(mini.PagerNoTotal, mini.Control, {
	pageIndex : 0,
	pageSize : 10,
	showPageIndex : !0,
	showPageSize : !0,
	showReloadButton : !0,
	_clearBorder : !1,
	showButtonText : !1,
	showButtonIcon : !0,
	firstText : "首页",
	prevText : "上一页",
	nextText : "下一页",
	sizeList : [ 10, 20, 50, 100 ],
	uiCls : "mini-pagernototal",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-pager";
		var t = '<div class="mini-pager-left"></div>';
		this.el.innerHTML = t, this.buttonsEl = this._leftEl = this.el.childNodes[0], this.sizeEl = mini.append(this.buttonsEl, '<span class="mini-pager-size"></span>'), this.sizeCombo = new mini.ComboBox, this.sizeCombo.setName("pagesize"), this.sizeCombo.setWidth(48), this.sizeCombo.render(this.sizeEl), mini.append(this.sizeEl, '<span class="separator"></span>'), this.firstButton = new mini.Button, this.firstButton.render(this.buttonsEl), this.prevButton = new mini.Button, this.prevButton.render(this.buttonsEl), this.indexEl = document.createElement("span"), this.indexEl.className = "mini-pager-index", this.indexEl.innerHTML = '<input id="" type="text" class="mini-pager-num"/>', this.buttonsEl.appendChild(this.indexEl), this.numInput = this.indexEl.firstChild, this.nextButton = new mini.Button, this.nextButton.render(this.buttonsEl), mini.append(this.buttonsEl, '<span class="separator"></span>'), this.reloadButton = new mini.Button, this.reloadButton.render(this.buttonsEl), this.firstButton.setPlain(!0), this.prevButton.setPlain(!0), this.nextButton.setPlain(!0), this.reloadButton.setPlain(!0), this.update()
	},
	destroy : function(t) {
		this.pageSelect && (mini.clearEvent(this.pageSelect), this.pageSelect = null), this.sizeCombo && (mini.clearEvent(this.sizeCombo), this.sizeCombo.destroy(t), this.sizeCombo = null), this.sizeEl && (mini.clearEvent(this.sizeEl), this.buttonsEl.removeChild(this.sizeEl), this.sizeEl = null), this.firstButton && (mini.clearEvent(this.firstButton), this.firstButton.destroy(t), this.firstButton = null), this.prevButton && (mini.clearEvent(this.prevButton), this.prevButton.destroy(t), this.prevButton = null), this.numInput && (mini.clearEvent(this.numInput), this.indexEl.removeChild(this.numInput), this.numInput = null), this.indexEl && (mini.clearEvent(this.indexEl), this.buttonsEl.removeChild(this.indexEl), this.indexEl = null), this.nextButton && (mini.clearEvent(this.nextButton), this.nextButton.destroy(t), this.nextButton = null), this.reloadButton && (mini.clearEvent(this.reloadButton), this.reloadButton.destroy(t), this.reloadButton = null), this.buttonsEl && (mini.clearEvent(this.buttonsEl), this.el.removeChild(this.buttonsEl), this.buttonsEl = null, this._leftEl = null), mini.Pager.superclass.destroy.call(this, t)
	},
	_initEvents : function() {
		function t() {
			if (!e) {
				e = !0;
				var t = parseInt(this.numInput.value);
				isNaN(t) ? this.update() : this._OnPageChanged(t - 1), setTimeout(function() {
					e = !1
				}, 100)
			}
		}
		mini.Pager.superclass._initEvents.call(this), this.firstButton.on("click", function(t) {
			this._OnPageChanged(0)
		}, this), this.prevButton.on("click", function(t) {
			this._OnPageChanged(this.pageIndex - 1)
		}, this), this.nextButton.on("click", function(t) {
			this._OnPageChanged(this.pageIndex + 1)
		}, this), this.reloadButton.on("click", function(t) {
			this._OnPageChanged()
		}, this);
		var e = !1;
		mini.on(this.numInput, "change", function(e) {
			t.call(this)
		}, this), mini.on(this.numInput, "keydown", function(e) {
			13 == e.keyCode && (t.call(this), e.stopPropagation())
		}, this), this.sizeCombo.on("valuechanged", this.__OnPageSelectChanged, this)
	},
	doLayout : function() {
		this.canLayout() && mini.layout(this._leftEl)
	},
	setPageIndex : function(t) {
		isNaN(t) || (this.pageIndex = t, this.update())
	},
	getPageIndex : function() {
		return this.pageIndex
	},
	setPageSize : function(t) {
		isNaN(t) || (this.pageSize = t, this.update())
	},
	getPageSize : function() {
		return this.pageSize
	},
	setSizeList : function(t) {
		mini.isArray(t) && (this.sizeList = t, this.update())
	},
	getSizeList : function() {
		return this.sizeList
	},
	setShowPageSize : function(t) {
		this.showPageSize = t, this.update()
	},
	getShowPageSize : function() {
		return this.showPageSize
	},
	setShowPageIndex : function(t) {
		this.showPageIndex = t, this.update()
	},
	getShowPageIndex : function() {
		return this.showPageIndex
	},
	setShowTotalCount : function(t) {
		this.showTotalCount = t, this.update()
	},
	getShowTotalCount : function() {
		return this.showTotalCount
	},
	setShowPageInfo : function(t) {
		this.showPageInfo = t, this.update()
	},
	getShowPageInfo : function() {
		return this.showPageInfo
	},
	setShowReloadButton : function(t) {
		this.showReloadButton = t, this.update()
	},
	getShowReloadButton : function() {
		return this.showReloadButton
	},
	getTotalPage : function() {
		return this.totalPage
	},
	update : function(t, e, i) {
		mini.isNumber(t) && (this.pageIndex = parseInt(t)), mini.isNumber(e) && (this.pageSize = parseInt(e)), mini.isNumber(i) && (this.totalCount = parseInt(i)), this.pageIndex <= 0 && (this.pageIndex = 0), this.firstButton.enable(), this.prevButton.enable(), this.nextButton.enable(), 0 == this.pageIndex && (this.firstButton.disable(), this.prevButton.disable()), this.totalCount < this.pageSize && this.nextButton.disable(), this.numInput.value = this.pageIndex > -1 ? this.pageIndex + 1 : 0;
		var n = this.sizeList.clone();
		-1 == n.indexOf(this.pageSize) && (n.push(this.pageSize), n = n.sort(function(t, e) {
			return t > e
		}));
		for (var s = [], o = 0, l = n.length; l > o; o++) {
			var r = n[o],
				a = {};
			a.text = r, a.id = r, s.push(a)
		}
		this.sizeCombo.setData(s), this.sizeCombo.setValue(this.pageSize);
		var h = this.firstText,
			d = this.prevText,
			u = this.nextText,
			c = this.lastText;
		0 == this.showButtonText && (h = d = u = c = ""), this.firstButton.setText(h), this.prevButton.setText(d), this.nextButton.setText(u);
		var h = this.firstText,
			d = this.prevText,
			u = this.nextText;
		1 == this.showButtonText && (h = d = u = ""), this.firstButton.setTooltip(h), this.prevButton.setTooltip(d), this.nextButton.setTooltip(u), this.firstButton.setIconCls(this.showButtonIcon ? "mini-pager-first" : ""), this.prevButton.setIconCls(this.showButtonIcon ? "mini-pager-prev" : ""), this.nextButton.setIconCls(this.showButtonIcon ? "mini-pager-next" : ""), this.reloadButton.setIconCls(this.showButtonIcon ? "mini-pager-reload" : ""), this.reloadButton.setVisible(this.showReloadButton);
		var m = this.reloadButton.el.previousSibling;
		m && (m.style.display = this.showReloadButton ? "" : "none"), this.indexEl.style.display = this.showPageIndex ? "" : "none", this.sizeEl.style.display = this.showPageSize ? "" : "none"
	},
	__OnPageSelectChanged : function(t) {
		var e = parseInt(this.sizeCombo.getValue());
		this._OnPageChanged(0, e)
	},
	_OnPageChanged : function(t, e) {
		var i = {
			pageIndex : mini.isNumber(t) ? t : this.pageIndex,
			pageSize : mini.isNumber(e) ? e : this.pageSize,
			cancel : !1,
			isreload : void 0 === t && void 0 === e
		};
		i.pageIndex < 0 && (i.pageIndex = 0), this.fire("beforepagechanged", i), 1 != i.cancel && (this.fire("pagechanged", i), this.update(i.pageIndex, i.pageSize))
	},
	onPageChanged : function(t, e) {
		this.on("pagechanged", t, e)
	},
	getAttrs : function(el) {
		var attrs = mini.Pager.superclass.getAttrs.call(this, el);
		return mini._ParseString(el, attrs, [ "onpagechanged", "sizeList", "onbeforepagechanged" ]), mini._ParseBool(el, attrs, [ "showPageIndex", "showPageSize", "showReloadButton" ]), mini._ParseInt(el, attrs, [ "pageIndex", "pageSize" ]), "string" == typeof attrs.sizeList && (attrs.sizeList = eval(attrs.sizeList)), attrs
	}
}), mini.regClass(mini.PagerNoTotal, "pagernototal"), mini.DataGrid = function() {
	this.data = [], this._idRows = {}, this._removes = [], this._originals = {}, this.columns = [], this._bottomColumns = [], this._idColumns = {}, this._nameColumns = {}, this._selecteds = [], this._idSelecteds = {}, this._cellErrors = [], this._cellMapErrors = {}, mini.DataGrid.superclass.constructor.call(this), this.doUpdate();
	var t = this;
	setTimeout(function() {
		t.autoLoad && t.reload()
	}, 1)
}, mini.DataGrid.RowID = 0, mini.DataGrid.ColumnID = 0, mini.extend(mini.DataGrid, mini.Control, {
	_displayStyle : "block",
	width : 300,
	height : "auto",
	onlyCheckSelection : !1,
	allowCellValid : !1,
	cellEditAction : "cellclick",
	showEmptyText : !1,
	dataLoaded : !1,
	loadErrorAlert : !0,
	emptyText : "No data returned.",
	showModified : !0,
	dependMerge : !1,
	minWidth : 300,
	minHeight : 150,
	maxWidth : 5e3,
	maxHeight : 3e3,
	_viewRegion : null,
	_virtualRows : 50,
	virtualScroll : !1,
	allowCellWrap : !1,
	allowHeaderWrap : !1,
	showColumnsMenu : !1,
	bodyCls : "",
	bodyStyle : "",
	footerCls : "",
	footerStyle : "",
	pagerCls : "",
	pagerStyle : "",
	idField : "id",
	data : [],
	columns : null,
	allowResize : !1,
	selectOnLoad : !1,
	_rowIdField : "_uid",
	columnWidth : 120,
	columnMinWidth : 20,
	columnMaxWidth : 2e3,
	fitColumns : !0,
	autoHideRowDetail : !0,
	showHeader : !0,
	showFooter : !0,
	showTop : !1,
	showHGridLines : !0,
	showVGridLines : !0,
	showFilterRow : !1,
	showSummaryRow : !1,
	sortMode : "server",
	allowSortColumn : !0,
	allowMoveColumn : !0,
	allowResizeColumn : !0,
	enableHotTrack : !0,
	allowRowSelect : !0,
	multiSelect : !1,
	allowAlternating : !1,
	_alternatingCls : "mini-grid-row-alt",
	allowUnselect : !1,
	_frozenCls : "mini-grid-frozen",
	_frozenCellCls : "mini-grid-frozenCell",
	frozenStartColumn : -1,
	frozenEndColumn : -1,
	isFrozen : function() {
		return this.frozenStartColumn >= 0 && this.frozenEndColumn >= this.frozenStartColumn
	},
	_rowCls : "mini-grid-row",
	_rowHoverCls : "mini-grid-row-hover",
	_rowSelectedCls : "mini-grid-row-selected",
	_headerCellCls : "mini-grid-headerCell",
	_cellCls : "mini-grid-cell",
	set : function(t) {
		var e = t.columns;
		delete t.columns;
		var i = t.pageSize;
		delete t.pageSize;
		var n = t.pager;
		return delete t.pager
			, void 0 !== t.ignoreTotalBusiness && (this.setIgnoreTotalBusiness(t.ignoreTotalBusiness),
			delete t.ignoreTotalBusiness
			), this._createPager(), mini.DataGrid.superclass.set.call(this, t), i && this.setPageSize(i), n && this.setPager(n), e && this.setColumns(e), this
	},
	uiCls : "mini-datagrid",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-grid", this.el.style.display = "block", this.el.tabIndex = 1;
		var t = '<div class="mini-grid-border"><div class="mini-grid-header"><div class="mini-grid-headerInner"></div></div><div class="mini-grid-filterRow"></div><div class="mini-grid-body"><div class="mini-grid-bodyInner"></div><div class="mini-grid-body-scrollHeight"></div></div><div class="mini-grid-scroller"><div></div></div><div class="mini-grid-summaryRow"></div><div class="mini-grid-footer"></div><div class="mini-resizer-trigger" style=""></div><a href="#" class="mini-grid-focus" style="position:absolute;left:-10px;top:-10px;width:0px;height:0px;outline:none;" hideFocus onclick="return false" ></a></div>';
		this.el.innerHTML = t, this._borderEl = this.el.firstChild, this._headerEl = this._borderEl.childNodes[0], this._filterEl = this._borderEl.childNodes[1], this._bodyEl = this._borderEl.childNodes[2], this._bodyInnerEl = this._bodyEl.childNodes[0], this._bodyScrollEl = this._bodyEl.childNodes[1], this._headerInnerEl = this._headerEl.firstChild, this._scrollEl = this._borderEl.childNodes[3], this._summaryEl = this._borderEl.childNodes[4], this._footerEl = this._borderEl.childNodes[5], this._resizeEl = this._borderEl.childNodes[6], this._focusEl = this._borderEl.childNodes[7], this._doUpdateFilterRow(), this._doUpdateSummaryRow(), mini.setStyle(this._bodyEl, this.bodyStyle), mini.addClass(this._bodyEl, this.bodyCls), this._doShowRows()
	},
	destroy : function(t) {
		this._destroyEditors(), this._Resizer.destroy(t), this._Splitter.destroy(t), this._ColumnMove.destroy(t), this._Select.destroy(t), this._CellTip.destroy(t), this._Sort.destroy(t), this._ColumnsMenu.destroy(t), this._scrollEl && (mini.clearEvent(this._scrollEl), this._borderEl.removeChild(this._scrollEl), this._scrollEl = null), this._summaryEl && (mini.clearEvent(this._summaryEl), this._borderEl.removeChild(this._summaryEl), this._summaryEl = null), this.pager && (mini.clearEvent(this.pager), this.pager.destroy(t), this.pager = null), this._footerEl && (mini.clearEvent(this._footerEl), this._borderEl.removeChild(this._footerEl), this._footerEl = null), this._resizeEl && (mini.clearEvent(this._resizeEl), this._borderEl.removeChild(this._resizeEl), this._resizeEl = null), this._focusEl && (mini.clearEvent(this._focusEl), this._borderEl.removeChild(this._focusEl), this._focusEl = null), this._bodyInnerEl && (mini.clearEvent(this._bodyInnerEl), this._bodyEl.removeChild(this._bodyInnerEl), this._bodyInnerEl = null), this._bodyScrollEl && (mini.clearEvent(this._bodyScrollEl), this._bodyEl.removeChild(this._bodyScrollEl), this._bodyScrollEl = null), this._bodyEl && (mini.clearEvent(this._bodyEl), this._borderEl.removeChild(this._bodyEl), this._bodyEl = null), this._filterEl && (mini.clearEvent(this._filterEl), this._borderEl.removeChild(this._filterEl), this._filterEl = null), this._topRightCellEl && (mini.clearEvent(this._topRightCellEl), this._headerInnerEl.removeChild(this._topRightCellEl), this._topRightCellEl = null), this._headerInnerEl && (mini.clearEvent(this._headerInnerEl), this._headerEl.removeChild(this._headerInnerEl), this._headerInnerEl = null), this._headerEl && (mini.clearEvent(this._headerEl), this._borderEl.removeChild(this._headerEl), this._headerEl = null), this._borderEl && (mini.clearEvent(this._borderEl), this.el.removeChild(this._borderEl), this._borderEl = null),
		delete this.data
		,
		delete this._idRows
		,
		delete this._removes
		,
		delete this._originals
		,
		delete this.columns
		,
		delete this._bottomColumns
		,
		delete this._idColumns
		,
		delete this._nameColumns
		,
		delete this._selecteds
		,
		delete this._idSelecteds
		,
		delete this._cellErrors
		,
		delete this._cellMapErrors
		,
		delete this._margedCells
		,
		delete this._mergedCellMaps
		,
		delete this._groupDataView
		, mini.DataGrid.superclass.destroy.call(this, t)
	},
	_initEvents : function() {
		js_touchScroll(this._bodyEl), mini._BindEvents(function() {
			mini.on(this.el, "click", this.__OnClick, this), mini.on(this.el, "dblclick", this.__OnDblClick, this), mini.on(this.el, "mousedown", this.__OnMouseDown, this), mini.on(this.el, "mouseup", this.__OnMouseUp, this), mini.on(this.el, "mousemove", this.__OnMouseMove, this), mini.on(this.el, "mouseover", this.__OnMouseOver, this), mini.on(this.el, "mouseout", this.__OnMouseOut, this), mini.on(this.el, "keydown", this.__OnKeyDown, this), mini.on(this.el, "keyup", this.__OnKeyUp, this), mini.on(this.el, "contextmenu", this.__OnContextMenu, this), mini.on(this._bodyEl, "scroll", this.__OnBodyScroll, this), mini.on(this._scrollEl, "scroll", this.__OnHScroll, this), mini.on(this.el, "mousewheel", this.__OnMousewheel, this)
		}, this), this._Resizer = new mini._Resizer(this), this._Splitter = new mini._ColumnSplitter(this), this._ColumnMove = new mini._ColumnMove(this), this._Select = new mini._GridSelect(this), this._CellTip = new mini._CellToolTip(this), this._Sort = new mini._GridSort(this), this._ColumnsMenu = new mini._ColumnsMenu(this)
	},
	_doShowRows : function() {
		this._resizeEl.style.display = this.allowResize ? "" : "none", this._footerEl.style.display = this.showFooter ? "" : "none", this._summaryEl.style.display = this.showSummaryRow ? "" : "none", this._filterEl.style.display = this.showFilterRow ? "" : "none", this._headerEl.style.display = this.showHeader ? "" : "none"
	},
	focus : function() {
		try {
			var t = this.getCurrent();
			if (t) {
				var e = this._getRowEl(t);
				if (e) {
					var i = mini.getBox(e);
					mini.setY(this._focusEl, i.top), isOpera ? e.focus() : isChrome ? this.el.focus() : isGecko ? this.el.focus() : this._focusEl.focus()
				}
			} else this._focusEl.focus()
		} catch (n) {}
	},
	_createPager : function() {
		this.ignoreTotalBusiness ? this.pager = new mini.PagerNoTotal : this.pager = new mini.Pager, this.pager.render(this._footerEl), this.bindPager(this.pager)
	},
	setPager : function(t) {
		if ("string" == typeof t) {
			var e = mini.byId(t);
			if (!e) return;
			mini.parse(t), t = mini.get(t), this.diypager = t
		}
		t && (t.update(this.pageIndex, this.pageSize, this.totalCount), this.bindPager(t))
	},
	bindPager : function(t) {
		t.on("beforepagechanged", this.__OnPageChanged, this), this.on("load", function(e) {
			t.update(this.pageIndex, this.pageSize, this.totalCount), this.totalPage = t.totalPage
		}, this)
	},
	setIdField : function(t) {
		this.idField = t
	},
	getIdField : function() {
		return this.idField
	},
	setUrl : function(t) {
		this.url = this.parseUrl(t)
	},
	getUrl : function(t) {
		return this.url
	},
	setAutoLoad : function(t) {
		this.autoLoad = t
	},
	getAutoLoad : function(t) {
		return this.autoLoad
	},
	setCheckSelectionOnly : function(t) {
		this.onlyCheckSelection = t
	},
	getCheckSelectionOnly : function() {
		return this.onlyCheckSelection
	},
	accept : function() {
		this._canUpdateRowEl = !1;
		for (var t = this.data, e = 0, i = t.length; i > e; e++) {
			var n = t[e];
			this.acceptRecord(n)
		}
		this._canUpdateRowEl = !0, this.doUpdate()
	},
	acceptRecord : function(t) {
		t = this._getRow(t), t && ("removed" == t._state && this._removes.remove(t),
		delete this._originals[t._uid]
		,
		delete t._state
		, this._canUpdateRowEl && this._updateRowEl(t))
	},
	_clearOriginals : !0,
	loadData : function(t) {
		mini.isArray(t) || (t = []), this.data = t, 1 == this._clearOriginals && (this._originals = {}), this._removes = [], this._idRows = {}, this._selecteds = [], this._idSelecteds = {}, this._cellErrors = [], this._cellMapErrors = {}, this._margedCells = null, this._mergedCellMaps = null, this._groupDataView = null;
		for (var e = 0, i = t.length; i > e; e++) {
			var n = t[e];
			n._uid = mini.DataGrid.RowID, n._index = e, this._idRows[n._uid] = n, mini.DataGrid.RowID += 1
		}
		this.isVirtualScroll() && this.scrollIntoView(this._getRow(0)), this.doUpdate()
	},
	setData : function(t) {
		if (this.dataLoaded = !0, this.loadData(t), 0 == t.length && this.pager) {
			this.pageIndex = 0, this.totalCount = 0;
			var e = {
				result : {
					data : t,
					total : t.length
				},
				data : t,
				total : this.totalCount,
				cancel : !1
			};
			this.fire("load", e)
		}
	},
	getData : function() {
		return mini.clone(this.data, !1)
	},
	toArray : function() {
		return this.data.clone()
	},
	getRange : function(t, e) {
		if (t > e) {
			var i = t;
			t = e, e = i
		}
		for (var n = this.data, s = [], o = t, l = e; l >= o; o++) {
			var r = n[o];
			s.push(r)
		}
		return s
	},
	selectRange : function(t, e) {
		if (mini.isNumber(t) || (t = this.indexOf(t)), mini.isNumber(e) || (e = this.indexOf(e)), !mini.isNull(t) && !mini.isNull(e)) {
			var i = this.getRange(t, e);
			this.selects(i)
		}
	},
	getHeaderHeight : function() {
		return this.showHeader ? mini.getHeight(this._headerEl) : 0
	},
	getFooterHeight : function() {
		return this.showFooter ? mini.getHeight(this._footerEl) : 0
	},
	getFilterRowHeight : function() {
		return this.showFilterRow ? mini.getHeight(this._filterEl) : 0
	},
	getSummaryRowHeight : function() {
		return this.showSummaryRow ? mini.getHeight(this._summaryEl) : 0
	},
	_getScrollHeight : function() {
		return this.isFrozen() ? mini.getHeight(this._scrollEl) : 0
	},
	_CreateTopTr : function(t) {
		var e = "empty" == t,
			i = 0;
		e && 0 == this.showEmptyText && (i = 1);
		var n = "",
			s = this.getBottomColumns();
		n += e ? '<tr style="height:' + i + 'px">' : isIE ? isIE6 || isIE7 || isIE8 && !mini.boxModel || isIE9 && !mini.boxModel ? '<tr style="display:none;">' : "<tr >" : '<tr style="height:' + i + 'px">';
		for (var o = 0, l = s.length; l > o; o++) {
			var r = s[o],
				a = (r.width, this._createColumnId(r) + "$" + t);
			n += '<td id="' + a + '" style="padding:0;border:0;margin:0;height:' + i + "px;", r.width && (n += "width:" + r.width), (o < this.frozenStartColumn || 0 == r.visible) && (n += ";display:none;"), n += '" ></td>'
		}
		return n += "</tr>"
	},
	_doUpdateFilterRow : function() {
		this._filterEl.firstChild && this._filterEl.removeChild(this._filterEl.firstChild);
		var t = this.isFrozen(),
			e = this.getBottomColumns(),
			i = [];
		i[i.length] = '<table class="mini-grid-table" cellspacing="0" cellpadding="0">', i[i.length] = this._CreateTopTr("filter"), i[i.length] = "<tr >";
		for (var n = 0, s = e.length; s > n; n++) {
			var o = e[n],
				l = this._createFilterCellId(o);
			i[i.length] = '<td id="', i[i.length] = l, i[i.length] = '" class="mini-grid-filterCell" style="', (t && n < this.frozenStartColumn || 0 == o.visible || 1 == o._hide) && (i[i.length] = ";display:none;"), i[i.length] = '"><span class="mini-grid-hspace"></span></td>'
		}
		i[i.length] = '</tr></table><div class="mini-grid-scrollCell"></div>', this._filterEl.innerHTML = i.join("");
		for (var n = 0, s = e.length; s > n; n++) {
			var o = e[n];
			if (o.filter) {
				var r = this.getFilterCellEl(n);
				o.filter.render(r)
			}
		}
	},
	_deferUpdateSummaryRow : function() {
		var t = this;
		this._summaryTimer || (this._summaryTimer = setTimeout(function() {
			t._doUpdateSummaryRow(), t._summaryTimer = null
		}, 1))
	},
	_doUpdateSummaryRow : function() {
		var t = this.data;
		this._summaryEl.firstChild && this._summaryEl.removeChild(this._summaryEl.firstChild);
		var e = this.isFrozen(),
			i = this.getBottomColumns(),
			n = [];
		n[n.length] = '<table class="mini-grid-table" cellspacing="0" cellpadding="0">', n[n.length] = this._CreateTopTr("summary"), n[n.length] = "<tr >";
		for (var s = 0, o = i.length; o > s; s++) {
			var l = i[s],
				r = this._createSummaryCellId(l),
				a = this._OnDrawSummaryCell(t, l);
			n[n.length] = '<td id="', n[n.length] = r, n[n.length] = '" class="mini-grid-summaryCell ' + a.cellCls + '" style="' + a.cellStyle + ";", (e && s < this.frozenStartColumn || 0 == l.visible || 1 == l._hide) && (n[n.length] = ";display:none;"), n[n.length] = '">', n[n.length] = a.cellHtml, n[n.length] = "</td>"
		}
		n[n.length] = '</tr></table><div class="mini-grid-scrollCell"></div>', this._summaryEl.innerHTML = n.join("")
	},
	_createHeaderText : function(t) {
		var e = t.header;
		return "function" == typeof e && (e = e.call(this, t)), (mini.isNull(e) || "" === e) && (e = "&nbsp;"), e
	},
	_isLastColumn : function(t) {
		function e(t) {
			var n = i(t, o);
			if (!n) return !1;
			var l = i(n, o);
			if (!l) return n._id == s._id ? !0 : !1;
			var r = l.columns.indexOf(n);
			if (r != l.columns.length - 1) return !1;
			var a = i(n, o);
			return a ? e(n) ? !0 : void 0 : !0
		}
		function i(t) {
			for (var e = 0; e < o.length; e++) {
				var i = n(t, o[e]);
				if (i) return i
			}
		}
		function n(t, e) {
			if (t._pid == e._id) return e;
			var i = e.columns;
			if (!i) return null;
			for (var s = 0; s < i.length; s++) {
				var o = n(t, i[s]);
				if (o) return o
			}
		}
		var s = this.columns[this.columns.length - 1],
			o = this.columns;
		return i(t, o) ? e(t) ? !0 : void 0 : !0
	},
	_doUpdateHeader : function(t) {
		t = t || "";
		var e = this.isFrozen(),
			i = this.getColumnRows(),
			n = this.getBottomColumns(),
			s = (n.length, []);
		s[s.length] = '<table style="' + t + ';display:table" class="mini-grid-table" cellspacing="0" cellpadding="0"  id="mini-grid-table-head' + this.getId() + '">', s[s.length] = this._CreateTopTr("header");
		for (var o = 0, l = i.length; l > o; o++) {
			var r = i[o];
			s[s.length] = "<tr >";
			for (var a = 0, h = r.length; h > a; a++) {
				var d = r[a],
					u = this._createHeaderText(d),
					c = this._createColumnId(d),
					m = "";
				this.sortField == d.field && (m = "asc" == this.sortOrder ? "mini-grid-asc" : "mini-grid-desc"), s[s.length] = '<td id="', s[s.length] = c, s[s.length] = '" class="mini-grid-headerCell ' + m + " " + (d.headerCls || "") + " ", a == h - 1 && this._isLastColumn(d) && (s[s.length] = " mini-grid-last-column ");var p = n.indexOf(d);
				s[s.length] = '" style="', (e && -1 != p && p < this.frozenStartColumn || 0 == d.visible || 1 == d._hide) && (s[s.length] = ";display:none;"), d.columns && d.columns.length > 0 && 0 == d.colspan && (s[s.length] = ";display:none;"), d.headerStyle && (s[s.length] = d.headerStyle + ";"), d.headerAlign && (s[s.length] = "text-align:" + d.headerAlign + ";"), s[s.length] = '" ', d.rowspan && (s[s.length] = 'rowspan="' + d.rowspan + '" '), d.colspan && (s[s.length] = 'colspan="' + d.colspan + '" '), s[s.length] = '><div class="mini-grid-cellInner">', s[s.length] = u, m && (s[s.length] = '<span class="mini-grid-sortIcon"></span>'), s[s.length] = "</div>", s[s.length] = "</td>"
			}
			s[s.length] = "</tr>"
		}
		s[s.length] = "</table>";
		var f = s.join("");
		f = '<div class="mini-grid-header">' + f + "</div>";
		var f = '<div class="mini-grid-scrollHeaderCell"></div>';
		f += '<div class="mini-grid-topRightCell"></div>', this._headerInnerEl.innerHTML = s.join("") + f, this._topRightCellEl = this._headerInnerEl.lastChild, this.fire("refreshHeader")
	},
	_destroyEditors : function() {
		for (var t = mini.getChildControls(this), e = [], i = 0, n = t.length; n > i; i++) {
			var s = t[i];
			s.el && mini.findParent(s.el, this._rowCls) && (e.push(s), s.destroy())
		}
	},
	_doUpdateBody : function() {
		this._destroyEditors();
		for (var t = this.getBottomColumns(), e = 0, i = t.length; i > e; e++) {
			var n = t[e];
			delete n._hide
		}
		this._doUpdateHeader();
		var s = this.data,
			o = this.isVirtualScroll(),
			l = this._markRegion(),
			r = [],
			a = this.isAutoHeight(),
			h = 0;
		if (o && (h = l.top), a ? r[r.length] = '<table class="mini-grid-table" cellspacing="0" cellpadding="0" id="mini-grid-table-body' + this.getId() + '">' : r[r.length] = '<table style="position:absolute;top:' + h + 'px;left:0;" class="mini-grid-table" cellspacing="0" cellpadding="0" id="mini-grid-table-body' + this.getId() + '">', r[r.length] = this._CreateTopTr("body"), s.length > 0)
			if (this.isGrouping())
				for (var d = 0, u = this._getGroupDataView(), c = this.getVisibleColumns(), m = 0, p = u.length; p > m; m++) {
					var f = u[m],
						g = this.uid + "$group$" + f.id,
						_ = this._OnDrawGroup(f);
					if (r[r.length] = '<tr id="' + g + '" class="mini-grid-groupRow">', this.__fzhj) {
						for (var v = {}, y = 0, C = f.rows.length; C > y; y++)
							for (var w in this.__fzhj) this.__fzhj[w] || (this.__fzhj[w] = function(t, e) {
									return t + e
								}), v[w] = this.__fzhj[w](v[w] || 0, f.rows[y][w], f);
						for (var x = 0, b = this.columns.length; b > x; x++) this.columns[x].field == this._groupField ? (r.push('<td class="mini-grid-groupCell"><div class="mini-grid-groupHeader">'), r[r.length] = '<div class="mini-grid-group-ecicon"></div>', r[r.length] = '<div class="mini-grid-groupTitle">' + _.cellHtml + "</div>", r[r.length] = "</div></td>") : r.push('<td class="mini-grid-groupCell">' + (v[this.columns[x].field] || "") + "</td>")
					} else r.push('<td class="mini-grid-groupCell" colspan="' + c.length + '"><div class="mini-grid-groupHeader">'), r[r.length] = '<div class="mini-grid-group-ecicon"></div>', r[r.length] = '<div class="mini-grid-groupTitle">' + _.cellHtml + "</div>", r[r.length] = "</div></td>";
					r.push("</tr>");
					for (var E = f.rows, e = 0, i = E.length; i > e; e++) {
						var T = E[e];
						this._createRow(T, r, d++)
					}
					this.showGroupSummary
			}
			else if (o)
				for (var S = l.start, I = l.end, e = S, i = I; i > e; e++) {
					var T = s[e];
					this._createRow(T, r, e)
			}
			else
				for (var e = 0, i = s.length; i > e; e++) {
					var T = s[e];
					this._createRow(T, r, e)
		}
		else this.showEmptyText && (this._resultObject || this.dataLoaded) && (r[r.length] = '<tr ><td class="mini-grid-emptyText" colspan="' + this.getVisibleColumns().length + '">' + this.emptyText + "</td></tr>");
		if (r[r.length] = "</table>", this._bodyInnerEl.firstChild && this._bodyInnerEl.removeChild(this._bodyInnerEl.firstChild), this._bodyInnerEl.innerHTML = r.join(""), o) {
			this._rowHeight = 23;try {
				var k = this._bodyInnerEl.firstChild.rows[1];
				k && (this._rowHeight = k.offsetHeight)
			} catch (B) {}
			var O = this._rowHeight * this.data.length;
			this._bodyScrollEl.style.display = "block", this._bodyScrollEl.style.height = O + "px"
		} else
			this._bodyScrollEl.style.display = "none"
	},
	showNewRow : !0,
	_createRow : function(t, e, i) {
		mini.isNumber(i) || (i = this.indexOf(t));
		var n = i == this.data.length - 1,
			s = this.isFrozen(),
			o = !e;
		e || (e = []);
		var l = this.getBottomColumns(),
			r = -1,
			a = " ",
			h = -1,
			d = " ";
		e[e.length] = '<tr id="', e[e.length] = this._createRowId(t), e[e.length] = '" class="mini-grid-row ', this.isSelected(t) && (e[e.length] = this._rowSelectedCls, e[e.length] = " "), "deleted" == t._state && (e[e.length] = "mini-grid-deleteRow "), "added" == t._state && this.showNewRow && (e[e.length] = "mini-grid-newRow "), this.allowAlternating && i % 2 == 1 && (e[e.length] = this._alternatingCls, e[e.length] = " "), r = e.length, e[e.length] = a, e[e.length] = '" style="', h = e.length, e[e.length] = d, e[e.length] = '">';
		for (var u = l.length - 1, c = 0, m = u; m >= c; c++) {
			var p = l[c],
				f = p.field ? this._HasRowModified(t, p.field) : !1,
				g = this.getCellError(t, p),
				_ = this._OnDrawCell(t, p, i, c),
				v = this._createCellId(t, p);
			e[e.length] = '<td id="', e[e.length] = v, e[e.length] = '" class="mini-grid-cell ', _.cellCls && (e[e.length] = _.cellCls), g && (e[e.length] = " mini-grid-cell-error "), this._currentCell && this._currentCell[0] == t && this._currentCell[1] == p && (e[e.length] = " ", e[e.length] = this._cellSelectedCls), n && (e[e.length] = " mini-grid-last-row "), c == u && (e[e.length] = " mini-grid-last-column "), s && this.frozenStartColumn <= c && c <= this.frozenEndColumn && (e[e.length] = " ", e[e.length] = this._frozenCellCls + " "), e[e.length] = '" style="', p.align && (e[e.length] = "text-align:", e[e.length] = p.align, e[e.length] = ";"), _.allowCellWrap && (e[e.length] = "white-space:normal;text-overflow:normal;word-break:break-all;"), _.cellStyle && (e[e.length] = _.cellStyle, e[e.length] = ";"), (s && c < this.frozenStartColumn || 0 == p.visible || 1 == p._hide) && (e[e.length] = "display:none;"), 0 == _.visible && (e[e.length] = "display:none;"), e[e.length] = '" ', _.rowSpan && (e[e.length] = 'rowspan="' + _.rowSpan + '"'), _.colSpan && (e[e.length] = 'colspan="' + _.colSpan + '"'), e[e.length] = ">", f && this.showModified && (e[e.length] = '<div class="mini-grid-cell-inner mini-grid-cell-dirty" style="', e[e.length] = '">'), e[e.length] = _.cellHtml, f && (e[e.length] = "</div>"), e[e.length] = "</td>", _.rowCls && (a = _.rowCls), _.rowStyle && (d = _.rowStyle)
		}
		return e[r] = a, e[h] = d, e[e.length] = "</tr>", o ? e.join("") : void 0
	},
	isVirtualScroll : function() {
		return this.virtualScroll && 0 == this.isAutoHeight() && 0 == this.isGrouping()
	},
	getScrollLeft : function() {
		return this.isFrozen() ? this._scrollEl.scrollLeft : this._bodyEl.scrollLeft
	},
	doUpdate : function() {
		if (new Date, this._allowUpdate !== !1) {
			if (1 == this.isAutoHeight() ? this.addCls("mini-grid-auto") : this.removeCls("mini-grid-auto"), this._doUpdateSummaryRow && this._doUpdateSummaryRow(), this._doUpdateBody(), this.isFrozen()) {
				var t = this;
				t._doScrollFrozen(!0)
			}
			this.doLayout()
		}
	},
	_fixIE : function() {
		isIE && (this._borderEl.style.display = "none", h = this.getHeight(!0), w = this.getWidth(!0), this._borderEl.style.display = "")
	},
	_deferLayout : function() {
		var t = this;
		this._layoutTimer || (this._layoutTimer = setTimeout(function() {
			t.doLayout(), t._layoutTimer = null
		}, 1))
	},
	doLayout : function() {
		if (this.canLayout()) {
			this._filterEl.scrollLeft = this._summaryEl.scrollLeft = this._headerInnerEl.scrollLeft = this._bodyEl.scrollLeft;
			var t = (new Date, this.isFrozen()),
				e = this._headerInnerEl.firstChild,
				i = this._bodyInnerEl.firstChild,
				n = this._filterEl.firstChild,
				s = this._summaryEl.firstChild,
				o = this.isAutoHeight();
			h = this.getHeight(!0), p = this.getWidth(!0);
			var l = this.data,
				r = p;
			17 > r && (r = 17), h < 0 && (h = 0);
			var a = r,
				d = 2e3;
			o ? this._bodyEl.style.height = "auto" : (h = h - this.getHeaderHeight() - this.getFooterHeight() - this.getFilterRowHeight() - this.getSummaryRowHeight() - this._getScrollHeight(), h < 0 && (h = 0), this._bodyEl.style.height = h + "px", d = h);
			var u = this._bodyEl.scrollHeight,
				c = this._bodyEl.clientHeight;
			if (this.isFitColumns()) {
				var m = this.getMaxColumnLevel();
				if (c >= u || o) {
					var p = a - 1 + "px";
					e.style.width = p, i.style.width = p, n.style.width = p, s.style.width = p, this._topRightCellEl.style.borderLeftWidth = "0px", mini.isIE8 && this.data.length > 0 && mini.addClass(this._bodyEl, "mini-grid-hidden-y")
				} else {
					var p = parseInt(a - 18);
					0 > p && (p = 0), p += "px", e.style.width = p, i.style.width = p, n.style.width = p, s.style.width = p, m > 0 && (this._topRightCellEl.style.borderLeftWidth = "1px"), mini.isIE8 && this.data.length > 0 && mini.removeClass(this._bodyEl, "mini-grid-hidden-y")
				}
				0 == l.length && (i.firstChild.firstChild.style.height = "1px", this._bodyEl.scrollWidth > this._bodyEl.clientWidth ? i.style.height = "1px" : i.style.height = "auto"), o && (a >= this._bodyEl.scrollWidth - 1 ? this._bodyEl.style.height = "auto" : this._bodyEl.style.height = i.offsetHeight + 17 + "px"), o && t && (this._bodyEl.style.height = "auto")
			} else e.style.width = i.style.width = "0px", n.style.width = s.style.width = "0px", c >= u || o ? mini.isIE8 && this.data.length > 0 && mini.addClass(this._bodyEl, "mini-grid-hidden-y") : mini.isIE8 && this.data.length > 0 && mini.removeClass(this._bodyEl, "mini-grid-hidden-y"), 0 == l.length && (i.style.height = "1px", this._bodyEl.scrollWidth > this._bodyEl.clientWidth ? i.style.height = "1px" : i.style.height = "auto");
			if (this.isFitColumns())
				if (u > c) {
					var p = r - 18;
					0 > p && (p = 0)
				} else this._headerInnerEl.style.width = "100%", this._filterEl.style.width = "100%", this._summaryEl.style.width = "100%", this._footerEl.style.width = "auto";
			else this._headerInnerEl.style.width = "100%", this._filterEl.style.width = "100%", this._summaryEl.style.width = "100%", this._footerEl.style.width = "auto";
			if (this.isFrozen() && (c < this._bodyEl.scrollHeight ? this._scrollEl.style.width = r - 17 + "px" : this._scrollEl.style.width = r + "px", this._bodyEl.offsetWidth < i.offsetWidth || this.isFrozen() ? (this._scrollEl.firstChild.style.width = this._getColumnsScrollWidth() + "px", e.style.width = i.style.width = "0px", n.style.width = s.style.width = "0px") : this._scrollEl.firstChild.style.width = "0px"), 0 == this.data.length) this._doInnerLayout();else {
				var f = this;
				this._innerLayoutTimer || (this._innerLayoutTimer = setTimeout(function() {
					f._doInnerLayout(), f._innerLayoutTimer = null
				}, 10))
			}
			this._doLayoutTopRightCell(), this.fire("layout"), this.isFrozen() && this._scrollEl.scrollLeft != this.__frozenScrollLeft && this._doScrollFrozen()
		}
	},
	_doLayoutTopRightCell : function() {
		var t = this._headerInnerEl.firstChild,
			e = t.offsetWidth + 1,
			i = t.offsetHeight - 1;
		0 > i && (i = 0), this._topRightCellEl.style.left = e + "px", this._topRightCellEl.style.height = i + "px"
	},
	_doInnerLayout : function() {
		this._doLayoutDetailRows(), this._doLayoutEditingRows(), mini.layout(this._filterEl), mini.layout(this._summaryEl), mini.layout(this._footerEl), mini.repaint(this.el), this._doLayouted = !0
	},
	setFitColumns : function(t) {
		this.fitColumns = t, this.fitColumns ? mini.removeClass(this.el, "mini-grid-fixcolumns") : mini.addClass(this.el, "mini-grid-fixcolumns"), this.doLayout()
	},
	getFitColumns : function(t) {
		return this.fitColumns
	},
	isFitColumns : function() {
		return this.fitColumns && !this.isFrozen()
	},
	_getColumnsScrollWidth : function() {
		if (this._bodyEl.offsetWidth < this._bodyInnerEl.firstChild.offsetWidth || this.isFrozen()) {
			for (var t = 0, e = this.getBottomColumns(), i = 0, n = e.length; n > i; i++) {
				var s = e[i];
				t += this.getColumnWidth(s)
			}
			return t
		}
		return 0
	},
	_createRowId : function(t) {
		return this.uid + "$" + t._uid
	},
	_createCellId : function(t, e) {
		return this.uid + "$" + t._uid + "$" + e._id
	},
	_createFilterCellId : function(t) {
		return this.uid + "$filter$" + t._id
	},
	_createSummaryCellId : function(t) {
		return this.uid + "$summary$" + t._id
	},
	_createRowDetailId : function(t) {
		return this.uid + "$detail$" + t._uid
	},
	_getHeaderScrollEl : function() {
		return this._headerInnerEl
	},
	getFilterCellEl : function(t) {
		return t = this.getColumn(t), t ? mini.byId(this._createFilterCellId(t), this.el) : null
	},
	getSummaryCellEl : function(t) {
		return t = this.getColumn(t), t ? mini.byId(this._createSummaryCellId(t), this.el) : null
	},
	_getRowEl : function(t) {
		if (t = this._getRow(t), !t) return null;
		var e = this._createRowId(t);
		return mini.byId(e, this.el)
	},
	getCellBox : function(t, e) {
		if (t = this._getRow(t), e = this.getColumn(e), !t || !e) return null;
		var i = this._getCellEl(t, e);
		return i ? mini.getBox(i) : null
	},
	getRowBox : function(t) {
		var e = this._getRowEl(t);
		return e ? mini.getBox(e) : null
	},
	getRowsBox : function() {
		for (var t = [], e = this.data, i = 0, n = 0, s = e.length; s > n; n++) {
			var o = e[n],
				l = this._createRowId(o),
				r = document.getElementById(l);
			if (r) {
				var a = r.offsetHeight;
				t[n] = {
					top : i,
					height : a,
					bottom : i + a
				}, i += a
			}
		}
		return t
	},
	setColumnWidth : function(t, e) {
		if (t = this.getColumn(t)) {
			mini.isNumber(e) && (e += "px"), t.width = e;
			var i = this._createColumnId(t) + "$header",
				n = this._createColumnId(t) + "$body",
				s = this._createColumnId(t) + "$filter",
				o = this._createColumnId(t) + "$summary",
				l = document.getElementById(i),
				r = document.getElementById(n),
				a = document.getElementById(s),
				h = document.getElementById(o);
			l && (l.style.width = e), r && (r.style.width = e), a && (a.style.width = e), h && (h.style.width = e), this.doLayout(), this.fire("columnschanged")
		}
	},
	getColumnWidth : function(t) {
		if (t = this.getColumn(t), !t) return 0;
		if (0 == t.visible) return 0;
		var e = 0,
			i = this._createColumnId(t) + "$body",
			n = document.getElementById(i);
		if (n) {
			var s = n.style.display;
			n.style.display = "", e = mini.getWidth(n), n.style.display = s
		}
		return e
	},
	_doVisibleColumn : function(t, e) {
		var i = document.getElementById(this._createColumnId(t));
		i && (i.style.display = e ? "" : "none");
		var n = document.getElementById(this._createFilterCellId(t));
		n && (n.style.display = e ? "" : "none");
		var s = document.getElementById(this._createSummaryCellId(t));
		s && (s.style.display = e ? "" : "none");
		var o = this._createColumnId(t) + "$header",
			l = this._createColumnId(t) + "$body",
			r = this._createColumnId(t) + "$filter",
			a = this._createColumnId(t) + "$summary",
			h = document.getElementById(o);
		h && (h.style.display = e ? "" : "none");
		var d = document.getElementById(r);
		d && (d.style.display = e ? "" : "none");
		var u = document.getElementById(a);
		if (u && (u.style.display = e ? "" : "none"), c) {
			if (e && "" == c.style.display) return;
			if (!e && "none" == c.style.display) return
		}
		var c = document.getElementById(l);
		c && (c.style.display = e ? "" : "none");
		var m = this.data;
		if (this.isVirtualScroll())
			for (var p = this._markRegion(), f = p.start, g = p.end, _ = f, v = g; v > _; _++) {
				var y = m[_],
					C = this._createCellId(y, t),
					w = document.getElementById(C);
				w && (w.style.display = e ? "" : "none")
		}
		else
			for (var _ = 0, v = this.data.length; v > _; _++) {
				var y = this.data[_],
					C = this._createCellId(y, t),
					w = document.getElementById(C);
				w && (w.style.display = e ? "" : "none")
		}
	},
	_doClassColumn : function(t, e, i) {
		var n = this.data;
		if (this.isVirtualScroll())
			for (var s = this._markRegion(), o = s.start, l = s.end, r = o, a = l; a > r; r++) {
				var h = n[r],
					d = this._createCellId(h, t),
					u = document.getElementById(d);
				u && (i ? mini.addClass(u, e) : mini.removeClass(u, e))
		}
		else
			for (var r = 0, a = this.data.length; a > r; r++) {
				var h = this.data[r],
					d = this._createCellId(h, t),
					u = document.getElementById(d);
				u && (i ? mini.addClass(u, e) : mini.removeClass(u, e))
		}
	},
	__doFrozen : function() {
		this._scrollEl.scrollLeft = this._headerInnerEl.scrollLeft = this._bodyEl.scrollLeft = 0;
		var t = this.isFrozen();
		t ? mini.addClass(this.el, this._frozenCls) : mini.removeClass(this.el, this._frozenCls);
		var e = this.getBottomColumns(),
			i = this._filterEl.firstChild,
			n = this._summaryEl.firstChild;
		if (t ? (i.style.height = jQuery(i).outerHeight() + "px", n.style.height = jQuery(n).outerHeight() + "px") : (i.style.height = "auto", n.style.height = "auto"), this.isFrozen()) {
			for (var s = 0, o = e.length; o > s; s++) {
				var l = e[s];
				this.frozenStartColumn <= s && s <= this.frozenEndColumn ? this._doClassColumn(l, this._frozenCellCls, !0) : this._doClassColumn(l, this._frozenCellCls, !1)
			}
			this._doFixRowsHeight(!0)
		} else {
			for (var s = 0, o = e.length; o > s; s++) {
				var l = e[s];
				delete l._hide
				, l.visible && this._doVisibleColumn(l, !0), this._doClassColumn(l, this._frozenCellCls, !1)
			}
			this._doUpdateHeader(), this._doFixRowsHeight(!1)
		}
		this.doLayout(), this._fixIE()
	},
	_deferFrozen : function() {
		this._headerTableHeight = mini.getHeight(this._headerInnerEl.firstChild);
		var t = this;
		this._deferFrozenTimer && clearTimeout(this._deferFrozenTimer), this._deferFrozenTimer = setTimeout(function() {
			t.__doFrozen()
		}, 1)
	},
	setFrozenStartColumn : function(t) {
		new Date, t = parseInt(t), isNaN(t) || (this.frozenStartColumn = t, this._deferFrozen())
	},
	getFrozenStartColumn : function() {
		return this.frozenStartColumn
	},
	setFrozenEndColumn : function(t) {
		t = parseInt(t), isNaN(t) || (this.frozenEndColumn = t, this._deferFrozen())
	},
	getFrozenEndColumn : function() {
		return this.frozenEndColumn
	},
	unFrozenColumns : function() {
		this.setFrozenStartColumn(-1), this.setFrozenEndColumn(-1)
	},
	frozenColumns : function(t, e) {
		this.unFrozenColumns(), this.setFrozenStartColumn(t), this.setFrozenEndColumn(e)
	},
	_rowHeight : 23,
	_markRegion : function() {
		for (var t = this._getViewNowRegion(), e = this._rowHeight, i = (this._bodyEl.scrollTop, t.start), n = t.end, s = 0, o = this.data.length; o > s; s += this._virtualRows) {
			var l = s + this._virtualRows;
			i >= s && l > i && (i = s), n > s && l >= n && (n = l)
		}
		n > this.data.length && (n = this.data.length);
		var r = i * e;
		return this._viewRegion = {
				start : i,
				end : n,
				top : r
			}, this._viewRegion
	},
	_getViewNowRegion : function() {
		var t = this._rowHeight,
			e = this._bodyEl.scrollTop,
			i = this._bodyEl.offsetHeight,
			n = parseInt(e / t),
			s = parseInt((e + i) / t) + 1,
			o = {
				start : n,
				end : s
			};
		return o
	},
	_canVirtualUpdate : function() {
		if (null == this.data || 0 == this.data.length) return !1;
		if (!this._viewRegion) return !0;
		var t = this._getViewNowRegion();
		return this._viewRegion.start <= t.start && t.end <= this._viewRegion.end ? !1 : !0
	},
	_tryUpdateScroll : function() {
		var t = this._canVirtualUpdate();
		t && this.doUpdate()
	},
	__OnBodyScroll : function(t) {
		this._filterEl.scrollLeft = this._summaryEl.scrollLeft = this._headerInnerEl.scrollLeft = this._bodyEl.scrollLeft;
		var e = this;
		if (setTimeout(function() {
				e._headerInnerEl.scrollLeft = e._bodyEl.scrollLeft
			}, 10), this.isVirtualScroll()) {
			var e = this;
			this._scrollTopTimer && clearTimeout(this._scrollTopTimer), this._scrollTopTimer = setTimeout(function() {
				e._scrollTopTimer = null, e._tryUpdateScroll()
			}, 100)
		}
	},
	__OnHScroll : function(t) {
		var e = this;
		this._HScrollTimer || (this._HScrollTimer = setTimeout(function() {
			e._doScrollFrozen(), e._HScrollTimer = null
		}, 30))
	},
	_doScrollFrozen : function(t) {
		if (this.isFrozen()) {
			var e = this.getBottomColumns(),
				i = this._scrollEl.scrollLeft;
			this.__frozenScrollLeft = i;
			for (var n = this.frozenEndColumn, s = 0, o = n + 1, l = e.length; l > o; o++) {
				var r = e[o];
				if (r.visible) {
					var a = this.getColumnWidth(r);
					if (s >= i) break;
					n = o, s += a
				}
			}
			if (t || this._lastStartColumn !== n) {
				this._lastStartColumn = n;
				for (var o = 0, l = e.length; l > o; o++) {
					var r = e[o];
					delete r._hide
					, this.frozenEndColumn < o && n >= o && (r._hide = !0)
				}
				for (var o = 0, l = e.length; l > o; o++) {
					var r = e[o];
					o < this.frozenStartColumn || o > this.frozenEndColumn && n > o || 0 == r.visible ? this._doVisibleColumn(r, !1) : this._doVisibleColumn(r, !0)
				}
				var h = "width:100%;";
				(this._scrollEl.offsetWidth < this._scrollEl.scrollWidth || !this.isFitColumns()) && (h = "width:0px"), this._doUpdateHeader(h);
				var d = this._headerTableHeight;
				mini.isIE9 && (d -= 1), mini.setHeight(this._headerInnerEl.firstChild, d);
				for (var o = this.frozenEndColumn + 1, l = e.length; l > o; o++) {
					var r = e[o];
					r.visible && (n >= o ? this._doVisibleColumn(r, !1) : this._doVisibleColumn(r, !0))
				}
				this._doUpdateDetailColSpan(), this._doMargeCells(), this._doLayoutTopRightCell(), this.fire("layout")
			}
		}
	},
	_doFixRowsHeight : function(t) {
		for (var e = this.data, i = 0, n = e.length; n > i; i++) {
			var s = e[i],
				o = this._getRowEl(s);
			if (o)
				if (t) {
					var l = 0;
					o.style.height = l + "px"
				} else
					o.style.height = ""
		}
	},
	_doGridLines : function() {
		this.showVGridLines ? mini.removeClass(this.el, "mini-grid-hideVLine") : mini.addClass(this.el, "mini-grid-hideVLine"), this.showHGridLines ? mini.removeClass(this.el, "mini-grid-hideHLine") : mini.addClass(this.el, "mini-grid-hideHLine")
	},
	setShowHGridLines : function(t) {
		this.showHGridLines != t && (this.showHGridLines = t, this._doGridLines(), this.doLayout())
	},
	getShowHGridLines : function() {
		return this.showHGridLines
	},
	setShowVGridLines : function(t) {
		this.showVGridLines != t && (this.showVGridLines = t, this._doGridLines(), this.doLayout())
	},
	getShowVGridLines : function() {
		return this.showVGridLines
	},
	setShowFilterRow : function(t) {
		this.showFilterRow != t && (this.showFilterRow = t, this._doShowRows(), this.doLayout())
	},
	getShowFilterRow : function() {
		return this.showFilterRow
	},
	setShowSummaryRow : function(t) {
		this.showSummaryRow != t && (this.showSummaryRow = t, this._doShowRows(), this.doLayout())
	},
	getShowSummaryRow : function() {
		return this.showSummaryRow
	},
	_doAlternating : function() {
		if (0 != this.allowAlternating)
			for (var t = this.data, e = 0, i = t.length; i > e; e++) {
				var n = t[e],
					s = this._getRowEl(n);
				s && (this.allowAlternating && e % 2 == 1 ? mini.addClass(s, this._alternatingCls) : mini.removeClass(s, this._alternatingCls))
		}
	},
	setAllowAlternating : function(t) {
		this.allowAlternating != t && (this.allowAlternating = t, this._doAlternating())
	},
	getAllowAlternating : function() {
		return this.allowAlternating
	},
	setEnableHotTrack : function(t) {
		this.enableHotTrack != t && (this.enableHotTrack = t)
	},
	getEnableHotTrack : function() {
		return this.enableHotTrack
	},
	setShowLoading : function(t) {
		this.showLoading = t
	},
	setAllowCellWrap : function(t) {
		this.allowCellWrap != t && (this.allowCellWrap = t)
	},
	getAllowCellWrap : function() {
		return this.allowCellWrap
	},
	setAllowHeaderWrap : function(t) {
		this.allowHeaderWrap = t, mini.removeClass(this.el, "mini-grid-headerWrap"), t && mini.addClass(this.el, "mini-grid-headerWrap")
	},
	getAllowHeaderWrap : function() {
		return this.allowHeaderWrap
	},
	setShowColumnsMenu : function(t) {
		this.showColumnsMenu = t
	},
	getShowColumnsMenu : function() {
		return this.showColumnsMenu
	},
	setEditNextOnEnterKey : function(t) {
		this.editNextOnEnterKey = t
	},
	getEditNextOnEnterKey : function() {
		return this.editNextOnEnterKey
	},
	setEditOnTabKey : function(t) {
		this.editOnTabKey = t
	},
	getEditOnTabKey : function() {
		return this.editOnTabKey
	},
	setVirtualScroll : function(t) {
		this.virtualScroll != t && (this.virtualScroll = t)
	},
	getVirtualScroll : function() {
		return this.virtualScroll
	},
	setScrollTop : function(t) {
		this.scrollTop = t, this._bodyEl.scrollTop = t
	},
	getScrollTop : function() {
		return this._bodyEl.scrollTop
	},
	setBodyStyle : function(t) {
		this.bodyStyle = t, mini.setStyle(this._bodyEl, t)
	},
	getBodyStyle : function() {
		return this.bodyStyle
	},
	setBodyCls : function(t) {
		this.bodyCls = t, mini.addClass(this._bodyEl, t)
	},
	getBodyCls : function() {
		return this.bodyCls
	},
	setFooterStyle : function(t) {
		this.footerStyle = t, mini.setStyle(this._footerEl, t)
	},
	getFooterStyle : function() {
		return this.footerStyle
	},
	setFooterCls : function(t) {
		this.footerCls = t, mini.addClass(this._footerEl, t)
	},
	getFooterCls : function() {
		return this.footerCls
	},
	setShowHeader : function(t) {
		this.showHeader = t, this._doShowRows(), this.doLayout()
	},
	setShowPager : function(t) {
		this.setShowFooter(t)
	},
	getShowPager : function() {
		return this.showFooter
	},
	setShowFooter : function(t) {
		this.showFooter = t, this._doShowRows(), this.doLayout()
	},
	getShowFooter : function() {
		return this.showFooter
	},
	setAutoHideRowDetail : function(t) {
		this.autoHideRowDetail = t
	},
	setSortMode : function(t) {
		this.sortMode = t
	},
	getSortMode : function() {
		return this.sortMode
	},
	setAllowSortColumn : function(t) {
		this.allowSortColumn = t
	},
	getAllowSortColumn : function() {
		return this.allowSortColumn
	},
	setAllowMoveColumn : function(t) {
		this.allowMoveColumn = t
	},
	getAllowMoveColumn : function() {
		return this.allowMoveColumn
	},
	setAllowResizeColumn : function(t) {
		this.allowResizeColumn = t
	},
	getAllowResizeColumn : function() {
		return this.allowResizeColumn
	},
	setSelectOnLoad : function(t) {
		this.selectOnLoad = t
	},
	getSelectOnLoad : function() {
		return this.selectOnLoad
	},
	setAllowResize : function(t) {
		this.allowResize = t, this._resizeEl.style.display = this.allowResize ? "" : "none"
	},
	getAllowResize : function() {
		return this.allowResize
	},
	setShowEmptyText : function(t) {
		this.showEmptyText = t
	},
	getShowEmptyText : function() {
		return this.showEmptyText
	},
	setEmptyText : function(t) {
		this.emptyText = t
	},
	getEmptyText : function() {
		return this.emptyText
	},
	setShowModified : function(t) {
		this.showModified = t
	},
	getShowModified : function() {
		return this.showModified
	},
	setShowNewRow : function(t) {
		this.showNewRow = t
	},
	getShowNewRow : function() {
		return this.showNewRow
	},
	setCellEditAction : function(t) {
		this.cellEditAction = t
	},
	getCellEditAction : function() {
		return this.cellEditAction
	},
	setAllowCellValid : function(t) {
		this.allowCellValid = t
	},
	getAllowCellValid : function() {
		return this.allowCellValid
	},
	__allowLayout : !0,
	showAllRowDetail : function() {
		this.__allowLayout = !1;
		for (var t = 0, e = this.data.length; e > t; t++) {
			var i = this.data[t];
			this.showRowDetail(i)
		}
		this.__allowLayout = !0, this.doLayout()
	},
	hideAllRowDetail : function() {
		this.__allowLayout = !1;
		for (var t = 0, e = this.data.length; e > t; t++) {
			var i = this.data[t];
			this.isShowRowDetail(i) && this.hideRowDetail(i)
		}
		this.__allowLayout = !0, this.doLayout()
	},
	showRowDetail : function(t) {
		if (t = this._getRow(t)) {
			var e = this.getRowDetailEl(t);
			e.style.display = "", t._showDetail = !0;
			var i = this._getRowEl(t);
			mini.addClass(i, "mini-grid-expandRow"), this.fire("showrowdetail", {
				record : t
			}), this.__allowLayout && this.doLayout()
		}
	},
	hideRowDetail : function(t) {
		if (t = this._getRow(t)) {
			var e = this._createRowDetailId(t),
				i = document.getElementById(e);
			i && (i.style.display = "none"),
			delete t._showDetail;
			var n = this._getRowEl(t);
			mini.removeClass(n, "mini-grid-expandRow"), this.fire("hiderowdetail", {
				record : t
			}), this.__allowLayout && this.doLayout()
		}
	},
	toggleRowDetail : function(t) {
		t = this._getRow(t), t && (grid.isShowRowDetail(t) ? grid.hideRowDetail(t) : grid.showRowDetail(t))
	},
	isShowRowDetail : function(t) {
		return t = this._getRow(t), t ? !!t._showDetail : !1
	},
	getRowDetailEl : function(t) {
		if (t = this._getRow(t), !t) return null;
		var e = this._createRowDetailId(t),
			i = document.getElementById(e);
		return i || (i = this._createRowDetail(t)), i
	},
	getRowDetailCellEl : function(t) {
		var e = this.getRowDetailEl(t);
		return e ? e.cells[0] : void 0
	},
	_createRowDetail : function(t) {
		var e = this._getRowEl(t),
			i = this._createRowDetailId(t),
			n = this.getBottomColumns().length;
		return jQuery(e).after('<tr id="' + i + '" class="mini-grid-detailRow"><td class="mini-grid-detailCell" colspan="' + n + '"></td></tr>'), this._doUpdateDetailColSpan(), document.getElementById(i)
	},
	_getColSpan : function() {
		for (var t = this._bodyInnerEl.firstChild.getElementsByTagName("tr")[0], e = t.getElementsByTagName("td"), i = 0, n = 0, s = e.length; s > n; n++) {
			var o = e[n];
			"none" != o.style.display && i++
		}
		return i
	},
	_doUpdateDetailColSpan : function() {
		for (var t = jQuery(".mini-grid-detailRow", this.el), e = this._getColSpan(), i = 0, n = t.length; n > i; i++) {
			var s = t[i],
				o = s.firstChild;
			o.colSpan = e
		}
	},
	_doLayoutDetailRows : function() {
		for (var t = 0, e = this.data.length; e > t; t++) {
			var i = this.data[t];
			if (1 == i._showDetail) {
				var n = this._createRowDetailId(i),
					s = document.getElementById(n);
				s && mini.layout(s)
			}
		}
	},
	_doLayoutEditingRows : function() {
		for (var t = 0, e = this.data.length; e > t; t++) {
			var i = this.data[t];
			if (1 == i._editing) {
				var n = this._getRowEl(i);
				n && mini.layout(n)
			}
		}
	},
	__OnPageChanged : function(t) {
		return 0 != this.data.length || t.isreload ? (this.fire("pagechanged", t), void (1 != t.cancel && this.gotoPage(t.pageIndex, t.pageSize, t.totalCount))) : void this.setPageSize(t.pageSize)
	},
	setShowReloadButton : function(t) {
		this.pager.setShowReloadButton(t)
	},
	getShowReloadButton : function() {
		return this.pager.getShowReloadButton()
	},
	setShowPageInfo : function(t) {
		this.pager.setShowPageInfo(t)
	},
	getShowPageInfo : function() {
		return this.pager.getShowPageInfo()
	},
	setSizeList : function(t) {
		mini.isArray(t) && this.pager.setSizeList(t)
	},
	getSizeList : function() {
		return this.pager.getSizeList()
	},
	setPageSize : function(t) {
		t = parseInt(t), isNaN(t) || (this.pageSize = t, this.pager && this.pager.update(this.pageIndex, this.pageSize, this.totalCount), this.diypager && this.diypager.update(this.pageIndex, this.pageSize, this.totalCount))
	},
	getPageSize : function() {
		return this.pageSize
	},
	setPageIndex : function(t) {
		t = parseInt(t), isNaN(t) || (this.pageIndex = t, this.pager && this.pager.update(this.pageIndex, this.pageSize, this.totalCount), this.diypager && this.diypager.update(this.pageIndex, this.pageSize, this.totalCount))
	},
	getPageIndex : function() {
		return this.pageIndex
	},
	setShowPageSize : function(t) {
		this.showPageSize = t, this.pager.setShowPageSize(t)
	},
	getShowPageSize : function() {
		return this.showPageSize
	},
	setShowPageIndex : function(t) {
		this.showPageIndex = t, this.pager.setShowPageIndex(t)
	},
	getShowPageIndex : function() {
		return this.showPageIndex
	},
	setShowTotalCount : function(t) {
		this.showTotalCount = t, this.pager.setShowTotalCount(t)
	},
	setIgnoreTotalBusiness : function(t) {
		this.ignoreTotalBusiness = t
	},
	getShowTotalCount : function() {
		return this.showTotalCount
	},
	setPageIndexField : function(t) {
		this.pageIndexField = t
	},
	getPageIndexField : function() {
		return this.pageIndexField
	},
	setPageSizeField : function(t) {
		this.pageSizeField = t
	},
	getPageSizeField : function() {
		return this.pageSizeField
	},
	setSortFieldField : function(t) {
		this.sortFieldField = t
	},
	getSortFieldField : function() {
		return this.sortFieldField
	},
	setSortOrderField : function(t) {
		this.sortOrderField = t
	},
	getSortOrderField : function() {
		return this.sortOrderField
	},
	setTotalField : function(t) {
		this.totalField = t
	},
	getTotalField : function() {
		return this.totalField
	},
	setDependMerge : function(t) {
		this.dependMerge = t
	},
	getDependMerge : function() {
		return this.dependMerge
	},
	setDataField : function(t) {
		this.dataField = t
	},
	getDataField : function() {
		return this.dataField
	},
	getSortField : function() {
		return this.sortField
	},
	getSortOrder : function() {
		return this.sortOrder
	},
	pageIndex : 0,
	pageSize : 10,
	totalCount : 0,
	totalPage : 0,
	showPageInfo : !0,
	pageIndexField : "pageIndex",
	pageSizeField : "pageSize",
	sortFieldField : "sortField",
	sortOrderField : "sortOrder",
	totalField : "total",
	showPageSize : !0,
	showPageIndex : !0,
	showTotalCount : !0,
	ignoreTotalBusiness : !1,
	setTotalCount : function(t) {
		this.totalCount = t, this.pager.setTotalCount(t), this.diypager && this.diypager.setTotalCount(t)
	},
	getTotalCount : function() {
		return this.totalCount
	},
	getTotalPage : function() {
		return this.totalPage
	},
	sortField : "",
	sortOrder : "",
	url : "",
	autoLoad : !1,
	loadParams : null,
	ajaxAsync : !0,
	ajaxMethod : "post",
	ajaxTimeout : 3e4,
	showLoading : !0,
	resultAsData : !1,
	checkSelectOnLoad : !0,
	setCheckSelectOnLoad : function(t) {
		this.checkSelectOnLoad = t
	},
	getCheckSelectOnLoad : function() {
		return this.checkSelectOnLoad
	},
	totalField : "total",
	dataField : "data",
	_getFromData : function(t) {
		return t.data
	},
	getResultObject : function() {
		return this._resultObject ? this._resultObject : {}
	},
	_doLoad : function(params, success, fail) {
		try {
			var url = eval(this.url);
			void 0 != url && (this.url = url)
		} catch (e) {}
		params = params || {}, mini.isNull(params.pageIndex) && (params.pageIndex = 0), mini.isNull(params.pageSize) && (params.pageSize = this.pageSize), params.sortField = this.sortField, params.sortOrder = this.sortOrder, "server" != this.sortMode && (params.sortField = this.sortField = "", params.sortOrder = this.sortOrder = ""), this.loadParams = params;
		var o = {};
		o[this.pageIndexField] = params.pageIndex, o[this.pageSizeField] = params.pageSize, params.sortField && (o[this.sortFieldField] = params.sortField), params.sortOrder && (o[this.sortOrderField] = params.sortOrder), mini.copyTo(params, o);
		var url = this.url,
			ajaxMethod = this.ajaxMethod,
			e = {
				url : url,
				async : this.ajaxAsync,
				type : ajaxMethod,
				data : params,
				params : params,
				timeout : this.ajaxTimeout,
				cache : !1,
				cancel : !1
			};
		if (this.fire("beforeload", e), e.data != e.params && e.params != params && (e.data = e.params), 1 == e.cancel) return params.pageIndex = this.getPageIndex(), void (params.pageSize = this.getPageSize());
		this.showLoading && this.loading(), this._selectedValue = this._selected ? this._selected[this.idField] : null;
		var sf = me = this,
			url = e.url;
		mini.copyTo(e, {
			success : function(t, e, i) {
				var n = null;
				try {
					n = mini.decode(t)
				} catch (s) {
					1 == mini_debugger && alert(url + "\ndatagrid json is error.")
				}
				if (n && !mini.isArray(n)) n.total = parseInt(mini._getMap(me.totalField, n)), n.data = mini._getMap(me.dataField, n);
				else if (null == n) n = {}, n.data = [], n.total = 0;
				else if (mini.isArray(n)) {
					var o = {};
					o.data = n, o.total = n.length, n = o
				}
				n.data || (n.data = []), n.total || (n.total = 0);
				var l = sf.getPageIndex();
				if (!sf.ignoreTotalBusiness && l > 0 && n.total > 0 && 0 == n.data.length) return l -= 1, void sf.gotoPage(l);
				if (sf._resultObject = n, sf.unmask(), mini.isNumber(n.error) && 0 != n.error) {
					var r = {
						errorCode : n.error,
						xmlHttp : i,
						errorMsg : n.message,
						result : n
					};
					return sf.fire("loaderror", r), void (fail && fail.call(sf, r))
				}
				var a = n.total,
					h = sf._getFromData(n);
				mini.isNumber(params.pageIndex) && (sf.pageIndex = params.pageIndex), mini.isNumber(params.pageSize) && (sf.pageSize = params.pageSize), sf.ignoreTotalBusiness ? sf.totalCount = h.length : mini.isNumber(a) && (sf.totalCount = a);
				var s = {
					result : n,
					data : h,
					total : a,
					cancel : !1,
					xmlHttp : i
				};
				if (sf.fire("preload", s), 1 != s.cancel) {
					var d = sf._allowLayout;
					if (sf._allowLayout = !1, sf.loadData(s.data), sf._selectedValue && sf.checkSelectOnLoad) {
						var u = sf.getRowById(sf._selectedValue);
						u ? sf.select(u) : sf.deselectAll()
					} else sf._selected && sf.deselectAll();
					null == sf.getSelected() && sf.selectOnLoad && sf.data.length > 0 && sf.select(0), sf.collapseGroupOnLoad && sf.collapseGroups(), sf._allowLayout = d, sf.doLayout(), sf.fire("load", s), success && success.call(sf, s)
				}
			},
			error : function(t, e, i) {
				var n = {
					xmlHttp : t,
					errorMsg : t.responseText,
					errorCode : t.status
				};
				1 == mini_debugger && 1 == this.loadErrorAlert && alert("network error"), sf.fire("loaderror", n), sf.unmask(), fail && fail.call(sf, n)
			}
		}), this._ajaxer = mini.ajax(e)
	},
	load : function(t, e, i) {
		this._loadTimer && clearTimeout(this._loadTimer);
		var n = this,
			s = mini.byClass("mini-grid-emptyText", this.el);
		s && (s.style.display = "none"), this.cancelEdit(), this.loadParams = t || {}, this.ajaxAsync ? this._loadTimer = setTimeout(function() {
			n._doLoad(t, e, i)
		}, 1) : n._doLoad(t, e, i)
	},
	reload : function(t, e) {
		this.accept(), this.load(this.loadParams, t, e)
	},
	gotoPage : function(t, e, i) {
		var n = this.loadParams || {};
		mini.isNumber(t) && (n.pageIndex = t), mini.isNumber(e) && (n.pageSize = e), mini.isNumber(i) && (n.totalCount = i), this.load(n)
	},
	sortBy : function(t, e) {
		if (this.sortField = t, this.sortOrder = "asc" == e ? "asc" : "desc", "server" == this.sortMode && this.url && this.data.length > 0) {
			var i = this.loadParams || {};
			i.sortField = t, i.sortOrder = e, i.pageIndex = this.pageIndex;
			var n = this;
			this.load(i, function() {
				n.fire("sort")
			})
		} else {
			var s = this.data.clone(),
				o = this._getSortFnByField(t);
			if (!o) return;
			for (var l = [], r = s.length - 1; r >= 0; r--) {
				var a = s[r],
					h = mini._getMap(t, a);
				(mini.isNull(h) || "" === h) && (l.insert(0, a), s.removeAt(r))
			}
			s = s.clone(), mini.sort(s, o, this), s.insertRange(0, l), "desc" == this.sortOrder && s.reverse(), this.data = s, this.doUpdate(), this.fire("sort")
		}
	},
	clearSort : function() {
		this.sortField = "", this.sortOrder = "", this.reload()
	},
	_getSortFnByField : function(t) {
		function e(e, i) {
			var n = mini._getMap(t, e),
				s = mini._getMap(t, i),
				o = a(n),
				l = a(s);
			return o > l ? 1 : o == l ? 0 : -1
		}
		if (!t) return null;
		for (var i = "string", n = null, s = this.getBottomColumns(), o = 0, l = s.length; l > o; o++) {
			var r = s[o];
			if (r.field == t) {
				r.dataType && (i = r.dataType.toLowerCase());break
			}
		}
		var a = mini.sortTypes[i];
		return a || (a = mini.sortTypes.string), n = e
	},
	allowCellSelect : !1,
	allowCellEdit : !1,
	_cellSelectedCls : "mini-grid-cell-selected",
	_currentCell : null,
	_editingCell : null,
	_editingControl : null,
	_editWrap : null,
	_doCurrentCell : function(t) {
		if (this._currentCell) {
			var e = this._currentCell[0],
				i = this._currentCell[1],
				n = this._getCellEl(e, i);
			n && (t ? mini.addClass(n, this._cellSelectedCls) : mini.removeClass(n, this._cellSelectedCls))
		}
	},
	setCurrentCell : function(t) {
		if (this._currentCell != t) {
			if (this._doCurrentCell(!1), this._currentCell = t, t) {
				var e = this._getRow(t[0]),
					i = this.getColumn(t[1]);
				e && i ? this._currentCell = [ e, i ] : this._currentCell = null
			}
			this._doCurrentCell(!0), t && (this.isFrozen() ? this.scrollIntoView(t[0]) : this.scrollIntoView(t[0])), this.fire("currentcellchanged")
		}
	},
	getCurrentCell : function() {
		var t = this._currentCell;
		return t && -1 == this.data.indexOf(t[0]) && (this._currentCell = null, t = null), t
	},
	setAllowCellSelect : function(t) {
		this.allowCellSelect = t
	},
	getAllowCellSelect : function(t) {
		return this.allowCellSelect
	},
	setAllowCellEdit : function(t) {
		this.allowCellEdit = t
	},
	getAllowCellEdit : function(t) {
		return this.allowCellEdit
	},
	beginEditCell : function(t, e) {
		t = this._getRow(t), e = this.getColumn(e);
		var i = [ t, e ];
		t && e && this.setCurrentCell(i);
		var i = this.getCurrentCell();
		if ((!this._editingCell || !i || this._editingCell[0] != i[0] || this._editingCell[1] != i[1]) && (this._editingCell && this.commitEdit(), i)) {
			var t = i[0],
				e = i[1],
				n = this._OnCellBeginEdit(t, e, this.getCellEditor(e));
			n !== !1 && (this.scrollIntoView(t, e), this._editingCell = i, this._OnCellShowingEdit(t, e))
		}
	},
	isEditingCell : function(t) {
		return this._editingCell && this._editingCell[0] == t[0] && this._editingCell[1] == t[1]
	},
	cancelEdit : function() {
		if (this.allowCellEdit) this._editingCell && this._OnCellEndEdit();
		else if (this.isEditing()) {
			this._allowLayout = !1;
			for (var t = this.data.clone(), e = 0, i = t.length; i > e; e++) {
				var n = t[e];
				1 == n._editing && this.cancelEditRow(e)
			}
			this._allowLayout = !0, this.doLayout()
		}
	},
	commitEdit : function() {
		if (this.allowCellEdit) this._editingCell && (this._OnCellCommitEdit(this._editingCell[0], this._editingCell[1]), this._OnCellEndEdit());
		else if (this.isEditing()) {
			this._allowLayout = !1;
			for (var t = this.data.clone(), e = 0, i = t.length; i > e; e++) {
				var n = t[e];
				1 == n._editing && this.commitEditRow(e)
			}
			this._allowLayout = !0, this.doLayout()
		}
	},
	getCellEditor : function(t, e) {
		if (t = this.getColumn(t)) {
			if (this.allowCellEdit) {
				var i = t.__editor;
				return i || (i = mini.getAndCreate(t.editor)), i && i != t.editor && (t.editor = i), i
			}
			if (e = this._getRow(e), t = this.getColumn(t), e || (e = this.getEditingRow()), !e || !t) return null;
			var n = this.uid + "$" + e._uid + "$" + t._id + "$editor";
			return mini.get(n)
		}
	},
	_OnCellBeginEdit : function(t, e, i) {
		var n = mini._getMap(e.field, t),
			s = {
				sender : this,
				rowIndex : this.data.indexOf(t),
				row : t,
				record : t,
				column : e,
				field : e.field,
				editor : i,
				value : n,
				cancel : !1
			};
		if (this.fire("cellbeginedit", s), !mini.isNull(e.defaultValue) && (mini.isNull(s.value) || "" === s.value)) {
			var o = e.defaultValue,
				l = mini.clone({
					d : o
				});
			s.value = l.d
		}
		var i = s.editor;
		if (n = s.value, s.cancel) return !1;
		if (!i) return !1;
		if (mini.isNull(n) && (n = ""), i.setValue && i.setValue(n), i.ownerRowID = t._uid, e.displayField && i.setText) {
			var r = mini._getMap(e.displayField, t);
			if (!mini.isNull(e.defaultText) && (mini.isNull(r) || "" === r)) {
				var l = mini.clone({
					d : e.defaultText
				});
				r = l.d
			}
			i.setText(r)
		}
		return this.allowCellEdit && (this._editingControl = s.editor), !0
	},
	_OnCellCommitEdit : function(t, e, i, n) {
		var s = {
			sender : this,
			record : t,
			rowIndex : this.data.indexOf(t),
			row : t,
			column : e,
			field : e.field,
			editor : n ? n : this.getCellEditor(e),
			value : mini.isNull(i) ? "" : i,
			text : "",
			cancel : !1
		};
		s.editor && s.editor.getValue && (s.editor.getFormValue ? s.value = s.editor.getFormValue() : s.value = s.editor.getValue()), s.editor && s.editor.getText && (s.text = s.editor.getText());
		var o = t[e.field],
			l = s.value;
		if (mini.isEquals(o, l)) return s;
		if (this.fire("cellcommitedit", s), 0 == s.cancel && this.allowCellEdit) {
			var r = {};
			if (mini._setMap(e.field, s.value, r), e.displayField && mini._setMap(e.displayField, s.text, r), this.updateRow(t, r), this._mergedCellMaps) {
				var a = this.getBottomColumns(),
					h = t._index,
					d = a.indexOf(e);
				if (this._mergedCellMaps[h + ":" + d])
					for (var u = h + 1; u < this.data.length && 1 == this._mergedCellMaps[u + ":" + d]; u++) this.updateRow(this._getRow(u), r)
			}
		}
		return s
	},
	_OnCellEndEdit : function() {
		if (this._editingCell) {
			var t = this._editingCell[0],
				e = this._editingCell[1],
				i = {
					sender : this,
					record : t,
					rowIndex : this.data.indexOf(t),
					row : t,
					column : e,
					field : e.field,
					editor : this._editingControl,
					value : t[e.field]
				};
			if (this.fire("cellendedit", i), this.allowCellEdit) {
				var n = i.editor;
				n && n.setIsValid && n.setIsValid(!0), this._editWrap && (this._editWrap.style.display = "none");
				for (var s = this._editWrap.childNodes, o = s.length - 1; o >= 0; o--) {
					var l = s[o];
					this._editWrap.removeChild(l)
				}
				n && n.hidePopup && n.hidePopup(), n && n.setValue && n.setValue(""), this._editingControl = null, this._editingCell = null, this.allowCellValid && this.validateCell(t, e)
			}
		}
	},
	_OnCellShowingEdit : function(t, e) {
		if (!this._editingControl) return !1;
		var i = this.getCellBox(t, e),
			n = mini.getViewportBox().width;
		i.right > n && (i.width = n - i.left, i.width < 10 && (i.width = 10), i.right = i.left + i.width);
		var s = {
			sender : this,
			rowIndex : this.data.indexOf(t),
			record : t,
			row : t,
			column : e,
			field : e.field,
			cellBox : i,
			editor : this._editingControl
		};
		this.fire("cellshowingedit", s);
		var o = s.editor;
		o && o.setIsValid && o.setIsValid(!0);
		var l = this._getCellEl(t, e);
		if (this._getEditWrap(i, l), this._editWrap.style.zIndex = mini.getMaxZIndex(), o.render ? (o.render(this._editWrap), setTimeout(function() {
				if (o.focus(), o.selectText && o.selectText(), "radiobuttonlist" == o.type || "checkboxlist" == o.type) {
					var t = o.getValue();
					o.setValue(""), o.setValue(t)
				}
			}, 50), o.setVisible && o.setVisible(!0)) : o.el && (this._editWrap.appendChild(o.el), setTimeout(function() {
				try {
					o.el.focus()
				} catch (t) {}
			}, 50)), o.setWidth) {
			var r = i.width;
			20 > r && (r = 20), o.setWidth(r)
		}
		if (o.setHeight && "textarea" == o.type) {
			var a = i.height - 1;
			o.minHeight && a < o.minHeight && (a = o.minHeight), o.setHeight(a)
		}
		if (o.setWidth && "textarea" == o.type) {
			var r = i.width - 1;
			o.minWidth && r < o.minWidth && (r = o.minWidth), o.setWidth(r)
		}
		mini.on(document, "mousedown", this.__OnBodyMouseDown, this), e.autoShowPopup && o.showPopup && o.showPopup()
	},
	__OnBodyMouseDown : function(t) {
		if (this._editingControl) {
			var e = this._getCellByEvent(t);
			if (this._editingCell && e && this._editingCell[0] == e.record && this._editingCell[1] == e.column) return !1;
			var i = !1;
			if (i = this._editingControl.within ? this._editingControl.within(t) : mini.isAncestor(this._editWrap, t.target), 0 == i) {
				var n = this;
				if (0 == mini.isAncestor(this._bodyEl, t.target)) setTimeout(function() {
						n.commitEdit()
					}, 1);else {
					var s = n._editingCell;
					setTimeout(function() {
						var t = n._editingCell;
						s == t && n.commitEdit()
					}, 70)
				}
				mini.un(document, "mousedown", this.__OnBodyMouseDown, this)
			}
		}
	},
	_getEditWrap : function(t, e) {
		this._editWrap || (this._editWrap = mini.append(document.body, '<div class="mini-grid-editwrap" style="position:absolute;"></div>'), mini.on(this._editWrap, "keydown", this.___OnEditControlKeyDown, this));
		var i = $(e).css("line-height");
		i.indexOf("px") && (i = i.substr(0, i.length - 2));
		var n = t.y + (t.height - i) / 2;
		this._editWrap.style.zIndex = 1e9, this._editWrap.style.display = "block", mini.setXY(this._editWrap, t.x, n), mini.setWidth(this._editWrap, t.width), mini.setHeight(this._editWrap, i);
		var s = mini.getViewportBox().width;
		return t.x > s && mini.setX(this._editWrap, -1e3), this._editWrap
	},
	___OnEditControlKeyDown : function(t) {
		var e = this._editingControl;
		if (13 != t.keyCode || !e || "textarea" != e.type)
			if (13 == t.keyCode) {
				var i = this._editingCell;
				if (i && i[1] && i[1].enterCommit === !1) return;
				this.commitEdit(), this.focus(), this.editNextOnEnterKey && (this.fire("celleditenter", {
					record : i[0]
				}), this._beginEditNextCell(0 == t.shiftKey))
			} else
				27 == t.keyCode ? (this.cancelEdit(), this.focus()) : 9 == t.keyCode && (this.commitEdit(), this.editOnTabKey && (t.preventDefault(), this.commitEdit(), this._beginEditNextCell(0 == t.shiftKey)))
	},
	editNextOnEnterKey : !1,
	editOnTabKey : !0,
	createOnEnter : !1,
	_beginEditNextCell : function(t) {
		var e = this,
			i = this.getCurrentCell();
		if (i) {
			this.focus();
			var n = e.getBottomVisibleColumns(),
				s = i ? i[1] : null,
				o = i ? i[0] : null,
				l = n.indexOf(s),
				r = e.indexOf(o);
			if (e.data.length, t === !1) {
				if (l -= 1, s = n[l], !s && (s = n[n.length - 1], o = e.getAt(r - 1), !o)) return
			} else if (l += 1, s = n[l], !s && (s = n[0], o = e.getAt(r + 1), !o)) {
				if (!this.createOnEnter) return;
				o = {}, this.addRow(o)
			}
			var i = [ o, s ];
			e.setCurrentCell(i), e.onlyCheckSelection || e.getCurrent() != o && (e.deselectAll(), e.setCurrent(o)), e.scrollIntoView(o, s), e.beginEditCell()
		}
	},
	getEditorOwnerRow : function(t) {
		var e = t.ownerRowID;
		return this.getRowByUID(e)
	},
	beginEditRow : function(row) {
		if (!this.allowCellEdit) {
			var sss = new Date;
			if (row = this._getRow(row)) {
				var rowEl = this._getRowEl(row);
				if (rowEl) {
					row._editing = !0;
					var s = this._createRow(row),
						rowEl = this._getRowEl(row);
					jQuery(rowEl).before(s), rowEl.parentNode.removeChild(rowEl);
					var rowEl = this._getRowEl(row);
					mini.addClass(rowEl, "mini-grid-rowEdit");
					for (var columns = this.getBottomColumns(), i = 0, l = columns.length; l > i; i++) {
						var column = columns[i],
							value = row[column.field],
							cellId = this._createCellId(row, columns[i]),
							cellEl = document.getElementById(cellId);
						if (cellEl) {
							"string" == typeof column.editor && (column.editor = eval("(" + column.editor + ")"));
							var editorConfig = mini.copyTo({}, column.editor);
							editorConfig.id = this.uid + "$" + row._uid + "$" + column._id + "$editor";
							var editor = mini.create(editorConfig);
							if (this._OnCellBeginEdit(row, column, editor) && editor && (mini.addClass(cellEl, "mini-grid-cellEdit"), cellEl.innerHTML = "", cellEl.appendChild(editor.el), mini.addClass(editor.el, "mini-grid-editor"), "radiobuttonlist" == editor.type || "checkboxlist" == editor.type)) {
								var value = editor.getValue();
								editor.setValue(""), editor.setValue(value)
							}
						}
					}
					this.doLayout()
				}
			}
		}
	},
	cancelEditRow : function(t) {
		if (!this.allowCellEdit && (t = this._getRow(t), t && t._editing)) {
			delete t._editing;
			for (var e = this._getRowEl(t), i = this.getBottomColumns(), n = 0, s = i.length; s > n; n++) {
				var o = (i[n], this._createCellId(t, i[n])),
					l = document.getElementById(o),
					r = l.firstChild,
					a = mini.get(r);
				a && a.destroy()
			}
			var h = this._createRow(t);
			jQuery(e).before(h), e.parentNode.removeChild(e), this.doLayout()
		}
	},
	commitEditRow : function(t) {
		if (!this.allowCellEdit && (t = this._getRow(t), t && t._editing)) {
			var e = this.getEditRowData(t);
			this._canUpdateRowEl = !1, this.updateRow(t, e), this._canUpdateRowEl = !0, this.cancelEditRow(t)
		}
	},
	isEditing : function() {
		for (var t = 0, e = this.data.length; e > t; t++) {
			var i = this.data[t];
			if (1 == i._editing) return !0
		}
		return !1
	},
	isEditingRow : function(t) {
		return t = this._getRow(t), t ? !!t._editing : !1
	},
	isNewRow : function(t) {
		return "added" == t._state
	},
	getEditingRows : function() {
		for (var t = [], e = 0, i = this.data.length; i > e; e++) {
			var n = this.data[e];
			1 == n._editing && t.push(n)
		}
		return t
	},
	getEditingRow : function() {
		var t = this.getEditingRows();
		return t[0]
	},
	getEditData : function(t) {
		for (var e = [], i = 0, n = this.data.length; n > i; i++) {
			var s = this.data[i];
			if (1 == s._editing) {
				var o = this.getEditRowData(i, t);
				o._index = i, e.push(o)
			}
		}
		return e
	},
	getEditRowData : function(t, e) {
		if (t = this._getRow(t), !t || !t._editing) return null;
		for (var i = {}, n = this.getBottomColumns(), s = 0, o = n.length; o > s; s++) {
			var l = n[s],
				r = this._createCellId(t, n[s]),
				a = document.getElementById(r),
				h = null;
			if ("checkboxcolumn" == l.type || "radiobuttoncolumn" == l.type) {
				var d = l.getCheckBoxEl(t),
					u = d.checked ? l.trueValue : l.falseValue;
				h = this._OnCellCommitEdit(t, l, u)
			} else {
				var c = a.firstChild,
					m = mini.get(c);
				if (!m) continue;
				h = this._OnCellCommitEdit(t, l, null, m)
			}
			mini._setMap(l.field, h.value, i), l.displayField && mini._setMap(l.displayField, h.text, i)
		}
		if (mini._setMap(this.idField, t[this.idField], i), e) {
			var p = mini.copyTo({}, t);
			i = mini.copyTo(p, i)
		}
		return i
	},
	getChanges : function(t, e) {
		var i = [];
		t && "removed" != t || i.addRange(this._removes);
		for (var n = 0, s = this.data.length; s > n; n++) {
			var o = this.data[n];
			!o._state || t && t != o._state || i.push(o)
		}
		if (e)
			for (var n = 0, s = i.length; s > n; n++) {
				var o = i[n];
				if ("modified" == o._state) {
					var l = {};
					l[this.idField] = o[this.idField];
					for (var r in o) {
						var a = this._HasRowModified(o, r);
						a && (l[r] = o[r])
					}
					i[n] = l
				}
		}
		return i
	},
	isChanged : function() {
		var t = this.getChanges();
		return t.length > 0
	},
	_originalIdField : "_uid",
	_getOriginal : function(t) {
		var e = t[this._originalIdField],
			i = this._originals[e];
		return i || (i = this._originals[e] = {}), i
	},
	_HasRowModified : function(t, e) {
		var i = this._originals[t[this._originalIdField]];
		return i ? mini.isNull(e) ? !1 : i.hasOwnProperty(e) : !1
	},
	_doUpdateRow : function(t, e) {
		var i = !1,
			n = mini.objToLine(e);
		for (var s in n) {
			var o,
				l;
			if (o = null == e[s] ? mini._getMap(s, e) : e[s], l = null == t[s] ? mini._getMap(s, t) : t[s], !mini.isEquals(l, o)) {
				if (mini._setMap(s, o, t), "added" != t._state) {
					t._state = "modified";
					var r = this._getOriginal(t);
					r.hasOwnProperty(s) || (r[s] = l)
				}
				i = !0
			}
		}
		return i
	},
	_canUpdateRowEl : !0,
	_updateRowEl : function(t) {
		var e = this,
			i = e._createRow(t),
			n = e._getRowEl(t);
		jQuery(n).before(i), n.parentNode.removeChild(n)
	},
	updateRow : function(t, e, i) {
		if (t = this._getRow(t), t && e) {
			if ("string" == typeof e) {
				var n = {};
				n[e] = i, e = n
			}
			var s = this._doUpdateRow(t, e);
			0 != s && (this._canUpdateRowEl && this._updateRowEl(t), "modified" == t._state && this.fire("updaterow", {
				record : t,
				row : t
			}), t == this.getSelected() && this._OnCurrentChanged(t), this._doMargeCells(), this._deferUpdateSummaryRow(), this._deferLayout())
		}
	},
	deleteRows : function(t) {
		if (mini.isArray(t)) {
			t = t.clone();
			for (var e = 0, i = t.length; i > e; e++) this.deleteRow(t[e])
		}
	},
	deleteRow : function(t) {
		if (t = this._getRow(t), t && "deleted" != t._state) {
			if ("added" == t._state) this.removeRow(t, !0);else {
				this.isEditingRow(t) && this.cancelEditRow(t), t._state = "deleted";
				var e = this._getRowEl(t);
				mini.addClass(e, "mini-grid-deleteRow"), this.fire("deleterow", {
					record : t,
					row : t
				})
			}
			this._doUpdateSummaryRow()
		}
	},
	removeRows : function(t, e) {
		if (mini.isArray(t)) {
			t = t.clone();
			for (var i = 0, n = t.length; n > i; i++) this.removeRow(t[i], e)
		}
	},
	removeSelected : function() {
		var t = this.getSelected();
		t && this.removeRow(t, !0)
	},
	removeRow : function(t, e) {
		if (t = this._getRow(t)) {
			var i = t == this.getSelected(),
				n = this.isSelected(t),
				s = this.data.indexOf(t);
			this.data.remove(t), "added" != t._state && (t._state = "removed", this._removes.push(t),
			delete this._originals[t[this._originalIdField]]
			),
			delete this._idRows[t._uid];
			var o = (this._createRow(t), this._getRowEl(t));
			o && o.parentNode.removeChild(o);
			var l = this._createRowDetailId(t),
				r = document.getElementById(l);
			if (r && r.parentNode.removeChild(r), n && e) {
				var a = this.getAt(s);
				a || (a = this.getAt(s - 1)), this.deselectAll(), this.select(a)
			}
			this._checkSelecteds(), this._removeRowError(t), this.fire("removerow", {
				record : t,
				row : t
			}), i && this._OnCurrentChanged(t), this._doAlternating(), this._deferLayout(), this._deferUpdateMergeCells(), this._deferUpdateSummaryRow()
		}
	},
	autoCreateNewID : !1,
	addRows : function(t, e) {
		if (mini.isArray(t)) {
			t = t.clone();
			for (var i = 0, n = t.length; n > i; i++) this.addRow(t[i], e), !mini.isNull(e) && mini.isNumber(e) && e++
		}
	},
	addRow : function(t, e) {
		mini.isNull(e) && (e = this.data.length), e = this.indexOf(e);
		var i = this._getRow(e);
		if (this.data.insert(e, t), !t[this.idField]) {
			this.autoCreateNewID && (t[this.idField] = UUID());
			var n = {
				row : t,
				record : t
			};
			this.fire("beforeaddrow", n)
		}
		t._state = "added",
		delete this._idRows[t._uid]
		, t._uid = mini.DataGrid.RowID++, this._idRows[t._uid] = t;
		var s = this._createRow(t);
		if (i) {
			var o = this._getRowEl(i);
			jQuery(o).before(s)
		} else mini.append(this._bodyInnerEl.firstChild, s);
		this._doAlternating(), this._deferLayout(), this.fire("addrow", {
			record : t,
			row : t
		});
		var l = jQuery(".mini-grid-emptyText", this._bodyEl)[0];
		l && mini.removeNode(l.parentNode), this._doUpdateMergeCells(), this._deferUpdateSummaryRow()
	},
	moveRow : function(t, e) {
		if (t = this._getRow(t), t && !(0 > e || e > this.data.length)) {
			var i = this._getRow(e);
			if (t != i) {
				this.data.remove(t);
				var n = this._getRowEl(t);
				if (i) {
					e = this.data.indexOf(i), this.data.insert(e, t);
					var s = this._getRowEl(i);
					jQuery(s).before(n)
				} else {
					this.data.insert(this.data.length, t);
					var o = this._bodyInnerEl.firstChild;
					mini.append(o.firstChild || o, n)
				}
				this._doAlternating(), this._deferLayout(), this.scrollIntoView(t), this.fire("moverow", {
					record : t,
					row : t,
					index : e
				}), this._doMargeCells()
			}
		}
	},
	moveUp : function(t) {
		if (mini.isArray(t)) {
			var e = this;
			t = t.sort(function(t, i) {
				var n = e.indexOf(t),
					s = e.indexOf(i);
				return n > s ? 1 : -1
			});
			for (var i = 0, n = t.length; n > i; i++) {
				var s = t[i],
					o = this.indexOf(s);
				this.moveRow(s, o - 1)
			}
		}
	},
	moveDown : function(t) {
		if (mini.isArray(t)) {
			var e = this;
			t = t.sort(function(t, i) {
				var n = e.indexOf(t),
					s = e.indexOf(i);
				return n > s ? 1 : -1
			}), t.reverse();
			for (var i = 0, n = t.length; n > i; i++) {
				var s = t[i],
					o = this.indexOf(s);
				this.moveRow(s, o + 2)
			}
		}
	},
	clearRows : function() {
		this.data = [], this.doUpdate()
	},
	indexOf : function(t) {
		if ("number" == typeof t) return t;
		if (this.isGrouping()) {
			var e = this._getGroupDataView();
			return e.data.indexOf(t)
		}
		return this.data.indexOf(t)
	},
	getAt : function(t) {
		if (this.isGrouping()) {
			var e = this._getGroupDataView();
			return e.data[t]
		}
		return this.data[t]
	},
	getRow : function(t) {
		if (null == t) return null;
		var e = typeof t;
		return "number" == e ? this.data[t] : "object" == e ? void 0 == t._index ? t : this.data[t._index] : this.getRowById(t)
	},
	_getRow : function(t) {
		var e = typeof t;
		return "number" == e ? this.data[t] : "object" == e ? t : this.getRowById(t)
	},
	getRowByValue : function(t) {
		for (var e = 0, i = this.data.length; i > e; e++) {
			var n = this.data[e];
			if (n[this.idField] == t) return n
		}
	},
	getRowById : function(t) {
		return this.getRowByValue(t)
	},
	getRowByUID : function(t) {
		return this._idRows[t]
	},
	findRows : function(t) {
		var e = [];
		if (t)
			for (var i = 0, n = this.data.length; n > i; i++) {
				var s = this.data[i],
					o = t(s);
				if (o === !0 && e.push(s), 1 === o) break
		}
		return e
	},
	findRow : function(t) {
		if (t)
			for (var e = 0, i = this.data.length; i > e; e++) {
				var n = this.data[e];
				if (t(n) === !0) return n
		}
	},
	collapseGroupOnLoad : !1,
	setCollapseGroupOnLoad : function(t) {
		this.collapseGroupOnLoad = t
	},
	getCollapseGroupOnLoad : function() {
		return this.collapseGroupOnLoad
	},
	showGroupSummary : !1,
	setShowGroupSummary : function(t) {
		this.showGroupSummary = t
	},
	getShowGroupSummary : function() {
		return this.showGroupSummary
	},
	collapseGroups : function() {
		if (this._groupDataView)
			for (var t = 0, e = this._groupDataView.length; e > t; t++) {
				var i = this._groupDataView[t];
				this._CollapseGroup(i)
		}
	},
	expandGroups : function() {
		if (this._groupDataView)
			for (var t = 0, e = this._groupDataView.length; e > t; t++) {
				var i = this._groupDataView[t];
				this._ExpandGroup(i)
		}
	},
	_CollapseGroup : function(t) {
		for (var e = t.rows, i = 0, n = e.length; n > i; i++) {
			var s = e[i],
				o = this._getRowEl(s);
			o && (o.style.display = "none");var o = this.getRowDetailEl(s);
			o && (o.style.display = "none")
		}
		t.expanded = !1;
		var l = this.uid + "$group$" + t.id,
			r = document.getElementById(l);
		r && mini.addClass(r, "mini-grid-group-collapse"), this.doLayout()
	},
	_ExpandGroup : function(t) {
		for (var e = t.rows, i = 0, n = e.length; n > i; i++) {
			var s = e[i],
				o = this._getRowEl(s);
			o && (o.style.display = "");var o = this.getRowDetailEl(s);
			o && (o.style.display = s._showDetail ? "" : "none")
		}
		t.expanded = !0;
		var l = this.uid + "$group$" + t.id,
			r = document.getElementById(l);
		r && mini.removeClass(r, "mini-grid-group-collapse"), this.doLayout()
	},
	_GroupID : 1,
	_groupField : "",
	_groupDir : "",
	groupBy : function(t, e, i) {
		t && (this._groupField = t, "string" == typeof e && (e = e.toLowerCase()), this._groupDir = e, this.__fzhj = i, this._groupDataView = null, this.doUpdate())
	},
	clearGroup : function() {
		this._groupField = "", this._groupDir = "", this._groupDataView = null, this.doUpdate()
	},
	getGroupField : function() {
		return this._groupField
	},
	getGroupDir : function() {
		return this._groupDir
	},
	isGrouping : function() {
		return "" != this._groupField
	},
	_getGroupDataView : function() {
		if (0 == this.isGrouping()) return null;
		if (!this._groupDataView) {
			var t = this._groupField,
				e = this._groupDir,
				i = this.data.clone();
			"function" == typeof e ? mini.sort(i, e) : (mini.sort(i, function(e, i) {
				var n = e[t],
					s = i[t];
				return n > s ? 1 : 0
			}, this), "desc" == e && i.reverse());
			for (var n = [], s = {}, o = 0, l = i.length; l > o; o++) {
				var r = i[o],
					a = r[t],
					h = mini.isDate(a) ? a.getTime() : a,
					d = s[h];
				d || (d = s[h] = {}, d.header = t, d.field = t, d.dir = e, d.value = a, d.rows = [], n.push(d), d.id = this._GroupID++), d.rows.push(r)
			}
			this._groupDataView = n;
			for (var i = [], o = 0, l = n.length; l > o; o++) i.addRange(n[o].rows);
			this._groupDataView.data = i
		}
		return this._groupDataView
	},
	_getGroupByID : function(t) {
		if (!this._groupDataView) return null;
		for (var e = this._groupDataView, i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			if (s.id == t) return s
		}
	},
	_OnDrawGroup : function(t) {
		var e = {
			group : t,
			rows : t.rows,
			field : t.field,
			dir : t.dir,
			value : t.value,
			cellHtml : t.header + " : " + t.value
		};
		return this.fire("drawgroup", e), e
	},
	onDrawGroupHeader : function(t, e) {
		this.on("drawgroupheader", t, e)
	},
	onDrawGroupSummary : function(t, e) {
		this.on("drawgroupsummary", t, e)
	},
	mergeColumns : function(t) {
		function e(t) {
			for (var e = [], i = 0; i < o.length; i++)
				for (var n = 0; n < t.length; n++) o[i].name == t[n] && e.push(t[n]);
			return e
		}
		function i(t) {
			if (t.field) {
				for (var e = [], i = -1, n = 1, s = o.indexOf(t), r = null, a = 0, h = l.length; h > a; a++) {
					var d = l[a],
						u = d[t.field];
					if (-1 == i || u != r) {
						if (n > 1) {
							var c = {
								rowIndex : i,
								columnIndex : s,
								rowSpan : n,
								colSpan : 1
							};
							e.push(c)
						}
						i = a, n = 1, r = u
					} else n++
				}
				return e
			}
		}
		function n(t, e, i) {
			function n(t, e, i) {
				for (var n = [], s = -1, l = 1, r = o.indexOf(t), a = null, h = 0, d = e.rowSpan; d >= h; h++) {
					var u = i[e.rowIndex + h],
						c = u[t.field];
					if (-1 == s || c != a || h == d) {
						if (l > 1) {
							var m = {
								rowIndex : s,
								columnIndex : r,
								rowSpan : l,
								colSpan : 1
							};
							n.push(m)
						}
						s = e.rowIndex + h, l = 1, a = c
					} else l++
				}
				return n
			}
			if (t.field) {
				for (var s = [], r = (o.indexOf(t), o.indexOf(i), 0), a = e.length; a > r; r++) {
					var h = n(t, e[r], l);
					h && s.addRange(h)
				}
				return s
			}
		}
		t && 0 == mini.isArray(t) && (t = [ t ]), this.mergeColumnsData = t;
		var s = this,
			o = s.getBottomColumns();
		t || (t = o);
		var l = s.data.clone();
		l.push({});
		var r,
			a,
			h = [];
		this.dependMerge && (t = e(t));
		for (var d = 0, u = t.length; u > d; d++) {
			var c = t[d];
			if (c = s.getColumn(c)) {
				var m;
				this.dependMerge ? (m = 0 == d ? i(c) : n(c, r, a), r = m, a = c) : m = i(c), m && h.addRange(m)
			}
		}
		s.mergeCells(h)
	},
	mergeCells : function(t) {
		function e(t, e, n, s, o) {
			for (var l = t, r = t + n; r > l; l++)
				for (var a = e, h = e + s; h > a; a++) l == t && a == e ? i[l + ":" + a] = o : i[l + ":" + a] = !0
		}
		if (mini.isArray(t)) {
			this._margedCells = t, this._doMargeCells();
			var i = this._mergedCellMaps = {},
				t = this._margedCells;
			if (t)
				for (var n = 0, s = t.length; s > n; n++) {
					var o = t[n];
					o.rowSpan || (o.rowSpan = 1), o.colSpan || (o.colSpan = 1), e(o.rowIndex, o.columnIndex, o.rowSpan, o.colSpan, o)
			}
		}
	},
	margeCells : function(t) {
		this.mergeCells(t)
	},
	_isCellVisible : function(t, e) {
		if (!this._mergedCellMaps) return !0;
		var i = this._mergedCellMaps[t + ":" + e];
		return !(i === !0)
	},
	_deferUpdateMergeCells : function() {
		var t = this;
		this._mergeTimer || (this._mergeTimer = setTimeout(function() {
			t._doUpdateMergeCells(), t._mergeTimer = null
		}, 1))
	},
	_doUpdateMergeCells : function() {
		function t(t) {
			for (var e = {}, i = 0, n = t.length; n > i; i++) {
				var s = t[i];
				e[s.columnIndex] ? e[s.columnIndex].push(s) : (e[s.columnIndex] = [], e[s.columnIndex].push(s))
			}
			return e
		}
		var e = this._margedCells;
		if (e) {
			var i = t(e);
			this._clearMergeCell(i), this.mergeColumns(this.mergeColumnsData), this._doUpdateBody()
		}
	},
	_clearMergeCell : function(t) {
		var e = [];
		for (rowIndex in t)
			for (var i = 0, n = this.getData().length; n > i; i++) {
				var s = {
					rowIndex : i,
					columnIndex : rowIndex,
					rowSpan : 1,
					colSpan : 1
				};
				e.push(s)
		}
		this.mergeCells(e)
	},
	_doMargeCells : function() {
		function t() {
			var t = this._margedCells;
			if (t)
				for (var e = 0, i = t.length; i > e; e++) {
					var n = t[e];
					n.rowSpan || (n.rowSpan = 1), n.colSpan || (n.colSpan = 1);
					for (var s = this._getCellEls(n.rowIndex, n.columnIndex, n.rowSpan, n.colSpan), o = 0, l = s.length; l > o; o++) {
						var r = s[o];
						0 != o ? r.style.display = "none" : (r.rowSpan = n.rowSpan, r.colSpan = n.colSpan)
					}
			}
		}
		t.call(this)
	},
	_getCellEls : function(t, e, i, n) {
		var s = [];
		if (!mini.isNumber(t)) return [];
		if (!mini.isNumber(e)) return [];
		for (var o = (this.getBottomColumns(), this.data, t), l = t + i; l > o; o++)
			for (var r = e, a = e + n; a > r; r++) {
				var h = this._getCellEl(o, r);
				h && s.push(h)
		}
		return s
	},
	_selected : null,
	_selecteds : [],
	_checkSelecteds : function() {
		for (var t = this._selecteds, e = t.length - 1; e >= 0; e--) {
			var i = t[e];
			0 == !!this._idRows[i._uid] && (t.removeAt(e),
			delete this._idSelecteds[i._uid]
			)
		}
		this._selected && 0 == !!this._idSelecteds[this._selected._uid] && (this._selected = null)
	},
	setAllowUnselect : function(t) {
		this.allowUnselect = t
	},
	getAllowUnselect : function(t) {
		return this.allowUnselect
	},
	setAllowRowSelect : function(t) {
		this.allowRowSelect = t
	},
	getAllowRowSelect : function(t) {
		return this.allowRowSelect
	},
	setMultiSelect : function(t) {
		this.multiSelect != t && (this.multiSelect = t, this._doUpdateHeader())
	},
	getMultiSelect : function() {
		return this.multiSelect
	},
	_getSelectAllCheckState : function() {
		var t = this.data,
			e = !0;
		if (0 == t.length) return e = !1;
		for (var i = 0, n = 0, s = t.length; s > n; n++) {
			var o = t[n];
			this.isSelected(o) && i++
		}
		return e = t.length == i ? !0 : 0 == i ? !1 : "has"
	},
	_fireSelect : function(t, e) {
		var i = {
			record : t,
			cancel : !1
		};
		return this.fire(e, i), !i.cancel
	},
	isSelected : function(t) {
		return t = this._getRow(t), t ? !!this._idSelecteds[t._uid] : !1
	},
	getSelecteds : function() {
		return this._checkSelecteds(), this._selecteds.clone()
	},
	setCurrent : function(t) {
		this.setSelected(t)
	},
	getCurrent : function() {
		return this.getSelected()
	},
	getSelected : function() {
		return this._checkSelecteds(), this._selected
	},
	scrollIntoView : function(t, e) {
		try {
			if (e) {
				var i = this._getCellEl(t, e);
				mini.scrollIntoView(i, this._bodyEl, !0)
			} else {
				var n = this._getRowEl(t);
				mini.scrollIntoView(n, this._bodyEl, !1)
			}
		} catch (s) {}
	},
	setSelected : function(t) {
		t ? this.select(t) : this.deselect(this._selected), this._selected && this.scrollIntoView(this._selected), this._blurRow()
	},
	select : function(t, e) {
		0 == this.multiSelect && this.deselectAll(), t = this._getRow(t), t && (this._selected = t, this.selects([ t ], e))
	},
	deselect : function(t, e) {
		t = this._getRow(t), t && this.deselects([ t ], e)
	},
	selectAll : function(t) {
		var e = this.data.clone();
		this.selects(e, t)
	},
	deselectAll : function(t) {
		var e = this._selecteds.clone();
		this._selected = null, this.deselects(e, t)
	},
	clearSelect : function(t) {
		this.deselectAll(t)
	},
	selects : function(t, e) {
		if (t && 0 != t.length) {
			new Date, t = t.clone();
			for (var i = t.length - 1; i >= 0; i--) {
				var n = this._getRow(t[i]);
				n ? t[i] = n : t.removeAt(i)
			}
			for (var s = {}, o = this.data, i = 0, l = o.length; l > i; i++) {
				var r = this._getRow(o[i]),
					a = r[this.idField];
				a && (s[r[this.idField]] = r)
			}
			for (var h = [], i = 0, l = t.length; l > i; i++) {
				var n = t[i],
					d = this._idRows[n._uid];
				d || (n = s[n[this.idField]]), n && h.push(n)
			}
			t = h, t = t.clone(), this._doSelects(t, !0);
			for (var i = 0, l = t.length; l > i; i++) {
				var n = t[i];
				if (!this.isSelected(n)) {
					if (e !== !1 && !this._fireSelect(n, "beforeselect")) continue;
					this._selecteds.push(n), this._idSelecteds[n._uid] = n, e !== !1 && this.fire("select", {
						record : n
					})
				}
			}
			this._OnSelectionChanged()
		}
	},
	deselects : function(t, e) {
		t || (t = []), t = t.clone();
		for (var i = t.length - 1; i >= 0; i--) {
			var n = this._getRow(t[i]);
			n ? t[i] = n : t.removeAt(i)
		}
		t = t.clone(), this._doSelects(t, !1);
		for (var i = t.length - 1; i >= 0; i--) {
			var n = t[i];
			if (this.isSelected(n)) {
				if (e !== !1 && !this._fireSelect(n, "beforedeselect")) continue;
				for (var s = 0, o = 0; o < this._selecteds.length; o++) this._selecteds[o]._uid === n._uid && (s = o);
				s >= 0 && this._selecteds.splice(s, 1),
				delete this._idSelecteds[n._uid]
				, e !== !1 && this.fire("deselect", {
					record : n
				})
			}
		}
		-1 != t.indexOf(this._selected) && (this._selected = null), this._OnSelectionChanged()
	},
	_doSelects : function(t, e) {
		for (var i = (new Date, 0), n = t.length; n > i; i++) {
			var s = t[i];
			e ? this.addRowCls(s, this._rowSelectedCls) : this.removeRowCls(s, this._rowSelectedCls)
		}
	},
	_OnSelectionChanged : function() {
		this._selectionTimer && clearTimeout(this._selectionTimer);
		var t = this;
		this._selectionTimer = setTimeout(function() {
			var e = {
				selecteds : t.getSelecteds(),
				selected : t.getSelected()
			};
			t.fire("SelectionChanged", e), t._OnCurrentChanged(e.selected)
		}, 1)
	},
	_OnCurrentChanged : function(t) {
		this._currentTimer && clearTimeout(this._currentTimer);
		var e = this;
		this._currentTimer = setTimeout(function() {
			var i = {
				record : t,
				row : t
			};
			e.fire("CurrentChanged", i), e._currentTimer = null
		}, 1)
	},
	addRowCls : function(t, e) {
		var i = this._getRowEl(t);
		i && mini.addClass(i, e)
	},
	removeRowCls : function(t, e) {
		var i = this._getRowEl(t);
		i && mini.removeClass(i, e)
	},
	setReadOnly : function(t) {
		mini.DataGrid.superclass.setReadOnly.call(this, t);
		for (var e = mini.getChildControls(this), i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			s.el && mini.findParent(s.el, this._rowCls) && s.setReadOnly && s.setReadOnly(t)
		}
	},
	_focusRow : function(t, e) {
		if (t = this._getRow(t), t && t != this._focusedRow) {
			var i = this._getRowEl(t);
			e && i && this.scrollIntoView(t), this._focusedRow != t && (this._blurRow(), this._focusedRow = t, mini.addClass(i, this._rowHoverCls))
		}
	},
	_blurRow : function() {
		if (this._focusedRow) {
			var t = this._getRowEl(this._focusedRow);
			t && mini.removeClass(t, this._rowHoverCls), this._focusedRow = null
		}
	},
	_getRecordByEvent : function(t) {
		var e = mini.findParent(t.target, this._rowCls);
		if (!e) return null;
		var i = e.id.split("$"),
			n = i[i.length - 1];
		return this.getRowByUID(n)
	},
	__OnMousewheel : function(t, e) {
		this.allowCellEdit && this.commitEdit();
		var i = jQuery(this._bodyEl).css("overflow-y");
		if ("hidden" == i) {
			var n = t.wheelDelta || 24 * -t.detail,
				s = this._bodyEl.scrollTop;
			s -= n, this._bodyEl.scrollTop = s, s == this._bodyEl.scrollTop && t.preventDefault();
			var t = {
				scrollTop : this._bodyEl.scrollTop,
				direction : "vertical"
			};
			this.fire("scroll", t)
		}
	},
	__OnClick : function(t) {
		var e = mini.findParent(t.target, "mini-grid-groupRow");
		if (e) {
			var i = e.id.split("$"),
				n = i[i.length - 1],
				s = this._getGroupByID(n);
			if (s) {
				var o = !(s.expanded === !1 ? !1 : !0);
				o ? this._ExpandGroup(s) : this._CollapseGroup(s)
			}
		} else this._fireEvent(t, "Click")
	},
	_tryFocus : function(t) {
		if (!t.target.tagName) return !1;
		var e = t.target.tagName.toLowerCase();
		if ("input" != e && "textarea" != e && "select" != e && mini.findParent(t.target, "mini-grid"))
			if (mini.isAncestor(this._filterEl, t.target) || mini.isAncestor(this._summaryEl, t.target) || mini.isAncestor(this._footerEl, t.target) || mini.findParent(t.target, "mini-grid-rowEdit") || mini.findParent(t.target, "mini-grid-detailRow"))
				;else {
				var i = this;
				i.focus()
		}
	},
	__OnDblClick : function(t) {
		this._fireEvent(t, "Dblclick")
	},
	__OnMouseDown : function(t) {
		this._fireEvent(t, "MouseDown"), this._tryFocus(t)
	},
	__OnMouseUp : function(t) {
		mini.isAncestor(this.el, t.target) && (this._tryFocus(t), this._fireEvent(t, "MouseUp"))
	},
	__OnMouseMove : function(t) {
		this._fireEvent(t, "MouseMove")
	},
	__OnMouseOver : function(t) {
		this._fireEvent(t, "MouseOver")
	},
	__OnMouseOut : function(t) {
		this._fireEvent(t, "MouseOut")
	},
	__OnKeyDown : function(t) {
		this._fireEvent(t, "KeyDown")
	},
	__OnKeyUp : function(t) {
		this._fireEvent(t, "KeyUp")
	},
	__OnContextMenu : function(t) {
		this._fireEvent(t, "ContextMenu")
	},
	_fireEvent : function(t, e) {
		if (this.enabled) {
			var i = this._getCellByEvent(t),
				n = i.record,
				s = i.column;
			if (n) {
				var o = {
						record : n,
						row : n,
						htmlEvent : t
					},
					l = this["_OnRow" + e];
				l ? l.call(this, o) : this.fire("row" + e, o)
			}
			if (s) {
				var o = {
						column : s,
						field : s.field,
						htmlEvent : t
					},
					l = this["_OnColumn" + e];
				l ? l.call(this, o) : this.fire("column" + e, o)
			}
			if (n && s) {
				var o = {
						sender : this,
						record : n,
						row : n,
						column : s,
						field : s.field,
						htmlEvent : t
					},
					l = this["_OnCell" + e];
				l ? l.call(this, o) : this.fire("cell" + e, o), s["onCell" + e] && s["onCell" + e].call(s, o)
			}
			if (!n && s) {
				var o = {
						column : s,
						htmlEvent : t
					},
					l = this["_OnHeaderCell" + e];
				if (l) l.call(this, o);else {
					var r = "onheadercell" + e.toLowerCase();
					s[r] && (o.sender = this, s[r](o)), this.fire("headercell" + e, o)
				}
			}
			n || this._blurRow()
		}
	},
	_OnDrawCell : function(t, e, i, n) {
		var s = mini._getMap(e.field, t),
			o = {
				sender : this,
				rowIndex : i,
				columnIndex : n,
				record : t,
				row : t,
				column : e,
				field : e.field,
				value : s,
				cellHtml : s,
				rowCls : null,
				cellCls : e.cellCls || "",
				rowStyle : null,
				cellStyle : e.cellStyle || "",
				allowCellWrap : this.allowCellWrap,
				autoEscape : e.autoEscape
			};
		if (o.visible = this._isCellVisible(i, n), 1 == o.visible && this._mergedCellMaps) {
			var l = this._mergedCellMaps[i + ":" + n];
			l && (o.rowSpan = l.rowSpan, o.colSpan = l.colSpan);
		}
		if (e.dateFormat)
			if (mini.isDate(o.value))
				o.cellHtml = mini.formatDate(s, e.dateFormat);
			else if (mini.isNull(s) || "" === s)
				o.cellHtml = s;else {
				var r = new Date(s.split(".")[0].replace(/-/g, "/"));
				o.cellHtml = mini.formatDate(r, e.dateFormat)
		}
		if ("int" == e.dataType) {
			var s = parseFloat(o.value);
			isNaN(s) || (o.cellHtml = mini.util.MathUtil.toFixed(s, 0))
		}
		if ("float" == e.dataType) {
			var s = parseFloat(o.value);
			if (!isNaN(s)) {
				var a = parseInt(e.decimalPlaces);
				isNaN(a) && (a = 2), o.cellHtml = mini.util.MathUtil.toFixed2(s, a)
			}
		}
		if ("currency" == e.dataType && (mini.isNull(s) || "" === s ? o.cellHtml = e.emptyText || "" : o.cellHtml = mini.util.StringUtil.formatMoney(o.cellHtml, e.decimalPlaces, e.currencyUnit)), "percent" == e.dataType)
			if (mini.isNull(s) || "" === s)
				o.cellHtml = e.emptyText || "";else {
				var a = parseInt(e.decimalPlaces);
				isNaN(a) && (a = 2), o.cellHtml = mini.formatPercent(o.value, e.showPercent, a)
		}
		e.displayField && (o.cellHtml = mini._getMap(e.displayField, t)), 1 == o.autoEscape && (o.cellHtml = mini.htmlEncode(o.cellHtml));
		var h = e.renderer;
		return h && (fn = "function" == typeof h ? h : mini._getFunctoin(h), fn && (o.cellHtml = fn.call(e, o))), this.fire("drawcell", o), o.cellHtml && o.cellHtml.unshift && 0 == o.cellHtml.length && (o.cellHtml = "&nbsp;"), (null === o.cellHtml || void 0 === o.cellHtml || "" === o.cellHtml) && (o.cellHtml = "&nbsp;"), o
	},
	_OnDrawSummaryCell : function(t, e) {
		var i = {
			result : this.getResultObject(),
			sender : this,
			data : t,
			column : e,
			field : e.field,
			value : "",
			cellHtml : "",
			cellCls : e.cellCls || "",
			cellStyle : e.cellStyle || "",
			allowCellWrap : this.allowCellWrap
		};
		if (!e.summaryType) return i.value = "", i;
		var n = mini.summaryTypes[e.summaryType];
		n && (i.value = n(t, e.field));
		var s = i.value;
		if (i.cellHtml = s, !mini.util.MathUtil.isNumber(i.value)) return i.cellHtml = "NaN", i;
		if (e.dateFormat && (mini.isDate(i.value) ? i.cellHtml = mini.formatDate(s, e.dateFormat) : i.cellHtml = s), "currency" == e.dataType && (i.cellHtml = mini.util.StringUtil.formatMoney(i.cellHtml, e.decimalPlaces, e.currencyUnit)), "int" == e.dataType && (i.cellHtml = mini.util.MathUtil.toFixed(s, 0)), "float" == e.dataType) {
			var o = parseInt(e.decimalPlaces);
			isNaN(o) && (o = 2), i.cellHtml = mini.util.MathUtil.toFixed2(s, o)
		}
		if ("percent" == e.dataType) {
			var o = parseInt(e.decimalPlaces);
			isNaN(o) && (o = 2), i.cellHtml = mini.formatPercent(i.value, e.showPercent, o)
		}
		var l = e.summaryRenderer;
		return l && (n = "function" == typeof l ? l : window[l], n && (i.cellHtml = n.call(e, i))), e.summaryValue = i.value, this.fire("drawsummarycell", i), (null === i.cellHtml || void 0 === i.cellHtml || "" === i.cellHtml) && (i.cellHtml = "&nbsp;"), i
	},
	_OnDrawGroupSummaryCell : function(t, e) {
		var i = {
			sender : this,
			data : t,
			column : e,
			field : e.field,
			value : "",
			cellHtml : "",
			cellCls : e.cellCls || "",
			cellStyle : e.cellStyle || "",
			allowCellWrap : this.allowCellWrap
		};
		if (e.groupSummaryType) {
			var n = mini.groupSummaryType[e.summaryType];
			n && (i.value = n(t, e.field))
		}
		i.cellHtml = i.value;
		var s = e.groupSummaryRenderer;
		return s && (n = "function" == typeof s ? s : window[s], n && (i.cellHtml = n.call(e, i))), this.fire("drawgroupsummarycell", i), (null === i.cellHtml || void 0 === i.cellHtml || "" === i.cellHtml) && (i.cellHtml = "&nbsp;"), i
	},
	_OnCellMouseDown : function(t) {
		t.record, this.fire("cellmousedown", t)
	},
	_OnRowMouseOut : function(t) {
		this.enabled && mini.isAncestor(this.el, t.target)
	},
	_OnRowMouseMove : function(t) {
		if (record = t.record, this.enabled && record.enabled !== !1 && 0 != this.enableHotTrack) {
			this.fire("rowmousemove", t);
			var e = this;
			e._focusRow(record)
		}
	},
	_OnHeaderCellClick : function(t) {
		t.sender = this;
		var e = t.column;
		if (!mini.hasClass(t.htmlEvent.target, "mini-grid-splitter")) {
			if (this.allowSortColumn && 0 == this.isEditing() && (!e.columns || 0 == e.columns.length) && e.field && e.allowSort !== !1) {
				var i = "asc";
				this.sortField == e.field && (i = "asc" == this.sortOrder ? "desc" : "asc"), this.sortBy(e.field, i)
			}
			this.fire("headercellclick", t)
		}
	},
	__OnHtmlContextMenu : function(t) {
		var e = {
			popupEl : this.el,
			htmlEvent : t,
			cancel : !1
		};
		if (mini.isAncestor(this._headerEl, t.target)) {
			if (this.headerContextMenu) {
				if (this.headerContextMenu.fire("BeforeOpen", e), 1 == e.cancel) return;
				if (this.headerContextMenu.fire("opening", e), 1 == e.cancel) return;
				this.headerContextMenu.showAtPos(t.pageX, t.pageY), this.headerContextMenu.fire("Open", e)
			}
		} else {
			var i = mini.findParent(t.target, "mini-grid-detailRow");
			if (i && mini.isAncestor(this.el, i)) return;
			if (this.contextMenu) {
				if (this.contextMenu.fire("BeforeOpen", e), 1 == e.cancel) return;
				if (this.contextMenu.fire("opening", e), 1 == e.cancel) return;
				this.contextMenu.showAtPos(t.pageX, t.pageY), this.contextMenu.fire("Open", e)
			}
		}
		return !1
	},
	headerContextMenu : null,
	setHeaderContextMenu : function(t) {
		var e = this._getContextMenu(t);
		e && this.headerContextMenu !== e && (this.headerContextMenu = e, this.headerContextMenu.owner = this, mini.on(this.el, "contextmenu", this.__OnHtmlContextMenu, this))
	},
	getHeaderContextMenu : function() {
		return this.headerContextMenu
	},
	columnsMenu : null,
	createColumnsMenu : function() {
		return this.columnsMenu || (this.columnsMenu = mini.create({
				type : "menu",
				items : [ {
					type : "menuitem",
					text : "Sort Asc"
				}, {
					type : "menuitem",
					text : "Sort Desc"
				}, "-", {
					type : "menuitem",
					text : "Columns",
					name : "columns",
					items : []
				} ]
			})), this.columnsMenu
	},
	_doShowColumnsMenu : function(t) {
		var e = this.createColumnsMenu(),
			i = this._getColumnEl(t),
			n = mini.getBox(i);
		e.showAtPos(n.right - 17, n.bottom)
	},
	onRowDblClick : function(t, e) {
		this.on("rowdblclick", t, e)
	},
	onRowClick : function(t, e) {
		this.on("rowclick", t, e)
	},
	onRowMouseDown : function(t, e) {
		this.on("rowmousedown", t, e)
	},
	onRowContextMenu : function(t, e) {
		this.on("rowcontextmenu", t, e)
	},
	onCellClick : function(t, e) {
		this.on("cellclick", t, e)
	},
	onCellMouseDown : function(t, e) {
		this.on("cellmousedown", t, e)
	},
	onCellContextMenu : function(t, e) {
		this.on("cellcontextmenu", t, e)
	},
	onBeforeLoad : function(t, e) {
		this.on("beforeload", t, e)
	},
	onLoad : function(t, e) {
		this.on("load", t, e)
	},
	onLoadError : function(t, e) {
		this.on("loaderror", t, e)
	},
	onPreLoad : function(t, e) {
		this.on("preload", t, e)
	},
	onDrawCell : function(t, e) {
		this.on("drawcell", t, e)
	},
	onCellBeginEdit : function(t, e) {
		this.on("cellbeginedit", t, e)
	},
	getAttrs : function(el) {
		for (var attrs = mini.DataGrid.superclass.getAttrs.call(this, el), cs = mini.getChildNodes(el), i = 0, l = cs.length; l > i; i++) {
			var node = cs[i],
				property = jQuery(node).attr("property");
			property && (property = property.toLowerCase(), "columns" == property ? attrs.columns = mini._ParseColumns(node) : "data" == property && (attrs.data = node.innerHTML))
		}
		return mini._ParseString(el, attrs, [ "url", "sizeList", "bodyCls", "bodyStyle", "footerCls", "footerStyle", "pagerCls", "pagerStyle", "onheadercellclick", "onheadercellmousedown", "onheadercellcontextmenu", "oncelleditenter", "onrowdblclick", "onselect", "ondeselect", "onbeforeselect", "onbeforedeselect", "onrowclick", "onrowmousedown", "onrowcontextmenu", "oncellclick", "oncellmousedown", "oncellcontextmenu", "oncelldblclick", "onbeforeload", "onpreload", "onloaderror", "onload", "ondrawcell", "oncellbeginedit", "onselectionchanged", "onshowrowdetail", "onhiderowdetail", "idField", "valueField", "ajaxMethod", "ondrawgroup", "pager", "oncellcommitedit", "oncellendedit", "headerContextMenu", "loadingMsg", "emptyText", "cellEditAction", "sortMode", "oncellvalidation", "onsort", "pageIndexField", "pageSizeField", "sortFieldField", "sortOrderField", "totalField", "dataField", "ondrawsummarycell", "ondrawgroupsummarycell", "onresize", "oncolumnschanged", "onpagechanged" ]), mini._ParseBool(el, attrs, [ "showHeader", "showPager", "showFooter", "showTop", "allowSortColumn", "allowMoveColumn", "allowResizeColumn", "showHGridLines", "showVGridLines", "showFilterRow", "showSummaryRow", "showFooter", "showTop", "fitColumns", "showLoading", "multiSelect", "allowAlternating", "resultAsData", "allowRowSelect", "allowUnselect", "enableHotTrack", "showPageIndex", "showPageSize", "showTotalCount", "checkSelectionOnly", "checkSelectOnLoad", "allowResize", "autoLoad", "autoHideRowDetail", "allowCellSelect", "allowCellEdit", "allowCellWrap", "allowHeaderWrap", "selectOnLoad", "virtualScroll", "collapseGroupOnLoad", "showGroupSummary", "showEmptyText", "allowCellValid", "showModified", "showColumnsMenu", "showPageInfo", "showReloadButton", "showNewRow", "editNextOnEnterKey", "createOnEnter", "dependMerge", "ignoreTotalBusiness" ]), mini._ParseInt(el, attrs, [ "columnWidth", "frozenStartColumn", "frozenEndColumn", "pageIndex", "pageSize", "ajaxTimeout" ]), "string" == typeof attrs.sizeList && (attrs.sizeList = eval(attrs.sizeList)), !attrs.idField && attrs.valueField && (attrs.idField = attrs.valueField), attrs
	}
}), mini.regClass(mini.DataGrid, "datagrid"), mini_Column_Prototype = {
	_getColumnEl : function(t) {
		if (t = this.getColumn(t), !t) return null;
		var e = this._createColumnId(t);
		return document.getElementById(e)
	},
	_getCellEl : function(t, e) {
		if (t = this._getRow ? this._getRow(t) : this.getNode(t), e = this.getColumn(e), !t || !e) return null;
		var i = this._createCellId(t, e);
		return document.getElementById(i)
	},
	getCellEl : function(t, e) {
		this._getCellEl(t, e)
	},
	_getCellByEvent : function(t) {
		var e = this._getRecordByEvent ? this._getRecordByEvent(t) : this._getNodeByEvent(t),
			i = this._getColumnByEvent(t);
		return {
			record : e,
			column : i
		}
	},
	_getColumnByEvent : function(t) {
		var e = mini.findParent(t.target, this._cellCls);
		if (e || (e = mini.findParent(t.target, this._headerCellCls)), e) {
			var i = e.id.split("$"),
				n = i[i.length - 1];
			return this._getColumnById(n)
		}
		return null
	},
	_createColumnId : function(t) {
		return this.uid + "$column$" + t._id
	},
	getColumnBox : function(t) {
		var e = this._createColumnId(t),
			i = document.getElementById(e);
		if (i) {
			var n = mini.getBox(i);
			return n.x -= 1, n.left = n.x, n.right = n.x + n.width, n
		}
	},
	setColumns : function(value) {
		function init(column, index, parentColumn) {
			if (column.type) {
				mini.isNull(column.header) || "function" == typeof column.header || "" == column.header.trim() &&
				delete column.header;
				var col = mini._getColumn(column.type);
				if (col) {
					var _column = mini.copyTo({}, column);
					mini.copyTo(column, col), mini.copyTo(column, _column)
				}
			}
			var width = parseInt(column.width);
			if (mini.isNumber(width) && String(width) == column.width && (column.width = width + "px"), mini.isNull(column.width) && (column.width = this.columnWidth + "px"), column.visible = column.visible !== !1, column.allowResize = column.allowResize !== !1, column.allowMove = column.allowMove !== !1, column.allowSort = column.allowSort === !0, column.allowDrag = !!column.allowDrag, column.readOnly = !!column.readOnly, column.autoEscape = !!column.autoEscape, void 0 != column.digit && (column.decimalPlaces = column.digit), column._id || (column._id = mini.DataGrid.ColumnID++), column._gridUID = this.uid, column._rowIdField = this._rowIdField, column._pid = parentColumn == this ? -1 : parentColumn._id, this._idColumns[column._id] = column, column.name && (this._nameColumns[column.name] = column), column.columns && 0 != column.columns.length || this._bottomColumns.push(column), column.level = level, level += 1, this.eachColumns(column, init, this), level -= 1, column.level > this.maxColumnLevel && (this.maxColumnLevel = column.level), "string" == typeof column.editor) {
				var cls = mini.getClass(column.editor);
				cls ? column.editor = {
					type : column.editor
				} : column.editor = eval("(" + column.editor + ")")
			}
			"string" == typeof column.filter && (column.filter = eval("(" + column.filter + ")")), column.filter && !column.filter.el && (column.filter = mini.create(column.filter)), "function" == typeof column.init && 1 != column.inited && column.init(this), column.inited = !0
		}
		mini.isArray(value) || (value = []), this.columns = value, this._idColumns = {}, this._nameColumns = {}, this._bottomColumns = [], this.maxColumnLevel = 0;
		var level = 0;
		this.eachColumns(this, init, this), this._doUpdateFilterRow && this._doUpdateFilterRow(), this.doUpdate(), this.fire("columnschanged")
	},
	getColumns : function() {
		return this.columns
	},
	getBottomColumns : function() {
		return this._bottomColumns
	},
	getVisibleColumns : function() {
		for (var t = this.getBottomColumns(), e = [], i = 0, n = t.length; n > i; i++) {
			var s = t[i];
			s.visible && e.push(s)
		}
		return e
	},
	getBottomVisibleColumns : function() {
		for (var t = [], e = 0, i = this._bottomColumns.length; i > e; e++) {
			var n = this._bottomColumns[e];
			this.isVisibleColumn(n) && t.push(n)
		}
		return t
	},
	eachColumns : function(t, e, i) {
		var n = t.columns;
		if (n)
			for (var s = n.clone(), o = 0, l = s.length; l > o; o++) {
				var r = s[o];
				if (e.call(i, r, o, t) === !1) break
		}
	},
	getColumn : function(t) {
		var e = typeof t;
		return "number" == e ? this.getBottomColumns()[t] : "object" == e ? t : this._nameColumns[t]
	},
	getColumnByField : function(t) {
		if (t) {
			for (var e = this.getBottomColumns(), i = 0, n = e.length; n > i; i++) {
				var s = e[i];
				if (s.field == t) return s
			}
			return s
		}
	},
	_getColumnById : function(t) {
		return this._idColumns[t]
	},
	getParentColumn : function(t) {
		t = this.getColumn(t);
		var e = t._pid;
		return -1 == e ? this : this._idColumns[e]
	},
	getAncestorColumns : function(t) {
		for (var e = [];;) {
			var i = this.getParentColumn(t);
			if (!i || i == this) break;
			e[e.length] = i, t = i
		}
		return e.reverse(), e
	},
	isAncestorColumn : function(t, e) {
		if (t == e) return !0;
		if (!t || !e) return !1;
		for (var i = this.getAncestorColumns(e), n = 0, s = i.length; s > n; n++)
			if (i[n] == t) return !0;
		return !1
	},
	isVisibleColumn : function(t) {
		t = this.getColumn(t);
		for (var e = this.getAncestorColumns(t), i = 0, n = e.length; n > i; i++)
			if (0 == e[i].visible) return !1;
		return !0
	},
	updateColumn : function(t, e) {
		t = this.getColumn(t), t && (mini.copyTo(t, e), this.setColumns(this.columns))
	},
	removeColumn : function(t) {
		t = this.getColumn(t);
		var e = this.getParentColumn(t);
		return t && e && (e.columns.remove(t), this.setColumns(this.columns)), t
	},
	moveColumn : function(t, e, i) {
		if (t = this.getColumn(t), e = this.getColumn(e), t && e && i && t != e && !this.isAncestorColumn(t, e)) {
			var n = this.getParentColumn(t);
			n && n.columns.remove(t);
			var s = e,
				o = i;
			if ("before" == o) s = this.getParentColumn(e), o = s.columns.indexOf(e);
			else if ("after" == o) s = this.getParentColumn(e), o = s.columns.indexOf(e) + 1;
			else if ("add" == o || "append" == o) s.columns || (s.columns = []), o = s.columns.length;
			else if (!mini.isNumber(o)) return;
			s.columns.insert(o, t), this.setColumns(this.columns)
		}
	},
	hideColumns : function(t) {
		this.allowCellEdit && this.commitEdit();
		for (var e = 0, i = t.length; i > e; e++) {
			var n = this.getColumn(t[e]);
			n && (n.visible = !1)
		}
		this.setColumns(this.columns)
	},
	showColumns : function(t) {
		this.allowCellEdit && this.commitEdit();
		for (var e = 0, i = t.length; i > e; e++) {
			var n = this.getColumn(t[e]);
			n && (n.visible = !0)
		}
		this.setColumns(this.columns)
	},
	hideColumn : function(t) {
		t = this.getColumn(t), t && (this.allowCellEdit && this.commitEdit(), t.visible = !1, this.setColumns(this.columns))
	},
	showColumn : function(t) {
		t = this.getColumn(t), t && (this.allowCellEdit && this.commitEdit(), t.visible = !0, this.setColumns(this.columns))
	},
	getColumnRows : function() {
		function t(t) {
			for (var e = mini.treeToArray(t.columns, "columns"), i = 0, n = 0, s = e.length; s > n; n++) {
				var o = e[n];
				1 == o.visible && 1 != o._hide && (o.columns && 0 != o.columns.length || (i += 1))
			}
			return i
		}
		for (var e = this.getMaxColumnLevel(), i = [], n = 0, s = e; s >= n; n++) i.push([]);
		for (var o = mini.treeToArray(this.columns, "columns"), n = 0, s = o.length; s > n; n++) {
			var l = o[n],
				r = i[l.level];
			l.columns && l.columns.length > 0 && (l.colspan = t(l)), (!l.columns || 0 == l.columns.length) && l.level < e && (l.rowspan = e - l.level + 1), r.push(l)
		}
		return i
	},
	getMaxColumnLevel : function() {
		return this.maxColumnLevel
	},
	getPrint : function(t) {
		var e = new mini.DataGrid_Print(this, t);
		return e
	}
}, mini.copyTo(mini.DataGrid.prototype, mini_Column_Prototype), mini._GridSort = function(t) {
	this.grid = t, mini.on(t._headerEl, "mousemove", this.__OnGridHeaderMouseMove, this), mini.on(t._headerEl, "mouseout", this.__OnGridHeaderMouseOut, this)
}, mini._GridSort.prototype = {
	destroy : function(t) {
		if (this._focusedColumnEl) {
			mini.clearEvent(this._focusedColumnEl);
			var e = this._focusedColumnEl.parentNode;
			e && e.removeChild(this._focusedColumnEl), this._focusedColumnEl = null
		}
	},
	__OnGridHeaderMouseOut : function(t) {
		this._focusedColumnEl && mini.removeClass(this._focusedColumnEl, "mini-grid-headerCell-hover")
	},
	__OnGridHeaderMouseMove : function(t) {
		var e = mini.findParent(t.target, "mini-grid-headerCell");
		e && (mini.addClass(e, "mini-grid-headerCell-hover"), this._focusedColumnEl = e)
	},
	__onGridHeaderCellClick : function(t) {}
}, mini._ColumnSplitter = function(t) {
	this.grid = t, mini.on(this.grid.el, "mousedown", this.__onGridMouseDown, this), t.on("layout", this.__OnGridLayout, this)
}, mini._ColumnSplitter.prototype = {
	destroy : function(t) {
		this.splittersEl && (mini.clearEvent(this.splittersEl), mini.removeNode(this.splittersEl), this.splittersEl = null), this.drag && (this.drag.destroy(), this.drag = null)
	},
	__OnGridLayout : function(t) {
		if (this.splittersEl && mini.removeNode(this.splittersEl), !this.splitterTimer) {
			var e = this.grid;
			if (0 != e.isDisplay()) {
				var i = this;
				this.splitterTimer = setTimeout(function() {
					for (var t = e.getBottomColumns(), n = (t.length, mini.getBox(e._headerEl, !0)), s = e.getScrollLeft(), o = [], l = 0, r = t.length; r > l; l++) {
						var a = t[l],
							h = e.getColumnBox(a);
						if (!h) break;
						var d = h.top - n.top,
							u = h.right - n.left - 2,
							c = h.height;
						e.isFrozen && e.isFrozen() ? l >= e.frozenStartColumn : u += s;var m = e.getParentColumn(a);
						m && m.columns && m.columns[m.columns.length - 1] == a && c + 5 < n.height && (d = 0, c = n.height), e.allowResizeColumn && a.allowResize && (o[o.length] = '<div id="' + a._id + '" class="mini-grid-splitter" style="left:' + (u - 1) + "px;top:" + d + "px;height:" + c + 'px;"></div>')
					}
					var p = o.join("");
					i.splittersEl = document.createElement("div"), i.splittersEl.className = "mini-grid-splitters", i.splittersEl.innerHTML = p;
					var f = e._getHeaderScrollEl();
					f.appendChild(i.splittersEl), i.splitterTimer = null
				}, 100)
			}
		}
	},
	__onGridMouseDown : function(t) {
		var e = this.grid,
			i = t.target;
		if (mini.hasClass(i, "mini-grid-splitter")) {
			var n = e._idColumns[i.id];
			e.allowResizeColumn && n && n.allowResize && (this.splitterColumn = n, this.getDrag().start(t))
		}
	},
	getDrag : function() {
		return this.drag || (this.drag = new mini.Drag({
				capture : !0,
				onStart : mini.createDelegate(this._OnDragStart, this),
				onMove : mini.createDelegate(this._OnDragMove, this),
				onStop : mini.createDelegate(this._OnDragStop, this)
			})), this.drag
	},
	_OnDragStart : function(t) {
		var e = this.grid,
			i = e.getColumnBox(this.splitterColumn);
		this.columnBox = i, this._dragProxy = mini.append(document.body, '<div class="mini-grid-proxy"></div>');
		var n = e.getBox(!0);
		n.x = i.x, n.width = i.width, n.right = i.right, mini.setBox(this._dragProxy, n)
	},
	_OnDragMove : function(t) {
		var e = this.grid,
			i = mini.copyTo({}, this.columnBox),
			n = i.width + (t.now[0] - t.init[0]);
		n < e.columnMinWidth && (n = e.columnMinWidth), n > e.columnMaxWidth && (n = e.columnMaxWidth), mini.setWidth(this._dragProxy, n)
	},
	_OnDragStop : function(t) {
		this.columnBox = null;
		var e = this.grid,
			i = mini.getBox(this._dragProxy),
			n = this,
			s = e.allowSortColumn;
		e.allowSortColumn = !1, setTimeout(function() {
			jQuery(n._dragProxy).remove(), n._dragProxy = null, e.allowSortColumn = s
		}, 10);
		var o = this.splitterColumn,
			l = parseInt(o.width);
		if (l + "%" != o.width) {
			var r = e.getColumnWidth(o),
				a = parseInt(l / r * i.width);
			e.setColumnWidth(o, a)
		}
	}
}, mini._ColumnMove = function(t) {
	this.grid = t, mini.on(this.grid.el, "mousedown", this.__onGridMouseDown, this)
}, mini._ColumnMove.prototype = {
	destroy : function(t) {
		this.drag && (this.drag.destroy(), this.drag = null)
	},
	__onGridMouseDown : function(t) {
		var e = this.grid;
		if (!(e.isEditing && e.isEditing() || mini.hasClass(t.target, "mini-grid-splitter") || t.button == mini.MouseButton.Right)) {
			var i = mini.findParent(t.target, e._headerCellCls);
			if (i) {
				this._remove();
				var n = e._getColumnByEvent(t);
				e.allowMoveColumn && n && n.allowMove && (this.dragColumn = n, this._columnEl = i, this.getDrag().start(t))
			}
		}
	},
	getDrag : function() {
		return this.drag || (this.drag = new mini.Drag({
				capture : !1,
				onStart : mini.createDelegate(this._OnDragStart, this),
				onMove : mini.createDelegate(this._OnDragMove, this),
				onStop : mini.createDelegate(this._OnDragStop, this)
			})), this.drag
	},
	_OnDragStart : function(t) {
		function e(t) {
			var e = t.header;
			return "function" == typeof e && (e = e.call(i, t)), (mini.isNull(e) || "" === e) && (e = "&nbsp;"), e
		}
		var i = this.grid;
		this._dragProxy = mini.append(document.body, '<div class="mini-grid-columnproxy"></div>'), this._dragProxy.innerHTML = '<div class="mini-grid-columnproxy-inner" style="height:26px;">' + e(this.dragColumn) + "</div>", mini.setXY(this._dragProxy, t.now[0] + 15, t.now[1] + 18), mini.addClass(this._dragProxy, "mini-grid-no"), this.moveTop = mini.append(document.body, '<div class="mini-grid-movetop"></div>'), this.moveBottom = mini.append(document.body, '<div class="mini-grid-movebottom"></div>')
	},
	_OnDragMove : function(t) {
		var e = this.grid,
			i = t.now[0];
		mini.setXY(this._dragProxy, i + 15, t.now[1] + 18), this.targetColumn = this.insertAction = null;
		var n = mini.findParent(t.event.target, e._headerCellCls);
		if (n) {
			var s = e._getColumnByEvent(t.event);
			if (s && s != this.dragColumn) {
				var o = e.getParentColumn(this.dragColumn),
					l = e.getParentColumn(s);
				if (o == l) {
					this.targetColumn = s, this.insertAction = "before";
					var r = e.getColumnBox(this.targetColumn);
					i > r.x + r.width / 2 && (this.insertAction = "after")
				}
			}
		}
		if (this.targetColumn) {
			mini.addClass(this._dragProxy, "mini-grid-ok"), mini.removeClass(this._dragProxy, "mini-grid-no");
			var a = e.getColumnBox(this.targetColumn);
			this.moveTop.style.display = "block", this.moveBottom.style.display = "block", "before" == this.insertAction ? (mini.setXY(this.moveTop, a.x - 4, a.y - 9), mini.setXY(this.moveBottom, a.x - 4, a.bottom)) : (mini.setXY(this.moveTop, a.right - 4, a.y - 9), mini.setXY(this.moveBottom, a.right - 4, a.bottom))
		} else mini.removeClass(this._dragProxy, "mini-grid-ok"), mini.addClass(this._dragProxy, "mini-grid-no"), this.moveTop.style.display = "none", this.moveBottom.style.display = "none"
	},
	_remove : function() {
		this.grid, mini.removeNode(this._dragProxy), mini.removeNode(this.moveTop), mini.removeNode(this.moveBottom), this._dragProxy = this.moveTop = this.moveBottom = this.dragColumn = this.targetColumn = null
	},
	_OnDragStop : function(t) {
		var e = this.grid;
		e.moveColumn(this.dragColumn, this.targetColumn, this.insertAction), this._remove()
	}
}, mini._GridSelect = function(t) {
	this.grid = t, this.grid.on("cellmousedown", this.__onGridCellMouseDown, this), this.grid.on("cellclick", this.__onGridCellClick, this), this.grid.on("celldblclick", this.__onGridCellClick, this), mini.on(this.grid.el, "keydown", this.__OnGridKeyDown, this)
}, mini._GridSelect.prototype = {
	destroy : function(t) {
		delete this.currentRecord
	},
	__OnGridKeyDown : function(t) {
		var e = this.grid;
		if (!(mini.isAncestor(e._filterEl, t.target) || mini.isAncestor(e._summaryEl, t.target) || mini.isAncestor(e._footerEl, t.target) || mini.findParent(t.target, "mini-grid-detailRow") || mini.findParent(t.target, "mini-grid-rowEdit"))) {
			var i = e.getCurrentCell();
			if (!(t.shiftKey || t.ctrlKey || t.altKey)) {
				(37 == t.keyCode || 38 == t.keyCode || 39 == t.keyCode || 40 == t.keyCode) && t.preventDefault();
				var n = e.getBottomVisibleColumns(),
					s = i ? i[1] : null,
					o = i ? i[0] : null;
				i || (o = e.getCurrent());
				var l = n.indexOf(s),
					r = e.indexOf(o),
					a = e.getData().length;
				switch (t.keyCode) {
				case 9:
					if (e.allowCellEdit && e.editOnTabKey) return t.preventDefault(), void e._beginEditNextCell(0 == t.shiftKey);
					break;case 27:
					break;case 13:
					if (e.allowCellEdit && e.editNextOnEnterKey && (e.isEditingCell(i) || !s.editor)) return void e._beginEditNextCell(0 == t.shiftKey);
					e.allowCellEdit && i && !s.readOnly && e.beginEditCell();
					break;case 37:
					s ? l > 0 && (l -= 1) : l = 0;
					break;case 38:
					o ? r > 0 && (r -= 1) : r = 0, 0 != r && e.isVirtualScroll() && e._viewRegion.start > r && (e._bodyEl.scrollTop -= e._rowHeight, e._tryUpdateScroll());
					break;case 39:
					s ? l < n.length - 1 && (l += 1) : l = 0;
					break;case 40:
					o ? a - 1 > r && (r += 1) : r = 0, e.isVirtualScroll() && e._viewRegion.end < r && (e._bodyEl.scrollTop += e._rowHeight, e._tryUpdateScroll())
				}
				if (s = n[l], o = e.getAt(r), s && o && e.allowCellSelect) {
					var i = [ o, s ];
					e.setCurrentCell(i), e.scrollIntoView(o, s)
				}
				e.onlyCheckSelection || o && e.allowRowSelect && (e.deselectAll(), e.setCurrent(o))
			}
		}
	},
	__onGridCellClick : function(t) {
		var e = this.grid;
		if (0 != e.allowCellEdit && this.grid.cellEditAction == t.type) {
			var i = (t.record, t.column);
			i.readOnly || this.grid.isReadOnly() || t.htmlEvent.shiftKey || t.htmlEvent.ctrlKey || this.grid.beginEditCell()
		}
	},
	__onGridCellMouseDown : function(t) {
		var e = this;
		e.__doSelect(t)
	},
	__doSelect : function(t) {
		var e = t.record,
			i = t.column,
			n = this.grid;
		if (this.grid.allowCellSelect) {
			var s = [ e, i ];
			this.grid.setCurrentCell(s)
		}
		if ((!n.onlyCheckSelection || i._multiRowSelect) && n.allowRowSelect)
			if (n.multiSelect)
				if (this.grid.el.onselectstart = function() {}, t.htmlEvent.shiftKey)
					if (this.grid.el.onselectstart = function() {
							return !1
						}, t.htmlEvent.preventDefault(), this.currentRecord) {
						if (this.currentRecord._index == e._index) return;
						var o = this.currentRecord._index,
							l = e._index;
						this.currentRecord._index > e._index && (o = e._index, l = this.currentRecord._index);
						for (var r = o; l >= r; r++) n.isSelected(r) || n.select(r)
					} else this.grid.select(e), this.currentRecord = this.grid.getSelected();else {
					if (this.grid.el.onselectstart = function() {}, t.htmlEvent.ctrlKey) {
						this.grid.el.onselectstart = function() {
							return !1
						};try {
							t.htmlEvent.preventDefault()
						} catch (a) {}
					}
					t.column._multiRowSelect === !0 || t.htmlEvent.ctrlKey || n.allowUnselect ? n.isSelected(e) ? n.deselect(e) : n.select(e) : n.isSelected(e) || (n.deselectAll(), n.select(e)), this.currentRecord = this.grid.getSelected()
			}
			else
				n.isSelected(e) ? t.htmlEvent.ctrlKey && n.deselectAll() : (n.deselectAll(), n.select(e))
	}
}, mini._CellToolTip = function(t) {
	this.grid = t, mini.on(this.grid.el, "mousemove", this.__onGridMouseMove, this), mini.on(this.grid.el, "mouseout", this.__onGridMouseOut, this)
}, mini._CellToolTip.prototype = {
	destroy : function(t) {},
	__onGridMouseMove : function(t) {
		var e = this.grid,
			i = e._getCellByEvent(t),
			n = e._getCellEl(i.record, i.column),
			s = e.getCellError(i.record, i.column);
		if (n) {
			if (s) return void (n.title = s.errorText);
			if (n.firstChild && (mini.hasClass(n.firstChild, "mini-grid-cell-inner") || mini.hasClass(n.firstChild, "mini-treegrid-treecolumn-inner")) && (n = n.firstChild), n.scrollWidth > n.clientWidth) {
				var o = n.innerText || n.textContent || "";
				n.title = o.trim()
			} else
				n.title = ""
		}
	},
	__onGridMouseOut : function(t) {
		var e = this.grid,
			i = e._getCellByEvent(t),
			n = e._getCellEl(i.record, i.column);
		n && (n.title = "")
	}
}, mini._ColumnsMenu = function(t) {
	this.grid = t, this.menu = this.createMenu(), mini.on(t.el, "contextmenu", this.__OnContextMenu, this)
}, mini._ColumnsMenu.prototype = {
	destroy : function(t) {
		this.arrowEl && (mini.clearEvent(this.arrowEl), this.arrowEl.parentNode.removeChild(this.arrowEl), this.arrowEl = null)
	},
	createMenu : function() {
		var t = mini.create({
			type : "menu",
			hideOnClick : !1
		});
		return t.on("itemclick", this.__OnItemClick, this), t
	},
	updateMenu : function() {
		for (var t = this.grid, e = this.menu, i = t.getBottomColumns(), n = [], s = 0, o = i.length; o > s; s++) {
			var l = i[s],
				r = {};
			r.checked = l.visible, r.checkOnClick = !0, r.text = t._createHeaderText(l), "&nbsp;" == r.text && ("indexcolumn" == l.type && (r.text = "序号"), "checkcolumn" == l.type && (r.text = "选择")), n.push(r), r._column = l
		}
		e.setItems(n)
	},
	__OnContextMenu : function(t) {
		var e = this.grid;
		return 0 != e.showColumnsMenu && 0 != mini.isAncestor(e._headerEl, t.target) ? (this.updateMenu(), this.menu.showAtPos(t.pageX, t.pageY), !1) : void 0
	},
	__OnItemClick : function(t) {
		for (var e = this.grid, i = this.menu, n = (e.getBottomColumns(), i.getItems()), s = t.item, o = s._column, l = 0, r = 0, a = n.length; a > r; r++) {
			var h = n[r];
			h.getChecked() && l++
		}
		1 > l && s.setChecked(!0);
		var d = s.getChecked();
		d ? e.showColumn(o) : e.hideColumn(o)
	}
}, mini_CellValidator_Prototype = {
	getCellErrors : function() {
		for (var t = this._cellErrors.clone(), e = this.data, i = 0, n = t.length; n > i; i++) {
			var s = t[i],
				o = s.record,
				l = s.column;
			if (-1 == e.indexOf(o)) {
				var r = o[this._rowIdField] + "$" + l._id;
				delete this._cellMapErrors[r]
				, this._cellErrors.remove(s)
			}
		}
		return this._cellErrors
	},
	getCellError : function(t, e) {
		if (t = this.getNode ? this.getNode(t) : this._getRow(t), e = this.getColumn(e), t && e) {
			var i = t[this._rowIdField] + "$" + e._id;
			return this._cellMapErrors[i]
		}
	},
	validateEditors : function() {
		for (var t = this.data, e = 0, i = t.length; i > e; e++)
			for (var n = t[e], s = this.getBottomColumns(), e = 0, i = s.length; i > e; e++) {
				var o = s[e],
					l = this.getCellEditor(o, n);
				l && l.validate()
		}
	},
	isEditorsValid : function() {
		for (var t = this.data, e = 0, i = t.length; i > e; e++)
			for (var n = t[e], s = this.getBottomColumns(), e = 0, i = s.length; i > e; e++) {
				var o = s[e],
					l = this.getCellEditor(o, n);
				if (l && !l.isValid()) return !1
		}
		return !0
	},
	isValid : function() {
		return 0 == this.getCellErrors().length
	},
	validate : function() {
		for (var t = this.data, e = 0, i = t.length; i > e; e++) {
			var n = t[e];
			this.validateRow(n)
		}
	},
	validateRow : function(t) {
		for (var e = this.getBottomColumns(), i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			this.validateCell(t, s)
		}
	},
	validateCell : function(t, e) {
		if (t = this.getNode ? this.getNode(t) : this._getRow(t), e = this.getColumn(e), t && e) {
			var i = {
				record : t,
				row : t,
				node : t,
				column : e,
				field : e.field,
				value : t[e.field],
				isValid : !0,
				errorText : ""
			};
			if (e.vtype && mini._ValidateVType(e.vtype, i.value, i, e), 1 == i.isValid && e.unique && e.field)
				for (var n = {}, s = this.data, o = e.field, l = 0, r = s.length; r > l; l++) {
					var a = s[l],
						h = a[o];
					if (mini.isNull(h) || "" === h)
						;else {
						var d = n[h];
						if (d && a == t) {
							i.isValid = !1, i.errorText = mini._getErrorText(e, "uniqueErrorText"), this.setCellIsValid(d, e, i.isValid, i.errorText);break
						}
						n[h] = a
					}
			}
			this.fire("cellvalidation", i), this.setCellIsValid(t, e, i.isValid, i.errorText)
		}
	},
	setIsValid : function(t) {
		if (t)
			for (var e = this._cellErrors.clone(), i = 0, n = e.length; n > i; i++) {
				var s = e[i];
				this.setCellIsValid(s.record, s.column, !0)
		}
	},
	_removeRowError : function(t) {
		for (var e = this.getColumns(), i = 0, n = e.length; n > i; i++) {
			var s = e[i],
				o = t[this._rowIdField] + "$" + s._id,
				l = this._cellMapErrors[o];
			l && (
			delete this._cellMapErrors[o]
			, this._cellErrors.remove(l))
		}
	},
	setCellIsValid : function(t, e, i, n) {
		if (t = this.getNode ? this.getNode(t) : this._getRow(t), e = this.getColumn(e), t && e) {
			var s = t[this._rowIdField] + "$" + e._id,
				o = this._getCellEl(t, e),
				l = this._cellMapErrors[s];
			delete this._cellMapErrors[s]
			, this._cellErrors.remove(l), i === !0 ? o && l && mini.removeClass(o, "mini-grid-cell-error") : (l = {
				record : t,
				column : e,
				isValid : i,
				errorText : n
			}, this._cellMapErrors[s] = l, this._cellErrors.add(l), o && mini.addClass(o, "mini-grid-cell-error"))
		}
	}
}, mini.copyTo(mini.DataGrid.prototype, mini_CellValidator_Prototype), mini.DataGrid_Print = function(t, e) {
	this.grid = t, this.config = mini.copyTo({
		printColumn : null,
		columnWidth : null
	}, e)
}, mini.DataGrid_Print.prototype = {
	getHtml : function() {
		var t = '<table class="datagrid-print-table">' + this._createHead() + this._createBody() + "</table>";
		return t
	},
	getBodyHtml : function() {
		return this._createBody()
	},
	getHeadHtml : function() {
		return this._createHead()
	},
	setColumn : function(t) {
		this.config.printColumn = t
	},
	setColumnWidth : function(t) {
		this.config.columnWidth = t
	},
	_createHead : function() {
		var t = "#mini-grid-table-head" + this.grid.getId();
		this.$printHeadTable = $(t).children(":first").clone(), this._removeHeanUnUseable();
		var e = this.$printHeadTable.html();
		return "<thead>" + e + "</thead>"
	},
	_createBody : function() {
		if (this.grid.isVirtualScroll()) return this._createBodyVirtual();
		var t = "#mini-grid-table-body" + this.grid.getId();
		this.$printBodyTable = $(t).clone(), this._removeBodyUnUseable();
		var e = this.$printBodyTable.html();
		return e
	},
	_createBodyVirtual : function() {
		var t = [];
		t[t.length] = "<tbody>";
		for (var e = this.grid.getData(), i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			this.grid._createRow(s, t, i)
		}
		return t[t.length] = "</tbody>", t.join("")
	},
	_removeBodyUnUseable : function() {
		this.$printBodyTable.find("tr:first").remove(), this.$printBodyTable.find("td").each(function() {
			$(this).removeAttr("id"), $(this).removeAttr("class")
		}), this.$printBodyTable.find("tr").each(function() {
			$(this).removeAttr("id"), $(this).removeAttr("class")
		})
	},
	_removeHeanUnUseable : function() {
		this.$printHeadTable.find("tr:first").remove(), this.$printHeadTable.find("td").each(function() {
			$(this).removeAttr("id"), $(this).removeAttr("class");
			var t = $(this).children(".mini-grid-cellInner:first"),
				e = t.html();
			t.remove(), $(this).append(e), $(this).children(".mini-grid-sortIcon").detach()
		}), this.$printHeadTable.find("tr").each(function() {
			$(this).removeAttr("id"), $(this).removeAttr("class")
		})
	}
}, mini.RadioButtonList = function() {
	mini.RadioButtonList.superclass.constructor.call(this)
}, mini.extend(mini.RadioButtonList, mini.CheckBoxList, {
	multiSelect : !1,
	_itemCls : "mini-radiobuttonlist-item",
	_itemHoverCls : "mini-radiobuttonlist-item-hover",
	_itemSelectedCls : "mini-radiobuttonlist-item-selected",
	_tableCls : "mini-radiobuttonlist-table",
	_tdCls : "mini-radiobuttonlist-td",
	_checkType : "radio",
	uiCls : "mini-radiobuttonlist"
}), mini.regClass(mini.RadioButtonList, "radiobuttonlist"), mini.Spinner = function() {
	mini.Spinner.superclass.constructor.call(this), this.setValue(this.minValue, !1)
}, mini.extend(mini.Spinner, mini.ButtonEdit, {
	value : 0,
	minValue : 0,
	maxValue : 100,
	increment : 1,
	decimalPlaces : 0,
	changeOnMousewheel : !0,
	allowLimitValue : !0,
	set : function(t) {
		if ("string" == typeof t) return this;
		var e = t.value;
		return delete t.value
			, mini.Spinner.superclass.set.call(this, t), mini.isNull(e) || this.setValue(e, this.defaultValueTriggerChange), this
	},
	uiCls : "mini-spinner",
	_getButtonHtml : function() {
		var t = "onmouseover=\"mini.addClass(this, '" + this._buttonHoverCls + "');\" onmouseout=\"mini.removeClass(this, '" + this._buttonHoverCls + "');\"";
		return '<span class="mini-buttonedit-button" ' + t + '><span class="mini-buttonedit-up"><span></span></span><span class="mini-buttonedit-down"><span></span></span></span>'
	},
	_initEvents : function() {
		mini.Spinner.superclass._initEvents.call(this), mini._BindEvents(function() {
			this.on("buttonmousedown", this.__OnButtonMouseDown, this), mini.on(this.el, "mousewheel", this.__OnMousewheel, this)
		}, this)
	},
	_ValueLimit : function() {
		0 != this.allowLimitValue && (this.minValue > this.maxValue && (this.maxValue = this.minValue + 100), this.value < this.minValue && this.setValue(this.minValue, !1), this.value > this.maxValue && this.setValue(this.maxValue, !1))
	},
	getFormValue : function() {
		var t = this.value;
		t = parseFloat(t), isNaN(t) && (t = 0);
		var e = String(t).split("."),
			i = e[0],
			n = e[1];
		if (n || (n = ""), this.decimalPlaces > 0) {
			for (var s = n.length, o = this.decimalPlaces; o > s; s++) n += "0";
			n = "." + n
		}
		return i + n
	},
	setValue : function(t, e) {
		t = parseFloat(t), isNaN(t) && (t = this.defaultValue), t = parseFloat(t), isNaN(t) && (t = this.minValue), t = parseFloat(t.toFixed(this.decimalPlaces)), mini.isEquals(this.value, t) ? this.text = this._textEl.value = this.getFormValue() : (this.value = t, this._ValueLimit(), this._valueEl.value = this.value, this.text = this._textEl.value = this.getFormValue(), void 0 === e && (e = !0), e && this._OnValueChanged())
	},
	setMaxValue : function(t) {
		t = parseFloat(t), isNaN(t) || (t = parseFloat(t.toFixed(this.decimalPlaces)), this.maxValue != t && (this.maxValue = t, this._ValueLimit()))
	},
	getMaxValue : function(t) {
		return this.maxValue
	},
	setMinValue : function(t) {
		t = parseFloat(t), isNaN(t) || (t = parseFloat(t.toFixed(this.decimalPlaces)), this.minValue != t && (this.minValue = t, this._ValueLimit()))
	},
	getMinValue : function(t) {
		return this.minValue
	},
	setIncrement : function(t) {
		t = parseFloat(t), isNaN(t) || this.increment != t && (this.increment = t)
	},
	getIncrement : function(t) {
		return this.increment
	},
	setDecimalPlaces : function(t) {
		t = parseInt(t), isNaN(t) || 0 > t || (this.decimalPlaces = t)
	},
	getDecimalPlaces : function(t) {
		return this.decimalPlaces
	},
	setChangeOnMousewheel : function(t) {
		this.changeOnMousewheel = t
	},
	getChangeOnMousewheel : function(t) {
		return this.changeOnMousewheel
	},
	setAllowLimitValue : function(t) {
		this.allowLimitValue = t
	},
	getAllowLimitValue : function(t) {
		return this.allowLimitValue
	},
	_SpinTimer : null,
	_StartSpin : function(t, e, i) {
		this._StopSpin(), this.setValue(this.value + t, !1);
		var n = this,
			s = i,
			o = new Date;
		this._SpinTimer = setInterval(function() {
			n.setValue(n.value + t, !1), i--, 0 == i && e > 50 && n._StartSpin(t, e - 100, s + 3);
			var l = new Date;
			l - o > 500 && n._StopSpin(), o = l
		}, e), mini.on(document, "mouseup", this._OnDocumentMouseUp, this)
	},
	_StopSpin : function() {
		clearInterval(this._SpinTimer), this._SpinTimer = null
	},
	__OnButtonMouseDown : function(t) {
		this._DownValue = this.getValue(), this.__OnInputTextChanged(), "up" == t.spinType ? this._StartSpin(this.increment, 230, 2) : this._StartSpin(-this.increment, 230, 2)
	},
	__OnInputKeyDown : function(t) {
		mini.Spinner.superclass.__OnInputKeyDown.call(this, t);
		var e = mini.Keyboard;
		switch (t.keyCode) {
		case e.Top:
			this.setValue(this.value + this.increment);
			break;case e.Bottom:
			this.setValue(this.value - this.increment)
		}
	},
	__OnMousewheel : function(t) {
		if (!this.isReadOnly() && 0 != this.changeOnMousewheel) {
			var e = t.wheelDelta || t.originalEvent.wheelDelta;
			mini.isNull(e) && (e = 24 * -t.detail);
			var i = this.increment;
			return 0 > e && (i = -i), this.setValue(this.value + i), !1
		}
	},
	_OnDocumentMouseUp : function(t) {
		this._StopSpin(), mini.un(document, "mouseup", this._OnDocumentMouseUp, this), this._DownValue != this.getValue() && this._OnValueChanged()
	},
	__OnInputTextChanged : function(t) {
		var e = (this.getValue(), parseFloat(this._textEl.value));
		this.setValue(e)
	},
	getAttrs : function(t) {
		var e = mini.Spinner.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "minValue", "maxValue", "increment", "decimalPlaces", "changeOnMousewheel" ]), mini._ParseBool(t, e, [ "allowLimitValue" ]), e
	}
}), mini.regClass(mini.Spinner, "spinner"), mini.SplitButton = function() {
	mini.SplitButton.superclass.constructor.call(this)
}, mini.extend(mini.SplitButton, mini.MenuButton, {
	uiCls : "mini-splitbutton",
	allowCls : "mini-button-split"
}), mini.regClass(mini.SplitButton, "splitbutton"), mini.Splitter = function() {
	this._initPanes(), mini.Splitter.superclass.constructor.call(this)
}, mini.extend(mini.Splitter, mini.Control, {
	width : 300,
	height : 180,
	vertical : !1,
	allowResize : !0,
	pane1 : null,
	pane2 : null,
	showHandleButton : !0,
	handlerStyle : "",
	handlerCls : "",
	handlerSize : 5,
	uiCls : "mini-splitter",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-splitter", this.el.innerHTML = '<div class="mini-splitter-border"><div id="1" class="mini-splitter-pane mini-splitter-pane1"></div><div id="2" class="mini-splitter-pane mini-splitter-pane2"></div><div class="mini-splitter-handler"></div></div>', this._borderEl = this.el.firstChild, this._pane1El = this._borderEl.firstChild, this._pane2El = this._borderEl.childNodes[1], this._handlerEl = this._borderEl.lastChild
	},
	_initEvents : function() {
		mini._BindEvents(function() {
			mini.on(this.el, "click", this.__OnClick, this), mini.on(this.el, "mousedown", this.__OnMouseDown, this)
		}, this)
	},
	_initPanes : function() {
		this.pane1 = {
			id : "",
			index : 1,
			minSize : 30,
			maxSize : 3e3,
			size : "",
			showCollapseButton : !1,
			cls : "",
			style : "",
			visible : !0,
			expanded : !0
		}, this.pane2 = mini.copyTo({}, this.pane1), this.pane2.index = 2
	},
	doUpdate : function() {
		this.doLayout()
	},
	doLayout : function() {
		if (this.canLayout()) {
			this._handlerEl.style.cursor = this.allowResize ? "" : "default", mini.removeClass(this.el, "mini-splitter-vertical"), this.vertical && mini.addClass(this.el, "mini-splitter-vertical"), mini.removeClass(this._pane1El, "mini-splitter-pane1-vertical"), mini.removeClass(this._pane2El, "mini-splitter-pane2-vertical"), this.vertical && (mini.addClass(this._pane1El, "mini-splitter-pane1-vertical"), mini.addClass(this._pane2El, "mini-splitter-pane2-vertical")), mini.removeClass(this._handlerEl, "mini-splitter-handler-vertical"), this.vertical && mini.addClass(this._handlerEl, "mini-splitter-handler-vertical");
			var t = this.getHeight(!0),
				e = this.getWidth(!0);
			if (!jQuery.boxModel) {
				var i = mini.getBorders(this._borderEl);
				t = t + i.top + i.bottom, e = e + i.left + i.right
			}
			this._borderEl.style.width = e + "px", this._borderEl.style.height = t + "px";
			var n = this._pane1El,
				s = this._pane2El;
			jQuery(n), jQuery(s), n.style.display = s.style.display = this._handlerEl.style.display = "";
			var o = this.handlerSize;
			this.pane1.size = String(this.pane1.size), this.pane2.size = String(this.pane2.size);
			var l = parseFloat(this.pane1.size),
				r = parseFloat(this.pane2.size),
				a = isNaN(l),
				h = isNaN(r),
				d = !isNaN(l) && -1 != this.pane1.size.indexOf("%"),
				u = !isNaN(r) && -1 != this.pane2.size.indexOf("%"),
				c = !a && !d,
				m = !h && !u,
				p = this.vertical ? t - this.handlerSize : e - this.handlerSize,
				f = p2Size = 0;
			if (a || h)
				a && h ? (f = parseInt(p / 2), p2Size = p - f) : c ? (f = l, p2Size = p - f) : d ? (f = parseInt(p * l / 100), p2Size = p - f) : m ? (p2Size = r, f = p - p2Size) : u && (p2Size = parseInt(p * r / 100), f = p - p2Size);
			else if (d && m) p2Size = r, f = p - p2Size;
			else if (c && u) f = l, p2Size = p - f;else {
				var g = l + r;
				f = parseInt(p * l / g), p2Size = p - f
			}
			f > this.pane1.maxSize && (f = this.pane1.maxSize, p2Size = p - f), p2Size > this.pane2.maxSize && (p2Size = this.pane2.maxSize, f = p - p2Size), f < this.pane1.minSize && (f = this.pane1.minSize, p2Size = p - f), p2Size < this.pane2.minSize && (p2Size = this.pane2.minSize, f = p - p2Size), 0 == this.pane1.expanded ? (p2Size = p, f = 0, n.style.display = "none") : 0 == this.pane2.expanded && (f = p, p2Size = 0, s.style.display = "none"), 0 == this.pane1.visible ? (p2Size = p + o, f = o = 0, n.style.display = "none", this._handlerEl.style.display = "none") : 0 == this.pane2.visible && (f = p + o, p2Size = o = 0, s.style.display = "none", this._handlerEl.style.display = "none"), this.vertical ? (mini.setWidth(n, e), mini.setWidth(s, e), mini.setHeight(n, f), mini.setHeight(s, p2Size), s.style.top = f + o + "px", this._handlerEl.style.left = "0px", this._handlerEl.style.top = f + "px", mini.setWidth(this._handlerEl, e), mini.setHeight(this._handlerEl, this.handlerSize), n.style.left = "0px", s.style.left = "0px") : (mini.setWidth(n, f), mini.setWidth(s, p2Size), mini.setHeight(n, t), mini.setHeight(s, t), s.style.left = f + o + "px", this._handlerEl.style.top = "0px", this._handlerEl.style.left = f + "px", mini.setWidth(this._handlerEl, this.handlerSize), mini.setHeight(this._handlerEl, t), n.style.top = "0px", s.style.top = "0px");
			var _ = '<div class="mini-splitter-handler-buttons">';
			this.pane1.expanded && this.pane2.expanded ? (this.pane1.showCollapseButton && (_ += '<a id="1" class="mini-splitter-pane1-button"></a>'), this.allowResize && (this.pane1.showCollapseButton || this.pane2.showCollapseButton || (_ += '<span class="mini-splitter-resize-button"></span>')), this.pane2.showCollapseButton && (_ += '<a id="2" class="mini-splitter-pane2-button"></a>')) : this.pane1.expanded ? this.pane2.showCollapseButton && (_ += '<a id="2" class="mini-splitter-pane1-button"></a>') : this.pane1.showCollapseButton && (_ += '<a id="1" class="mini-splitter-pane2-button"></a>'), _ += "</div>", this._handlerEl.innerHTML = _;
			var v = this._handlerEl.firstChild;
			v.style.display = this.showHandleButton ? "" : "none";
			var y = mini.getBox(v);
			this.vertical ? v.style.marginLeft = -y.width / 2 + "px" : v.style.marginTop = -y.height / 2 + "px", this.pane1.visible && this.pane2.visible && this.pane1.expanded && this.pane2.expanded ? mini.removeClass(this._handlerEl, "mini-splitter-nodrag") : mini.addClass(this._handlerEl, "mini-splitter-nodrag"), mini.layout(this._borderEl), this.fire("layout")
		}
	},
	getPaneBox : function(t) {
		var e = this.getPaneEl(t);
		return e ? mini.getBox(e) : null
	},
	getPane : function(t) {
		return 1 == t ? this.pane1 : 2 == t ? this.pane2 : t
	},
	setPanes : function(t) {
		if (mini.isArray(t))
			for (var e = 0; 2 > e; e++) {
				var i = t[e];
				this.updatePane(e + 1, i)
		}
	},
	setPaneControls : function(t, e) {
		var i = this.getPane(t);
		if (i) {
			var n = this.getPaneEl(t);
			__mini_setControls(e, n, this)
		}
	},
	getPaneEl : function(t) {
		return 1 == t ? this._pane1El : this._pane2El
	},
	updatePane : function(t, e) {
		var i = this.getPane(t);
		if (i) {
			mini.copyTo(i, e);
			var n = this.getPaneEl(t),
				s = i.body;
			if (
				delete i.body
				, s) {
				mini.isArray(s) || (s = [ s ]);
				for (var o = 0, l = s.length; l > o; o++) mini.append(n, s[o])
			}
			if (i.bodyParent)
				for (var r = i.bodyParent; r.firstChild;) n.appendChild(r.firstChild);
			if (
				delete i.bodyParent
				, n.id = i.id, mini.setStyle(n, i.style), mini.addClass(n, i["class"]), i.controls) {
				var t = i == this.pane1 ? 1 : 2;
				this.setPaneControls(t, i.controls),
				delete i.controls
			}
			this.doUpdate()
		}
	},
	setShowHandleButton : function(t) {
		this.showHandleButton = t, this.doUpdate()
	},
	getShowHandleButton : function(t) {
		return this.showHandleButton
	},
	setVertical : function(t) {
		this.vertical = t, this.doUpdate()
	},
	getVertical : function() {
		return this.vertical
	},
	expandPane : function(t) {
		var e = this.getPane(t);
		if (e) {
			e.expanded = !0, this.doUpdate();
			var i = {
				pane : e,
				paneIndex : this.pane1 == e ? 1 : 2
			};
			this.fire("expand", i)
		}
	},
	collapsePane : function(t) {
		var e = this.getPane(t);
		if (e) {
			e.expanded = !1;
			var i = e == this.pane1 ? this.pane2 : this.pane1;
			0 == i.expanded && (i.expanded = !0, i.visible = !0), this.doUpdate();
			var n = {
				pane : e,
				paneIndex : this.pane1 == e ? 1 : 2
			};
			this.fire("collapse", n)
		}
	},
	togglePane : function(t) {
		var e = this.getPane(t);
		e && (e.expanded ? this.collapsePane(e) : this.expandPane(e))
	},
	showPane : function(t) {
		var e = this.getPane(t);
		e && (e.visible = !0, this.doUpdate())
	},
	hidePane : function(t) {
		var e = this.getPane(t);
		if (e) {
			e.visible = !1;
			var i = e == this.pane1 ? this.pane2 : this.pane1;
			0 == i.visible && (i.expanded = !0, i.visible = !0), this.doUpdate()
		}
	},
	setAllowResize : function(t) {
		this.allowResize != t && (this.allowResize = t, this.doLayout())
	},
	getAllowResize : function() {
		return this.allowResize
	},
	setHandlerSize : function(t) {
		this.handlerSize != t && (this.handlerSize = t, this.doLayout())
	},
	getHandlerSize : function() {
		return this.handlerSize
	},
	__OnClick : function(t) {
		var e = t.target;
		if (mini.isAncestor(this._handlerEl, e)) {
			var i = parseInt(e.id),
				n = this.getPane(i),
				t = {
					pane : n,
					paneIndex : i,
					cancel : !1
				};
			n.expanded ? this.fire("beforecollapse", t) : this.fire("beforeexpand", t), 1 != t.cancel && ("mini-splitter-pane1-button" == e.className ? this.togglePane(i) : "mini-splitter-pane2-button" == e.className && this.togglePane(i))
		}
	},
	_OnButtonClick : function(t, e) {
		this.fire("buttonclick", {
			pane : t,
			index : this.pane1 == t ? 1 : 2,
			htmlEvent : e
		})
	},
	onButtonClick : function(t, e) {
		this.on("buttonclick", t, e)
	},
	__OnMouseDown : function(t) {
		var e = t.target;
		if (this.allowResize && this.pane1.visible && this.pane2.visible && this.pane1.expanded && this.pane2.expanded && mini.isAncestor(this._handlerEl, e))
			if ("mini-splitter-pane1-button" == e.className || "mini-splitter-pane2-button" == e.className)
				;else {
				var i = this._getDrag();
				i.start(t)
		}
	},
	_getDrag : function() {
		return this.drag || (this.drag = new mini.Drag({
				capture : !0,
				onStart : mini.createDelegate(this._OnDragStart, this),
				onMove : mini.createDelegate(this._OnDragMove, this),
				onStop : mini.createDelegate(this._OnDragStop, this)
			})), this.drag
	},
	_OnDragStart : function(t) {
		this._maskProxy = mini.append(document.body, '<div class="mini-resizer-mask"></div>'), this._dragProxy = mini.append(document.body, '<div class="mini-proxy"></div>'), this._dragProxy.style.cursor = this.vertical ? "n-resize" : "w-resize", this.handlerBox = mini.getBox(this._handlerEl), this.elBox = mini.getBox(this._borderEl, !0), mini.setBox(this._dragProxy, this.handlerBox)
	},
	_OnDragMove : function(t) {
		if (this.handlerBox) {
			this.elBox || (this.elBox = mini.getBox(this._borderEl, !0));
			var e = this.elBox.width,
				i = this.elBox.height,
				n = (this.handlerSize, this.vertical ? i - this.handlerSize : e - this.handlerSize, this.pane1.minSize),
				s = this.pane1.maxSize,
				o = this.pane2.minSize,
				l = this.pane2.maxSize;
			if (1 == this.vertical) {
				var r = t.now[1] - t.init[1],
					a = this.handlerBox.y + r;
				a - this.elBox.y > s && (a = this.elBox.y + s), a + this.handlerBox.height < this.elBox.bottom - l && (a = this.elBox.bottom - l - this.handlerBox.height), a - this.elBox.y < n && (a = this.elBox.y + n), a + this.handlerBox.height > this.elBox.bottom - o && (a = this.elBox.bottom - o - this.handlerBox.height), mini.setY(this._dragProxy, a)
			} else {
				var h = t.now[0] - t.init[0],
					d = this.handlerBox.x + h;
				d - this.elBox.x > s && (d = this.elBox.x + s), d + this.handlerBox.width < this.elBox.right - l && (d = this.elBox.right - l - this.handlerBox.width), d - this.elBox.x < n && (d = this.elBox.x + n), d + this.handlerBox.width > this.elBox.right - o && (d = this.elBox.right - o - this.handlerBox.width), mini.setX(this._dragProxy, d)
			}
		}
	},
	_OnDragStop : function(t) {
		var e = this.elBox.width,
			i = this.elBox.height,
			n = (this.handlerSize, parseFloat(this.pane1.size)),
			s = parseFloat(this.pane2.size),
			o = isNaN(n),
			l = isNaN(s),
			r = !isNaN(n) && -1 != this.pane1.size.indexOf("%"),
			a = !isNaN(s) && -1 != this.pane2.size.indexOf("%"),
			h = !o && !r,
			d = !l && !a,
			u = this.vertical ? i - this.handlerSize : e - this.handlerSize,
			c = mini.getBox(this._dragProxy),
			m = c.x - this.elBox.x,
			p = u - m;
		this.vertical && (m = c.y - this.elBox.y, p = u - m), o || l ? o && l ? (n = parseFloat(m / u * 100).toFixed(1), this.pane1.size = n + "%") : h ? (n = m, this.pane1.size = n) : r ? (n = parseFloat(m / u * 100).toFixed(1), this.pane1.size = n + "%") : d ? (s = p, this.pane2.size = s) : a && (s = parseFloat(p / u * 100).toFixed(1), this.pane2.size = s + "%") : r && d ? this.pane2.size = p : h && a ? this.pane1.size = m : (this.pane1.size = parseFloat(m / u * 100).toFixed(1), this.pane2.size = 100 - this.pane1.size), jQuery(this._dragProxy).remove(), jQuery(this._maskProxy).remove(), this._maskProxy = null, this._dragProxy = null, this.elBox = this.handlerBox = null, this.doLayout(), this.fire("resize")
	},
	getAttrs : function(t) {
		var e = mini.Splitter.superclass.getAttrs.call(this, t);
		mini._ParseBool(t, e, [ "allowResize", "vertical", "showHandleButton", "onresize" ]), mini._ParseInt(t, e, [ "handlerSize" ]);
		for (var i = [], n = mini.getChildNodes(t), s = 0, o = 2; o > s; s++) {
			var l = n[s],
				r = (jQuery(l), {});
			i.push(r), l && (r.style = l.style.cssText, mini._ParseString(l, r, [ "cls", "size", "id", "class" ]), mini._ParseBool(l, r, [ "visible", "expanded", "showCollapseButton" ]), mini._ParseInt(l, r, [ "minSize", "maxSize", "handlerSize" ]), r.bodyParent = l)
		}
		return e.panes = i, e
	}
}), mini.regClass(mini.Splitter, "splitter"), mini.Tabs = function() {
	this._initTabs(), mini.Tabs.superclass.constructor.call(this)
}, mini.extend(mini.Tabs, mini.Control, {
	activeIndex : -1,
	tabAlign : "left",
	tabPosition : "top",
	showBody : !0,
	showHeader : !0,
	nameField : "name",
	titleField : "title",
	urlField : "url",
	url : "",
	maskOnLoad : !0,
	plain : !0,
	bodyStyle : "",
	_tabHoverCls : "mini-tab-hover",
	_tabActiveCls : "mini-tab-active",
	set : function(t) {
		if ("string" == typeof t) return this;
		var e = this._allowLayout;
		this._allowLayout = !1;
		var i = t.activeIndex;
		delete t.activeIndex;
		var n = t.url;
		return delete t.url
			, mini.Tabs.superclass.set.call(this, t), n && this.setUrl(n), mini.isNumber(i) && this.setActiveIndex(i), this._allowLayout = e, this.doLayout(), this
	},
	uiCls : "mini-tabs",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-tabs";
		var t = '<table class="mini-tabs-table" cellspacing="0" cellpadding="0"><tr style="width:100%;"><td></td><td style="text-align:left;vertical-align:top;width:100%;"><div class="mini-tabs-bodys"></div></td><td></td></tr></table>';
		this.el.innerHTML = t, this._tableEl = this.el.firstChild;
		var e = this.el.getElementsByTagName("td");
		this._td1El = e[0], this._td2El = e[1], this._td3El = e[2], this._bodyEl = this._td2El.firstChild, this._borderEl = this._bodyEl, this.doUpdate()
	},
	destroy : function(t) {
		this._tableEl = this._td1El = this._td2El = this._td3El = null, this._bodyEl = this._borderEl = this.headerEl = null, this.tabs = [], mini.Tabs.superclass.destroy.call(this, t)
	},
	_doClearElement : function() {
		mini.removeClass(this._td1El, "mini-tabs-header"), mini.removeClass(this._td3El, "mini-tabs-header"), this._td1El.innerHTML = "", this._td3El.innerHTML = "", mini.removeChilds(this._td2El, this._bodyEl)
	},
	_initEvents : function() {
		mini._BindEvents(function() {
			mini.on(this.el, "mousedown", this.__OnMouseDown, this), mini.on(this.el, "click", this.__OnClick, this), mini.on(this.el, "mouseover", this.__OnMouseOver, this), mini.on(this.el, "mouseout", this.__OnMouseOut, this)
		}, this)
	},
	_initTabs : function() {
		this.tabs = []
	},
	_TabID : 1,
	createTab : function(t) {
		var e = mini.copyTo({
			_id : this._TabID++,
			name : "",
			title : "",
			newLine : !1,
			iconCls : "",
			iconStyle : "",
			headerCls : "",
			headerStyle : "",
			bodyCls : "",
			bodyStyle : "",
			visible : !0,
			enabled : !0,
			showCloseButton : !1,
			active : !1,
			url : "",
			loaded : !1,
			refreshOnClick : !1
		}, t);
		return t && (t = mini.copyTo(t, e), e = t), e
	},
	_doLoad : function() {
		var t = mini.getData(this.url);
		this.dataField && (t = mini._getMap(this.dataField, t)), t || (t = []), this.setTabs(t), this.fire("load")
	},
	load : function(t) {
		"string" == typeof t ? this.setUrl(t) : this.setTabs(t)
	},
	setUrl : function(t) {
		this.url = t, this._doLoad()
	},
	getUrl : function() {
		return this.url
	},
	setNameField : function(t) {
		this.nameField = t
	},
	getNameField : function() {
		return this.nameField
	},
	setTitleField : function(t) {
		this.titleField = t
	},
	getTitleField : function() {
		return this.titleField
	},
	setUrlField : function(t) {
		this.urlField = t
	},
	getUrlField : function() {
		return this.urlField
	},
	setButtons : function(t) {
		if (this._buttons = mini.byId(t), this._buttons) {
			var e = mini.byClass("mini-tabs-buttons", this.el);
			e && (e.appendChild(this._buttons), mini.parse(e), this.doLayout())
		}
	},
	setTabControls : function(t, e) {
		var t = this.getTab(t);
		if (t) {
			var i = this.getTabBodyEl(t);
			__mini_setControls(e, i, this)
		}
	},
	setTabs : function(t) {
		if (mini.isArray(t)) {
			this.beginUpdate(), this.removeAll();
			for (var e = 0, i = t.length; i > e; e++) {
				var n = t[e];
				n.title = mini._getMap(this.titleField, n), n.url = mini._getMap(this.urlField, n), n.name = mini._getMap(this.nameField, n)
			}
			for (var e = 0, i = t.length; i > e; e++) this.addTab(t[e]);
			this.setActiveIndex(0), this.endUpdate()
		}
	},
	getTabs : function() {
		return this.tabs
	},
	removeAll : function(t) {
		var e = this.getActiveTab();
		mini.isNull(t) && (t = []), mini.isArray(t) || (t = [ t ]);
		for (var i = t.length - 1; i >= 0; i--) {
			var n = this.getTab(t[i]);
			n ? t[i] = n : t.removeAt(i)
		}
		for (var s = this.tabs, i = s.length - 1; i >= 0; i--) {
			var o = s[i];
			-1 == t.indexOf(o) && this.removeTab(o)
		}
		var l = t[0];
		e != this.getActiveTab() && l && this.activeTab(l)
	},
	addTab : function(t, e) {
		"string" == typeof t && (t = {
			title : t
		}), t = this.createTab(t), t.name || (t.name = ""), "number" != typeof e && (e = this.tabs.length), this.tabs.insert(e, t);
		var i = this._createTabBodyId(t),
			n = '<div id="' + i + '" class="mini-tabs-body ' + t.bodyCls + '" style="' + t.bodyStyle + ';display:none;"></div>';
		mini.append(this._bodyEl, n);
		var s = this.getTabBodyEl(t),
			o = t.body;
		if (
			delete t.body
			, o) {
			mini.isArray(o) || (o = [ o ]);
			for (var l = 0, r = o.length; r > l; l++) mini.append(s, o[l])
		}
		if (t.bodyParent)
			for (var a = t.bodyParent; a.firstChild;) 8 == a.firstChild.nodeType ? a.removeChild(a.firstChild) : s.appendChild(a.firstChild);
		return delete t.bodyParent
			, t.controls && (this.setTabControls(t, t.controls),
			delete t.controls
			), this.doUpdate(), t
	},
	removeTab : function(t) {
		if (t = this.getTab(t), t && -1 != this.tabs.indexOf(t)) {
			var e = this.getActiveTab(),
				i = t == e,
				n = this._OnTabDestroy(t);
			this.tabs.remove(t), this._doRemoveIFrame(t);
			var s = this.getTabBodyEl(t);
			if (s && this._bodyEl.removeChild(s), n && i) {
				for (var o = this.activeIndex; o >= 0; o--) {
					var t = this.getTab(o);
					if (t && t.enabled && t.visible) {
						this.activeIndex = o;break
					}
				}
				this.doUpdate(), this.setActiveIndex(this.activeIndex), this.fire("activechanged")
			} else this.activeIndex = this.tabs.indexOf(e), this.doUpdate();
			return t
		}
	},
	moveTab : function(t, e) {
		if (t = this.getTab(t)) {
			var i = this.tabs[e];
			if (i != t) {
				this.tabs.remove(t);
				var e = this.tabs.indexOf(i);
				-1 == e ? this.tabs.add(t) : this.tabs.insert(e, t), this.doUpdate()
			}
		}
	},
	updateTab : function(t, e) {
		t = this.getTab(t), t && (mini.copyTo(t, e), this.doUpdate())
	},
	_getMaskWrapEl : function() {
		return this._bodyEl
	},
	_doRemoveIFrame : function(t, e) {
		if (t._iframeEl && t._iframeEl.parentNode) {
			t._iframeEl.onload = function() {}, jQuery(t._iframeEl).unbind("load"), t._iframeEl.src = "";try {
				iframe.contentWindow.document.write(""), iframe.contentWindow.document.close()
			} catch (i) {}
			t._iframeEl._ondestroy && t._iframeEl._ondestroy();try {
				t._iframeEl.parentNode.removeChild(t._iframeEl), t._iframeEl.removeNode(!0)
			} catch (i) {}
		}
		if (t._iframeEl = null, t.loadedUrl = null, e === !0) {
			var n = this.getTabBodyEl(t);
			if (n)
				for (var s = mini.getChildNodes(n, !0), o = 0, l = s.length; l > o; o++) {
					var r = s[o];
					r && r.parentNode && r.parentNode.removeChild(r)
			}
		}
	},
	_deferLoadingTime : 180,
	_cancelLoadTabs : function(t) {
		for (var e = this.tabs, i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			s != t && s._loading && s._iframeEl && (s._loading = !1, this._doRemoveIFrame(s, !0))
		}
		t && t == this.getActiveTab() && t._loading || (this._loading = !1, this.unmask())
	},
	_doLoadTab : function(t) {
		if (t && t == this.getActiveTab()) {
			var e = this.getTabBodyEl(t);
			if (e) {
				this._cancelLoadTabs(), this._doRemoveIFrame(t, !0), this._loading = !0, t._loading = !0, this.unmask(), this.maskOnLoad && this.loading();
				var i = new Date,
					n = this;
				n.isLoading = !0;
				var s = mini.createIFrame(t.url, function(e, s) {
					try {
						t._iframeEl.contentWindow.Owner = window, t._iframeEl.contentWindow.CloseOwnerWindow = function(e) {
							t.removeAction = e;
							var i = !0;
							return t.ondestroy && ("string" == typeof t.ondestroy && (t.ondestroy = window[t.ondestroy]), t.ondestroy && (i = t.ondestroy.call(this, o))), i === !1 ? !1 : void setTimeout(function() {
									n.removeTab(t)
								}, 10)
						}
					} catch (o) {}
					if (1 == t._loading) {
						var l = i - new Date + n._deferLoadingTime;
						if (t._loading = !1, t.loadedUrl = t.url, 0 > l && (l = 0), setTimeout(function() {
								n.unmask(), n.doLayout(), n.isLoading = !1
							}, l), s) {
							var o = {
								sender : n,
								tab : t,
								index : n.tabs.indexOf(t),
								name : t.name,
								iframe : t._iframeEl
							};
							t.onload && ("string" == typeof t.onload && (t.onload = window[t.onload]), t.onload && t.onload.call(n, o))
						}
						n.getActiveTab() == t && n.fire("tabload", o)
					}
				});
				setTimeout(function() {
					t._iframeEl == s && e.appendChild(s)
				}, 1), t._iframeEl = s
			}
		}
	},
	_OnTabDestroy : function(t) {
		var e = {
			sender : this,
			tab : t,
			index : this.tabs.indexOf(t),
			name : t.name,
			iframe : t._iframeEl,
			autoActive : !0
		};
		return this.fire("tabdestroy", e), e.autoActive
	},
	loadTab : function(t, e, i, n) {
		if (t && (e = this.getTab(e), e || (e = this.getActiveTab()), e)) {
			var s = this.getTabBodyEl(e);
			s && mini.addClass(s, "mini-tabs-hideOverflow"), e.url = t,
			delete e.loadedUrl
			, i && (e.onload = i), n && (e.ondestroy = n);
			var o = this;
			clearTimeout(this._loadTabTimer), this._loadTabTimer = null, this._loadTabTimer = setTimeout(function() {
				o._doLoadTab(e)
			}, 1)
		}
	},
	reloadTab : function(t) {
		t = this.getTab(t), t || (t = this.getActiveTab()), t && this.loadTab(t.url, t)
	},
	getTabRows : function() {
		for (var t = [], e = [], i = 0, n = this.tabs.length; n > i; i++) {
			var s = this.tabs[i];
			0 != i && s.newLine && (t.push(e), e = []), e.push(s)
		}
		return t.push(e), t
	},
	doUpdate : function() {
		if (this._allowUpdate !== !1) {
			if (this._buttons && this._buttons.parentNode && this._buttons.parentNode.removeChild(this._buttons), mini.removeClass(this.el, "mini-tabs-position-left"), mini.removeClass(this.el, "mini-tabs-position-top"), mini.removeClass(this.el, "mini-tabs-position-right"), mini.removeClass(this.el, "mini-tabs-position-bottom"), "bottom" == this.tabPosition ? (mini.addClass(this.el, "mini-tabs-position-bottom"), this._doUpdateBottom()) : "right" == this.tabPosition ? (mini.addClass(this.el, "mini-tabs-position-right"), this._doUpdateRight()) : "left" == this.tabPosition ? (mini.addClass(this.el, "mini-tabs-position-left"), this._doUpdateLeft()) : (mini.addClass(this.el, "mini-tabs-position-top"), this._doUpdateTop()), this._buttons) {
				var t = mini.byClass("mini-tabs-buttons", this.el);
				t && (t.appendChild(this._buttons), mini.parse(t))
			}
			this.doLayout(), this.setActiveIndex(this.activeIndex, !1)
		}
	},
	_handleIFrameOverflow : function() {
		var t = this.getTabBodyEl(this.activeIndex);
		if (t) {
			mini.removeClass(t, "mini-tabs-hideOverflow");
			var e = mini.getChildNodes(t)[0];
			e && e.tagName && "IFRAME" == e.tagName.toUpperCase() && mini.addClass(t, "mini-tabs-hideOverflow")
		}
	},
	doLayout : function() {
		if (this.canLayout()) {
			this._headerEl.style.display = this.showHeader ? "" : "none", this._handleIFrameOverflow();
			var t = this.isAutoHeight();
			C = this.getHeight(!0), B = this.getWidth();
			var e = C,
				i = B;
			if (this.showBody ? this._bodyEl.style.display = "" : this._bodyEl.style.display = "none", this.plain ? mini.addClass(this.el, "mini-tabs-plain") : mini.removeClass(this.el, "mini-tabs-plain"), !t && this.showBody) {
				var n = jQuery(this._headerEl).outerHeight(),
					s = jQuery(this._headerEl).outerWidth();
				if ("top" == this.tabPosition && (n = jQuery(this._headerEl.parentNode).outerHeight()), "left" == this.tabPosition || "right" == this.tabPosition ? B -= s : C -= n, jQuery.boxModel) {
					var o = mini.getPaddings(this._bodyEl),
						l = mini.getBorders(this._bodyEl);
					C = C - o.top - o.bottom - l.top - l.bottom, B = B - o.left - o.right - l.left - l.right
				}
				if (margin = mini.getMargins(this._bodyEl), C = C - margin.top - margin.bottom, B = B - margin.left - margin.right, 0 > C && (C = 0), 0 > B && (B = 0), this._bodyEl.style.width = B + "px", this._bodyEl.style.height = C + "px", "left" == this.tabPosition || "right" == this.tabPosition) {
					for (var r = this._headerEl.getElementsByTagName("tr")[0], a = r.childNodes, h = a[0].getElementsByTagName("tr"), d = last = all = 0, u = 0, c = h.length; c > u; u++) {
						var r = h[u],
							m = jQuery(r).outerHeight();
						all += m, 0 == u && (d = m), u == c - 1 && (last = m)
					}
					switch (this.tabAlign) {
					case "center":
						for (var p = parseInt((e - (all - d - last)) / 2), u = 0, c = a.length; c > u; u++) {
							a[u].firstChild.style.height = e + "px";var f = a[u].firstChild,
								h = f.getElementsByTagName("tr"),
								g = h[0],
								_ = h[h.length - 1];
							g.style.height = p + "px", _.style.height = p + "px"
						}
						break;case "right":
						for (var u = 0, c = a.length; c > u; u++) {
							var f = a[u].firstChild,
								h = f.getElementsByTagName("tr"),
								r = h[0],
								v = e - (all - d);
							v >= 0 && (r.style.height = v + "px")
						}
						break;case "fit":
						for (var u = 0, c = a.length; c > u; u++) a[u].firstChild.style.height = e + "px";
						break;default:
						for (var u = 0, c = a.length; c > u; u++) {
							var f = a[u].firstChild,
								h = f.getElementsByTagName("tr"),
								r = h[h.length - 1],
								v = e - (all - last);
							v >= 0 && (r.style.height = v + "px")
						}
					}
				}
			} else this._bodyEl.style.width = "auto", this._bodyEl.style.height = "auto";
			var y = this.getTabBodyEl(this.activeIndex);
			if (y)
				if (!t && this.showBody) {
					var C = mini.getHeight(this._bodyEl, !0);
					if (jQuery.boxModel) {
						var o = mini.getPaddings(y),
							l = mini.getBorders(y);
						C = C - o.top - o.bottom - l.top - l.bottom
					}
					y.style.height = C + "px"
				} else
					y.style.height = "auto";
			switch (this.tabPosition) {
			case "bottom":
				for (var w = this._headerEl.childNodes, u = 0, c = w.length; c > u; u++) {
					var f = w[u];
					mini.removeClass(f, "mini-tabs-header2"), c > 1 && 0 != u && mini.addClass(f, "mini-tabs-header2")
				}
				break;case "left":
				for (var a = this._headerEl.firstChild.rows[0].cells, u = 0, c = a.length; c > u; u++) {
					var x = a[u];
					mini.removeClass(x, "mini-tabs-header2"), c > 1 && 0 == u && mini.addClass(x, "mini-tabs-header2")
				}
				break;case "right":
				for (var a = this._headerEl.firstChild.rows[0].cells, u = 0, c = a.length; c > u; u++) {
					var x = a[u];
					mini.removeClass(x, "mini-tabs-header2"), c > 1 && 0 != u && mini.addClass(x, "mini-tabs-header2")
				}
				break;default:
				for (var w = this._headerEl.childNodes, u = 0, c = w.length; c > u; u++) {
					var f = w[u];
					mini.removeClass(f, "mini-tabs-header2"), c > 1 && 0 == u && mini.addClass(f, "mini-tabs-header2")
				}
			}
			mini.removeClass(this.el, "mini-tabs-scroll");
			var x = mini.byClass("mini-tabs-lastSpace", this.el),
				b = mini.byClass("mini-tabs-buttons", this.el),
				E = this._headerEl.parentNode;
			if (E.style.paddingRight = "0px", this._navEl && (this._navEl.style.display = "none"), b && (b.style.display = "none"), mini.setWidth(E, i), "top" == this.tabPosition && "left" == this.tabAlign) {
				this._headerEl.style.width = "auto", b.style.display = "block";
				var T = i,
					S = this._headerEl.firstChild.offsetWidth - x.offsetWidth,
					I = b.firstChild ? b.offsetWidth : 0;
				if (S + I > T) {
					this._navEl.style.display = "block", this._navEl.style.right = I + "px";
					var k = this._navEl.offsetWidth,
						B = T - I - k;
					mini.setWidth(this._headerEl, B)
				}
			}
			this._scrollToTab(this.activeIndex), this._doScrollButton(), mini.layout(this._bodyEl);
			var O = this.getActiveTab();
			if (O && O.repaint && y) {
				var B = y.style.width;
				y.style.width = "0px", setTimeout(function() {
					y.style.width = B
				}, 1)
			}
			this.fire("layout")
		}
	},
	setTabAlign : function(t) {
		this.tabAlign = t, this.doUpdate()
	},
	setTabPosition : function(t) {
		this.tabPosition = t, this.doUpdate()
	},
	getTab : function(t) {
		if ("object" == typeof t) return t;
		if ("number" == typeof t) return this.tabs[t];
		for (var e = 0, i = this.tabs.length; i > e; e++) {
			var n = this.tabs[e];
			if (n.name == t) return n
		}
	},
	getHeaderEl : function() {
		return this._headerEl
	},
	getBodyEl : function() {
		return this._bodyEl
	},
	getTabEl : function(t) {
		var e = this.getTab(t);
		if (!e) return null;
		for (var i = this._createTabId(e), n = this.el.getElementsByTagName("*"), s = 0, o = n.length; o > s; s++) {
			var l = n[s];
			if (l.id == i) return l
		}
		return null
	},
	getTabBodyEl : function(t) {
		var e = this.getTab(t);
		if (!e) return null;
		for (var i = this._createTabBodyId(e), n = this._bodyEl.childNodes, s = 0, o = n.length; o > s; s++) {
			var l = n[s];
			if (l.id == i) return l
		}
		return null
	},
	getTabIFrameEl : function(t) {
		var e = this.getTab(t);
		return e ? e._iframeEl : null
	},
	_createTabId : function(t) {
		return this.uid + "$" + t._id
	},
	_createTabBodyId : function(t) {
		return this.uid + "$body$" + t._id
	},
	_doScrollButton : function() {
		if ("top" == this.tabPosition) {
			mini.removeClass(this._leftButtonEl, "mini-disabled"), mini.removeClass(this._rightButtonEl, "mini-disabled"), 0 == this._headerEl.scrollLeft && mini.addClass(this._leftButtonEl, "mini-disabled");
			var t = this.getTabEl(this.tabs.length - 1);
			if (t) {
				var e = mini.getBox(t),
					i = mini.getBox(this._headerEl);
				e.right <= i.right && mini.addClass(this._rightButtonEl, "mini-disabled")
			}
		}
	},
	setActiveIndex : function(t, e) {
		var i = this.getTab(t),
			n = this.getTab(this.activeIndex),
			s = i != n,
			o = this.getTabBodyEl(this.activeIndex);
		o && (o.style.display = "none"), i ? this.activeIndex = this.tabs.indexOf(i) : this.activeIndex = -1;
		var o = this.getTabBodyEl(this.activeIndex);
		o && (o.style.display = "");
		var o = this.getTabEl(n);
		o && mini.removeClass(o, this._tabActiveCls);
		var o = this.getTabEl(i);
		if (o && mini.addClass(o, this._tabActiveCls), o && s) {
			if ("bottom" == this.tabPosition) {
				var l = mini.findParent(o, "mini-tabs-header");
				l && jQuery(this._headerEl).prepend(l)
			} else if ("left" == this.tabPosition) {
				var r = mini.findParent(o, "mini-tabs-header").parentNode;
				r && r.parentNode.appendChild(r)
			} else if ("right" == this.tabPosition) {
				var r = mini.findParent(o, "mini-tabs-header").parentNode;
				r && jQuery(r.parentNode).prepend(r)
			} else {
				var l = mini.findParent(o, "mini-tabs-header");
				l && this._headerEl.appendChild(l)
			}
			this._headerEl.scrollLeft, this.doLayout();
			var a = this.getTabRows();
			a.length > 1 || (this._scrollToTab(this.activeIndex), this._doScrollButton());
			for (var h = 0, d = this.tabs.length; d > h; h++) {
				var u = this.getTabEl(this.tabs[h]);
				u && mini.removeClass(u, this._tabHoverCls)
			}
		}
		var c = this;
		if (s) {
			var m = {
				tab : i,
				index : this.tabs.indexOf(i),
				name : i ? i.name : ""
			};
			setTimeout(function() {
				c.fire("ActiveChanged", m)
			}, 1)
		}
		if (this._cancelLoadTabs(i), e !== !1 && i && i.url && !i.loadedUrl) {
			var c = this;
			c.loadTab(i.url, i)
		}
		if (c.canLayout()) try {
				mini.layoutIFrames(c.el)
			} catch (m) {}
	},
	_scrollToTab : function(t) {
		var e = this._headerEl.scrollLeft;
		if ("top" == this.tabPosition) {
			this._headerEl.scrollLeft = e;
			var i = this.getTabEl(t);
			if (i) {
				var n = this,
					s = mini.getBox(i),
					o = mini.getBox(n._headerEl);
				s.x < o.x ? n._headerEl.scrollLeft -= o.x - s.x : s.right > o.right && (n._headerEl.scrollLeft += s.right - o.right)
			}
		}
	},
	getActiveIndex : function() {
		return this.activeIndex
	},
	activeTab : function(t) {
		this.setActiveIndex(t)
	},
	getActiveTab : function() {
		return this.getTab(this.activeIndex)
	},
	getActiveIndex : function() {
		return this.activeIndex
	},
	_tryActiveTab : function(t) {
		if (t = this.getTab(t)) {
			var e = this.tabs.indexOf(t);
			if (this.activeIndex != e) {
				var i = {
					tab : t,
					index : e,
					name : t.name,
					cancel : !1
				};
				this.fire("BeforeActiveChanged", i), 0 == i.cancel && this.activeTab(t)
			}
		}
	},
	setShowHeader : function(t) {
		this.showHeader != t && (this.showHeader = t, this.doLayout())
	},
	getShowHeader : function() {
		return this.showHeader
	},
	setShowBody : function(t) {
		this.showBody != t && (this.showBody = t, this.doLayout())
	},
	getShowBody : function() {
		return this.showBody
	},
	setBodyStyle : function(t) {
		this.bodyStyle = t, mini.setStyle(this._bodyEl, t), this.doLayout()
	},
	getBodyStyle : function() {
		return this.bodyStyle
	},
	setMaskOnLoad : function(t) {
		this.maskOnLoad = t
	},
	getMaskOnLoad : function() {
		return this.maskOnLoad
	},
	setPlain : function(t) {
		this.plain = t, this.doLayout()
	},
	getPlain : function() {
		return this.plain
	},
	getTabByEvent : function(t) {
		return this._getTabByEvent(t)
	},
	_getTabByEvent : function(t) {
		var e = mini.findParent(t.target, "mini-tab");
		if (!e) return null;
		var i = e.id.split("$");
		if (i[0] != this.uid) return null;
		var n = parseInt(jQuery(e).attr("index"));
		return this.getTab(n)
	},
	__OnClick : function(t) {
		var e = this._getTabByEvent(t);
		if (e && e.enabled) {
			var i = this;
			setTimeout(function() {
				if (mini.findParent(t.target, "mini-tab-close")) i._OnCloseButtonClick(e, t);else {
					var n = e.loadedUrl;
					i._tryActiveTab(e), e.refreshOnClick && e.url == n && i.reloadTab(e)
				}
			}, 10)
		}
	},
	hoverTab : null,
	__OnMouseOver : function(t) {
		var e = this._getTabByEvent(t);
		if (e && e.enabled) {
			var i = this.getTabEl(e);
			mini.addClass(i, this._tabHoverCls), this.hoverTab = e
		}
	},
	__OnMouseOut : function(t) {
		if (this.hoverTab) {
			var e = this.getTabEl(this.hoverTab);
			mini.removeClass(e, this._tabHoverCls)
		}
		this.hoverTab = null
	},
	__OnMouseDown : function(t) {
		if (clearInterval(this._scrollTimer), "top" == this.tabPosition) {
			var e = this,
				i = 0,
				n = 10;
			t.target == this._leftButtonEl ? this._scrollTimer = setInterval(function() {
				e._headerEl.scrollLeft -= n, i++, i > 5 && (n = 18), i > 10 && (n = 25), e._doScrollButton()
			}, 25) : t.target == this._rightButtonEl && (this._scrollTimer = setInterval(function() {
				e._headerEl.scrollLeft += n, i++, i > 5 && (n = 18), i > 10 && (n = 25), e._doScrollButton()
			}, 25)), mini.on(document, "mouseup", this.__OnDocMouseUp, this)
		}
	},
	__OnDocMouseUp : function(t) {
		clearInterval(this._scrollTimer), this._scrollTimer = null, mini.un(document, "mouseup", this.__OnDocMouseUp, this)
	},
	_doUpdateTop : function() {
		var t = "top" == this.tabPosition,
			e = "";
		t && (e += '<div class="mini-tabs-scrollCt">', e += '<div class="mini-tabs-nav"><a class="mini-tabs-leftButton" href="javascript:void(0)" hideFocus onclick="return false"></a><a class="mini-tabs-rightButton" href="javascript:void(0)" hideFocus onclick="return false"></a></div>', e += '<div class="mini-tabs-buttons"></div>'), e += '<div class="mini-tabs-headers">';
		for (var i = this.getTabRows(), n = 0, s = i.length; s > n; n++) {
			var o = i[n],
				l = "";
			e += '<table class="mini-tabs-header" cellspacing="0" cellpadding="0"><tr><td class="mini-tabs-space mini-tabs-firstSpace"><div></div></td>';
			for (var r = 0, a = o.length; a > r; r++) {
				var h = o[r],
					d = this._createTabId(h);
				if (h.visible) {
					var u = this.tabs.indexOf(h),
						l = h.headerCls || "";
					if (0 == h.enabled && (l += " mini-disabled"), e += '<td id="' + d + '" index="' + u + '"  class="mini-tab ' + l + '" style="' + h.headerStyle + '">', (h.iconCls || h.iconStyle) && (e += '<span class="mini-tab-icon ' + h.iconCls + '" style="' + h.iconStyle + '"></span>'), e += '<span class="mini-tab-text">' + h.title + "</span>", h.showCloseButton) {
						var c = "";
						h.enabled && (c = "onmouseover=\"mini.addClass(this, 'mini-tab-close-hover')\" onmouseout=\"mini.removeClass(this, 'mini-tab-close-hover')\""), e += '<span class="mini-tab-close" ' + c + "></span>"
					}
					e += "</td>", r != a - 1 && (e += '<td class="mini-tabs-space2"><div></div></td>')
				}
			}
			e += '<td class="mini-tabs-space mini-tabs-lastSpace" ><div></div></td></tr></table>'
		}
		t && (e += "</div>"), e += "</div>", this._doClearElement(), mini.prepend(this._td2El, e);
		var m = this._td2El;
		switch (this._headerEl = m.firstChild.lastChild, t && (this._navEl = this._headerEl.parentNode.firstChild, this._leftButtonEl = this._navEl.firstChild, this._rightButtonEl = this._navEl.childNodes[1]), this.tabAlign) {
		case "center":
			for (var p = this._headerEl.childNodes, r = 0, a = p.length; a > r; r++) {
				var f = p[r],
					g = f.getElementsByTagName("td");
				g[0].style.width = "50%", g[g.length - 1].style.width = "50%"
			}
			break;case "right":
			for (var p = this._headerEl.childNodes, r = 0, a = p.length; a > r; r++) {
				var f = p[r],
					g = f.getElementsByTagName("td");
				g[0].style.width = "100%"
			}
			break;case "fit":
			break;default:
			for (var p = this._headerEl.childNodes, r = 0, a = p.length; a > r; r++) {
				var f = p[r],
					g = f.getElementsByTagName("td");
				g[g.length - 1].style.width = "100%"
			}
		}
	},
	_doUpdateBottom : function() {
		this._doUpdateTop();
		var t = this._td2El;
		mini.append(t, t.firstChild), this._headerEl = t.lastChild
	},
	_doUpdateLeft : function() {
		for (var t = '<table cellspacing="0" cellpadding="0"><tr>', e = this.getTabRows(), i = 0, n = e.length; n > i; i++) {
			var s = e[i],
				o = "";
			n > 1 && i != n - 1 && (o = "mini-tabs-header2"), t += '<td class="' + o + '"><table class="mini-tabs-header" cellspacing="0" cellpadding="0">', t += '<tr ><td class="mini-tabs-space mini-tabs-firstSpace" ><div></div></td></tr>';
			for (var l = 0, r = s.length; r > l; l++) {
				var a = s[l],
					h = this._createTabId(a);
				if (a.visible) {
					var d = this.tabs.indexOf(a),
						o = a.headerCls || "";
					if (0 == a.enabled && (o += " mini-disabled"), t += '<tr><td id="' + h + '" index="' + d + '"  class="mini-tab ' + o + '" style="' + a.headerStyle + '">', (a.iconCls || a.iconStyle) && (t += '<span class="mini-tab-icon ' + a.iconCls + '" style="' + a.iconStyle + '"></span>'), t += '<span class="mini-tab-text">' + a.title + "</span>", a.showCloseButton) {
						var u = "";
						a.enabled && (u = "onmouseover=\"mini.addClass(this, 'mini-tab-close-hover')\" onmouseout=\"mini.removeClass(this, 'mini-tab-close-hover')\""), t += '<span class="mini-tab-close" ' + u + "></span>"
					}
					t += "</td></tr>", l != r - 1 && (t += '<tr><td class="mini-tabs-space2"><div></div></td></tr>')
				}
			}
			t += '<tr ><td class="mini-tabs-space mini-tabs-lastSpace" ><div></div></td></tr>', t += "</table></td>"
		}
		t += "</tr ></table>", this._doClearElement(), mini.addClass(this._td1El, "mini-tabs-header"), mini.append(this._td1El, t), this._headerEl = this._td1El
	},
	_doUpdateRight : function() {
		this._doUpdateLeft(), mini.removeClass(this._td1El, "mini-tabs-header"), mini.removeClass(this._td3El, "mini-tabs-header"), mini.append(this._td3El, this._td1El.firstChild), this._headerEl = this._td3El
	},
	_OnCloseButtonClick : function(t, e) {
		var i = {
			tab : t,
			index : this.tabs.indexOf(t),
			name : t.name.toLowerCase(),
			htmlEvent : e,
			cancel : !1
		};
		if (this.fire("beforecloseclick", i), 1 != i.cancel) {
			try {
				if (t._iframeEl && t._iframeEl.contentWindow) {
					var n = !0;
					t._iframeEl.contentWindow.CloseWindow ? n = t._iframeEl.contentWindow.CloseWindow("close") : t._iframeEl.contentWindow.CloseOwnerWindow && (n = t._iframeEl.contentWindow.CloseOwnerWindow("close")), n === !1 && (i.cancel = !0)
				}
			} catch (s) {}
			1 != i.cancel && (t.removeAction = "close", this.removeTab(t), this.fire("closeclick", i))
		}
	},
	onBeforeCloseClick : function(t, e) {
		this.on("beforecloseclick", t, e)
	},
	onCloseClick : function(t, e) {
		this.on("closeclick", t, e)
	},
	onActiveChanged : function(t, e) {
		this.on("activechanged", t, e)
	},
	getAttrs : function(el) {
		var attrs = mini.Tabs.superclass.getAttrs.call(this, el);
		mini._ParseString(el, attrs, [ "tabAlign", "tabPosition", "bodyStyle", "onactivechanged", "onbeforeactivechanged", "url", "ontabload", "ontabdestroy", "onbeforecloseclick", "oncloseclick", "titleField", "urlField", "nameField", "loadingMsg", "buttons" ]), mini._ParseBool(el, attrs, [ "allowAnim", "showBody", "showHeader", "maskOnLoad", "plain" ]), mini._ParseInt(el, attrs, [ "activeIndex" ]);
		for (var tabs = [], nodes = mini.getChildNodes(el), i = 0, l = nodes.length; l > i; i++) {
			var node = nodes[i],
				o = {};
			tabs.push(o), o.style = node.style.cssText, mini._ParseString(node, o, [ "name", "title", "url", "cls", "iconCls", "iconStyle", "headerCls", "headerStyle", "bodyCls", "bodyStyle", "onload", "ondestroy", "data-options" ]), mini._ParseBool(node, o, [ "newLine", "visible", "enabled", "showCloseButton", "refreshOnClick" ]), o.bodyParent = node;var options = o["data-options"];
			options && (options = eval("(" + options + ")"), options && mini.copyTo(o, options))
		}
		return attrs.tabs = tabs, attrs
	}
}), mini.regClass(mini.Tabs, "tabs"), mini = mini || {}, mini.TextArea = function() {
	mini.TextArea.superclass.constructor.call(this)
}, mini.extend(mini.TextArea, mini.TextBox, {
	maxLength : 1e7,
	width : 180,
	height : 50,
	minHeight : 50,
	_InputType : "textarea",
	uiCls : "mini-textarea",
	doLayout : function() {
		if (this.canLayout()) {
			mini.TextArea.superclass.doLayout.call(this);
			var t = mini.getHeight(this.el);
			mini.setHeight(this._borderEl, t), t -= 2, 0 > t && (t = 0), this._textEl.style.height = t + "px"
		}
	}
}), mini.regClass(mini.TextArea, "textarea"), mini = mini || {}, mini.TextBoxList = function() {
	mini.TextBoxList.superclass.constructor.call(this), this.data = [], this.doUpdate()
}, mini.extend(mini.TextBoxList, mini.ValidatorBase, {
	formField : !0,
	value : "",
	text : "",
	valueField : "id",
	textField : "text",
	url : "",
	delay : 150,
	allowInput : !0,
	editIndex : 0,
	_focusCls : "mini-textboxlist-focus",
	_itemHoverClass : "mini-textboxlist-item-hover",
	_itemSelectedClass : "mini-textboxlist-item-selected",
	_closeHoverClass : "mini-textboxlist-close-hover",
	textName : "",
	setTextName : function(t) {
		this.textName = t
	},
	getTextName : function() {
		return this.textName
	},
	uiCls : "mini-textboxlist",
	_create : function() {
		var t = '<table class="mini-textboxlist" cellpadding="0" cellspacing="0"><tr ><td class="mini-textboxlist-border"><ul></ul><a href="#"></a><input type="hidden"/></td></tr></table>',
			e = document.createElement("div");
		e.innerHTML = t, this.el = e.firstChild;
		var i = this.el.getElementsByTagName("td")[0];
		this.ulEl = i.firstChild, this._valueEl = i.lastChild, this.focusEl = i.childNodes[1]
	},
	destroy : function(t) {
		this.isShowPopup && this.hidePopup(), mini.un(document, "mousedown", this.__OnDocMouseDown, this), mini.TextBoxList.superclass.destroy.call(this, t)
	},
	_initEvents : function() {
		mini.TextBoxList.superclass._initEvents.call(this), mini.on(this.el, "mousemove", this.__OnMouseMove, this), mini.on(this.el, "mouseout", this.__OnMouseOut, this), mini.on(this.el, "mousedown", this.__OnMouseDown, this), mini.on(this.el, "click", this.__OnClick, this), mini.on(this.el, "keydown", this.__OnKeyDown, this), mini.on(document, "mousedown", this.__OnDocMouseDown, this)
	},
	__OnDocMouseDown : function(t) {
		this.isReadOnly() || (this.isShowPopup && (mini.isAncestor(this.popup.el, t.target) || this.hidePopup()), this._focused && 0 == this.within(t) && (this.select(null, !1), this.showInput(!1), this.removeCls(this._focusCls), this._focused = !1))
	},
	errorIconEl : null,
	getErrorIconEl : function() {
		if (!this._errorIconEl) {
			var t = this.el.rows[0],
				e = t.insertCell(1);
			e.style.cssText = "width:18px;vertical-align:top;", e.innerHTML = '<div class="mini-errorIcon"></div>', this._errorIconEl = e.firstChild
		}
		return this._errorIconEl
	},
	_RemoveErrorIcon : function() {
		this._errorIconEl && jQuery(this._errorIconEl.parentNode).remove(), this._errorIconEl = null
	},
	doLayout : function() {
		0 != this.canLayout() && (mini.TextBoxList.superclass.doLayout.call(this), this.isReadOnly() || 0 == this.allowInput ? this._inputEl.readOnly = !0 : this._inputEl.readOnly = !1)
	},
	doUpdate : function() {
		this._ValueChangeTimer && clearInterval(this._ValueChangeTimer), this._inputEl && mini.un(this._inputEl, "keydown", this.__OnInputKeyDown, this);
		for (var t = [], e = this.uid, i = 0, n = this.data.length; n > i; i++) {
			var s = this.data[i],
				o = e + "$text$" + i,
				l = mini._getMap(this.textField, s);
			mini.isNull(l) && (l = ""), t[t.length] = '<li id="' + o + '" class="mini-textboxlist-item">', t[t.length] = l, t[t.length] = '<span class="mini-textboxlist-close"></span></li>'
		}
		var r = e + "$input";
		t[t.length] = '<li id="' + r + '" class="mini-textboxlist-inputLi"><input class="mini-textboxlist-input" type="text" autocomplete="off"></li>', this.ulEl.innerHTML = t.join(""), this.editIndex = this.data.length, this.editIndex < 0 && (this.editIndex = 0), this.inputLi = this.ulEl.lastChild, this._inputEl = this.inputLi.firstChild, mini.on(this._inputEl, "keydown", this.__OnInputKeyDown, this);
		var a = this;
		this._inputEl.onkeyup = function() {
			a._syncInputSize()
		}, a._ValueChangeTimer = null, a._LastInputText = a._inputEl.value, this._inputEl.onfocus = function() {
			a._ValueChangeTimer = setInterval(function() {
				a._LastInputText != a._inputEl.value && (a._startQuery(), a._LastInputText = a._inputEl.value)
			}, 10), a.addCls(a._focusCls), a._focused = !0, a.fire("focus")
		}, this._inputEl.onblur = function() {
			clearInterval(a._ValueChangeTimer), a.fire("blur")
		}
	},
	getItemByEvent : function(t) {
		var e = mini.findParent(t.target, "mini-textboxlist-item");
		if (e) {
			var i = e.id.split("$"),
				n = i[i.length - 1];
			return this.data[n]
		}
	},
	getItem : function(t) {
		return "number" == typeof t ? this.data[t] : "object" == typeof t ? t : void 0
	},
	getItemEl : function(t) {
		var e = this.data.indexOf(t),
			i = this.uid + "$text$" + e;
		return document.getElementById(i)
	},
	hoverItem : function(t, e) {
		if (!this.isReadOnly() && 0 != this.enabled) {
			this.blurItem();
			var i = this.getItemEl(t);
			mini.addClass(i, this._itemHoverClass), e && mini.hasClass(e.target, "mini-textboxlist-close") && mini.addClass(e.target, this._closeHoverClass)
		}
	},
	blurItem : function() {
		for (var t = this.data.length, e = 0, i = t; i > e; e++) {
			var n = this.data[e],
				s = this.getItemEl(n);
			s && (mini.removeClass(s, this._itemHoverClass), mini.removeClass(s.lastChild, this._closeHoverClass))
		}
	},
	showInput : function(t) {
		this.select(null), mini.isNumber(t) ? this.editIndex = t : this.editIndex = this.data.length, this.editIndex < 0 && (this.editIndex = 0), this.editIndex > this.data.length && (this.editIndex = this.data.length);
		var e = this.inputLi;
		if (e.style.display = "block", mini.isNumber(t) && t < this.data.length) {
			var i = this.data[t],
				n = this.getItemEl(i);
			jQuery(n).before(e)
		} else this.ulEl.appendChild(e);
		return t !== !1 ? setTimeout(function() {
				try {
					e.firstChild.focus(), mini.selectRange(e.firstChild, 100)
				} catch (t) {}
			}, 10) : (this.lastInputText = "", this._inputEl.value = ""), e
	},
	select : function(t) {
		if (t = this.getItem(t), this._selected) {
			var e = this.getItemEl(this._selected);
			mini.removeClass(e, this._itemSelectedClass)
		}
		if (this._selected = t, this._selected) {
			var e = this.getItemEl(this._selected);
			mini.addClass(e, this._itemSelectedClass)
		}
		var i = this;
		if (this._selected) {
			this.focusEl.focus();
			var n = this;
			setTimeout(function() {
				try {
					n.focusEl.focus()
				} catch (t) {}
			}, 50)
		}
		this._selected && (i.addCls(i._focusCls), i._focused = !0)
	},
	_doInsertSelectValue : function() {
		var t = this._listbox.getSelected(),
			e = this.editIndex;
		t && (t = mini.clone(t), this.insertItem(e, t))
	},
	insertItem : function(t, e) {
		this.data.insert(t, e);
		var i = this.getText(),
			n = this.getValue();
		this.setValue(n, !1), this.setText(i, !1), this._createData(), this.doUpdate(), this.showInput(t + 1), this._OnValueChanged()
	},
	removeItem : function(t) {
		if (t) {
			var e = this.getItemEl(t);
			mini.removeNode(e), this.data.remove(t);
			var i = this.getText(),
				n = this.getValue();
			this.setValue(n, !1), this.setText(i, !1), this._OnValueChanged()
		}
	},
	_createData : function() {
		var t = (this.text ? this.text : "").split(","),
			e = (this.value ? this.value : "").split(",");
		"" == e[0] && (e = []);
		var i = e.length;
		this.data.length = i;
		for (var n = 0, s = i; s > n; n++) {
			var o = this.data[n];
			o || (o = {}, this.data[n] = o);var l = mini.isNull(t[n]) ? "" : t[n],
				r = mini.isNull(e[n]) ? "" : e[n];
			mini._setMap(this.textField, l, o), mini._setMap(this.valueField, r, o)
		}
		this.value = this.getValue(), this.text = this.getText()
	},
	getInputText : function() {
		return this._inputEl ? this._inputEl.value : ""
	},
	getText : function() {
		for (var t = [], e = 0, i = this.data.length; i > e; e++) {
			var n = this.data[e],
				s = mini._getMap(this.textField, n);
			mini.isNull(s) && (s = ""), s = s.replace(",", "，"), t.push(s)
		}
		return t.join(",")
	},
	getValue : function() {
		for (var t = [], e = 0, i = this.data.length; i > e; e++) {
			var n = this.data[e],
				s = mini._getMap(this.valueField, n);
			t.push(s)
		}
		return t.join(",")
	},
	setName : function(t) {
		this.name != t && (this.name = t, this._valueEl.name = t)
	},
	setValue : function(t) {
		mini.isNull(t) && (t = ""), this.value != t && (this.value = t, this._valueEl.value = t, this._createData(), this.doUpdate())
	},
	setText : function(t) {
		mini.isNull(t) && (t = ""), this.text !== t && (this.text = t, this._createData(), this.doUpdate())
	},
	setValueField : function(t) {
		this.valueField = t, this._createData()
	},
	getValueField : function() {
		return this.valueField
	},
	setTextField : function(t) {
		this.textField = t, this._createData()
	},
	getTextField : function() {
		return this.textField
	},
	setAllowInput : function(t) {
		this.allowInput = t, this.doLayout()
	},
	getAllowInput : function() {
		return this.allowInput
	},
	setUrl : function(t) {
		this.url = this.parseUrl(t)
	},
	getUrl : function() {
		return this.url
	},
	setPopupHeight : function(t) {
		this.popupHeight = t
	},
	getPopupHeight : function() {
		return this.popupHeight
	},
	setPopupMinHeight : function(t) {
		this.popupMinHeight = t
	},
	getPopupMinHeight : function() {
		return this.popupMinHeight
	},
	setPopupMaxHeight : function(t) {
		this.popupMaxHeight = t
	},
	getPopupMaxHeight : function() {
		return this.popupMaxHeight
	},
	doQuery : function() {
		this._startQuery(!0)
	},
	_syncInputSize : function() {
		if (0 != this.isDisplay()) {
			var t = this.getInputText(),
				e = mini.measureText(this._inputEl, t),
				i = e.width > 20 ? e.width + 4 : 20,
				n = mini.getWidth(this.el, !0);
			i > n - 15 && (i = n - 15), this._inputEl.style.width = i + "px"
		}
	},
	_startQuery : function(t) {
		var e = this;
		setTimeout(function() {
			e._syncInputSize()
		}, 1), this.showPopup("loading"), this._stopQuery(), this._loading = !0, this.delayTimer = setTimeout(function() {
			e._inputEl.value, e._doQuery()
		}, this.delay)
	},
	_doQuery : function() {
		if (0 != this.isDisplay()) {
			var t = this.getInputText(),
				e = this,
				i = (this._listbox.getData(), {
					value : this.getValue(),
					text : this.getText()
				});
			i[this.searchField] = t;
			var n = this.url,
				s = "function" == typeof n ? n : window[n];
			if ("function" == typeof s && (n = s(this)), n) {
				var o = "post";
				n && (-1 != n.indexOf(".txt") || -1 != n.indexOf(".json")) && (o = "get");
				var l = {
					url : n,
					async : !0,
					params : i,
					data : i,
					type : o,
					cache : !1,
					cancel : !1
				};
				this.fire("beforeload", l), l.data != l.params && l.params != i && (l.data = l.params), l.cancel || (mini.copyTo(l, {
					success : function(t) {
						var i = mini.decode(t);
						e.dataField && (i = mini._getMap(e.dataField, i)), i || (i = []), e._listbox.setData(i), e.showPopup(), e._listbox._focusItem(0, !0), e.fire("load"), e._loading = !1, e._selectOnLoad && (e.__doSelectValue(), e._selectOnLoad = null)
					},
					error : function(t, i, n) {
						e.showPopup("error")
					}
				}), e._ajaxer = mini.ajax(l))
			}
		}
	},
	_stopQuery : function() {
		this.delayTimer && (clearTimeout(this.delayTimer), this.delayTimer = null), this._ajaxer && this._ajaxer.abort(), this._loading = !1
	},
	within : function(t) {
		return mini.isAncestor(this.el, t.target) ? !0 : this.showPopup && this.popup && this.popup.within(t) ? !0 : !1
	},
	popupLoadingText : "<span class='mini-textboxlist-popup-loading'>Loading...</span>",
	popupErrorText : "<span class='mini-textboxlist-popup-error'>Error</span>",
	popupEmptyText : "<span class='mini-textboxlist-popup-noresult'>No Result</span>",
	isShowPopup : !1,
	popupHeight : "",
	popupMinHeight : 30,
	popupMaxHeight : 150,
	_createPopup : function() {
		return this.popup || (this.popup = new mini.ListBox, this.popup.addCls("mini-textboxlist-popup"), this.popup.setStyle("position:absolute;left:0;top:0;"), this.popup.showEmpty = !0, this.popup.setValueField(this.valueField), this.popup.setTextField(this.textField), this.popup.render(document.body), this.popup.on("itemclick", function(t) {
				this.hidePopup(), this._doInsertSelectValue()
			}, this)), this._listbox = this.popup, this.popup
	},
	showPopup : function(t) {
		if (0 != this.isDisplay()) {
			this.isShowPopup = !0;
			var e = this._createPopup();
			e.el.style.zIndex = mini.getMaxZIndex();
			var i = this._listbox;
			i.emptyText = this.popupEmptyText, "loading" == t ? (i.emptyText = this.popupLoadingText, this._listbox.setData([])) : "error" == t && (i.emptyText = this.popupLoadingText, this._listbox.setData([])), this._listbox.doUpdate();
			var n = this.getBox(),
				s = n.x,
				o = n.y + n.height;
			this.popup.el.style.display = "block", mini.setXY(e.el, -1e3, -1e3), this.popup.setWidth(n.width), this.popup.setHeight(this.popupHeight), this.popup.getHeight() < this.popupMinHeight && this.popup.setHeight(this.popupMinHeight), this.popup.getHeight() > this.popupMaxHeight && this.popup.setHeight(this.popupMaxHeight), mini.setXY(e.el, s, o)
		}
	},
	hidePopup : function() {
		this.isShowPopup = !1, this.popup && (this.popup.el.style.display = "none")
	},
	__OnMouseMove : function(t) {
		if (0 != this.enabled) {
			var e = this.getItemByEvent(t);
			return e ? void this.hoverItem(e, t) : void this.blurItem()
		}
	},
	__OnMouseOut : function(t) {
		this.blurItem()
	},
	__OnClick : function(t) {
		if (!this.isReadOnly() && 0 != this.enabled && 0 != this.enabled) {
			var e = this.getItemByEvent(t);
			if (!e) return void (mini.findParent(t.target, "mini-textboxlist-input") || this.showInput());
			this.focusEl.focus(), this.select(e), t && mini.hasClass(t.target, "mini-textboxlist-close") && this.removeItem(e)
		}
	},
	__OnKeyDown : function(t) {
		function e() {
			var t = n.data[i];
			n.removeItem(t), t = n.data[i], t || (t = n.data[i - 1]), n.select(t), t || n.showInput()
		}
		if (this.isReadOnly() || 0 == this.allowInput) return !1;
		var i = this.data.indexOf(this._selected),
			n = this;
		switch (t.keyCode) {
		case 8:
			t.preventDefault(), e();
			break;case 37:
		case 38:
			this.select(null), this.showInput(i);
			break;case 39:
		case 40:
			i += 1, this.select(null), this.showInput(i);
			break;case 46:
			e()
		}
	},
	__doSelectValue : function() {
		var t = this._listbox.getFocusedItem();
		t && this._listbox.setSelected(t), this.lastInputText = this.text, this.hidePopup(), this._doInsertSelectValue()
	},
	__OnInputKeyDown : function(t) {
		if (this._selectOnLoad = null, this.isReadOnly() || 0 == this.allowInput) return !1;
		if (t.stopPropagation(), !this.isReadOnly() && 0 != this.allowInput) {
			var e = mini.getSelectRange(this._inputEl),
				i = e[0],
				n = e[1],
				s = this._inputEl.value.length,
				o = i == n && 0 == i,
				l = i == n && n == s;
			if ((this.isReadOnly() || 0 == this.allowInput) && t.preventDefault(), 9 == t.keyCode) return void this.hidePopup();
			if (16 != t.keyCode && 17 != t.keyCode && 18 != t.keyCode) switch (t.keyCode) {
				case 13:
					if (this.isShowPopup) {
						if (t.preventDefault(), this._loading) return void (this._selectOnLoad = !0);
						this.__doSelectValue()
					}
					break;case 27:
					t.preventDefault(), this.hidePopup();
					break;case 8:
					o && t.preventDefault();case 37:
					if (o)
						if (this.isShowPopup) this.hidePopup();
						else if (this.editIndex > 0) {
							var r = this.editIndex - 1;
							0 > r && (r = 0), r >= this.data.length && (r = this.data.length - 1), this.showInput(!1), this.select(r)
					}
					break;case 39:
					if (l)
						if (this.isShowPopup) this.hidePopup();
						else if (this.editIndex <= this.data.length - 1) {
							var r = this.editIndex;
							this.showInput(!1), this.select(r)
					}
					break;case 38:
					if (t.preventDefault(), this.isShowPopup) {
						var r = -1,
							a = this._listbox.getFocusedItem();
						a && (r = this._listbox.indexOf(a)), r--, 0 > r && (r = 0), this._listbox._focusItem(r, !0)
					}
					break;case 40:
					if (t.preventDefault(), this.isShowPopup) {
						var r = -1,
							a = this._listbox.getFocusedItem();
						a && (r = this._listbox.indexOf(a)), r++, 0 > r && (r = 0), r >= this._listbox.getCount() && (r = this._listbox.getCount() - 1), this._listbox._focusItem(r, !0)
					} else this._startQuery(!0)
			}
		}
	},
	focus : function() {
		try {
			this._inputEl.focus()
		} catch (t) {}
	},
	blur : function() {
		try {
			this._inputEl.blur()
		} catch (t) {}
	},
	searchField : "key",
	setSearchField : function(t) {
		this.searchField = t
	},
	getSearchField : function() {
		return this.searchField
	},
	getAttrs : function(t) {
		var e = mini.TextBox.superclass.getAttrs.call(this, t);
		return jQuery(t), mini._ParseString(t, e, [ "value", "text", "valueField", "textField", "url", "popupHeight", "textName", "onfocus", "onbeforeload", "onload", "searchField" ]), mini._ParseBool(t, e, [ "allowInput" ]), mini._ParseInt(t, e, [ "popupMinHeight", "popupMaxHeight" ]), e
	}
}), mini.regClass(mini.TextBoxList, "textboxlist"), mini.TimeSpinner = function() {
	mini.TimeSpinner.superclass.constructor.call(this), this.setValue("00:00:00")
}, mini.extend(mini.TimeSpinner, mini.ButtonEdit, {
	value : null,
	format : "H:mm:ss",
	uiCls : "mini-timespinner",
	_getButtonHtml : function() {
		var t = "onmouseover=\"mini.addClass(this, '" + this._buttonHoverCls + "');\" onmouseout=\"mini.removeClass(this, '" + this._buttonHoverCls + "');\"";
		return '<span class="mini-buttonedit-button" ' + t + '><span class="mini-buttonedit-up"><span></span></span><span class="mini-buttonedit-down"><span></span></span></span>'
	},
	_initEvents : function() {
		mini.TimeSpinner.superclass._initEvents.call(this), mini._BindEvents(function() {
			this.on("buttonmousedown", this.__OnButtonMouseDown, this), mini.on(this.el, "mousewheel", this.__OnMousewheel, this), mini.on(this._textEl, "keydown", this.__OnKeyDown, this)
		}, this)
	},
	setFormat : function(t) {
		"string" == typeof t && this.format != t && (this.format = t, this.text = this._textEl.value = this.getFormattedValue())
	},
	getFormat : function() {
		return this.format
	},
	setValue : function(t, e) {
		t = mini.parseTime(t, this.format), t || (t = mini.parseTime("00:00:00", this.format)), mini.isDate(t) && (t = new Date(t.getTime())), mini.formatDate(this.value, "H:mm:ss") != mini.formatDate(t, "H:mm:ss") && (this.value = t, this.text = this._textEl.value = this.getFormattedValue(), this._valueEl.value = this.getFormValue(), void 0 === e && (e = !0), e && this._OnValueChanged())
	},
	getValue : function() {
		return null == this.value ? null : new Date(this.value.getTime())
	},
	getFormValue : function() {
		return this.value ? mini.formatDate(this.value, "H:mm:ss") : ""
	},
	getFormattedValue : function() {
		return this.value ? mini.formatDate(this.value, this.format) : ""
	},
	_ChangeValue : function(t, e) {
		var i = this.getValue();
		if (i) switch (e) {
			case "hours":
				var n = i.getHours() + t;
				n > 23 && (n = 23), 0 > n && (n = 0), i.setHours(n);
				break;case "minutes":
				var s = i.getMinutes() + t;
				s > 59 && (s = 59), 0 > s && (s = 0), i.setMinutes(s);
				break;case "seconds":
				var o = i.getSeconds() + t;
				o > 59 && (o = 59), 0 > o && (o = 0), i.setSeconds(o)
		}
		else
			i = "00:00:00";
		this.setValue(i)
	},
	_SpinTimer : null,
	_StartSpin : function(t, e, i) {
		this._StopSpin(), this._ChangeValue(t, this._timeType);
		var n = this,
			s = i,
			o = new Date;
		this._SpinTimer = setInterval(function() {
			n._ChangeValue(t, n._timeType), i--, 0 == i && e > 50 && n._StartSpin(t, e - 100, s + 3);
			var l = new Date;
			l - o > 500 && n._StopSpin(), o = l
		}, e), mini.on(document, "mouseup", this._OnDocumentMouseUp, this)
	},
	_StopSpin : function() {
		clearInterval(this._SpinTimer), this._SpinTimer = null
	},
	__OnButtonMouseDown : function(t) {
		this._DownValue = this.getFormValue(), this._timeType = "hours", "up" == t.spinType ? this._StartSpin(1, 230, 2) : this._StartSpin(-1, 230, 2)
	},
	_OnDocumentMouseUp : function(t) {
		this._StopSpin(), mini.un(document, "mouseup", this._OnDocumentMouseUp, this)
	},
	__OnInputTextChanged : function(t) {
		this.getFormValue(), this.setValue(this._textEl.value)
	},
	getAttrs : function(t) {
		var e = mini.TimeSpinner.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "format" ]), e
	}
}), mini.regClass(mini.TimeSpinner, "timespinner"), mini.ToolBar = function() {
	mini.ToolBar.superclass.constructor.call(this)
}, mini.extend(mini.ToolBar, mini.Container, {
	_clearBorder : !1,
	style : "",
	uiCls : "mini-toolbar",
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-toolbar"
	},
	_initEvents : function() {},
	doLayout : function() {
		if (this.canLayout())
			for (var t = mini.getChildNodes(this.el, !0), e = 0, i = t.length; i > e; e++) mini.layout(t[e])
	},
	set_bodyParent : function(t) {
		t && (this.el = t, this.doLayout())
	},
	getAttrs : function(t) {
		var e = {};
		return mini._ParseString(t, e, [ "id", "borderStyle" ]), this.el = t, this.el.uid = this.uid, this.addCls(this.uiCls), e
	}
}), mini.regClass(mini.ToolBar, "toolbar"), mini.Tree = function(t) {
	this.root = {
		_id : -1,
		_pid : "",
		_level : -1
	}, this.data = this.root[this.nodesField] = [], this._idNodes = {}, this.idNodes = {}, this._viewNodes = null, mini.Tree.superclass.constructor.call(this, t), this.on("beforeexpand", function(t) {
		var e = t.node,
			i = this.isLeaf(e),
			n = e[this.nodesField];
		i || n && 0 != n.length || this.loadOnExpand && e.asyncLoad !== !1 && (t.cancel = !0, this.loadNode(e))
	}, this), this.doUpdate()
}, mini.Tree.NodeUID = 1;
var lastNodeLevel = [];
mini.extend(mini.Tree, mini.Control, {
	_ajaxOption : {
		async : !0,
		type : "get"
	},
	isTree : !0,
	_displayStyle : "block",
	autoLoad : !0,
	autoEscape : !0,
	loadOnExpand : !0,
	removeOnCollapse : !0,
	expandOnDblClick : !0,
	expandOnNodeClick : !1,
	value : "",
	_selectedNode : null,
	allowSelect : !0,
	showCheckBox : !1,
	showFolderCheckBox : !0,
	showExpandButtons : !0,
	enableHotTrack : !0,
	showArrow : !1,
	expandOnLoad : !1,
	delimiter : ",",
	url : "",
	root : null,
	resultAsTree : !0,
	parentField : "pid",
	idField : "id",
	textField : "text",
	iconField : "iconCls",
	nodesField : "children",
	showTreeIcon : !1,
	showTreeLines : !0,
	checkRecursive : !1,
	checkOpposite : !1,
	allowAnim : !0,
	_checkBoxCls : "mini-tree-checkbox",
	_selectedNodeCls : "mini-tree-selectedNode",
	_nodeHoverCls : "mini-tree-node-hover",
	leafIcon : "mini-tree-leaf",
	folderIcon : "mini-tree-folder",
	_borderCls : "mini-tree-border",
	_headerCls : "mini-tree-header",
	_bodyCls : "mini-tree-body",
	_nodeCls : "mini-tree-node",
	_nodesCls : "mini-tree-nodes",
	_expandNodeCls : "mini-tree-expand",
	_collapseNodeCls : "mini-tree-collapse",
	_eciconCls : "mini-tree-node-ecicon",
	_inNodeCls : "mini-tree-nodeshow",
	set : function(t) {
		if ("string" == typeof t) return this;
		var e = t.value;
		delete t.value;
		var i = t.url;
		delete t.url;
		var n = t.data;
		return delete t.data
			, mini.Tree.superclass.set.call(this, t), mini.isNull(n) || this.setData(n), mini.isNull(i) || this.setUrl(i), mini.isNull(e) || this.setValue(e), this
	},
	uiCls : "mini-tree",
	destroy : function(t) {
		delete this._idNodes
		,
		delete this.idNodes
		,
		delete this._viewNodes
		,
		delete this._selectedNode
		,
		delete this._focusedNode
		, this._headerEl && (mini.clearEvent(this._headerEl), this._borderEl.removeChild(this._headerEl), this._headerEl = null), this._bodyEl && (mini.clearEvent(this._bodyEl), this._borderEl.removeChild(this._bodyEl), this._bodyEl = null), this._borderEl && (mini.clearEvent(this._borderEl), this.el.removeChild(this._borderEl), this._borderEl = null), this._DragDrop && (mini.clearEvent(this._DragDrop), this._DragDrop.destroy(t), this._DragDrop = null),
		delete this._cellErrors
		,
		delete this._cellMapErrors
		,
		delete this.data
		,
		delete this._list
		,
		delete this.root
		,
		delete this._indexs
		, mini.Tree.superclass.destroy.call(this, t)
	},
	_create : function() {
		this.el = document.createElement("div"), this.el.className = "mini-tree", 1 == this.showTreeLines && mini.addClass(this.el, "mini-tree-treeLine"), this.el.style.display = "block", this._borderEl = mini.append(this.el, '<div class="' + this._borderCls + '"><div class="' + this._headerCls + '"></div><div class="' + this._bodyCls + '"></div></div>'), this._headerEl = this._borderEl.childNodes[0], this._bodyEl = this._borderEl.childNodes[1], this._DragDrop = new mini._TreeDragDrop(this)
	},
	_initEvents : function() {
		mini._BindEvents(function() {
			mini.on(this.el, "click", this.__OnClick, this), mini.on(this.el, "dblclick", this.__OnDblClick, this), mini.on(this.el, "mousedown", this.__OnMouseDown, this), mini.on(this.el, "mousemove", this.__OnMouseMove, this), mini.on(this.el, "mouseout", this.__OnMouseOut, this), mini.on(this.el, "mouseover", this.__OnMouseOver, this)
		}, this)
	},
	load : function(t, e) {
		"undefined" == typeof t ? this._doLoad({}, this.root) : "string" == typeof t ? (this.url = t, this._doLoad(e, this.root)) : this.setData(t)
	},
	setData : function(data) {
		"string" == typeof data && (data = eval("(" + data + ")")), this.loadData(data), this.data = data, this._cellErrors = [], this._cellMapErrors = {}
	},
	getData : function() {
		return this.data
	},
	toArray : function() {
		return this.getList()
	},
	getList : function() {
		if (!this._list) {
			this._list = mini.treeToArray(this.root[this.nodesField], this.nodesField, this.idField, this.parentField, "-1"), this._indexs = {};
			for (var t = 0, e = this._list.length; e > t; t++) {
				var i = this._list[t];
				this._indexs[i[this.idField]] = t
			}
		}
		return this._list
	},
	_clearTree : function() {
		this._list = null, this._indexs = null
	},
	loadList : function(t, e, i) {
		e = e || this.idField, i = i || this.parentField;
		var n = mini.arrayToTree(t, this.nodesField, e, i);
		this.setData(n)
	},
	loadData : function(t) {
		mini.isArray(t) || (t = []), this.root[this.nodesField] = t, this.data = t, this.idNodes = {}, this._idNodes = {}, this._updateParentAndLevel(this.root, null), this.cascadeChild(this.root, function(t) {
			if (mini.isNull(t.expanded)) {
				var e = this.getLevel(t);
				this.expandOnLoad === !0 || mini.isNumber(this.expandOnLoad) && e <= this.expandOnLoad ? t.expanded = !0 : t.expanded = !1
			}
			if (t.isLeaf === !1) {
				var i = t[this.nodesField];
				i && i.length > 0 &&
				delete t.isLeaf
			}
		}, this), this._viewNodes = null, this._selectedNode = null, this.doUpdate()
	},
	clearData : function() {
		this.loadData([])
	},
	setUrl : function(t) {
		this.url = this.parseUrl(t), this.autoLoad && this.load(this.url)
	},
	getUrl : function() {
		return this.url
	},
	loadNode : function(t, e) {
		if (t = this.getNode(t), t && !this.isLeaf(t)) {
			var i = {};
			i[this.idField] = this.getItemValue(t);
			var n = this;
			n.addNodeCls(t, "mini-tree-loading");
			var s = new Date;
			this._doLoad(i, t, function(i) {
				var o = new Date - s;
				60 > o && (o = 60 - o), setTimeout(function() {
					n.removeNodeCls(t, "mini-tree-loading"), n.removeNodes(t[n.nodesField]), i && i.length > 0 ? (n.addNodes(i, t), e !== !1 ? n.expandNode(t, !0) : n.collapseNode(t, !0), n.fire("loadnode", {
						node : t
					})) : (
						delete t.isLeaf
						, n._doUpdateNodeTitle(t))
				}, o)
			}, function(e) {
				n.removeNodeCls(t, "mini-tree-loading")
			}), this.ajaxAsync = !1
		}
	},
	setAjaxOption : function(t) {
		mini.copyTo(this._ajaxOption, t)
	},
	getAjaxOption : function(t) {
		return this._ajaxOption
	},
	_doLoad : function(params, node, success, fail) {
		try {
			var url = eval(this.url);
			void 0 != url && (this.url = url)
		} catch (e) {}
		var isRoot = node == this.root,
			e = {
				url : this.url,
				async : this._ajaxOption.async,
				type : this._ajaxOption.type,
				params : params,
				data : params,
				cache : !1,
				cancel : !1,
				node : node,
				isRoot : isRoot
			};
		if (this.fire("beforeload", e), e.data != e.params && e.params != params && (e.data = e.params), 1 != e.cancel) {
			node != this.root;
			var sf = this,
				container = node;
			isRoot ? (mini.addClass(this._bodyEl, "mini-tree-loading"), this._bodyEl.innerHTML = "<div class='mini-treegrid-ec-icon'>&nbsp;</div>") : sf.addNodeCls(container, "mini-tree-loading"), mini.copyTo(e, {
				success : function(t, e, i) {
					isRoot ? (mini.removeClass(sf._bodyEl, "mini-tree-loading"), sf._bodyEl.innerHTML = "") : sf.removeNodeCls(container, "mini-tree-loading");
					var n = null;
					try {
						n = mini.decode(t)
					} catch (s) {
						n = [], 1 == mini_debugger && alert("tree json is error.")
					}
					sf.dataField && (n = mini._getMap(sf.dataField, n)), n || (n = []);
					var s = {
						result : n,
						data : n,
						cancel : !1,
						node : node
					};
					0 == sf.resultAsTree && (s.data = mini.arrayToTree(s.data, sf.nodesField, sf.idField, sf.parentField)), sf.fire("preload", s), 1 != s.cancel && (isRoot && sf.setData(s.data), success && success(s.data), sf._doCheckLoadNodes(), sf.fire("load", s))
				},
				error : function(t, e, i) {
					isRoot ? (mini.removeClass(sf._bodyEl, "mini-tree-loading"), sf._bodyEl.innerHTML = "") : sf.removeNodeCls(container, "mini-tree-loading");
					var n = {
						xmlHttp : t,
						errorCode : e
					};
					fail && fail(n), 1 == mini_debugger && alert("network error"), sf.fire("loaderror", n)
				}
			}), this._ajaxer = mini.ajax(e)
		}
	},
	getItemValue : function(t) {
		if (!t) return "";
		var e = mini._getMap(this.idField, t);
		return mini.isNull(e) ? "" : String(e)
	},
	getItemText : function(t) {
		if (!t) return "";
		var e = mini._getMap(this.textField, t);
		return mini.isNull(e) ? "" : String(e)
	},
	_OnDrawNode : function(t) {
		var e = this.showCheckBox;
		e && this.hasChildren(t) && (e = this.showFolderCheckBox);
		var i = this.getItemText(t),
			n = {
				isLeaf : this.isLeaf(t),
				node : t,
				nodeHtml : i,
				nodeCls : "",
				nodeStyle : "",
				showCheckBox : e,
				iconCls : this.getNodeIcon(t),
				showTreeIcon : this.showTreeIcon
			};
		return 1 == this.autoEscape && (n.nodeHtml = mini.htmlEncode(n.nodeHtml)), this.fire("drawnode", n), (null === n.nodeHtml || void 0 === n.nodeHtml || "" === n.nodeHtml) && (n.nodeHtml = "&nbsp;"), n
	},
	_createNodeTitle : function(t, e, i) {
		var n = !i;
		i || (i = []);
		var s = t[this.textField];
		(null === s || void 0 === s) && (s = "");
		var o = this.isLeaf(t),
			l = this.getLevel(t),
			r = this._OnDrawNode(t),
			a = r.nodeCls;
		o || (this._viewNodes ? this._getViewChildNodes(t).length > 0 && (a = this.isExpandedNode(t) ? this._expandNodeCls : this._collapseNodeCls) : a = this.isExpandedNode(t) ? this._expandNodeCls : this._collapseNodeCls), this._selectedNode == t && (a += " " + this._selectedNodeCls), o || (a += " mini-tree-parentNode"), i[i.length] = '<div class="mini-tree-nodetitle ' + a + '" style="' + r.nodeStyle + '">';
		for (var h = this.getParentNode(t), d = 0, u = d; l >= u; u++)
			if (u != l && !(o && 0 == this.showExpandButtons && u >= l - 1)) {
				var c = "";
				this._isInViewLastNode(t, u) && (c = "background:none"), i[i.length] = '<span class="mini-tree-indent " style="' + c + '"></span>'
		}
		var m = "";
		if (this._isViewFirstNode(t) && this._isViewLastNode(t) ? (m = "mini-tree-node-ecicon-last", h == this.root && (m = "mini-tree-node-ecicon-firstLast")) : this._isViewFirstNode(t) && h && h != this.root ? m = "" : this._isViewFirstNode(t) ? m = "mini-tree-node-ecicon-first" : this._isViewLastNode(t) && (m = "mini-tree-node-ecicon-last"), o ? i[i.length] = '<span class="' + this._eciconCls + " " + m + '" ></span>' : i[i.length] = '<a class="' + this._eciconCls + " " + m + '" style="' + (this.showExpandButtons ? "" : "display:none") + '" href="javascript:void(0);" onclick="return false;" hidefocus></a>', i[i.length] = '<span class="mini-tree-nodeshow">', r.showTreeIcon && (i[i.length] = '<span class="' + r.iconCls + ' mini-tree-icon"></span>'), r.showCheckBox) {
			var p = this._createCheckNodeId(t),
				f = this.isCheckedNode(t);
			i[i.length] = '<input type="checkbox" id="' + p + '" class="' + this._checkBoxCls + '" hidefocus ' + (f ? "checked" : "") + " " + (t.enabled === !1 ? "disabled" : "") + "/>"
		}
		if (i[i.length] = '<span class="mini-tree-nodetext">', e) {
			var g = this.uid + "$edit$" + t._id,
				s = t[this.textField];
			(null === s || void 0 === s) && (s = ""), i[i.length] = '<input id="' + g + '" type="text" class="mini-tree-editinput" value="' + s + '"/>'
		} else
			this.autoEscape ? i[i.length] = mini.htmlEncode(r.nodeHtml) : i[i.length] = r.nodeHtml;
		return i[i.length] = "</span>", i[i.length] = "</span>", i[i.length] = "</div>", n ? i.join("") : void 0
	},
	_createNode : function(t, e) {
		var i = !e;
		if (e || (e = []), !t) return "";
		var n = this._createNodeId(t),
			s = this.isVisibleNode(t) ? "" : "display:none";
		e[e.length] = '<div id="', e[e.length] = n, e[e.length] = '" class="', e[e.length] = this._nodeCls, t.enabled === !1 && (e[e.length] = " mini-disabled"), e[e.length] = '" style="', e[e.length] = s, e[e.length] = '">', this._createNodeTitle(t, !1, e);
		var o = this._getViewChildNodes(t);
		return o && o.length > 0 && this.removeOnCollapse && this.isExpandedNode(t) && this._createNodes(o, t, e), e[e.length] = "</div>", i ? e.join("") : void 0
	},
	_createNodes : function(t, e, i) {
		var n = !i;
		if (i || (i = []), !t) return "";
		var s = this._createNodesId(e),
			o = this.isExpandedNode(e) ? "" : "display:none";
		i[i.length] = '<div id="', i[i.length] = s, i[i.length] = '" class="', i[i.length] = this._nodesCls, i[i.length] = '" style="', i[i.length] = o, i[i.length] = '">';
		for (var l = 0, r = t.length; r > l; l++) {
			var a = t[l];
			this._createNode(a, i)
		}
		return i[i.length] = "</div>", n ? i.join("") : void 0
	},
	doUpdate : function() {
		if (this._allowUpdate) {
			var t = this._getViewChildNodes(this.root),
				e = [];
			this._createNodes(t, this.root, e);
			var i = e.join("");
			this._bodyEl.innerHTML = i, this._deferLayout()
		}
	},
	_doLayoutHeader : function() {},
	_deferLayout : function() {
		var t = this;
		this._layoutTimer || (this._layoutTimer = setTimeout(function() {
			t.doLayout(), t._layoutTimer = null
		}, 1))
	},
	doLayout : function() {
		if (this.showCheckBox ? mini.addClass(this.el, "mini-tree-showCheckBox") : mini.removeClass(this.el, "mini-tree-showCheckBox"), this.enableHotTrack ? mini.addClass(this.el, "mini-tree-hottrack") : mini.removeClass(this.el, "mini-tree-hottrack"), this.el) {
			var t = this.el.firstChild;
			t && mini.addClass(t, "mini-tree-rootnodes")
		}
	},
	filter : function(t, e) {
		function i(o) {
			var l = o[s];
			if (!l) return !1;
			for (var r = o._id, a = [], h = 0, d = l.length; d > h; h++) {
				var u = l[h],
					c = i(u),
					m = t.call(e, u, h, this);
				(m === !0 || c) && (a.push(u), n[u._id] = null)
			}
			return a.length > 0 && (n[r] = a), a.length > 0
		}
		e = e || this;
		var n = this._viewNodes = {},
			s = this.nodesField;
		return i(this.root), this.doUpdate(), this._viewNodes
	},
	clearFilter : function() {
		this._viewNodes && (this._viewNodes = null, this.doUpdate())
	},
	setShowCheckBox : function(t) {
		this.showCheckBox != t && (this.showCheckBox = t, this.doUpdate())
	},
	getShowCheckBox : function() {
		return this.showCheckBox
	},
	setShowFolderCheckBox : function(t) {
		this.showFolderCheckBox != t && (this.showFolderCheckBox = t, this.doUpdate())
	},
	getShowFolderCheckBox : function() {
		return this.showFolderCheckBox
	},
	setAllowSelect : function(t) {
		this.allowSelect != t && (this.allowSelect = t, this.doUpdate())
	},
	getAllowSelect : function() {
		return this.allowSelect
	},
	setShowTreeIcon : function(t) {
		this.showTreeIcon != t && (this.showTreeIcon = t, this.doUpdate())
	},
	getShowTreeIcon : function() {
		return this.showTreeIcon
	},
	setShowExpandButtons : function(t) {
		this.showExpandButtons != t && (this.showExpandButtons = t, this.doUpdate())
	},
	getShowExpandButtons : function() {
		return this.showExpandButtons
	},
	setEnableHotTrack : function(t) {
		this.enableHotTrack != t && (this.enableHotTrack = t, this.doLayout())
	},
	getEnableHotTrack : function() {
		return this.enableHotTrack
	},
	setExpandOnLoad : function(t) {
		this.expandOnLoad = t
	},
	getExpandOnLoad : function() {
		return this.expandOnLoad
	},
	setCheckRecursive : function(t) {
		this.checkRecursive != t && (this.checkRecursive = t)
	},
	getCheckRecursive : function() {
		return this.checkRecursive
	},
	setCheckOpposite : function(t) {
		this.checkOpposite = t
	},
	getNodeIcon : function(t) {
		var e = mini._getMap(this.iconField, t);
		return e || (e = this.isLeaf(t) ? this.leafIcon : this.folderIcon), e
	},
	isAncestor : function(t, e) {
		if (t == e) return !0;
		if (!t || !e) return !1;
		for (var i = this.getAncestors(e), n = 0, s = i.length; s > n; n++)
			if (i[n] == t) return !0;
		return !1
	},
	getAncestors : function(t) {
		for (var e = [];;) {
			var i = this.getParentNode(t);
			if (!i || i == this.root) break;
			e[e.length] = i, t = i
		}
		return e.reverse(), e
	},
	getRootNode : function() {
		return this.root
	},
	getParentNode : function(t) {
		return t ? t._pid == this.root._id ? this.root : this._idNodes[t._pid] : null
	},
	isRoot : function(t) {
		return t ? t == this.root : !1
	},
	_isViewFirstNode : function(t) {
		if (this._viewNodes) {
			var e = this.getParentNode(t),
				i = this._getViewChildNodes(e);
			return i[0] === t
		}
		return this.isFirstNode(t)
	},
	_isViewLastNode : function(t) {
		if (this._viewNodes) {
			var e = this.getParentNode(t),
				i = this._getViewChildNodes(e);
			return i[i.length - 1] === t
		}
		return this.isLastNode(t)
	},
	_isInViewLastNode : function(t, e) {
		if (this._viewNodes) {
			for (var i = null, n = this.getAncestors(t), s = 0, o = n.length; o > s; s++) {
				var l = n[s];
				this.getLevel(l) == e && (i = l)
			}
			return i && i != this.root ? this._isViewLastNode(i) : !1
		}
		return this.isInLastNode(t, e)
	},
	_getViewChildNodes : function(t) {
		var e = this.getChildNodes(t);
		if (!e) return [];
		if (this._viewNodes) {
			for (var i = [], n = 0; n < e.length; n++) this._viewNodes.hasOwnProperty(e[n]._id) && i.push(e[n]);
			return i
		}
		return e
	},
	getChildNodes : function(t) {
		return t = this.getNode(t), t ? t[this.nodesField] : null
	},
	getAllChildNodes : function(t) {
		if (t = this.getNode(t), !t) return [];
		var e = [];
		return this.cascadeChild(t, function(t) {
				e.push(t)
			}, this), e
	},
	indexOf : function(t) {
		if (t = this.getNode(t), !t) return -1;
		this.getList();
		var e = this._indexs[t[this.idField]];
		return mini.isNull(e) ? -1 : e
	},
	getAt : function(t) {
		var e = this.getList();
		return e[t]
	},
	indexOfChildren : function(t) {
		var e = this.getParentNode(t);
		if (!e) return -1;
		var i = e[this.nodesField];
		return i.indexOf(t)
	},
	hasChildren : function(t) {
		var e = this.getChildNodes(t);
		return !!(e && e.length > 0)
	},
	isLeaf : function(t) {
		if (!t || t.isLeaf === !1) return !1;
		var e = this.getChildNodes(t);
		return e && e.length > 0 ? !1 : !0
	},
	getLevel : function(t) {
		return t._level
	},
	isExpandedNode : function(t) {
		return t = this.getNode(t), t ? 1 == t.expanded || mini.isNull(t.expanded) : !1
	},
	isCheckedNode : function(t) {
		return t = this.getNode(t), t ? 1 == t.checked : !1
	},
	isVisibleNode : function(t) {
		if (0 == t.visible) return !1;
		var e = this.getParentNode(t);
		return e && e != this.root ? e.expanded === !1 ? !1 : this.isVisibleNode(e) : !0
	},
	isEnabledNode : function(t) {
		return t.enabled !== !1 || this.enabled
	},
	isFirstNode : function(t) {
		var e = this.getParentNode(t),
			i = this.getChildNodes(e);
		return i[0] === t
	},
	isLastNode : function(t) {
		var e = this.getParentNode(t),
			i = this.getChildNodes(e);
		return i[i.length - 1] === t
	},
	isInLastNode : function(t, e) {
		for (var i = null, n = this.getAncestors(t), s = 0, o = n.length; o > s; s++) {
			var l = n[s];
			this.getLevel(l) == e && (i = l)
		}
		return i && i != this.root ? this.isLastNode(i) : !1
	},
	bubbleParent : function(t, e, i) {
		i = i || this, t && e.call(this, t);
		var n = this.getParentNode(t);
		n && n != this.root && this.bubbleParent(n, e, i)
	},
	cascadeChild : function(t, e, i) {
		if (e) {
			t || (t = this.root);
			var n = t[this.nodesField];
			if (n) {
				n = n.clone();
				for (var s = 0, o = n.length; o > s; s++) {
					var l = n[s];
					if (e.call(i || this, l, s, t) === !1) return;
					this.cascadeChild(l, e, i)
				}
			}
		}
	},
	eachChild : function(t, e, i) {
		if (e && t) {
			var n = t[this.nodesField];
			if (n)
				for (var s = n.clone(), o = 0, l = s.length; l > o; o++) {
					var r = s[o];
					if (e.call(i || this, r, o, t) === !1) break
			}
		}
	},
	_updateParentAndLevel : function(t, e) {
		t._id || (t._id = mini.Tree.NodeUID++), this._idNodes[t._id] = t, this.idNodes[t[this.idField]] = t, t._pid = e ? e._id : "", t._level = e ? e._level + 1 : -1, this.cascadeChild(t, function(t, e, i) {
			t._id || (t._id = mini.Tree.NodeUID++), this._idNodes[t._id] = t, this.idNodes[t[this.idField]] = t, t._pid = i._id, t._level = i._level + 1
		}, this), this._clearTree()
	},
	_updateNodeElLevel : function(t) {
		function e(t) {
			i._doUpdateNodeTitle(t)
		}
		var i = this;
		t != this.root && e(t), this.cascadeChild(t, function(t) {
			e(t)
		}, this)
	},
	removeNodes : function(t) {
		if (mini.isArray(t)) {
			t = t.clone();
			for (var e = 0, i = t.length; i > e; e++) {
				var n = t[e];
				this.removeNode(n)
			}
		}
	},
	_doUpdateNodeTitle : function(t) {
		var e = this._createNodeTitle(t),
			i = this._getNodeEl(t);
		i && jQuery(i.firstChild).replaceWith(e)
	},
	setNodeText : function(t, e) {
		t = this.getNode(t), t && (t[this.textField] = e, this._doUpdateNodeTitle(t))
	},
	setNodeIconCls : function(t, e) {
		t = this.getNode(t), t && (t[this.iconField] = e, this._doUpdateNodeTitle(t))
	},
	updateNode : function(t, e) {
		if (t = this.getNode(t), t && e) {
			var i = t[this.nodesField];
			mini.copyTo(t, e), t[this.nodesField] = i, this._doUpdateNodeTitle(t)
		}
	},
	removeNode : function(t) {
		if (t = this.getNode(t)) {
			this._selectedNode == t && (this._selectedNode = null);
			var e = [ t ];
			this.cascadeChild(t, function(t) {
				e.push(t)
			}, this);
			var i = this.getParentNode(t);
			i[this.nodesField].remove(t), this._updateParentAndLevel(t, i);
			var n = this._getNodeEl(t);
			if (n && (n.parentNode.removeChild(n), this.isLeaf(i))) {
				var s = this._getNodesEl(i);
				s.parentNode.removeChild(s)
			}
			this._updateNodeElLevel(i);
			for (var o = 0, l = e.length; l > o; o++) {
				var t = e[o];
				delete t._id
				,
				delete t._pid
				,
				delete this._idNodes[t._id]
				,
				delete this.idNodes[t[this.idField]]
			}
		}
	},
	_getDropedParentNode : function(t, e, i) {
		switch (i || (e = "add"), e) {
		case "before":
			if (!i) return null;
			var n = this.getParentNode(i);
			return n;case "after":
			return i ? n = this.getParentNode(i) : null;case "add":
			return i;default:
			return null
		}
	},
	addNodes : function(t, e, i) {
		if (mini.isArray(t))
			for (var n = 0, s = t.length; s > n; n++) {
				var o = t[n];
				this.addNode(o, i, e)
		}
	},
	addNode : function(t, e, i) {
		if (t = this.getNode(t)) {
			i || (e = "add");
			var n = i;
			switch (e) {
			case "before":
				if (!n) return;
				i = this.getParentNode(n);var s = i[this.nodesField];
				e = s.indexOf(n);
				break;case "after":
				if (!n) return;
				i = this.getParentNode(n);var s = i[this.nodesField];
				e = s.indexOf(n) + 1;
				break;case "add":
			}
			i = this.getNode(i), i || (i = this.root);
			var o = i[this.nodesField];
			o || (o = i[this.nodesField] = []), e = parseInt(e), isNaN(e) && (e = o.length);
			var n = o[e];
			n || (e = o.length), o.insert(e, t), this._updateParentAndLevel(t, i);
			var l = this._getNodesEl(i);
			if (l) {
				var r = this._createNode(t),
					e = o.indexOf(t) + 1,
					n = o[e];
				if (n) {
					var a = this._getNodeEl(n);
					jQuery(a).before(r)
				} else mini.append(l, r)
			} else {
				var r = this._createNode(i),
					h = this._getNodeEl(i);
				jQuery(h).replaceWith(r)
			}
			i = this.getParentNode(t), this._updateNodeElLevel(i)
		}
	},
	moveNodes : function(t, e, i) {
		if (t && 0 != t.length && e && i) {
			this.beginUpdate();
			for (var n = 0, s = t.length; s > n; n++) {
				var o = t[n];
				this.moveNode(o, e, i), 0 != n && (e = o, i = "after")
			}
			this.endUpdate()
		}
	},
	moveNode : function(t, e, i) {
		if (t = this.getNode(t), e = this.getNode(e), !t || !e || !i) return !1;
		if (this.isAncestor(t, e)) return !1;
		var n = -1,
			s = null;
		switch (i) {
		case "before":
			s = this.getParentNode(e), n = this.indexOfChildren(e);
			break;case "after":
			s = this.getParentNode(e), n = this.indexOfChildren(e) + 1;
			break;default:
			s = e;var o = this.getChildNodes(s);
			o || (o = s[this.nodesField] = []), n = o.length
		}
		var l = {},
			o = this.getChildNodes(s);
		o.insert(n, l);
		var r = this.getParentNode(t),
			a = this.getChildNodes(r);
		return a.remove(t), n = o.indexOf(l), o[n] = t, this._updateParentAndLevel(t, s), this.doUpdate(), !0
	},
	isEditingNode : function(t) {
		return this._editingNode == t
	},
	beginEdit : function(t) {
		if (t = this.getNode(t)) {
			var e = this._getNodeEl(t),
				i = this._createNodeTitle(t, !0),
				e = this._getNodeEl(t);
			e && jQuery(e.firstChild).replaceWith(i), this._editingNode = t;
			var n = this.uid + "$edit$" + t._id;
			this._editInput = document.getElementById(n), this._editInput.focus(), mini.selectRange(this._editInput, 1e3, 1e3), mini.on(this._editInput, "keydown", this.__OnEditInputKeyDown, this), mini.on(this._editInput, "blur", this.__OnEditInputBlur, this)
		}
	},
	cancelEdit : function() {
		this._editingNode && (this._doUpdateNodeTitle(this._editingNode), mini.un(this._editInput, "keydown", this.__OnEditInputKeyDown, this), mini.un(this._editInput, "blur", this.__OnEditInputBlur, this)), this._editingNode = null, this._editInput = null
	},
	__OnEditInputKeyDown : function(t) {
		if (13 == t.keyCode) {
			var e = this._editInput.value;
			this.setNodeText(this._editingNode, e), this.cancelEdit(), this.fire("endedit", {
				node : this._editingNode,
				text : e
			})
		} else 27 == t.keyCode && this.cancelEdit()
	},
	__OnEditInputBlur : function(t) {
		var e = this._editInput.value;
		this.setNodeText(this._editingNode, e), this.cancelEdit(), this.fire("endedit", {
			node : this._editingNode,
			text : e
		})
	},
	_getNodeByEvent : function(t) {
		if (mini.hasClass(t.target, this._nodesCls)) return null;
		var e = mini.findParent(t.target, this._nodeCls);
		if (e) {
			var i = e.id.split("$"),
				n = i[i.length - 1],
				s = this._idNodes[n];
			return s
		}
		return null
	},
	_createNodeId : function(t) {
		return this.uid + "$" + t._id
	},
	_createNodesId : function(t) {
		return this.uid + "$nodes$" + t._id
	},
	_createCheckNodeId : function(t) {
		return this.uid + "$check$" + t._id
	},
	addNodeCls : function(t, e) {
		var i = this._getNodeEl(t);
		i && mini.addClass(i, e)
	},
	removeNodeCls : function(t, e) {
		var i = this._getNodeEl(t);
		i && mini.removeClass(i, e)
	},
	getNodeBox : function(t) {
		var e = this._getNodeEl(t);
		return e ? mini.getBox(e.firstChild) : void 0
	},
	_getNodeEl : function(t) {
		if (!t) return null;
		var e = this._createNodeId(t);
		return document.getElementById(e)
	},
	_getNodeHoverEl : function(t) {
		if (!t) return null;
		var e = this._getNodeTitleEl(t);
		return e ? e = mini.byClass(this._inNodeCls, e) : null
	},
	_getNodeTitleEl : function(t) {
		var e = this._getNodeEl(t);
		return e ? e.firstChild : void 0
	},
	_getNodesEl : function(t) {
		if (!t) return null;
		if (0 == this.isVisibleNode(t)) return null;
		var e = this._createNodesId(t);
		return mini.byId(e, this.el)
	},
	_getCheckBoxEl : function(t) {
		if (!t) return null;
		if (0 == this.isVisibleNode(t)) return null;
		var e = this._createCheckNodeId(t);
		return mini.byId(e, this.el)
	},
	findNodes : function(t, e) {
		var i = [];
		return e = e || this, this.cascadeChild(this.root, function(n) {
				t && t.call(e, n) === !0 && i.push(n)
			}, this), i
	},
	getNode : function(t) {
		return "object" == typeof t ? t : this.idNodes[t] || null
	},
	hideNode : function(t) {
		if (t = this.getNode(t)) {
			t.visible = !1;
			var e = this._getNodeEl(t);
			e.style.display = "none"
		}
	},
	showNode : function(t) {
		if (t = this.getNode(t)) {
			t.visible = !1;
			var e = this._getNodeEl(t);
			e.style.display = ""
		}
	},
	enableNode : function(t) {
		if (t = this.getNode(t)) {
			t.enabled = !0;
			var e = this._getNodeEl(t);
			mini.removeClass(e, "mini-disabled");
			var i = this._getCheckBoxEl(t);
			i && (i.disabled = !1)
		}
	},
	disableNode : function(t) {
		if (t = this.getNode(t)) {
			t.enabled = !1;
			var e = this._getNodeEl(t);
			mini.addClass(e, "mini-disabled");
			var i = this._getCheckBoxEl(t);
			i && (i.disabled = !0)
		}
	},
	_allowExpandLayout : !0,
	expandNode : function(t, e) {
		function i() {
			var t = this.getAllChildNodes(n);
			t.push(n);
			for (var e = 0, i = t.length; i > e; e++) {
				var n = t[e];
				if (n && n._indeterminate) {
					var s = this._getCheckBoxEl(n);
					s && n._indeterminate && (s.indeterminate = n._indeterminate)
				}
			}
		}
		if (t = this.getNode(t)) {
			var n = this.isExpandedNode(t);
			if (!n && !this.isLeaf(t)) {
				t.expanded = !0;
				var s = this._getNodeEl(t);
				if (this.removeOnCollapse && s) {
					var o = this._createNode(t);
					jQuery(s).before(o), jQuery(s).remove()
				}
				var l = this._getNodesEl(t);
				l && (l.style.display = "");
				var l = this._getNodeEl(t);
				if (l) {
					var r = l.firstChild;
					mini.removeClass(r, this._collapseNodeCls), mini.addClass(r, this._expandNodeCls)
				}
				this.fire("expand", {
					node : t
				}), e = e && !mini.isIE6;
				var a = this._getViewChildNodes(t);
				if (e && a && a.length > 0) {
					this._inAniming = !0;
					var l = this._getNodesEl(t);
					if (!l) return;
					var h = mini.getHeight(l);
					l.style.height = "1px", this._doPositoin && (l.style.position = "relative");
					var d = {
							height : h + "px"
						},
						u = this,
						c = jQuery(l);
					c.animate(d, 180, function() {
						u._inAniming = !1, u._doLayoutHeader(), clearInterval(u._animateTimer), l.style.height = "auto", u._doPositoin && (l.style.position = "static"), mini.repaint(s)
					}), clearInterval(this._animateTimer), this._animateTimer = setInterval(function() {
						u._doLayoutHeader()
					}, 60)
				}
				this._doLayoutHeader();
				var m = this;
				i.call(m)
			}
		}
	},
	collapseNode : function(t, e) {
		if (t = this.getNode(t)) {
			var i = this.isExpandedNode(t);
			if (i && !this.isLeaf(t)) {
				t.expanded = !1;
				var n = this._getNodeEl(t),
					s = this._getNodesEl(t);
				s && (s.style.display = "none");
				var s = this._getNodeEl(t);
				if (s) {
					var o = s.firstChild;
					mini.removeClass(o, this._expandNodeCls), mini.addClass(o, this._collapseNodeCls)
				}
				this.fire("collapse", {
					node : t
				}), e = e && !mini.isIE6;
				var l = this._getViewChildNodes(t);
				if (e && l && l.length > 0) {
					this._inAniming = !0;
					var s = this._getNodesEl(t);
					if (!s) return;
					s.style.display = "", s.style.height = "auto", this._doPositoin && (s.style.position = "relative");
					var r = (mini.getHeight(s), {
							height : "1px"
						}),
						a = this,
						h = jQuery(s);
					h.animate(r, 180, function() {
						s.style.display = "none", s.style.height = "auto", a._doPositoin && (s.style.position = "static"), a._inAniming = !1, a._doLayoutHeader(), clearInterval(a._animateTimer);
						var e = a._getNodesEl(t);
						a.removeOnCollapse && e && jQuery(e).remove(), mini.repaint(n)
					}), clearInterval(this._animateTimer), this._animateTimer = setInterval(function() {
						a._doLayoutHeader()
					}, 60)
				} else {
					var d = this._getNodesEl(t);
					this.removeOnCollapse && d && jQuery(d).remove()
				}
				this._doLayoutHeader(), this._allowExpandLayout && mini.repaint(this.el)
			}
		}
	},
	toggleNode : function(t, e) {
		this.isExpandedNode(t) ? this.collapseNode(t, e) : this.expandNode(t, e)
	},
	expandLevel : function(t) {
		this.cascadeChild(this.root, function(e) {
			this.getLevel(e) == t && null != e[this.nodesField] && this.expandNode(e)
		}, this)
	},
	collapseLevel : function(t) {
		this.cascadeChild(this.root, function(e) {
			this.getLevel(e) == t && null != e[this.nodesField] && this.collapseNode(e)
		}, this)
	},
	expandAll : function() {
		this.cascadeChild(this.root, function(t) {
			null != t[this.nodesField] && this.expandNode(t)
		}, this)
	},
	collapseAll : function() {
		this.cascadeChild(this.root, function(t) {
			null != t[this.nodesField] && this.collapseNode(t)
		}, this)
	},
	expandPath : function(t) {
		if (t = this.getNode(t))
			for (var e = this.getAncestors(t), i = 0, n = e.length; n > i; i++) this.expandNode(e[i])
	},
	collapsePath : function(t) {
		if (t = this.getNode(t))
			for (var e = this.getAncestors(t), i = 0, n = e.length; n > i; i++) this.collapseNode(e[i])
	},
	selectNode : function(t) {
		t = this.getNode(t);
		var e = this._getNodeEl(this._selectedNode);
		e && mini.removeClass(e.firstChild, this._selectedNodeCls), this._selectedNode = t;
		var e = this._getNodeEl(this._selectedNode);
		e && mini.addClass(e.firstChild, this._selectedNodeCls);
		var i = {
			node : t,
			isLeaf : this.isLeaf(t)
		};
		this.fire("nodeselect", i)
	},
	getSelectedNode : function() {
		return this._selectedNode
	},
	getSelectedNodes : function() {
		var t = [];
		return this._selectedNode && t.push(this._selectedNode), t
	},
	doUpdateCheckedState : function() {},
	autoCheckParent : !1,
	setAutoCheckParent : function(t) {
		this.autoCheckParent = t
	},
	getAutoCheckParent : function(t) {
		return this.autoCheckParent
	},
	hasCheckedChildNode : function(t) {
		for (var e = !1, i = this.getAllChildNodes(t), n = 0, s = i.length; s > n; n++) {
			var o = i[n];
			if (this.isCheckedNode(o)) {
				e = !0;break
			}
		}
		return e
	},
	_doCheckLoadNodes : function() {
		for (var t = this.getList(), e = [], i = 0, n = t.length; n > i; i++) {
			var s = t[i];
			s.checked && e.push(s)
		}
		for (var i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			this._doCheckNode(s, !0, this.checkRecursive)
		}
	},
	_doCheckNode : function(t, e, i) {
		var n = t,
			s = [];
		if (t.checked = e, t._indeterminate = !1, s.push(t), i) {
			this.cascadeChild(t, function(t) {
				t.checked = e, t._indeterminate = !1, s.push(t)
			}, this);
			var o = this.getAncestors(t);
			o.reverse();
			for (var l = 0, r = o.length; r > l; l++) {
				for (var a = o[l], h = this.getChildNodes(a), d = !0, u = !1, c = 0, m = h.length; m > c; c++) {
					var p = h[c];
					this.isCheckedNode(p) ? u = !0 : d = !1
				}
				d ? (a.checked = !0, a._indeterminate = !1) : (a.checked = !1, a._indeterminate = u), s.push(a)
			}
		}
		if (this.autoCheckParent)
			for (var o = this.getAncestors(n), l = 0, r = o.length; r > l; l++) {
				var a = o[l],
					u = this.hasCheckedChildNode(a);
				u && (a.checked = !0, a._indeterminate = !1, s.push(a))
		}
		if (this.checkOpposite) {
			s = [], s.push(t), t.checked && this.cascadeChild(t, function(t) {
				t.checked = !1, t._indeterminate = !1, s.push(t)
			}, this);
			var o = this.getAncestors(t);
			o.reverse();
			for (var l = 0, r = o.length; r > l; l++) {
				var a = o[l];
				t.checked && (a.checked = !1, a._indeterminate = !1), s.push(a)
			}
		}
		for (var l = 0, r = s.length; r > l; l++) {
			var t = s[l],
				f = this._getCheckBoxEl(t);
			f && (t.checked ? (f.indeterminate = !1, f.checked = !0) : (f.indeterminate = t._indeterminate, f.checked = !1))
		}
	},
	checkNode : function(t) {
		t = this.getNode(t), t && this._doCheckNode(t, !0, this.checkRecursive)
	},
	uncheckNode : function(t) {
		t = this.getNode(t), t && this._doCheckNode(t, !1, this.checkRecursive)
	},
	checkNodes : function(t) {
		mini.isArray(t) || (t = []);
		for (var e = 0, i = t.length; i > e; e++) {
			var n = t[e];
			this.checkNode(n)
		}
	},
	uncheckNodes : function(t) {
		mini.isArray(t) || (t = []);
		for (var e = 0, i = t.length; i > e; e++) {
			var n = t[e];
			this.uncheckNode(n)
		}
	},
	checkAllNodes : function() {
		this.cascadeChild(this.root, function(t) {
			this._doCheckNode(t, !0, !1)
		}, this)
	},
	uncheckAllNodes : function(t) {
		this.cascadeChild(this.root, function(t) {
			this._doCheckNode(t, !1, !1)
		}, this)
	},
	getCheckedNodes : function(t) {
		var e = [],
			i = {},
			n = this._viewNodes ? this._viewNodes : null;
		return this.cascadeChild(this.root, function(s) {
				if ((null === n && 1 == s.checked || 1 == s.checked && n.hasOwnProperty(s._id)) && (e.push(s), t))
					for (var o = this.getAncestors(s), l = 0, r = o.length; r > l; l++) {
						var a = o[l];
						i[a._id] || (i[a._id] = a, e.push(a))
				}
			}, this), e
	},
	setValue : function(t) {
		mini.isNull(t) && (t = ""), t = String(t);
		var e = this.getCheckedNodes();
		if (this.uncheckNodes(e), this.value = t, this.showCheckBox)
			for (var i = String(t).split(this.delimiter), n = 0, s = i.length; s > n; n++) this.checkNode(i[n]);
		else this.value = t, this.selectNode(t)
	},
	getNodesByValue : function(t) {
		mini.isNull(t) && (t = ""), t = String(t);
		for (var e = [], i = String(t).split(this.delimiter), n = 0, s = i.length; s > n; n++) {
			var o = this.getNode(i[n]);
			o && e.push(o)
		}
		return e
	},
	getValueAndText : function(t) {
		mini.isNull(t) && (t = []), mini.isArray(t) || (t = this.getNodesByValue(t));
		for (var e = [], i = [], n = 0, s = t.length; s > n; n++) {
			var o = t[n];
			o && (e.push(this.getItemValue(o)), i.push(this.getItemText(o)))
		}
		return [ e.join(this.delimiter), i.join(this.delimiter) ]
	},
	getValue : function(t) {
		for (var e = this.getCheckedNodes(t), i = [], n = 0, s = e.length; s > n; n++) {
			var o = this.getItemValue(e[n]);
			o && i.push(o)
		}
		return i.join(this.delimiter)
	},
	setResultAsTree : function(t) {
		this.resultAsTree = t
	},
	getResultAsTree : function() {
		return this.resultAsTree
	},
	setParentField : function(t) {
		this.parentField = t
	},
	getParentField : function() {
		return this.parentField
	},
	setIdField : function(t) {
		this.idField = t
	},
	getIdField : function() {
		return this.idField
	},
	setTextField : function(t) {
		this.textField = t
	},
	getTextField : function() {
		return this.textField
	},
	setShowTreeLines : function(t) {
		this.showTreeLines = t, 1 == t ? mini.addClass(this.el, "mini-tree-treeLine") : mini.removeClass(this.el, "mini-tree-treeLine")
	},
	getShowTreeLines : function() {
		return this.showTreeLines
	},
	setShowArrow : function(t) {
		this.showArrow = t, 1 == t ? mini.addClass(this.el, "mini-tree-showArrows") : mini.removeClass(this.el, "mini-tree-showArrows")
	},
	getShowArrow : function() {
		return this.showArrow
	},
	setIconField : function(t) {
		this.iconField = t
	},
	getIconField : function() {
		return this.iconField
	},
	setNodesField : function(t) {
		this.nodesField = t
	},
	getNodesField : function() {
		return this.nodesField
	},
	setTreeColumn : function(t) {
		this.treeColumn = t
	},
	getTreeColumn : function() {
		return this.treeColumn
	},
	setLeafIcon : function(t) {
		this.leafIcon = t
	},
	getLeafIcon : function() {
		return this.leafIcon
	},
	setFolderIcon : function(t) {
		this.folderIcon = t
	},
	getFolderIcon : function() {
		return this.folderIcon
	},
	setExpandOnDblClick : function(t) {
		this.expandOnDblClick = t
	},
	getExpandOnDblClick : function() {
		return this.expandOnDblClick
	},
	setExpandOnNodeClick : function(t) {
		this.expandOnNodeClick = t, t ? mini.addClass(this.el, "mini-tree-nodeclick") : mini.removeClass(this.el, "mini-tree-nodeclick")
	},
	getExpandOnNodeClick : function() {
		return this.expandOnNodeClick
	},
	setRemoveOnCollapse : function(t) {
		this.removeOnCollapse = t
	},
	getRemoveOnCollapse : function() {
		return this.removeOnCollapse
	},
	setLoadOnExpand : function(t) {
		this.loadOnExpand = t
	},
	getLoadOnExpand : function() {
		return this.loadOnExpand
	},
	setAutoEscape : function(t) {
		this.autoEscape = t
	},
	getAutoEscape : function() {
		return this.autoEscape
	},
	imgPath : "",
	setImgPath : function(t) {
		this.imgPath = t
	},
	getImgPath : function() {
		return this.imgPath
	},
	imgField : "img",
	setImgField : function(t) {
		this.imgField = t
	},
	getImgField : function() {
		return this.imgField
	},
	__OnDblClick : function(t) {
		if (this.enabled && !mini.findParent(t.target, this._checkBoxCls)) {
			var e = this._getNodeByEvent(t);
			if (e && e.enabled !== !1 && mini.findParent(t.target, this._inNodeCls)) {
				var i = this.isExpandedNode(e),
					n = {
						node : e,
						expanded : i,
						cancel : !1
					};
				if (this.fire("nodedblclick", {
						htmlEvent : t,
						node : e,
						isLeaf : this.isLeaf(e)
					}), this.expandOnDblClick && !this._inAniming) {
					if (this._viewNodes) {
						var s = this._getViewChildNodes(e);
						if (0 == s.length) return
					} else if (!this.getChildNodes(e)) return;
					if (i) {
						if (this.fire("beforecollapse", n), 1 == n.cancel) return;
						this.collapseNode(e, this.allowAnim)
					} else {
						if (this.fire("beforeexpand", n), 1 == n.cancel) return;
						this.expandNode(e, this.allowAnim)
					}
				}
			}
		}
	},
	__OnClick : function(t) {
		if (this.enabled) {
			var e = this._getNodeByEvent(t);
			if (e && e.enabled !== !1) {
				var i = mini.findParent(t.target, this._inNodeCls) && this.expandOnNodeClick;
				if (mini.findParent(t.target, this._checkBoxCls) && (i = !1), (mini.findParent(t.target, this._eciconCls) || i) && 0 == this.isLeaf(e)) {
					if (this._inAniming) return;
					var n = this.isExpandedNode(e),
						s = {
							node : e,
							expanded : n,
							cancel : !1
						};
					if (!this._inAniming) {
						if (this._viewNodes) {
							var o = this._getViewChildNodes(e);
							if (0 == o.length) return
						}
						if (n) {
							if (this.fire("beforecollapse", s), 1 == s.cancel) return;
							this.collapseNode(e, this.allowAnim)
						} else {
							if (this.fire("beforeexpand", s), 1 == s.cancel) return;
							this.expandNode(e, this.allowAnim)
						}
					}
				} else if (mini.findParent(t.target, this._checkBoxCls)) {
					var l = this.isCheckedNode(e),
						s = {
							isLeaf : this.isLeaf(e),
							node : e,
							checked : l,
							checkRecursive : this.checkRecursive,
							htmlEvent : t,
							cancel : !1
						};
					if (this.fire("beforenodecheck", s), 1 == s.cancel) return void t.preventDefault();
					l ? this.uncheckNode(e) : this.checkNode(e), s.checked = this.isCheckedNode(e), this.fire("nodecheck", s)
				} else this._OnNodeClick(e, t)
			}
		}
	},
	__OnMouseDown : function(t) {
		if (this.enabled) {
			this._editInput && !mini.findParent(t.target, "mini-tree-editinput") && this._editInput.blur();
			var e = this._getNodeByEvent(t);
			e && (mini.findParent(t.target, this._eciconCls) || mini.findParent(t.target, this._checkBoxCls) || this._OnNodeMouseDown(e, t))
		}
	},
	_OnNodeMouseDown : function(t, e) {
		var i = mini.findParent(e.target, this._inNodeCls);
		if (!i) return null;
		if (this.isEnabledNode(t)) {
			var n = {
				node : t,
				cancel : !1,
				isLeaf : this.isLeaf(t),
				htmlEvent : e
			};
			this.allowSelect && t.allowSelect !== !1 && this._selectedNode != t && (this.fire("beforenodeselect", n), 1 != n.cancel && this.selectNode(t)), this.fire("nodeMouseDown", n)
		}
	},
	_OnNodeClick : function(t, e) {
		var i = mini.findParent(e.target, this._inNodeCls);
		if (!i) return null;
		if ("a" == e.target.tagName.toLowerCase() && (e.target.hideFocus = !0), this.isEnabledNode(t)) {
			var n = {
				node : t,
				cancel : !1,
				isLeaf : this.isLeaf(t),
				htmlEvent : e
			};
			if (this._getColumnByEvent) {
				var s = this._getColumnByEvent(e);
				s && (n.column = s, n.field = s.field)
			}
			this.fire("nodeClick", n)
		}
	},
	__OnMouseOver : function(t) {
		if (!this._dragging) {
			(mini.hasClass(t.target, "mini-tree-parentNode") || mini.hasClass(t.target, "mini-tree-rootnodes")) && (this.currentMouseOverNode = null);
			var e = this._getNodeByEvent(t);
			e && this._OnNodeMouseOver(e, t)
		}
	},
	_OnNodeMouseOver : function(t, e) {
		if (this.isEnabledNode(t) && mini.findParent(e.target, this._inNodeCls)) {
			var e = {
				node : t,
				htmlEvent : e
			};
			this.currentMouseOverNode != t && this.fire("nodemouseover", e), this.currentMouseOverNode = t
		}
	},
	__OnMouseMove : function(t) {
		var e = this._getNodeByEvent(t);
		e && this._OnNodeMouseMove(e, t)
	},
	__OnMouseOut : function(t) {
		var e = this._getNodeByEvent(t);
		e && this._OnNodeMouseOut(e, t)
	},
	_OnNodeMouseOut : function(t, e) {
		if (this.isEnabledNode(t) && mini.findParent(e.target, this._inNodeCls)) {
			this.blurNode();
			var e = {
				node : t,
				htmlEvent : e
			};
			this.fire("nodemouseout", e)
		}
	},
	_OnNodeMouseMove : function(t, e) {
		if (this.isEnabledNode(t) && mini.findParent(e.target, this._inNodeCls)) {
			1 == this.enableHotTrack && this.focusNode(t);
			var e = {
				node : t,
				htmlEvent : e
			};
			this.fire("nodemousemove", e)
		}
	},
	focusNode : function(t, e) {
		function i() {
			var i = this._getNodeHoverEl(t);
			e && i && this.scrollIntoView(t), this._focusedNode != t && (this.blurNode(), this._focusedNode = t, mini.addClass(i, this._nodeHoverCls))
		}
		if (t = this.getNode(t)) {
			var n = this;
			i.call(n)
		}
	},
	blurNode : function() {
		if (this._focusedNode) {
			var t = this._getNodeHoverEl(this._focusedNode);
			t && mini.removeClass(t, this._nodeHoverCls), this._focusedNode = null
		}
	},
	scrollIntoView : function(t) {
		if (t = this.getNode(t)) {
			this.expandNode(t);
			var e = this._getNodeEl(t);
			mini.scrollIntoView(e, this.el, !1)
		}
	},
	__OnHtmlContextMenu : function(t) {
		return mini.isAncestor(this._headerEl, t.target) ? !0 : mini.Tree.superclass.__OnHtmlContextMenu.call(this, t)
	},
	onNodeClick : function(t, e) {
		this.on("nodeClick", t, e)
	},
	onBeforeNodeSelect : function(t, e) {
		this.on("beforenodeselect", t, e)
	},
	onNodeSelect : function(t, e) {
		this.on("nodeselect", t, e)
	},
	onBeforeNodeCheck : function(t, e) {
		this.on("beforenodecheck", t, e)
	},
	onCheckNode : function(t, e) {
		this.on("nodecheck", t, e)
	},
	onNodeMouseDown : function(t, e) {
		this.on("nodemousedown", t, e)
	},
	onBeforeExpand : function(t, e) {
		this.on("beforeexpand", t, e)
	},
	onExpand : function(t, e) {
		this.on("expand", t, e)
	},
	onBeforeCollapse : function(t, e) {
		this.on("beforecollapse", t, e)
	},
	onCollapse : function(t, e) {
		this.on("collapse", t, e)
	},
	onBeforeLoad : function(t, e) {
		this.on("beforeload", t, e)
	},
	onLoad : function(t, e) {
		this.on("load", t, e)
	},
	onLoadError : function(t, e) {
		this.on("loaderror", t, e)
	},
	onDataLoad : function(t, e) {
		this.on("dataload", t, e)
	},
	_getDragData : function() {
		return this.getSelectedNodes().clone()
	},
	_getDragText : function(t) {
		return 1 == this.autoEscape ? mini.htmlEncode(this.getItemText(t[0])) : this.getItemText(t[0])
	},
	allowDrag : !1,
	allowDrop : !1,
	dragGroupName : "",
	dropGroupName : "",
	allowLeafDropIn : !1,
	setAllowLeafDropIn : function(t) {
		this.allowLeafDropIn = t
	},
	getAllowLeafDropIn : function() {
		return this.allowLeafDropIn
	},
	setAllowDrag : function(t) {
		this.allowDrag = t
	},
	getAllowDrag : function() {
		return this.allowDrag
	},
	setAllowDrop : function(t) {
		this.allowDrop = t
	},
	getAllowDrop : function() {
		return this.allowDrop
	},
	setDragGroupName : function(t) {
		this.dragGroupName = t
	},
	getDragGroupName : function() {
		return this.dragGroupName
	},
	setDropGroupName : function(t) {
		this.dropGroupName = t
	},
	getDropGroupName : function() {
		return this.dropGroupName
	},
	isAllowDrag : function(t) {
		return this.allowDrag ? t.allowDrag === !1 ? !1 : !0 : !1
	},
	_OnDragStart : function(t) {
		var e = {
			node : t,
			nodes : this._getDragData(),
			dragText : this._getDragText(this._getDragData()),
			cancel : !1
		};
		return this.fire("DragStart", e), e
	},
	_OnDragDrop : function(t, e, i) {
		t = t.clone();
		var n = {
				dragNodes : t,
				targetNode : e,
				action : i,
				cancel : !1
			},
			s = this._getDropedParentNode(t, i, e);
		return n.dragNode = n.dragNodes[0], n.dropNode = n.targetNode, n.dragAction = n.action, n.dropParentNode = s, this.fire("beforedrop", n), this.fire("DragDrop", n), n
	},
	_OnGiveFeedback : function(t, e, i) {
		var n = {};
		return n.effect = t, n.nodes = e, n.targetNode = i, n.node = n.nodes[0], n.dragNodes = e, n.dragNode = n.dragNodes[0], n.dropNode = n.targetNode, n.dragAction = n.action, this.fire("givefeedback", n), n
	},
	_allowDrag : function(t) {
		return !0
	},
	getAttrs : function(t) {
		function e(t) {
			for (var i = [], n = 0, a = t.length; a > n; n++) {
				var h = t[n],
					d = mini.getChildNodes(h),
					u = d[0],
					c = d[1];
				u && c || (u = h);var m = jQuery(u),
					p = {};
				p[s] = u.getAttribute("value"), p[l] = m.attr("iconCls"), p[o] = u.innerHTML, i.add(p);var f = m.attr("expanded");
				f && (p.expanded = "false" == f ? !1 : !0);var g = m.attr("allowSelect");
				if (g && (p.allowSelect = "false" == g ? !1 : !0), c) {
					var _ = mini.getChildNodes(c),
						v = e(_);
					v.length > 0 && (p[r] = v)
				}
			}
			return i
		}
		var i = mini.Tree.superclass.getAttrs.call(this, t);
		if (mini._ParseString(t, i, [ "data", "value", "url", "idField", "textField", "iconField", "nodesField", "parentField", "valueField", "leafIcon", "folderIcon", "ondrawnode", "onbeforenodeselect", "onnodeselect", "onnodemousedown", "onnodeclick", "onnodedblclick", "onbeforeload", "onpreload", "onload", "onloaderror", "ondataload", "onnodemouseover", "onnodemouseout", "onbeforenodecheck", "onnodecheck", "onbeforeexpand", "onexpand", "onbeforecollapse", "oncollapse", "dragGroupName", "dropGroupName", "onendedit", "imgPath", "imgField", "expandOnLoad", "ajaxOption", "ondragstart", "onbeforedrop", "ondrop", "ongivefeedback" ]), mini._ParseBool(t, i, [ "allowSelect", "showCheckBox", "showExpandButtons", "showTreeIcon", "showTreeLines", "checkRecursive", "enableHotTrack", "showFolderCheckBox", "resultAsTree", "allowLeafDropIn", "allowDrag", "allowDrop", "showArrow", "expandOnDblClick", "removeOnCollapse", "autoCheckParent", "loadOnExpand", "expandOnNodeClick", "autoEscape", "autoLoad", "checkOpposite" ]), i.ajaxOption && (i.ajaxOption = mini.decode(i.ajaxOption)), i.expandOnLoad) {
			var n = parseInt(i.expandOnLoad);
			mini.isNumber(n) ? i.expandOnLoad = n : i.expandOnLoad = "true" == i.expandOnLoad ? !0 : !1
		}
		var s = i.idField || this.idField,
			o = i.textField || this.textField,
			l = i.iconField || this.iconField,
			r = i.nodesField || this.nodesField,
			a = e(mini.getChildNodes(t));
		return a.length > 0 && (i.data = a), !i.idField && i.valueField && (i.idField = i.valueField), i
	}
}), mini.regClass(mini.Tree, "tree"), mini._TreeDragDrop = function(t) {
	this.owner = t, this.owner.on("NodeMouseDown", this.__OnTreeNodeMouseDown, this)
}, mini._TreeDragDrop.prototype = {
	destroy : function(t) {
		this.drag && (mini.clearEvent(this.drag), this.drag.destroy(t), this.drag = null), this.owner = null, mini.clearEvent(this)
	},
	__OnTreeNodeMouseDown : function(t) {
		var e = t.node;
		if (t.htmlEvent.button != mini.MouseButton.Right) {
			var i = this.owner;
			if (!i._dragging && !i.isReadOnly() && 0 != i.isAllowDrag(t.node) && !i.isEditingNode(e) && i._allowDrag(t.htmlEvent)) {
				this.dragData = i._getDragData(), -1 == this.dragData.indexOf(e) && this.dragData.push(e);
				var n = this._getDrag();
				n.start(t.htmlEvent, e)
			}
		}
	},
	_OnDragStart : function(t, e) {
		var i = this.owner;
		i._dragging = !0;
		var n = i._OnDragStart(e);
		n.cancel || (this.dragText = n.dragText, this.feedbackEl = mini.append(document.body, '<div class="mini-feedback"></div>'), this.feedbackEl.innerHTML = this.dragText, this.lastFeedbackClass = "", this.enableHotTrack = i.enableHotTrack, i.setEnableHotTrack(!1))
	},
	_getDropTree : function(t) {
		var e = mini.findParent(t.target, "mini-tree", 500);
		return e ? mini.get(e) : void 0
	},
	_OnDragMove : function(t) {
		var e = this.owner,
			i = this._getDropTree(t.event),
			n = t.now[0],
			s = t.now[1];
		if (mini.setXY(this.feedbackEl, n + 15, s + 18), this.dragAction = "no", i)
			if (e._allowDrag(t.event)) {
				var o = i._getNodeByEvent(t.event);
				if (this.dropNode = o, o && 1 == i.allowDrop) {
					if (!i.isLeaf(o)) {
						var l = o[i.nodesField];
						l && l.length > 0 || e.loadOnExpand && o.asyncLoad !== !1 && i.loadNode(o)
					}
					this.dragAction = this.getFeedback(o, s, 3, i)
				} else
					this.dragAction = "no";
				e && i && e != i && !o && 0 == i.getChildNodes(i.root).length && (o = i.getRootNode(), this.dragAction = "add", this.dropNode = o)
			} else
				this.dragAction = "no";
		this.lastFeedbackClass = "mini-feedback-" + this.dragAction, this.feedbackEl.className = "mini-feedback " + this.lastFeedbackClass, "no" == this.dragAction && (o = null), this.setRowFeedback(o, this.dragAction, i)
	},
	_OnDragStop : function(t) {
		var e = this.owner,
			i = this._getDropTree(t.event);
		e._dragging = !1, mini.removeNode(this.feedbackEl), this.feedbackEl = null, this.setRowFeedback(null);
		for (var n = [], s = 0, o = this.dragData.length; o > s; s++) {
			for (var l = this.dragData[s], r = !1, a = 0, h = this.dragData.length; h > a; a++) {
				var d = this.dragData[a];
				if (d != l && (r = e.isAncestor(d, l))) break
			}
			r || n.push(l)
		}
		if (this.dragData = n, this.dropNode && i && "no" != this.dragAction) {
			var u = e._OnDragDrop(this.dragData, this.dropNode, this.dragAction);
			if (u.cancel) return;
			var n = u.dragNodes,
				c = u.targetNode,
				m = u.action;
			if (e == i ? e.moveNodes(n, c, m) : (e.removeNodes(n), i.addNodes(n, c, m)), !this.dragData[0]) return;
			var u = {
				dragNode : this.dragData[0],
				dropNode : this.dropNode,
				dragAction : this.dragAction,
				dropParentNode : e.getParentNode(l)
			};
			e.fire("drop", u)
		}
		e.setEnableHotTrack(this.enableHotTrack), this.dropNode = null, this.dragData = null
	},
	setRowFeedback : function(t, e, i) {
		if (this.lastAddDomNode && mini.removeClass(this.lastAddDomNode, "mini-tree-feedback-add"), (null == t || "add" == this.dragAction) && (mini.removeNode(this.feedbackLine), this.feedbackLine = null), this.lastRowFeedback = t, null != t)
			if ("before" == e || "after" == e) {
				this.feedbackLine || (this.feedbackLine = mini.append(document.body, "<div class='mini-feedback-line'></div>")), this.feedbackLine.style.display = "block";
				var n = i.getNodeBox(t),
					s = n.x,
					o = n.y - 1;
				"after" == e && (o += n.height), mini.setXY(this.feedbackLine, s, o);
				var l = i.getBox(!0);
				mini.setWidth(this.feedbackLine, l.width)
			} else {
				var r = i._getNodeTitleEl(t);
				mini.addClass(r, "mini-tree-feedback-add"), this.lastAddDomNode = r
		}
	},
	getFeedback : function(t, e, i, n) {
		var s = n.getNodeBox(t),
			o = s.height,
			l = e - s.y,
			r = null;
		if (-1 != this.dragData.indexOf(t)) return "no";
		var a = !1;
		if (3 == i) {
			a = n.isLeaf(t);
			for (var h = 0, d = this.dragData.length; d > h; h++) {
				var u = this.dragData[h],
					c = n.isAncestor(u, t);
				if (c) {
					r = "no";break
				}
			}
		}
		null == r && (r = a && 0 == n.allowLeafDropIn ? l > o / 2 ? "after" : "before" : l > o / 3 * 2 ? "after" : l >= o / 3 && o / 3 * 2 >= l ? "add" : "before");
		var m = n._OnGiveFeedback(r, this.dragData, t);
		return m.effect
	},
	_getDrag : function() {
		return this.drag || (this.drag = new mini.Drag({
				capture : !1,
				onStart : mini.createDelegate(this._OnDragStart, this),
				onMove : mini.createDelegate(this._OnDragMove, this),
				onStop : mini.createDelegate(this._OnDragStop, this)
			})), this.drag
	}
}, mini.TreeGrid = function() {
	this.columns = [], this._bottomColumns = [], this._idColumns = {}, this._nameColumns = {}, this._cellErrors = [], this._cellMapErrors = {}, mini.TreeGrid.superclass.constructor.call(this), this._resizeEl.style.display = this.allowResize ? "" : "none"
}, mini.extend(mini.TreeGrid, mini.Tree, {
	_rowIdField : "_id",
	width : 300,
	height : 180,
	minWidth : 300,
	minHeight : 150,
	maxWidth : 5e3,
	maxHeight : 3e3,
	allowResize : !1,
	treeColumn : "",
	columns : [],
	columnWidth : 80,
	allowResizeColumn : !0,
	allowMoveColumn : !0,
	_doPositoin : !0,
	showPager : !1,
	pageIndex : 0,
	pageSize : -1,
	totalCount : 0,
	totalPage : 0,
	_headerCellCls : "mini-treegrid-headerCell",
	_cellCls : "mini-treegrid-cell",
	_borderCls : "mini-treegrid-border",
	_headerCls : "mini-treegrid-header",
	_bodyCls : "mini-treegrid-body",
	_nodeCls : "mini-treegrid-node",
	_nodesCls : "mini-treegrid-nodes",
	_selectedNodeCls : "mini-treegrid-selectedNode",
	_nodeHoverCls : "mini-treegrid-hoverNode",
	_expandNodeCls : "mini-treegrid-expand",
	_collapseNodeCls : "mini-treegrid-collapse",
	_eciconCls : "mini-treegrid-ec-icon",
	_inNodeCls : "mini-treegrid-nodeTitle",
	_getNodeHoverEl : function(t) {
		if (!t) return null;
		var e = this._getNodeTitleEl(t),
			e = this._getNodeTitleEl(t);
		return e
	},
	uiCls : "mini-treegrid",
	_create : function() {
		mini.TreeGrid.superclass._create.call(this), this._footerEl = mini.append(this._borderEl, '<div class="mini-grid-footer"></div>'), this._resizeEl = mini.append(this._borderEl, '<div class="mini-resizer-trigger" style=""></div>'), mini.on(this._bodyEl, "scroll", this.__OnScroll, this), this._Resizer = new mini._Resizer(this), this._ColumnMove = new mini._ColumnMove(this), this._Splitter = new mini._ColumnSplitter(this), this._CellTip = new mini._CellToolTip(this), this._createPager()
	},
	_createPager : function() {
		this.pager = new mini.Pager, this.pager.render(this._footerEl), this.bindPager(this.pager)
	},
	bindPager : function(t) {
		t.on("beforepagechanged", this.__OnPageChanged, this), this.on("load", function(e) {
			t.update(this.pageIndex, this.pageSize, e.total), this.totalPage = t.totalPage
		}, this)
	},
	__OnPageChanged : function(t) {
		return 0 != this.data.length || t.isreload ? void this.gotoPage(t.pageIndex, t.pageSize) : void this.setPageSize(t.pageSize)
	},
	gotoPage : function(t, e) {
		var i = {};
		mini.isNumber(t) && (i.pageIndex = t), mini.isNumber(e) && (i.pageSize = e), this.pageIndex = t, this.pageSize = e, this.load(this.url, i)
	},
	load : function(t, e) {
		e = e || {}, mini.isNull(e.pageIndex) && (e.pageIndex = 0), mini.isNull(e.pageSize) && (e.pageSize = this.pageSize), this.url = t, this._doLoad(e, this.root)
	},
	_doLoad : function(params, node, success, fail) {
		try {
			var url = eval(this.url);
			void 0 != url && (this.url = url)
		} catch (e) {}
		var isRoot = node == this.root,
			e = {
				url : this.url,
				async : this._ajaxOption.async,
				type : this._ajaxOption.type,
				params : params,
				data : params,
				cache : !1,
				cancel : !1,
				node : node,
				isRoot : isRoot
			};
		if (this.fire("beforeload", e), e.data != e.params && e.params != params && (e.data = e.params), 1 != e.cancel) {
			node != this.root;
			var sf = this,
				container = node;
			isRoot ? (mini.addClass(this._bodyEl, "mini-tree-loading"), this._bodyEl.innerHTML = "<div class='mini-treegrid-ec-icon'>&nbsp;</div>") : sf.addNodeCls(container, "mini-tree-loading"), mini.copyTo(e, {
				success : function(t, e, i) {
					isRoot ? (mini.removeClass(sf._bodyEl, "mini-tree-loading"), sf._bodyEl.innerHTML = "") : sf.removeNodeCls(container, "mini-tree-loading");
					var n = null;
					try {
						n = mini.decode(t)
					} catch (s) {
						n = [], 1 == mini_debugger && alert("tree json is error.")
					}
					sf.dataField && (n = mini._getMap(sf.dataField, n)), n || (n = []);
					var s;
					s = n instanceof Array ? {
						result : n,
						data : n,
						cancel : !1,
						node : node
					} : {
						result : n,
						data : n.data,
						total : n.total,
						cancel : !1,
						node : node
					}, 0 == sf.resultAsTree && (s.data = mini.arrayToTree(s.data, sf.nodesField, sf.idField, sf.parentField)), sf.fire("preload", s), 1 != s.cancel && (isRoot && sf.setData(s.data), success && success(s.data), sf._doCheckLoadNodes(), sf.fire("load", s))
				},
				error : function(t, e, i) {
					isRoot ? (mini.removeClass(sf._bodyEl, "mini-tree-loading"), sf._bodyEl.innerHTML = "") : sf.removeNodeCls(container, "mini-tree-loading");
					var n = {
						xmlHttp : t,
						errorCode : e
					};
					fail && fail(n), 1 == mini_debugger && alert("network error"), sf.fire("loaderror", n)
				}
			}), this._ajaxer = mini.ajax(e)
		}
	},
	_createColumnId : function(t) {
		return this.uid + "$column$" + t.id
	},
	_getHeaderScrollEl : function() {
		return this._headerEl.firstChild
	},
	_CreateTopTr : function(t) {
		var e = "",
			i = this.getBottomColumns();
		e += isIE ? isIE6 || isIE7 || isIE8 && !jQuery.boxModel || isIE9 && !jQuery.boxModel ? '<tr style="display:none;">' : "<tr >" : "<tr>";
		for (var n = 0, s = i.length; s > n; n++) {
			var o = i[n],
				l = (o.width, this._createColumnId(o) + "$" + t);
			e += '<td id="' + l + '" style="padding:0;border:0;margin:0;height:0;', o.width && (e += "width:" + o.width), 0 == o.visible && (e += ";display:none;"), e += '" ></td>'
		}
		return e += "</tr>"
	},
	_doUpdateHeader : function() {
		var t = this.getColumnRows(),
			e = this.getBottomColumns(),
			i = (e.length, []);
		i[i.length] = '<div class="mini-treegrid-headerInner"><table style="display:table" class="mini-treegrid-table" cellspacing="0" cellpadding="0">', i[i.length] = this._CreateTopTr("header");
		for (var n = 0, s = t.length; s > n; n++) {
			var o = t[n];
			i[i.length] = "<tr >";
			for (var l = 0, r = o.length; r > l; l++) {
				var a = o[l],
					h = a.header;
				"function" == typeof h && (h = h.call(this, a)), (mini.isNull(h) || "" === h) && (h = "&nbsp;");var d = this._createColumnId(a);
				i[i.length] = '<td id="', i[i.length] = d, i[i.length] = '" class="mini-treegrid-headerCell  ' + (a.headerCls || "") + " ", l == r - 1 && (i[i.length] = " mini-treegrid-last-column "), i[i.length] = '" style="', e.indexOf(a), 0 == a.visible && (i[i.length] = ";display:none;"), a.columns && a.columns.length > 0 && 0 == a.colspan && (i[i.length] = ";display:none;"), a.headerStyle && (i[i.length] = a.headerStyle + ";"), a.headerAlign && (i[i.length] = "text-align:" + a.headerAlign + ";"), i[i.length] = '" ', a.rowspan && (i[i.length] = 'rowspan="' + a.rowspan + '" '), a.colspan && (i[i.length] = 'colspan="' + a.colspan + '" '), i[i.length] = ">", i[i.length] = h, i[i.length] = "</td>"
			}
			i[i.length] = "</tr>"
		}
		i[i.length] = '</table><div class="mini-treegrid-topRightCell"></div></div>';
		var u = i.join("");
		this._headerEl.innerHTML = u, this._headerInnerEl = this._headerEl.firstChild, this._topRightCellEl = this._headerInnerEl.lastChild
	},
	_createNodeTitle : function(t, e, i) {
		var n = !i;
		i || (i = []);
		var s = t[this.textField];
		(null === s || void 0 === s) && (s = "");
		var o = this.isLeaf(t),
			l = (this.getLevel(t), "");
		o || (this._viewNodes ? this._getViewChildNodes(t).length > 0 && (l = this.isExpandedNode(t) ? this._expandNodeCls : this._collapseNodeCls) : l = this.isExpandedNode(t) ? this._expandNodeCls : this._collapseNodeCls), this._selectedNode == t && (l += " " + this._selectedNodeCls);
		var r = this.getBottomColumns();
		i[i.length] = '<table class="mini-treegrid-nodeTitle ', i[i.length] = l, i[i.length] = '" cellspacing="0" cellpadding="0">', i[i.length] = this._CreateTopTr(), i[i.length] = "<tr>";
		for (var a = 0, h = r.length; h > a; a++) {
			var d = r[a],
				u = this._createCellId(t, d),
				c = this._OnDrawCell(t, d),
				m = d.width;
			"number" == typeof m && (m += "px"), i[i.length] = '<td id="', i[i.length] = u, i[i.length] = '" class="mini-treegrid-cell ', c.cellCls && (i[i.length] = c.cellCls), a == h - 1 && (i[i.length] = " mini-treegrid-last-column "), i[i.length] = '" style="', c.cellStyle && (i[i.length] = c.cellStyle, i[i.length] = ";"), d.align && (i[i.length] = "text-align:", i[i.length] = d.align, i[i.length] = ";"), 0 == d.visible && (i[i.length] = "display:none;"), i[i.length] = '">', i[i.length] = c.cellHtml, i[i.length] = "</td>", c.rowCls && (rowCls = c.rowCls), c.rowStyle && (rowStyle = c.rowStyle)
		}
		return i[i.length] = "</table>", n ? i.join("") : void 0
	},
	doUpdate : function() {
		if (this._allowUpdate) {
			this._doUpdateHeader();
			var t = (new Date, this._getViewChildNodes(this.root)),
				e = [];
			this._createNodes(t, this.root, e);
			var i = e.join("");
			this._bodyEl.innerHTML = i, this._deferLayout()
		}
	},
	getScrollLeft : function() {
		return this._bodyEl.scrollLeft
	},
	setShowPager : function(t) {
		this.showPager = t, t && -1 == this.pageSize && this.setPageSize(10)
	},
	getFooterHeight : function() {
		return this.showPager ? mini.getHeight(this._footerEl) : 0
	},
	doLayout : function() {
		if (this.canLayout()) {
			var t = this.isAutoHeight(),
				e = (this.isAutoWidth(), this.getWidth(!0)),
				i = this.getHeight(!0),
				n = this.getHeaderHeight();
			if (this._bodyEl.style.width = e + "px", t)
				this._bodyEl.style.height = "auto";else {
				var s = i - n - this.getFooterHeight();
				this._bodyEl.style.height = s + "px"
			}
			this._doLayoutHeader(), this._doLayoutTopRightCell(), this.fire("layout")
		}
	},
	_doLayoutTopRightCell : function() {
		var t = this._headerInnerEl.firstChild,
			e = (t.offsetWidth + 1, t.offsetHeight - 1);
		0 > e && (e = 0), this._topRightCellEl.style.height = e + "px"
	},
	_doLayoutHeader : function() {
		var t = this._bodyEl.scrollHeight,
			e = this._bodyEl.clientHeight,
			i = (this.getWidth(!0), this._headerEl.firstChild.firstChild),
			n = this._bodyEl.firstChild;
		if (e >= t) n && (n.style.width = "100%"), i && (i.style.width = "100%");else {
			if (n) {
				var s = parseInt(n.parentNode.offsetWidth - 17) + "px";
				n.style.width = s
			}
			i && (i.style.width = s)
		}
		try {
			var s = this._headerEl.firstChild.firstChild.firstChild.offsetWidth;
			this._bodyEl.firstChild.style.width = s + "px"
		} catch (o) {}
		this.__OnScroll()
	},
	getHeaderHeight : function() {
		return mini.getHeight(this._headerEl)
	},
	_getDragText : function(t) {
		for (var e, i = 0; i < this.columns.length; i++)
			if (this.columns[i].name && this.columns[i].name == this.treeColumn) {
				e = this.columns[i].field;break
		}
		if (e) {
			var n = mini._getMap(e, t[0]);
			return 1 == this.autoEscape ? mini.htmlEncode(n) : n
		}
		return ""
	},
	_OnDrawCell : function(t, e) {
		var i = this.showCheckBox;
		i && this.hasChildren(t) && (i = this.showFolderCheckBox);
		var n = mini._getMap(e.field, t),
			s = {
				isLeaf : this.isLeaf(t),
				rowIndex : this.indexOf(t),
				showCheckBox : i,
				iconCls : this.getNodeIcon(t),
				showTreeIcon : this.showTreeIcon,
				sender : this,
				record : t,
				row : t,
				node : t,
				column : e,
				field : e ? e.field : null,
				value : n,
				cellHtml : n,
				rowCls : null,
				cellCls : e ? e.cellCls || "" : "",
				rowStyle : null,
				cellStyle : e ? e.cellStyle || "" : ""
			};
		e.dateFormat && (mini.isDate(s.value) ? s.cellHtml = mini.formatDate(n, e.dateFormat) : s.cellHtml = n);
		var o = e.renderer;
		return o && (fn = "function" == typeof o ? o : window[o], fn && (s.cellHtml = fn.call(e, s))), this.fire("drawcell", s), (null === s.cellHtml || void 0 === s.cellHtml || "" === s.cellHtml) && (s.cellHtml = "&nbsp;"), this.treeColumn && this.treeColumn === e.name ? (this._doTreeColumn(s), s) : s
	},
	_doTreeColumn : function(t) {
		var e = t.node;
		mini.isNull(t.showTreeIcon) && (t.showTreeIcon = this.showTreeIcon);
		var i = t.cellHtml;
		this.autoEscape && (i = mini.htmlEncode(i));
		var n = this.isLeaf(e),
			s = this.getLevel(e),
			o = 18 * s,
			l = "";
		t.cellCls ? t.cellCls += " mini-treegrid-treecolumn " : t.cellCls = " mini-treegrid-treecolumn ";
		for (var r = '<div class="mini-treegrid-treecolumn-inner ' + l + '">', a = this.getParentNode(e), h = 0, d = h; s >= d; d++)
			if (d != s && !(n && 0 == this.showExpandButtons && d >= s - 1)) {
				var u = "";
				this._isInViewLastNode(e, d) && (u = "background:none;"), r += '<span class="mini-treegrid-indent " style="' + u + "left:" + 18 * d + 'px;"></span>'
		}
		var c = "";
		if (this._isViewFirstNode(e) && this._isViewLastNode(e) ? (c = this._eciconCls + "-last", a == this.root && (c = this._eciconCls + "-firstLast")) : this._isViewFirstNode(e) && a && a != this.root ? c = "" : this._isViewFirstNode(e) ? c = this._eciconCls + "-first" : this._isViewLastNode(e) && (c = this._eciconCls + "-last"), r += n ? '<span class="' + this._eciconCls + " " + c + '" style="left:' + o + 'px;" ></span>' : '<a href="#" onclick="return false;"  hidefocus class="' + this._eciconCls + " " + c + '" style="left:' + o + 'px;"></a>', o += 18, t.showTreeIcon) {
			var m = this.getNodeIcon(e);
			r += '<div class="' + m + ' mini-treegrid-nodeicon" style="left:' + o + 'px;"></div>', o += 18
		}
		if (i = '<span class="mini-tree-nodetext">' + i + "</span>", t.showCheckBox) {
			var p = this._createCheckNodeId(e),
				f = this.isCheckedNode(e);
			i = '<input type="checkbox" id="' + p + '" class="' + this._checkBoxCls + '" hidefocus ' + (f ? "checked" : "") + "/>" + i
		}
		r += '<div class="mini-treegrid-nodeshow" style="margin-left:' + (o + 2) + 'px;">' + i + "</div>", r += "</div>", i = r, t.cellHtml = i
	},
	setTreeColumn : function(t) {
		this.treeColumn != t && (this.treeColumn = t, this.doUpdate())
	},
	getTreeColumn : function(t) {
		return this.treeColumn
	},
	setAllowResizeColumn : function(t) {
		this.allowResizeColumn = t
	},
	getAllowResizeColumn : function(t) {
		return this.allowResizeColumn
	},
	setAllowMoveColumn : function(t) {
		this.allowMoveColumn = t
	},
	getAllowMoveColumn : function(t) {
		return this.allowMoveColumn
	},
	setAllowResize : function(t) {
		this.allowResize = t, this._resizeEl.style.display = this.allowResize ? "" : "none"
	},
	getAllowResize : function() {
		return this.allowResize
	},
	_createCellId : function(t, e) {
		return this.uid + "$" + t._id + "$" + e._id
	},
	setColumnWidth : function(t, e) {
		t = this.getColumn(t), t && (mini.isNumber(e) && (e += "px"), t.width = e, this.doUpdate())
	},
	setPageSize : function(t) {
		t = parseInt(t), isNaN(t) || (this.pageSize = t)
	},
	getColumnWidth : function(t) {
		var e = this.getColumnBox(t);
		return e ? e.width : 0
	},
	__OnScroll : function(t) {
		var e = this._bodyEl.scrollLeft;
		this._headerEl.firstChild.scrollLeft = e
	},
	_allowDrag : function(t) {
		var e = mini.findParent(t.target, "mini-treegrid-treecolumn");
		return e ? !0 : !1
	},
	getAttrs : function(t) {
		var e = mini.TreeGrid.superclass.getAttrs.call(this, t);
		mini._ParseString(t, e, [ "treeColumn", "ondrawcell" ]), mini._ParseBool(t, e, [ "allowResizeColumn", "allowMoveColumn", "allowResize", "showPager" ]), mini._ParseInt(t, e, [ "pageSize", "ajaxTimeout" ]);
		for (var i = mini.getChildNodes(t), n = 0, s = i.length; s > n; n++) {
			var o = i[n],
				l = jQuery(o).attr("property");
			l && (l = l.toLowerCase(), "columns" == l && (e.columns = mini._ParseColumns(o)))
		}
		return delete e.data
			, e
	}
}), mini.copyTo(mini.TreeGrid.prototype, mini_Column_Prototype), mini.copyTo(mini.TreeGrid.prototype, mini_CellValidator_Prototype), mini.regClass(mini.TreeGrid, "treegrid"), mini.TreeSelect = function() {
	this.data = [], mini.TreeSelect.superclass.constructor.call(this)
}, mini.extend(mini.TreeSelect, mini.PopupEdit, {
	_ajaxOption : {
		async : !0,
		type : "get"
	},
	valueFromSelect : !1,
	text : "",
	value : "",
	autoCheckParent : !1,
	checkOpposite : !1,
	expandOnLoad : !1,
	valueField : "id",
	textField : "text",
	nodesField : "children",
	delimiter : ",",
	showClose : !0,
	multiSelect : !1,
	data : [],
	url : "",
	allowInput : !1,
	showTreeIcon : !1,
	showTreeLines : !0,
	resultAsTree : !1,
	parentField : "pid",
	checkRecursive : !1,
	showFolderCheckBox : !0,
	popupHeight : 200,
	popupWidth : 200,
	popupMaxHeight : 250,
	popupMinWidth : 100,
	queryValue : null,
	set : function(t) {
		if ("string" == typeof t) return this;
		var e = t.value;
		delete t.value;
		var i = t.text;
		delete t.text;
		var n = t.url;
		delete t.url;
		var s = t.data;
		return delete t.data
			, t.onvaluechanged || (this.defaultValueTriggerChange = !1), mini.TreeSelect.superclass.set.call(this, t), mini.isNull(s) || this.setData(s), mini.isNull(n) || this.setUrl(n), mini.isNull(e) || this.setValue(e, this.defaultValueTriggerChange), mini.isNull(i) || this.setText(i), this
	},
	uiCls : "mini-treeselect",
	destroy : function(t) {
		this.tree && (mini.clearEvent(this.tree), this.tree.destroy(t), this.tree = null), this._destroyQueryToolBar(),
		delete this.data
		, mini.TreeSelect.superclass.destroy.call(this, t)
	},
	uiCls : "mini-treeselect",
	_createPopup : function() {
		mini.TreeSelect.superclass._createPopup.call(this), this._createQueryToolBar(), this.tree = new mini.Tree, this.tree.set({
			delimiter : this.delimiter
		}), this.tree.setShowTreeIcon(!0), this.tree.setStyle("border:0;width:100%;height:100%;"), this.showQueryToolBar && this.popup.setStyle("overflow:hidden;"), this.tree.setResultAsTree(this.resultAsTree), this.tree.render(this.popup._contentEl), this.tree.setCheckRecursive(this.checkRecursive), this.tree.setShowFolderCheckBox(this.showFolderCheckBox), this.tree.setCheckOpposite(this.checkOpposite), this.tree.on("nodeclick", this.__OnNodeClick, this), this.tree.on("nodecheck", this.__OnCheckedChanged, this), this.tree.on("expand", this.__OnTreeExpand, this), this.tree.on("collapse", this.__OnTreeCollapse, this), this.tree.on("beforenodecheck", this.__OnTreeBeforeNodeCheck, this), this.tree.on("beforenodeselect", this.__OnTreeBeforeNodeSelect, this), this.tree.allowAnim = !1;
		var t = this;
		this.tree.on("beforeload", function(e) {
			t.fire("beforeload", e)
		}, this), this.tree.on("load", this.__OnTreeLoad, this), this.tree.on("loaderror", function(e) {
			t.fire("loaderror", e)
		}, this), this.tree.on("drawnode", function(e) {
			t.fire("drawnode", e)
		}, this)
	},
	__OnTreeLoad : function(t) {
		this.isAsync() && this._value && this.setValue(this._value, this.defaultValueTriggerChange),
		delete this._value
		, this.fire("load", t)
	},
	__OnTreeBeforeNodeCheck : function(t) {
		t.tree = t.sender, this.fire("beforenodecheck", t)
	},
	__OnTreeBeforeNodeSelect : function(t) {
		t.tree = t.sender, this.fire("beforenodeselect", t)
	},
	__OnTreeExpand : function(t) {},
	__OnTreeCollapse : function(t) {},
	__OnPopupKeyDown : function(t) {
		(27 == t.keyCode || 13 == t.keyCode) && (jQuery(t.target).hasClass("mini-textbox-input") || (this.hidePopup(), this.focus()))
	},
	getSelectedNode : function() {
		return this.tree.getSelectedNode()
	},
	getCheckedNodes : function(t) {
		return this.tree.getCheckedNodes(t)
	},
	getSelectedNodes : function() {
		return this.tree.getSelectedNodes()
	},
	getParentNode : function(t) {
		return this.tree.getParentNode(t)
	},
	getChildNodes : function(t) {
		return this.tree.getChildNodes(t)
	},
	showPopup : function() {
		mini.TreeSelect.superclass.showPopup.call(this) !== !1 && (this.showQueryToolBar && this.tree.setHeight(this.popup.getHeight() - 35), this.tree.setValue(this.value), this.queryInput && this.queryInput.setValue(""))
	},
	__OnPopupHide : function(t) {
		this.__doFocusCls(), this.tree && this.tree.clearFilter(), this.fire("hidepopup")
	},
	getItem : function(t) {
		return "object" == typeof t ? t : this.data[t]
	},
	indexOf : function(t) {
		return this.data.indexOf(t)
	},
	getAt : function(t) {
		return this.data[t]
	},
	loadList : function(t, e, i) {
		this.tree.loadList(t, e, i), this.data = this.tree.getData()
	},
	getList : function() {
		return this.tree.getList()
	},
	load : function(t) {
		this.isAsync() && void 0 == this._value && (this._value = this.value), this.tree.load(t)
	},
	setData : function(t) {
		"string" == typeof t && (t = this._eval(t)), mini.isArray(t) || (t = []), t = mini.clone(t), this.tree.setData(t), this.data = this.tree.getData()
	},
	_eval : function(_) {
		return eval("(" + _ + ")")
	},
	getData : function() {
		return this.data
	},
	setUrl : function(t) {
		this.getPopup(), this.tree.setUrl(this.parseUrl(t)), this.url = this.tree.url, this.isAsync() && void 0 == this._value && (this._value = this.value)
	},
	getUrl : function() {
		return this.url
	},
	setTextField : function(t) {
		this.tree && this.tree.setTextField(t), this.textField = t
	},
	getTextField : function() {
		return this.textField
	},
	setNodesField : function(t) {
		this.tree && this.tree.setNodesField(t), this.nodesField = t
	},
	getNodesField : function() {
		return this.nodesField
	},
	isAsync : function() {
		return 1 == this._ajaxOption.async
	},
	setValue : function(t, e) {
		this.isAsync() && (this._value = t);
		var i = this.getValue(),
			n = this.tree.getValueAndText(t);
		"" != n[1] || this.valueFromSelect || (n[0] = t, n[1] = t), this.value = n[0], this._valueEl.value = n[0], this.text = this._textEl.value = n[1], this._doEmpty(), this.tree.setValue(this.value), mini.isEquals(this.value, i) || (void 0 === e && (e = !0), e && this._OnValueChanged())
	},
	setMultiSelect : function(t) {
		this.multiSelect != t && (this.multiSelect = t, this.tree.setShowCheckBox(t), this.tree.setAllowSelect(!t), this.tree.setEnableHotTrack(!t))
	},
	getMultiSelect : function() {
		return this.multiSelect
	},
	__OnInputTextChanged : function() {
		var t = this._textEl.value,
			e = (this.getValue(), this.tree.getSelectedNode());
		e || this.setValue(t)
	},
	__OnNodeClick : function(t) {
		if (!this.multiSelect) {
			var e = this.tree.getSelectedNode(),
				i = this.tree.getItemValue(e);
			this.getValue(), e && i != this.getValue() && (this.setValue(i), this.hidePopup(), this.focus(), this.fire("nodeclick", {
				node : t.node
			}))
		}
	},
	__OnCheckedChanged : function(t) {
		if (this.multiSelect) {
			var e = this.tree.getValue();
			this.getValue(), this.setValue(e), this.fire("nodecheck", t)
		}
	},
	__OnInputKeyDown : function(t) {
		if (this.fire("keydown", {
				htmlEvent : t
			}), 8 == t.keyCode && (this.isReadOnly() || 0 == this.allowInput)) return !1;
		if (9 == t.keyCode) return void this.hidePopup();
		if (!this.isReadOnly()) switch (t.keyCode) {
			case 27:
				this.isShowPopup() && t.stopPropagation(), this.hidePopup();
				break;case 13:
				var e = this;
				this.hidePopup(), setTimeout(function() {
					e.fire("enter", t)
				}, 10);
				break;case 37:
				break;case 38:
				t.preventDefault();
				break;case 39:
				break;case 40:
				t.preventDefault(), this.showPopup();
				break;default:
				if (this.isReadOnly() || 0 == this.allowInput)
					break;
				this.allowInput && (this.tree._selectedNode = null, this.value = "");var e = this;
				setTimeout(function() {
					e._doQuery()
				}, 10)
		}
	},
	_doQuery : function() {
		var t = this.textField,
			e = this._textEl.value.toLowerCase();
		this.tree.filter(function(i) {
			var n = String(i[t] ? i[t] : "").toLowerCase();
			return -1 != n.indexOf(e) ? !0 : !1
		}), this.tree.expandAll(), this.showPopup()
	},
	setCheckRecursive : function(t) {
		this.checkRecursive = t, this.tree && this.tree.setCheckRecursive(t)
	},
	getCheckRecursive : function() {
		return this.checkRecursive
	},
	setResultAsTree : function(t) {
		this.resultAsTree = t, this.tree && this.tree.setResultAsTree(t)
	},
	getResultAsTree : function() {
		return this.resultAsTree
	},
	setParentField : function(t) {
		this.parentField = t, this.tree && this.tree.setParentField(t)
	},
	getParentField : function() {
		return this.parentField
	},
	setValueField : function(t) {
		this.tree && this.tree.setIdField(t), this.valueField = t
	},
	getValueField : function() {
		return this.valueField
	},
	setShowTreeIcon : function(t) {
		this.showTreeIcon = t, this.tree && this.tree.setShowTreeIcon(t)
	},
	getShowTreeIcon : function() {
		return this.showTreeIcon
	},
	setShowTreeLines : function(t) {
		this.showTreeLines = t, this.tree && this.tree.setShowTreeLines(t)
	},
	getShowTreeLines : function() {
		return this.showTreeLines
	},
	setShowFolderCheckBox : function(t) {
		this.showFolderCheckBox = t, this.tree && this.tree.setShowFolderCheckBox(t)
	},
	getShowFolderCheckBox : function() {
		return this.showFolderCheckBox
	},
	setAutoCheckParent : function(t) {
		this.autoCheckParent = t, this.tree && this.tree.setAutoCheckParent(t)
	},
	getAutoCheckParent : function() {
		return this.autoCheckParent
	},
	setCheckOpposite : function(t) {
		this.checkOpposite = t, this.tree && this.tree.setCheckOpposite(t)
	},
	setExpandOnLoad : function(t) {
		this.expandOnLoad = t, this.tree && this.tree.setExpandOnLoad(t)
	},
	getExpandOnLoad : function() {
		return this.expandOnLoad
	},
	setValueFromSelect : function(t) {
		this.valueFromSelect = t
	},
	getValueFromSelect : function() {
		return this.valueFromSelect
	},
	setDataField : function(t) {
		this.tree && this.tree.setDataField(t), this.dataField = t
	},
	setQueryField : function(t) {
		this.tree.queryfield = t
	},
	getAttrs : function(t) {
		var e = mini.TreeSelect.superclass.getAttrs.call(this, t);
		if (mini._ParseString(t, e, [ "url", "data", "textField", "valueField", "nodesField", "parentField", "onnodecheck", "onbeforenodecheck", "onbeforenodeselect", "expandOnLoad", "onnodeclick", "onbeforeload", "onload", "onloaderror", "ondrawnode", "queryField" ]), mini._ParseBool(t, e, [ "multiSelect", "resultAsTree", "checkRecursive", "showTreeIcon", "showTreeLines", "showFolderCheckBox", "autoCheckParent", "showQueryToolBar", "valueFromSelect", "checkOpposite" ]), e.expandOnLoad) {
			var i = parseInt(e.expandOnLoad);
			mini.isNumber(i) ? e.expandOnLoad = i : e.expandOnLoad = "true" == e.expandOnLoad ? !0 : !1
		}
		return e
	}
}), mini.regClass(mini.TreeSelect, "TreeSelect"), mini.Window = function() {
	mini.Window.superclass.constructor.call(this), this.addCls("mini-window"), this.setVisible(!1), this.setAllowDrag(this.allowDrag), this.setAllowResize(this.allowResize)
}, mini.extend(mini.Window, mini.Panel, {
	x : 0,
	y : 0,
	state : "restore",
	_dragCls : "mini-window-drag",
	_resizeCls : "mini-window-resize",
	allowDrag : !0,
	showCloseButton : !0,
	showMaxButton : !1,
	showMinButton : !1,
	showCollapseButton : !1,
	effect : "none",
	showModal : !0,
	minWidth : 150,
	minHeight : 80,
	maxWidth : 2e3,
	maxHeight : 2e3,
	uiCls : "mini-window",
	_create : function() {
		mini.Window.superclass._create.call(this)
	},
	_initButtons : function() {
		this.buttons = [];
		var t = this.createButton({
			name : "close",
			cls : "mini-tools-close",
			visible : this.showCloseButton
		});
		this.buttons.push(t);
		var e = this.createButton({
			name : "max",
			cls : "mini-tools-max",
			visible : this.showMaxButton
		});
		this.buttons.push(e);
		var i = this.createButton({
			name : "min",
			cls : "mini-tools-min",
			visible : this.showMinButton
		});
		this.buttons.push(i);
		var n = this.createButton({
			name : "collapse",
			cls : "mini-tools-collapse",
			visible : this.showCollapseButton
		});
		this.buttons.push(n)
	},
	_initEvents : function() {
		mini.Window.superclass._initEvents.call(this), mini._BindEvents(function() {
			mini.on(this.el, "mouseover", this.__OnMouseOver, this), mini.on(window, "resize", this.__OnWindowResize, this), mini.on(this.el, "mousedown", this.__OnWindowMouseDown, this)
		}, this), this.on("resize", this._onResize, this), this.on("move.resizer", this._onResizerMove, this)
	},
	_onResize : function() {
		this._doShim()
	},
	_onResizerMove : function(t) {
		mini_useShims && this._shimEl && mini.setSize(this._shimEl, t.w, t.h)
	},
	_doShim : function() {
		function t() {
			this._shimEl.style.display = "";var t = mini.getBox(this.el),
				e = this._shimEl.style;
			e.width = t.width + "px", e.height = t.height + "px", e.left = t.x + "px", e.top = t.y + "px";var i = mini.getStyle(this.el, "zIndex");
			isNaN(i) || (this._shimEl.style.zIndex = i - 3)
		}
		if (mini_useShims) {
			if (!this._shimEl) {
				var e = "<iframe frameborder='0' style='position: absolute; z-index: -1; width: 0; height: 0; top: 0;left:0;scrolling:no;'></iframe>";
				this._shimEl = mini.append(document.body, e)
			}
			this._shimEl.style.display = "none", this._doShimTimer && (clearTimeout(this._doShimTimer), this._doShimTimer = null);
			var i = this;
			this._doShimTimer = setTimeout(function() {
				i._doShimTimer = null, t.call(i)
			}, 20)
		}
	},
	doLayout : function() {
		if (this.canLayout()) {
			if ("max" == this.state) {
				var t = this.getParentBox();
				this.el.style.left = "0px", this.el.style.top = "0px", mini.setSize(this.el, t.width, t.height)
			}
			mini.Window.superclass.doLayout.call(this), this.allowDrag && mini.addClass(this.el, this._dragCls), "max" == this.state && (this._resizeGridEl.style.display = "none", mini.removeClass(this.el, this._dragCls)), this._doModal()
		}
	},
	_doModal : function() {
		var t = this.showModal && this.isDisplay() && this.visible;
		if (this._modalEl || 0 != this.showModal)
			if (this._modalEl || (this._modalEl = mini.append(document.body, '<div class="mini-modal mini-fixed" style="display:none"></div>')), t) {
				var e = this;
				e._modalEl && (e._modalEl.style.display = "block", e._modalEl.style.zIndex = mini.getStyle(e.el, "zIndex") - 1)
			} else
				this._modalEl.style.display = "none"
	},
	getParentBox : function() {
		var t = mini.getViewportBox(),
			e = this._containerEl || document.body;
		return e != document.body && (t = mini.getBox(e)), t
	},
	setShowModal : function(t) {
		this.showModal = t
	},
	getShowModal : function() {
		return this.showModal
	},
	setMinWidth : function(t) {
		isNaN(t) || (this.minWidth = t)
	},
	getMinWidth : function() {
		return this.minWidth
	},
	setMinHeight : function(t) {
		isNaN(t) || (this.minHeight = t)
	},
	getMinHeight : function() {
		return this.minHeight
	},
	setMaxWidth : function(t) {
		isNaN(t) || (this.maxWidth = t)
	},
	getMaxWidth : function() {
		return this.maxWidth
	},
	setMaxHeight : function(t) {
		isNaN(t) || (this.maxHeight = t)
	},
	getMaxHeight : function() {
		return this.maxHeight
	},
	setAllowDrag : function(t) {
		this.allowDrag = t, mini.removeClass(this.el, this._dragCls), t && mini.addClass(this.el, this._dragCls)
	},
	getAllowDrag : function() {
		return this.allowDrag
	},
	setShowMaxButton : function(t) {
		this.showMaxButton = t;
		var e = this.getButton("max");
		e.visible = t, this._doTools()
	},
	getShowMaxButton : function() {
		return this.showMaxButton
	},
	setShowMinButton : function(t) {
		this.showMinButton = t;
		var e = this.getButton("min");
		e.visible = t, this._doTools()
	},
	getShowMinButton : function() {
		return this.showMinButton
	},
	max : function() {
		this.state = "max", this.show();
		var t = this.getButton("max");
		t && (t.cls = "mini-tools-restore", this._doTools())
	},
	restore : function() {
		this.state = "restore", this.show(this.x, this.y);
		var t = this.getButton("max");
		t && (t.cls = "mini-tools-max", this._doTools())
	},
	containerEl : null,
	showAtPos : function(t, e, i) {
		this.show(t, e, i)
	},
	show : function(t, e, i) {
		this._allowLayout = !1;
		var n = this._containerEl || document.body;
		if (this.isRender() && this.el.parentNode == n || this.render(n), this.el.style.zIndex = mini.getMaxZIndex(), this._doShow(t, e), this._allowLayout = !0, "none" == this.effect || "fast" != this.effect && "slow" != this.effect) this.setVisible(!0);else {
			this.visible = !0;
			var s = this;
			s.doLayout(), this.el.style.display = "none", $(this.el).fadeTo(this.effect, 1, function() {
				isIE && this.style.removeAttribute("filter")
			})
		}
		try {
			this.el.focus()
		} catch (o) {}
	},
	hide : function() {
		this.fire("beforehide"), this.state = "restore",
		delete this._width
		,
		delete this._height;
		var t = this;
		"none" == this.effect || "fast" != this.effect && "slow" != this.effect ? this.setVisible(!1) : $(this.el).fadeTo(this.effect, 0, function() {
			isIE && this.style.removeAttribute("filter"), t.setVisible(!1)
		}), this._doModal()
	},
	getWidth : function() {
		this._headerEl.style.width = "50px";
		var t = mini.getWidth(this.el);
		return this._headerEl.style.width = "auto", t
	},
	getBox : function() {
		this._headerEl.style.width = "50px", this.el.style.display = "";
		var t = mini.getWidth(this.el);
		this._headerEl.style.width = "auto";
		var e = mini.getBox(this.el);
		return e.width = t, e.right = e.x + t, e
	},
	_measureSize : function() {
		var t = this.getBox();
		t.width > this.maxWidth && (mini.setWidth(this.el, this.maxWidth), t = this.getBox()), t.height > this.maxHeight && (mini.setHeight(this.el, this.maxHeight), t = this.getBox()), t.width < this.minWidth && (mini.setWidth(this.el, this.minWidth), t = this.getBox()), t.height < this.minHeight && (mini.setHeight(this.el, this.minHeight), t = this.getBox())
	},
	setWidth : function(t) {
		this.state = "restore",
		delete this._width
		, mini.Window.superclass.setWidth.call(this, t)
	},
	setHeight : function(t) {
		this.state = "restore",
		delete this._height
		, mini.Window.superclass.setHeight.call(this, t)
	},
	_doShow : function(t, e) {
		var i = this.getParentBox();
		if ("max" == this.state) {
			if (!this._width) {
				var n = this.getBox();
				this._width = n.width, this._height = n.height, this.x = n.x, this.y = n.y
			}
		} else {
			mini.isNull(t) && (t = "center"), mini.isNull(e) && (e = "middle"), this.el.style.position = "absolute", this.el.style.left = "-2000px", this.el.style.top = "-2000px", this.el.style.display = "", this._width ? (this.setWidth(this._width), this.setHeight(this._height)) : (this.setWidth(this.width), this.setHeight(this.height)), this._measureSize();
			var n = this.getBox();
			"left" == t && (t = 0), "center" == t && (t = i.width / 2 - n.width / 2), "right" == t && (t = i.width - n.width), "top" == e && (e = 0), "middle" == e && (e = i.y + i.height / 2 - n.height / 2), "bottom" == e && (e = i.height - n.height), t + n.width > i.right && (t = i.right - n.width), e + n.height > i.bottom && (e = i.bottom - n.height), 0 > t && (t = 0), 0 > e && (e = 0), this.el.style.display = "", mini.setX(this.el, t), mini.setY(this.el, e), this.el.style.left = t + "px", this.el.style.top = e + "px", this.x = n.x, this.y = n.y
		}
		this.doLayout(), this._doShim()
	},
	_OnButtonClick : function(t, e) {
		var i = mini.Window.superclass._OnButtonClick.call(this, t, e);
		return 1 == i.cancel ? i : ("max" == i.name && ("max" == this.state ? this.restore() : this.max()), i)
	},
	__OnWindowResize : function(t) {
		"max" == this.state && this.doLayout()
	},
	__OnWindowMouseDown : function(t) {
		var e = this;
		if ("max" != this.state && this.allowDrag && mini.isAncestor(this._headerEl, t.target) && !mini.findParent(t.target, "mini-tools")) {
			var e = this;
			this.el && (this.el.style.zIndex = mini.getMaxZIndex());
			var i = this.getBox(),
				n = new mini.Drag({
					capture : !0,
					onStart : function() {
						e._maskProxy = mini.append(document.body, '<div class="mini-resizer-mask"></div>'), e._dragProxy = mini.append(document.body, '<div class="mini-drag-proxy"></div>'), e.el.style.display = "none"
					},
					onMove : function(t) {
						var n = t.now[0] - t.init[0],
							s = t.now[1] - t.init[1];
						n = i.x + n, s = i.y + s;
						var o = e.getParentBox(),
							l = n + i.width,
							r = s + i.height;
						l > o.width && (n = o.width - i.width), r > o.height && (s = o.height - i.height), 0 > n && (n = 0), 0 > s && (s = 0), e.x = n, e.y = s;
						var a = {
							x : n,
							y : s,
							width : i.width,
							height : i.height
						};
						if (mini.setBox(e._dragProxy, a), this.moved = !0, e._shimEl) {
							mini.setXY(e._shimEl, a.x, a.y);
							var h = mini.getStyle(e.el, "zIndex");
							isNaN(h) || (e._dragProxy.style.zIndex = h)
						}
					},
					onStop : function() {
						if (e.el.style.display = "block", this.moved) {
							var t = mini.getBox(e._dragProxy);
							mini.setXY(e.el, t.x, t.y)
						}
						jQuery(e._maskProxy).remove(), e._maskProxy = null, jQuery(e._dragProxy).remove(), e._dragProxy = null, e._doShim()
					}
				});
			n.start(t)
		}
	},
	destroy : function(t) {
		this._shimEl && (jQuery(this._shimEl).remove(), this._shimEl = null), this._doShimTimer && (clearTimeout(this._doShimTimer), this._doShimTimer = null), this.un("resize", this._onResize, this), this.un("move.resizer", this._onResizerMove, this), mini.un(window, "resize", this.__OnWindowResize, this),
		delete this.buttons
		, this._modalEl && (jQuery(this._modalEl).remove(), this._modalEl = null), this.shadowEl && (jQuery(this.shadowEl).remove(), this.shadowEl = null), mini.Window.superclass.destroy.call(this, t)
	},
	getAttrs : function(t) {
		var e = mini.Window.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "modalStyle", "effect", "onbeforehide" ]), mini._ParseBool(t, e, [ "showModal", "showShadow", "allowDrag", "allowResize", "showMaxButton", "showMinButton" ]), mini._ParseInt(t, e, [ "minWidth", "minHeight", "maxWidth", "maxHeight" ]), e
	},
	showAtEl : function(t, e) {
		if (t = mini.byId(t)) {
			this.isRender() && this.el.parentNode == document.body || this.render(document.body);
			var i = {
				xAlign : this.xAlign,
				yAlign : this.yAlign,
				xOffset : 0,
				yOffset : 0,
				popupCls : this.popupCls
			};
			mini.copyTo(i, e), this._popupEl = t, this.el.style.position = "absolute", this.el.style.left = "-2000px", this.el.style.top = "-2000px", this.el.style.display = "", this.doLayout(), this._measureSize();
			var n = mini.getViewportBox(),
				s = this.getBox(),
				o = mini.getBox(t),
				l = i.xy,
				r = (i.xAlign, i.yAlign, n.width / 2 - s.width / 2),
				a = 0;
			switch (l && (r = l[0], a = l[1]), i.xAlign) {
			case "outleft":
				r = o.x - s.width;
				break;case "left":
				r = o.x;
				break;case "center":
				r = o.x + o.width / 2 - s.width / 2;
				break;case "right":
				r = o.right - s.width;
				break;case "outright":
				r = o.right
			}
			switch (i.yAlign) {
			case "above":
				a = o.y - s.height;
				break;case "top":
				a = o.y;
				break;case "middle":
				a = o.y + o.height / 2 - s.height / 2;
				break;case "bottom":
				a = o.bottom - s.height;
				break;case "below":
				a = o.bottom
			}
			if (r = parseInt(r), a = parseInt(a), i.outYAlign || i.outXAlign) {
				if ("above" == i.outYAlign && a + s.height > n.bottom) {
					var h = o.y - n.y,
						d = n.bottom - o.bottom;
					h > d && (a = o.y - s.height)
				}
				if ("outleft" == i.outXAlign && r + s.width > n.right) {
					var u = o.x - n.x,
						c = n.right - o.right;
					u > c && (r = o.x - s.width)
				}
				"right" == i.outXAlign && r + s.width > n.right && (r = o.right - s.width), this._Show(r, a)
			} else this.showAtPos(r + i.xOffset, a + i.yOffset)
		}
	}
}), mini.regClass(mini.Window, "window"), mini.OutlookTree = function() {
	mini.OutlookTree.superclass.constructor.call(this), this.data = []
}, mini.extend(mini.OutlookTree, mini.OutlookBar, {
	url : "",
	textField : "text",
	iconField : "iconCls",
	urlField : "url",
	resultAsTree : !1,
	nodesField : "children",
	idField : "id",
	parentField : "pid",
	style : "width:100%;height:100%;",
	set : function(t) {
		if ("string" == typeof t) return this;
		var e = t.url;
		delete t.url;
		var i = t.activeIndex;
		return delete t.activeIndex
			, mini.OutlookTree.superclass.set.call(this, t), e && this.setUrl(e), mini.isNumber(i) && this.setActiveIndex(i), this
	},
	uiCls : "mini-outlooktree",
	destroy : function(t) {
		if (this._trees) {
			for (var e = this._trees.clone(), i = 0, n = e.length; n > i; i++) {
				var s = e[i];
				s.destroy()
			}
			this._trees.length = 0
		}
		mini.OutlookTree.superclass.destroy.call(this, t)
	},
	_doParseFields : function(t) {
		for (var e = 0, i = t.length; i > e; e++) {
			var n = t[e];
			n.text = n[this.textField], n.url = n[this.urlField], n.iconCls = n[this.iconField]
		}
	},
	_doLoad : function() {
		var t = [];
		try {
			t = mini.getData(this.url)
		} catch (e) {
			1 == mini_debugger && alert("outlooktree json is error.")
		}
		this.dataField && (t = mini._getMap(this.dataField, t)), t || (t = []), 0 == this.resultAsTree && (t = mini.arrayToTree(t, this.nodesField, this.idField, this.parentField));
		var i = mini.treeToArray(t, this.nodesField, this.idField, this.parentField);
		this._doParseFields(i), this.createNavBarTree(t), this.fire("load")
	},
	loadList : function(t, e, i) {
		e = e || this.idField, i = i || this.parentField, this._doParseFields(t);
		var n = mini.arrayToTree(t, this.nodesField, e, i);
		this.load(n)
	},
	load : function(t) {
		if ("undefined" == typeof t) this.setUrl(this.url);
		else if ("string" == typeof t) this.setUrl(t);else {
			var e;
			0 == this.resultAsTree && (e = mini.arrayToTree(t, this.nodesField, this.idField, this.parentField));
			var i = mini.treeToArray(e, this.nodesField, this.idField, this.parentField);
			this._doParseFields(i), this.createNavBarTree(e)
		}
	},
	setData : function(t) {
		this.load(t)
	},
	setUrl : function(t) {
		this.url = this.parseUrl(t), this._doLoad()
	},
	getUrl : function() {
		return this.url
	},
	setTextField : function(t) {
		this.textField = t
	},
	getTextField : function() {
		return this.textField
	},
	setIconField : function(t) {
		this.iconField = t
	},
	getIconField : function() {
		return this.iconField
	},
	setUrlField : function(t) {
		this.urlField = t
	},
	getUrlField : function() {
		return this.urlField
	},
	setResultAsTree : function(t) {
		this.resultAsTree = t
	},
	getResultAsTree : function() {
		return this.resultAsTree
	},
	setNodesField : function(t) {
		this.nodesField = t
	},
	getNodesField : function() {
		return this.nodesField
	},
	setIdField : function(t) {
		this.idField = t
	},
	getIdField : function() {
		return this.idField
	},
	setParentField : function(t) {
		this.parentField = t
	},
	getParentField : function() {
		return this.parentField
	},
	_selected : null,
	getSelected : function() {
		return this._selected
	},
	selectNode : function(t) {
		if (t = this.getNode(t)) {
			var e = this._getOwnerTree(t);
			e.selectNode(t)
		}
	},
	expandPath : function(t) {
		if (t = this.getNode(t)) {
			var e = this._getOwnerTree(t);
			e.expandPath(t), this.expandGroup(e._ownerGroup)
		}
	},
	findNodes : function(t, e) {
		var i = [];
		e = e || this;
		for (var n = 0, s = this._trees.length; s > n; n++) {
			var o = this._trees[n],
				l = o.findNodes(t, e);
			i.addRange(l)
		}
		return i
	},
	getNode : function(t) {
		for (var e = 0, i = this._trees.length; i > e; e++) {
			var n = this._trees[e],
				s = n.getNode(t);
			if (s) return s
		}
		return null
	},
	getList : function() {
		for (var t = [], e = 0, i = this._trees.length; i > e; e++) {
			var n = this._trees[e],
				s = n.getList();
			t.addRange(s)
		}
		return t
	},
	_getOwnerTree : function(t) {
		if (t)
			for (var e = 0, i = this._trees.length; i > e; e++) {
				var n = this._trees[e];
				if (n._idNodes[t._id]) return n
		}
	},
	expandOnLoad : !1,
	setExpandOnLoad : function(t) {
		this.expandOnLoad = t
	},
	getExpandOnLoad : function() {
		return this.expandOnLoad
	},
	getAttrs : function(t) {
		var e = mini.OutlookTree.superclass.getAttrs.call(this, t);
		if (e.text = t.innerHTML, mini._ParseString(t, e, [ "url", "textField", "urlField", "idField", "parentField", "nodesField", "iconField", "onnodeclick", "onnodeselect", "onnodemousedown", "expandOnLoad" ]), mini._ParseBool(t, e, [ "resultAsTree" ]), e.expandOnLoad) {
			var i = parseInt(e.expandOnLoad);
			mini.isNumber(i) ? e.expandOnLoad = i : e.expandOnLoad = "true" == e.expandOnLoad ? !0 : !1
		}
		return e
	},
	autoCollapse : !0,
	activeIndex : 0,
	createNavBarTree : function(t) {
		mini.isArray(t) || (t = []), this.data = t;
		for (var e = [], i = 0, n = this.data.length; n > i; i++) {
			var s = this.data[i],
				o = {};
			o.title = s.text, o.iconCls = s.iconCls, e.push(o), o._children = s[this.nodesField]
		}
		this.setGroups(e), this.getExpandOnLoad() && this.setActiveIndex(this.activeIndex), this._trees = [];
		for (var i = 0, n = this.groups.length; n > i; i++) {
			var o = this.groups[i],
				l = this.getGroupBodyEl(o),
				t = new mini.Tree;
			t.set({
				expandOnLoad : this.expandOnLoad,
				showTreeIcon : !0,
				style : "width:100%;height:100%;border:0;background:none",
				data : o._children
			}), t.render(l), t.on("nodeclick", this.__OnNodeClick, this), t.on("nodeselect", this.__OnNodeSelect, this), t.on("nodemousedown", this.__OnNodeMouseDown, this), this._trees.push(t),
			delete o._children
			, t._ownerGroup = o
		}
		this.doLayout()
	},
	__OnNodeMouseDown : function(t) {
		var e = {
			node : t.node,
			isLeaf : t.sender.isLeaf(t.node),
			htmlEvent : t.htmlEvent
		};
		this.fire("nodemousedown", e)
	},
	__OnNodeClick : function(t) {
		var e = {
			node : t.node,
			isLeaf : t.sender.isLeaf(t.node),
			htmlEvent : t.htmlEvent
		};
		this.fire("nodeclick", e)
	},
	__OnNodeSelect : function(t) {
		if (t.node) {
			for (var e = 0, i = this._trees.length; i > e; e++) {
				var n = this._trees[e];
				n != t.sender && n.selectNode(null)
			}
			var s = {
				node : t.node,
				isLeaf : t.sender.isLeaf(t.node),
				htmlEvent : t.htmlEvent
			};
			this._selected = t.node, this.fire("nodeselect", s)
		}
	}
}), mini.regClass(mini.OutlookTree, "outlooktree"), mini.NavBarTree = function() {
	mini.NavBarTree.superclass.constructor.call(this)
}, mini.extend(mini.NavBarTree, mini.OutlookTree, {
	uiCls : "mini-navbartree"
}), mini.regClass(mini.NavBarTree, "navbartree"), mini.Separator = function() {
	mini.Separator.superclass.constructor.call(this)
}, mini.extend(mini.Separator, mini.Control, {
	_clearBorder : !1,
	uiCls : "mini-separator",
	_create : function() {
		this.el = document.createElement("span"), this.el.className = "mini-separator"
	}
}), mini.regClass(mini.Separator, "separator"), mini.ToolTip = function() {
	mini.ToolTip.superclass.constructor.call(this)
}, mini.extend(mini.ToolTip, mini.Control, {
	selector : "[title]",
	placement : "bottom",
	trigger : "hover focus",
	uiCls : "mini-tooltip",
	_create : function() {
		this.el = jQuery('<div class="mini-tooltip"><div class="mini-tooltip-arrow"></div><div class="mini-tooltip-inner"></div></div>')[0], this.$element = jQuery(this.el), this.$element.appendTo(document.body)
	},
	_initEvents : function() {},
	_bindTooltip : function() {
		this.el.style.padding = "";
		for (var t = jQuery(document), e = this.selector, i = "tooltip", n = this.trigger.split(" "), s = n.length; s--;) {
			var o = n[s];
			if ("click" == o) t.delegate(e, "click." + i, $.proxy(this._toggle, this));
			else if ("manual" != o) {
				var l = "hover" == o ? "mouseenter" : "focus",
					r = "hover" == o ? "mouseleave" : "blur";
				t.delegate(e, l + "." + i, $.proxy(this._enter, this)), t.delegate(e, r + "." + i, $.proxy(this._leave, this))
			}
		}
	},
	setSelector : function(t) {
		this.selector = t, this._bindTooltip()
	},
	getSelector : function() {
		return this.selector
	},
	setPlacement : function(t) {
		this.placement = t
	},
	getPlacement : function() {
		return this.placement
	},
	_enter : function(t) {
		this.open(t.target)
	},
	_leave : function(t) {
		this.close()
	},
	_toggle : function(t) {
		"none" == this._getTip().css("display") ? this.enter(t) : this.leave(t)
	},
	open : function(t) {
		var t = $(t)[0] || this.target,
			e = ($(t), this.getContent(t)),
			i = {
				element : t,
				content : e,
				cancel : !e
			};
		this.fire("beforeopen", i), i.cancel || (this.$element.show(), this._target = t, this.setContent(i.content), this.fire("open", {
			element : t
		}))
	},
	close : function() {
		this._target = null, this.$element.hide()
	},
	showLoading : function() {
		this.setContent('<div class="mini-tooltip-loading"></div>')
	},
	setContent : function(t) {
		this.$element.children(".mini-tooltip-inner").html(t || "&nbsp;"), this.applyPlacement()
	},
	getContent : function(t) {
		var e = t.title;
		return e && $(t).attr("data-tooltip", e).attr("title", ""), e || (e = $(t).attr("data-tooltip")), e
	},
	applyPlacement : function() {
		function t(t) {
			o.removeClass("mini-tooltip-left mini-tooltip-top mini-tooltip-right mini-tooltip-bottom mini-tooltip-bottomleft mini-tooltip-topleft mini-tooltip-bottomright mini-tooltip-topright").addClass("mini-tooltip-" + t)
		}
		function e(t) {
			o.offset(t)
		}
		if (this._target && "none" != this.$element.css("display")) {
			var i = this._target,
				n = jQuery(i),
				s = n.attr("data-placement") || this.placement,
				o = this.$element;
			o.show().css({
				left : "-2000px",
				top : "-2000px"
			});
			var l = mini.getBox(i),
				r = mini.getViewportBox(),
				a = l.top - r.top,
				h = r.bottom - l.bottom;
			t(s);
			var d = mini.getBox(o[0]),
				u = mini.getCalculatedOffset(s, l, d.width, d.height);
			"left" == s || "right" == s || "top" == s || "bottom" == s || "bottomleft" == s && a > h && u.top + d.height > r.bottom && (s = "topleft"), t(s), u = mini.getCalculatedOffset(s, l, d.width, d.height), e(u)
		}
	},
	getAttrs : function(t) {
		var e = mini.ToolTip.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "selector", "placement", "onbeforeopen", "onopen", "onclose" ]), e
	}
}), mini.regClass(mini.ToolTip, "tooltip"), mini._allComponents = {}, function() {
	var t,
		e,
		i,
		n;
	for (e in mini) t = mini[e], "function" == typeof t && t.prototype.isControl && (mini._allComponents[e] = [ t ]);
	for (e in mini._allComponents)
		if (t = mini._allComponents[e], t[0].superclass) {
			i = t[0].superclass.constructor;
			for (n in mini._allComponents) mini._allComponents[n][0] == i && mini._allComponents[n].push(e)
	}
}(), mini.plugin = function(t, e) {
	if (t && e) {
		var i;
		for (i in e) mini._plugin(t, i, e[i])
	}
}, mini._plugin = function(t, e, i) {
	var n,
		s,
		o;
	if ("string" == typeof t)
		n = mini._allComponents[t];else
		for (s in mini._allComponents) mini._allComponents[s][0] === t && (n = mini._allComponents[s]);
	t = n[0];
	for (var l = 1, r = n.length; r > l; l++) o = mini[n[l]], o && o.prototype && t.prototype[e] === o.prototype[e] && mini._plugin(n[l], e, i);
	t.prototype[e] = i
}, mini.plugin(mini.TreeSelect, {
	showQueryToolBar : !1,
	_createQueryToolBar : function() {
		this.showQueryToolBar && !this.queryToolbar && (this.queryToolbar = new mini.ToolBar, this.queryToolbar.render(this.popup._contentEl, "prepend"), this.queryInput = new mini.TextBox, this.queryInput.setEmptyText("请录入查询条件"), this.queryInput.setWidth(50), this.queryInput.render(this.queryToolbar.el), this.queryInput.on("enter", this._queryEvent, this), this.queryButton = new mini.Button, this.queryButton.setText("查询"), this.queryButton.setPlain(!0), this.queryButton.setStyle("margin-left:2px;"), this.queryButton.render(this.queryToolbar.el), this.queryButton.onClick(this._queryEvent, this), this.on("showpopup", function() {
			var t = this.queryToolbar.getWidth();
			this.queryInput.setWidth(t - 58)
		}))
	},
	_destroyQueryToolBar : function(t) {
		this.queryInput && (mini.clearEvent(this.queryInput), this.queryInput.destroy(t), this.queryInput = null), this.queryButton && (mini.clearEvent(this.queryButton), this.queryButton.destroy(t), this.queryButton = null), this.queryToolbar && (mini.clearEvent(this.queryToolbar), this.queryToolbar.destroy(t), this.queryToolbar = null)
	},
	_queryEvent : function(t) {
		var e = this.queryInput.getValue();
		if (this.queryValue = e, e) {
			e = e.trim();
			var i = null;
			this.tree.filter(function(t) {
				var n = mini._getMap(this.queryfield, t);
				return (null == n || void 0 == n) && (n = ""), n = String(n).toLowerCase(), -1 != t[this.textField].toLowerCase().indexOf(e.toLowerCase()) || -1 != t[this.idField].toLowerCase().indexOf(e.toLowerCase()) || -1 != n.indexOf(e.toLowerCase()) ? (i && t[this.parentField] != i[this.idField] || (i = t), !0) : void 0
			}), i && this.tree.expandPath(i)
		} else this.tree.clearFilter()
	},
	setShowQueryToolBar : function(t) {
		this.showQueryToolBar = t, this.queryToolbar && (t ? this.queryToolbar.el.style.display = "" : this.queryToolbar.el.style.display = "none")
	},
	getShowQueryToolBar : function() {
		return this.showQueryToolBar
	},
	doUpdate : function() {
		mini.TreeSelect.superclass.doUpdate.call(this), this._createQueryToolBar()
	}
}), mini.locale = "en-US", mini.dateInfo = {
	monthsLong : [ "一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月" ],
	monthsShort : [ "1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月" ],
	daysLong : [ "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" ],
	daysShort : [ "日", "一", "二", "三", "四", "五", "六" ],
	quarterLong : [ "一季度", "二季度", "三季度", "四季度" ],
	quarterShort : [ "Q1", "Q2", "Q2", "Q4" ],
	halfYearLong : [ "上半年", "下半年" ],
	patterns : {
		d : "yyyy-M-d",
		D : "yyyy年M月d日",
		f : "yyyy年M月d日 H:mm",
		F : "yyyy年M月d日 H:mm:ss",
		g : "yyyy-M-d H:mm",
		G : "yyyy-M-d H:mm:ss",
		m : "MMMd日",
		o : "yyyy-MM-ddTHH:mm:ss.fff",
		s : "yyyy-MM-ddTHH:mm:ss",
		t : "H:mm",
		T : "H:mm:ss",
		U : "yyyy年M月d日 HH:mm:ss",
		y : "yyyy年MM月"
	},
	tt : {
		AM : "上午",
		PM : "下午"
	},
	ten : {
		Early : "上旬",
		Mid : "中旬",
		Late : "下旬"
	},
	today : "今天",
	clockType : 24
}, mini.Calendar && mini.copyTo(mini.Calendar.prototype, {
	firstDayOfWeek : 0,
	todayText : "今天",
	clearText : "清除",
	okText : "确定",
	cancelText : "取消",
	daysShort : [ "日", "一", "二", "三", "四", "五", "六" ],
	format : "yyyy年MM月",
	timeFormat : "H:mm"
});
for (var id in mini) {
	var clazz = mini[id];
	clazz && clazz.prototype && clazz.prototype.isControl && (clazz.prototype.requiredErrorText = "不能为空")
}
if (mini.TextBox) {
	var vtypeErrorTexts = {
		emailErrorText : "请输入邮件格式",
		urlErrorText : "请输入URL格式",
		floatErrorText : "请输入数字",
		intErrorText : "请输入整数",
		dateErrorText : "请输入日期格式 {0}",
		maxLengthErrorText : "不能超过 {0} 个字符",
		minLengthErrorText : "不能少于 {0} 个字符",
		maxErrorText : "数字不能大于 {0} ",
		minErrorText : "数字不能小于 {0} ",
		rangeLengthErrorText : "字符长度必须在 {0} 到 {1} 之间",
		rangeCharErrorText : "字符数必须在 {0} 到 {1} 之间",
		rangeErrorText : "数字必须在 {0} 到 {1} 之间",
		rangeDecimalsErrorText : "请保留小数点后 {0} 位小数."
	};
	mini.copyTo(mini.TextBox.prototype, vtypeErrorTexts), mini.copyTo(mini.Password.prototype, vtypeErrorTexts), mini.copyTo(mini.TextArea.prototype, vtypeErrorTexts)
}
mini.Pager && mini.copyTo(mini.Pager.prototype, {
	firstText : "首页",
	prevText : "上一页",
	nextText : "下一页",
	lastText : "尾页",
	pageInfoText : "每页 {0} 条, 共 {1} 条"
}), mini.DataGrid && mini.copyTo(mini.DataGrid.prototype, {
	emptyText : "没有返回的数据"
}), window.mini.Gantt && (mini.GanttView.ShortWeeks = [ "日", "一", "二", "三", "四", "五", "六" ], mini.GanttView.LongWeeks = [ "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" ], mini.Gantt.PredecessorLinkType = [ {
	ID : 0,
	Name : "完成-完成(FF)",
	Short : "FF"
}, {
	ID : 1,
	Name : "完成-开始(FS)",
	Short : "FS"
}, {
	ID : 2,
	Name : "开始-完成(SF)",
	Short : "SF"
}, {
	ID : 3,
	Name : "开始-开始(SS)",
	Short : "SS"
} ], mini.Gantt.ConstraintType = [ {
	ID : 0,
	Name : "越早越好"
}, {
	ID : 1,
	Name : "越晚越好"
}, {
	ID : 2,
	Name : "必须开始于"
}, {
	ID : 3,
	Name : "必须完成于"
}, {
	ID : 4,
	Name : "不得早于...开始"
}, {
	ID : 5,
	Name : "不得晚于...开始"
}, {
	ID : 6,
	Name : "不得早于...完成"
}, {
	ID : 7,
	Name : "不得晚于...完成"
} ], mini.copyTo(mini.Gantt, {
	ID_Text : "标识号",
	Name_Text : "任务名称",
	PercentComplete_Text : "进度",
	Duration_Text : "工期",
	Start_Text : "开始日期",
	Finish_Text : "完成日期",
	Critical_Text : "关键任务",
	PredecessorLink_Text : "前置任务",
	Work_Text : "工时",
	Priority_Text : "重要级别",
	Weight_Text : "权重",
	OutlineNumber_Text : "大纲字段",
	OutlineLevel_Text : "任务层级",
	ActualStart_Text : "实际开始日期",
	ActualFinish_Text : "实际完成日期",
	WBS_Text : "WBS",
	ConstraintType_Text : "限制类型",
	ConstraintDate_Text : "限制日期",
	Department_Text : "部门",
	Principal_Text : "负责人",
	Assignments_Text : "资源名称",
	Summary_Text : "摘要任务",
	Task_Text : "任务",
	Baseline_Text : "比较基准",
	LinkType_Text : "链接类型",
	LinkLag_Text : "延隔时间",
	From_Text : "从",
	To_Text : "到",
	Goto_Text : "转到任务",
	UpGrade_Text : "升级",
	DownGrade_Text : "降级",
	Add_Text : "新增",
	Edit_Text : "编辑",
	Remove_Text : "删除",
	Move_Text : "移动",
	ZoomIn_Text : "放大",
	ZoomOut_Text : "缩小",
	Deselect_Text : "取消选择",
	Split_Text : "拆分任务"
})), "function" == typeof define && define.amd && define("miniui", [ "jquery" ], function() {
	return mini
}), mini.Range = function() {
	mini.Range.superclass.constructor.call(this)
}, mini.extend(mini.Range, mini.ValidatorBase, {
	startElConfig : {},
	endElConfig : {},
	formField : !0,
	_errorIconEl : null,
	vtype : "",
	elType : "textbox",
	label : [ "从", "至" ],
	businessInfo : [ "", "" ],
	elWidth : 100,
	_errorIconEl : null,
	allowEquals : !1,
	uiCls : "mini-range",
	set : function(t) {
		return mini.isNull(t.startElConfig) || (this.startElConfig = mini.decode(t.startElConfig),
			delete t.startElConfig
			), mini.isNull(t.endElConfig) || (this.endElConfig = mini.decode(t.endElConfig),
			delete t.endElConfig
			), mini.isNull(t.businessInfo) || (this.businessInfo = mini.decode(t.businessInfo),
			delete t.businessInfo
			), mini.isNull(t.label) || (this.label = mini.decode(t.label),
			delete t.label
			), mini.Range.superclass.set.call(this, t), this.startElConfig.type = this.elType, this.startElConfig.vtype = this.vtype, this.startElConfig.required = this.required, this.startElConfig.errorMode = "none", this.startElConfig.width = this.elWidth, this.startElConfig.name = this.startElConfig.name || "0", this.endElConfig.type = this.elType, this.endElConfig.vtype = this.vtype, this.endElConfig.required = this.required, this.endElConfig.errorMode = "none", this.endElConfig.width = this.elWidth, this.endElConfig.name = this.endElConfig.name || "1", this._initEl(), this
	},
	_create : function() {
		this.el = document.createElement("div"), this.el.className = this.uiCls
	},
	_initEl : function() {
		this.el.innerHTML = "", this.startLabel = document.createElement("label"), this.startLabel.innerHTML = this.label[0], this.el.appendChild(this.startLabel), this.startCmp = mini.create(this.startElConfig), this.startCmp.on("validation", this.__OnValidationStart, this), this.el.appendChild(this.startCmp.getEl()), this.endLabel = document.createElement("label"), this.endLabel.innerHTML = this.label[1], this.el.appendChild(this.endLabel), this.endCmp = mini.create(this.endElConfig), this.endCmp.on("validation", this.__OnValidationEnd, this), this.el.appendChild(this.endCmp.getEl())
	},
	doLayout : function() {
		mini.Range.superclass.doLayout.call(this), this.startCmp && this.startCmp.doLayout(), this.endCmp && this.endCmp.doLayout()
	},
	destroy : function(t) {
		this.startCmp && (mini.clearEvent(this.startCmp), this.startCmp = null), this.endCmp && (mini.clearEvent(this.endCmp), this.endCmp = null), this.startLabel = null, this.endLabel = null, mini.Range.superclass.destroy.call(this, t)
	},
	setValidate : function(t) {
		return this.validCmp = null, this.errorText = t.errorText, this.setIsValid(t.isValid), this.isValid()
	},
	__OnValidationStart : function(t) {
		if (t.isValid) {
			var e = this.endCmp.getValue();
			mini.isNull(e) || "" === e ? t.isValid = !0 : mini.isNull(t.value) || "" === t.value ? t.isValid = !0 : "textbox" == this.elType && (this.allowEquals && parseFloat(t.value) > parseFloat(e) ? (t.errorText = this.businessInfo[1] + "必须大于等于" + this.businessInfo[0], t.isValid = !1) : !this.allowEquals && parseFloat(t.value) >= parseFloat(e) && (t.errorText = this.businessInfo[1] + "必须大于" + this.businessInfo[0], t.isValid = !1))
		}
		t.isValid && this.validCmp != this.endCmp && (this.validCmp = this.startCmp, t.isValid = this.endCmp.validate(), t.errorText = this.endCmp.getErrorText()), this.fire("validation", t), this.setValidate(t)
	},
	__OnValidationEnd : function(t) {
		if (t.isValid) {
			var e = this.startCmp.getValue();
			mini.isNull(e) || "" === e ? t.isValid = !0 : mini.isNull(t.value) || "" === t.value ? t.isValid = !0 : "textbox" == this.elType && (this.allowEquals && parseFloat(t.value) < parseFloat(e) ? (t.errorText = this.businessInfo[1] + "必须大于等于" + this.businessInfo[0], t.isValid = !1) : !this.allowEquals && parseFloat(t.value) <= parseFloat(e) && (t.errorText = this.businessInfo[1] + "必须大于" + this.businessInfo[0], t.isValid = !1))
		}
		t.isValid && this.validCmp != this.startCmp && (this.validCmp = this.endCmp, t.isValid = this.startCmp.validate(), t.errorText = this.startCmp.getErrorText()), this.fire("validation", t), this.setValidate(t)
	},
	getValue : function() {
		return [ this.startCmp.getValue(), this.endCmp.getValue() ]
	},
	getFormValue : function() {
		var t = {};
		return t[this.startElConfig.name] = this.startCmp.getValue(), t[this.endElConfig.name] = this.endCmp.getValue(), t
	},
	setValue : function(t) {
		if (t || (t = [ "", "" ]), mini.isArray(t)) this.startCmp.setValue(t[0]), this.endCmp.setValue(t[1]);
		else if ("object" == $.type(t)) this.startCmp.setValue(t[this.startElConfig.name]), this.endCmp.setValue(t[this.endElConfig.name]);
		else if ("string" == $.type(t)) {
			var e = t.split(",");
			this.startCmp.setValue(e[0]), this.endCmp.setValue(e[1])
		}
	},
	setAllowEquals : function(t) {
		this.allowEquals = t
	},
	getErrorIconEl : function() {
		return this._errorIconEl || (this._errorIconEl = mini.append(this.el, '<span class="mini-errorIcon"></span>'), this.startCmp.setWidth(this.startCmp.getWidth() - 9), this.endCmp.setWidth(this.endCmp.getWidth() - 9)), this._errorIconEl
	},
	_RemoveErrorIcon : function() {
		if (this._errorIconEl) {
			var t = this._errorIconEl;
			jQuery(t).remove(), this.startCmp.setWidth(this.startCmp.getWidth() + 9), this.endCmp.setWidth(this.endCmp.getWidth() + 9)
		}
		this._errorIconEl = null
	},
	getAttrs : function(t) {
		var e = mini.Range.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "startElConfig", "endElConfig", "elType", "elWidth", "vtype", "label", "businessInfo" ]), mini._ParseBool(t, e, [ "allowEquals" ]), e
	}
}), mini.regClass(mini.Range, "range"), mini.Span = function() {
	mini.Span.superclass.constructor.call(this)
}, mini.extend(mini.Span, mini.ValidatorBase, {
	name : "",
	defaultValue : "",
	value : "",
	vtype : "",
	formField : !0,
	showValue : !0,
	_errorIconEl : null,
	uiCls : "mini-span",
	_create : function() {
		this.el = document.createElement("span"), this.el.className = "mini-span", this.contentEl = document.createElement("span"), this.contentEl.className = "mini-span-content", mini.append(this.el, this.contentEl)
	},
	_initEvents : function() {
		this.on("validation", this.__OnValidation, this)
	},
	__OnValidation : function(t) {
		0 != t.isValid && mini._ValidateVType(this.vtype, t.value, t, this)
	},
	doUpdate : function() {
		this.required ? this.addCls(this._requiredCls) : this.removeCls(this._requiredCls)
	},
	getValue : function() {
		return this.value
	},
	getFormValue : function() {
		return value = this.value, (null === value || void 0 === value) && (value = ""), String(value)
	},
	setValue : function(t) {
		var e = this.value;
		this.value = t, mini.isEquals(t, e) || (this._RemoveErrorIcon(), this.showValue && (t ? mini.addClass(this.el, "mini-span-show") : mini.removeClass(this.el, "mini-span-show"), this.contentEl.innerHTML = t), this.validate())
	},
	setVtype : function(t) {
		this.vtype = t
	},
	getVtype : function() {
		return this.vtype
	},
	getErrorIconEl : function() {
		return this._errorIconEl || (this._errorIconEl = mini.append(this.el, '<span class="mini-errorIcon"></span>')), this._errorIconEl
	},
	_RemoveErrorIcon : function() {
		if (this._errorIconEl) {
			var t = this._errorIconEl;
			jQuery(t).remove()
		}
		this._errorIconEl = null
	},
	getAttrs : function(t) {
		var e = mini.Span.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "value", "defaultValue", "vtype" ]), mini._ParseBool(t, e, [ "showValue" ]), e
	}
}), mini.regClass(mini.Span, "span"), mini.WDatePicker = function() {
	mini.WDatePicker.superclass.constructor.call(this), this.calendarOpts = {}
}, mini.extend(mini.WDatePicker, mini.ButtonEdit, {
	calendarOpts : {},
	uiCls : "mini-wdatepicker",
	set : function(t) {
		if ("string" == typeof t) return this;
		t.has && "string" == $.type(t.has) && (t.has = mini.decode(t.has)), t.disabledDates && "string" == $.type(t.disabledDates) && (t.disabledDates = mini.decode(t.disabledDates)), t.disabledDays && "string" == $.type(t.disabledDays) && (t.disabledDays = mini.decode(t.disabledDays));
		var e = this;
		return this.calendarOpts.onpickedFn = t.onpicked, this.calendarOpts.onpicked = function(t) {
				var i = t.cal.getNewDateStr();
				e.setValue(i), e.calendarOpts.onpickedFn && e.calendarOpts.onpickedFn(t)
			}, this.calendarOpts.onclearedFn = t.oncleared, this.calendarOpts.oncleared = function() {
				e.setValue(""), e.calendarOpts.onclearedFn && e.calendarOpts.onclearedFn(dp)
			},
			delete t.onpicked
			,
			delete t.oncleared
			, this.calendarOpts.readOnly = !t.allowInput, mini.copyTo(this.calendarOpts, t), mini.WDatePicker.superclass.set.call(this, t), this
	},
	_OnButtonClick : function(t) {
		if (0 != this.enabled) {
			var e = {
				htmlEvent : t,
				cancel : !1
			};
			this.fire("beforebuttonclick", e), 1 != e.cancel && (this.showCalendar(), this.fire("buttonclick", e))
		}
	},
	__OnFocus : function(t) {
		0 != this.enabled && (mini.WDatePicker.superclass.__OnFocus.call(this, t), this.showCalendar())
	},
	showCalendar : function() {
		WdatePicker(this.calendarOpts)
	},
	_ParseFunction : function(el, config, attrs) {
		for (var i = 0, l = attrs.length; l > i; i++) {
			var property = attrs[i],
				value = mini.getAttr(el, property);
			value && (config[property] = eval(value))
		}
	},
	setValue : function(t) {
		mini.WDatePicker.superclass.setValue.call(this, t), this.setText(t)
	},
	getAttrs : function(t) {
		var e = mini.WDatePicker.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "skin", "dateFmt", "realDateFmt", "realTimeFmt", "realFullFmt", "minDate", "maxDate", "startDate", "specialDates", "specialDays", "disabledDates", "disabledDays", "errMsg", "quickSel", "has" ]), this._ParseFunction(t, e, [ "onpicking", "onpicked", "onclearing", "oncleared", "ychanging", "ychanged", "Mchanging", "Mchanged", "dchanging", "dchanged", "Hchanging", "Hchanged", "mchanging", "mchanged", "schanging", "schanged" ]), mini._ParseBool(t, e, [ "$crossFrame", "$preLoad", "doubleCalendar", "enableKeyboard", "enableInputMask", "autoUpdateOnChanged", "alwaysUseStartDate", "isShowWeek", "highLineWeekDay", "isShowClear", "isShowToday", "isShowOK", "isShowOthers", "readOnly", "autoPickDate", "qsEnabled", "autoShowQS", "opposite" ]), mini._ParseInt(t, e, [ "errDealMode" ]), e
	}
}), mini.regClass(mini.WDatePicker, "wdatepicker"), mini.AsynPager = function() {
	mini.AsynPager.superclass.constructor.call(this)
}, mini.extend(mini.AsynPager, mini.Pager, {
	showReloadButton : !1,
	totalPage : 1 / 0,
	uiCls : "mini-asynpager",
	setVirtualPageInfo : function(t, e, i) {
		mini.isNumber(e) && (this.pageIndex = parseInt(e)), mini.isNumber(i) && (this.pageSize = parseInt(i));
		var n = (this.pageIndex + 1) * this.pageSize;
		this.totalCount < n && (this.totalCount = n), this._rightEl.innerHTML = String.format(this.pageInfoText, this.pageSize, this.totalCount + "+"), this._rightEl.style.display = this.showPageInfo ? "" : "none", this.pagesLabel.innerHTML = "/ " + t + "+", this.numInput.value = this.pageIndex > -1 ? this.pageIndex + 1 : 0, t >= this.pageIndex && this.nextButton.enable(), this.pageIndex > 0 ? (this.firstButton.enable(), this.prevButton.enable()) : (this.firstButton.disable(), this.prevButton.disable()), this.lastButton.disable()
	},
	_OnPageChanged : function(t, e) {
		var i = {
			pageIndex : mini.isNumber(t) ? t : this.pageIndex,
			pageSize : mini.isNumber(e) ? e : this.pageSize,
			cancel : !1,
			isreload : void 0 === t && void 0 === e
		};
		return i.pageIndex > this.totalPage ? (i.pageIndex = this.pageIndex, void this.update(i.pageIndex, i.pageSize)) : (i.pageIndex == this.totalPage && (i.pageIndex = this.totalPage - 1), i.pageIndex < 0 && (i.pageIndex = 0), this.fire("beforepagechanged", i), void (1 == i.cancel))
	},
	update : function(t, e, i) {
		var n = {
			pageIndex : mini.isNumber(t) ? t : this.pageIndex,
			pageSize : mini.isNumber(e) ? e : this.pageSize,
			cancel : !1,
			isreload : void 0 === t && void 0 === e
		};
		this.fire("pagechanged", n), this.totalPage == 1 / 0 && -1 == i ? this.setVirtualPageInfo(n.pageIndex + 1, n.pageIndex, n.pageSize) : mini.AsynPager.superclass.update.call(this, t, e, this.totalCount)
	},
	setGrid : function(t) {
		function e(t) {
			-1 != t.total || t.data && 0 != t.data.length ? -1 == t.total && t.data.length < this.pageSize ? (n.totalPage = this.pageIndex + 1, n.totalCount = this.pageIndex * this.pageSize + t.data.length, n.update(this.pageIndex, this.pageSize, n.totalCount)) : -1 != t.total && (n.totalPage = parseInt(t.total / this.pageSize) + 1, n.totalCount = t.total) : (this.pageIndex <= 0 ? (n.totalPage = 0, n.totalCount = 0, n.update(this.pageIndex, this.pageSize, n.totalCount)) : n.pageIndex + 1 == this.pageIndex ? (n.totalPage = n.pageIndex + 1, n.totalCount = n.pageIndex * n.pageSize + this.getData().length, n.update(n.pageIndex, n.pageSize, n.totalCount)) : n.update(n.pageIndex, n.pageSize, t.total), this.pageIndex > 0 && (mini.alert("没有更多数据。"), t.cancel = !0))
		}
		if ("string" == typeof t) {
			var i = mini.byId(t);
			if (!i) return;
			mini.parse(t), this.grid = mini.get(t)
		} else
			this.grid = t;
		var n = this,
			s = this.grid._doLoad;
		this.grid._doLoad = function() {
			mini.isNull(arguments[0].pageIndex) && (n.totalPage = 1 / 0, n.totalCount = 0), s.apply(n.grid, arguments)
		};
		var o = this.grid.setData;
		this.grid.setData = function(t) {
			mini.isNull(this.pageIndex) && (n.totalPage = 1 / 0, n.totalCount = 0), e.call(this, {
				data : t,
				total : n.totalPage == 1 / 0 ? -1 : n.totalCount
			}), o.apply(n.grid, arguments)
		};
		var n = this;
		this.grid.on("preload", function(t) {
			e.call(this, t)
		})
	},
	getAttrs : function(t) {
		var e = mini.AsynPager.superclass.getAttrs.call(this, t);
		return mini._ParseString(t, e, [ "grid" ]), e
	}
}), mini.regClass(mini.AsynPager, "asynpager"), $.ajaxSetup({
	cache : !1
}), mini_debugger = !0, mini && (mini.Relations = {
	map : {},
	onchange : function(t) {
		if (t && t.id) {
			var e = this.map[t.id];
			if (e)
				for (var i in e) {
					var n = e[i];
					n = mini.get(n), n && n.destroyed !== !0 && (n.onRelatedChange || (n.onRelatedChange = mini.Relations.onRelatedChange), n.onRelatedChange())
			}
		}
	},
	add : function(t) {
		var e = t.relations;
		if (e && !(e.length <= 0)) {
			var i = e.split(","),
				n = this.map[i[i.length - 1]];
			n || (n = {}, this.map[i[i.length - 1]] = n), n[t.id] = t
		}
	},
	onRelatedChange : function(t) {
		for (var e = this.getRelations(), i = e.split(","), n = [], s = 0, o = 0; o < i.length; o++) {
			var l = mini.get(i[o]);
			l && l.getValue() && (s++, n.push(l.getValue()))
		}
		if (s < i.length) return this.setData([]), void this.setValue("");
		var r = n.join(";"),
			a = this.getUrl2 ? this.getUrl2() : null;
		a || (a = this.getUrl());
		var h = a.indexOf("&param");
		if (-1 != h) {
			var d = a.indexOf("&", h + 1);
			a = -1 == d ? a.substring(0, h) : a.substring(0, h) + a.substring(d, a.length)
		}
		a = a + "&param=" + r, this.load(a)
	}
}, mini.checkedOnlyPorC = function(t) {
	if (!t.checked) {
		var e = t.sender.tree,
			i = t.node,
			n = e.getParentNode(i);
		if (n && n.checked) return void (t.cancel = !0);
		if (!t.isLeaf)
			for (var s = e.getChildNodes(i), o = 0; o < s.length; o++)
				if (s[o].checked) return void (t.cancel = !0)
	}
}), mini.Component && mini.plugin(mini.Component, {
	defaultValueTriggerChange : !0
}), mini.DataGrid && (mini.DataGrid.prototype.miniSetColumns = mini.DataGrid.prototype.setColumns, mini.DataGrid.prototype.miniGetAttrs = mini.DataGrid.prototype.getAttrs, mini.DataGrid.prototype.mini_createPager = mini.DataGrid.prototype._createPager, mini.DataGrid.prototype.mini_initEvents = mini.DataGrid.prototype._initEvents, mini.DataGrid.prototype.mini_doUpdateBody = mini.DataGrid.prototype._doUpdateBody, mini.DataGrid.prototype.miniDoLayout = mini.DataGrid.prototype.doLayout, mini.DataGrid.prototype.mini_OnCellBeginEdit = mini.DataGrid.prototype._OnCellBeginEdit, mini.DataGrid.prototype.mini_OnDrawCell = mini.DataGrid.prototype._OnDrawCell, mini.DataGrid.prototype.miniBeginEditRow = mini.DataGrid.prototype.beginEditRow, mini.copyTo(mini.DataGrid.prototype, {
	width : "100%",
	height : "100%",
	showFooter : !1,
	allowResize : !1,
	showModified : !1,
	allowUnselect : !0,
	editorHeight : 21,
	showEditHotTrack : !1,
	ajaxTimeout : 6e5,
	loadErrorAlert : !1,
	_initEvents : function() {
		this.mini_initEvents(), mini._BindEvents(function() {
			mini.on(this._headerEl, "mousemove", this.__OnHeaderCellMouseMove, this), mini.on(this._headerEl, "mouseout", this.__OnHeaderCellMouseOut, this)
		}, this)
	},
	getAttrs : function(t) {
		var e = this.miniGetAttrs(t);
		return mini._ParseInt(t, e, [ "editorHeight" ]), mini._ParseBool(t, e, [ "showEditHotTrack" ]), e
	},
	doLayout : function() {
		function t(t, e, i) {
			t.allowResize && -1 != t.width.indexOf("%") ? (d += parseInt(t.width), u++) : h -= parseInt(t.width)
		}
		function e(t, e, i) {
			t.allowResize && -1 != t.width.indexOf("%") ? (o[e].style.width = Math.floor(h * parseInt(t.width) / d) + "px", l[e].style.width = Math.floor(h * parseInt(t.width) / d) + "px") : (o[e].style.width = parseInt(t.width) + "px", l[e].style.width = parseInt(t.width) + "px")
		}
		if (this.canLayout()) {
			if (this.isFitColumns()) {
				var i = "hidden" == jQuery(this._bodyEl).css("overflow-y"),
					n = this._headerInnerEl.firstChild,
					s = this._bodyInnerEl.firstChild,
					o = n.rows[0].cells,
					l = s.rows[0].cells,
					r = this._bodyEl.scrollHeight,
					a = this._bodyEl.clientHeight,
					h = this.getWidth(!0);
				!i && r > a && !this.isAutoHeight() && (h = parseInt(h - 17));
				var d = 0,
					u = 0,
					c = this.getBottomColumns();
				this.eachColumns({
					columns : c
				}, t, this), 80 * u > h && (h = 80 * u), this.eachColumns({
					columns : c
				}, e, this)
			}
			this.miniDoLayout()
		}
	},
	setColumns : function(t) {
		function e(t, e, i) {
			t.editor && (t.editor.height = this.editorHeight)
		}
		this.miniSetColumns(t), this.eachColumns(this, e, this)
	},
	_createPager : function() {
		this.mini_createPager(), this.showFooter || this.pager.sizeCombo.un("valuechanged", this.pager.__OnPageSelectChanged, this.pager)
	},
	_OnCellClick : function(t) {
		this.fire("cellClick", t);
		var e = t.sender;
		if (!e.allowCellEdit || !e.allowCellSelect) {
			var i = this.getCellEditor(t.column, t.record);
			if (i && i.setHeight && "textarea" == i.type && i.getHeight() < 22) {
				var n = this._getCellEl(t.record, t.column),
					s = n.childNodes,
					o = s.length > 0 && 3 == s[0].nodeType;
				if (0 == i.enabled) return;
				o && (i.setValue($(n).html()), $(n).html(""));
				var l = this.getCellBox(t.record, t.column),
					r = mini_getPaddings(n);
				l.x = l.x + r.left, l.y = l.y - r.top, l.width = l.width - r.left - r.right;this._getEditWrap(l, n);mini.un(this._editWrap, "keydown", this.___OnEditControlKeyDown, this), this._editWrap.style.zIndex = mini.getMaxZIndex(), i.render(this._editWrap), setTimeout(function() {
					i.focus(), i.selectText && i.selectText()
				}, 10), i.setVisible && i.setVisible(!0);
				var a = i.getHeight();
				$(i).data("data", {
					cellHeight : a,
					cellId : this._createCellId(t.record, t.column)
				}), i.minHeight && a < i.minHeight && i.setHeight(i.minHeight);
				var h = this,
					d = function() {
						h.__onEditorBlur(i), mini.un(i._textEl, "blur", d, h), mini.un(h.el, "mousewheel", u, h)
					},
					u = function() {
						h.__onEditorBlur(i), mini.un(h.el, "mousewheel", u, h), mini.un(i._textEl, "blur", d, h)
					};
				mini.on(this.el, "mousewheel", u, h), mini.on(i._textEl, "blur", d, this)
			}
		}
	},
	_OnCellKeyUp : function(t) {
		9 == t.htmlEvent.keyCode && this._OnCellClick(t)
	},
	__onEditorBlur : function(t) {
		var e = t._textEl.value;
		e.length > t.maxLength && (t._textEl.value = e.substring(0, t.maxLength), t.setValue(t._textEl.value));
		var i = $(t),
			n = i.data("data");
		this._editWrap.style.display = "none";
		var s = document.getElementById(n.cellId);
		s.innerHTML = "", s.appendChild(t.el), t.setHeight(n.cellHeight)
	},
	_OnCellBeginEdit : function(t, e, i) {
		var n,
			s = i && i.style && i.style.toLowerCase() || "",
			o = /height\s*:\s*(\d{1,})px/,
			l = mini.DataGrid.prototype.mini_OnCellBeginEdit.apply(this, arguments);
		return s && (n = s.match(o)) && i.setHeight(n[1]), l
	},
	__OnHeaderCellMouseMove : function(t) {
		var e = mini.findParent(t.target, "mini-grid-headerCell");
		if (e)
			if (e.firstChild.scrollWidth > e.clientWidth) {
				var i = e.innerText || e.textContent || "";
				e.title = i.trim()
			} else
				e.title = ""
	},
	__OnHeaderCellMouseOut : function(t) {
		var e = mini.findParent(t.target, "mini-grid-headerCell");
		e && (e.title = "")
	},
	getClientLastRowHeight : function(t) {
		var e = $(this._bodyEl).height(),
			i = $(this._bodyInnerEl.firstChild).height(),
			n = 0,
			s = this.getRowBox(0);
		return s && (n = s.height), n % 2 == 0 && (n += 1), i > e + n ? 0 : i > e ? n + e - i : n > i ? i : n
	},
	getBodyEl : function() {
		return this._bodyEl
	},
	beginEdit : function() {
		if (!this.allowCellEdit) {
			var t = this;
			this._allowLayout = !1, this.findRows(function(e) {
				t.beginEditRow(e)
			}), this._allowLayout = !0, this.doLayout()
		}
	},
	getEditData : function(t, e) {
		for (var i = [], n = 0, s = this.data.length; s > n; n++) {
			var o = this.data[n];
			if (1 == o._editing) {
				var l = this.getEditRowData(n, t);
				l._index = n, i.push(l)
			} else e && i.push(o)
		}
		return i
	},
	_doUpdateBody : function() {
		mini.DataGrid.prototype.mini_doUpdateBody.call(this), this.fire("updatebody")
	},
	_OnDrawCell : function(t, e, i, n) {
		var s = this.mini_OnDrawCell(t, e, i, n);
		return this.showEditHotTrack && e.editor && this.allowCellEdit && (s.cellCls = s.cellCls + " mini-grid-editCell-hotTrack"), s
	},
	beginEditRow : function(t) {
		if (this.miniBeginEditRow(t), this.showEditHotTrack) {
			var e = this._getRowEl(t);
			$(".mini-grid-cellEdit", e).addClass("mini-grid-editCell-hotTrack")
		}
	}
})), mini._ColumnSplitter && (mini._ColumnSplitter.prototype.mini_OnDragStop = mini._ColumnSplitter.prototype._OnDragStop, mini.copyTo(mini._ColumnSplitter.prototype, {
	_OnDragStop : function(t) {
		this.mini_OnDragStop(t);
		var e = this.grid,
			i = mini.getBox(this._dragProxy),
			n = this.splitterColumn,
			s = parseInt(n.width);
		if (s + "%" == n.width) {
			var o = e.getColumnWidth(n);
			parseInt(s / o * i.width);e.setColumnWidth(n, i.width)
		}
	}
})), mini.Pager && mini.copyTo(mini.Pager.prototype, {
	showReloadButton : !1
}), mini.Tree && (mini.Tree.prototype.mini_initEvents = mini.Tree.prototype._initEvents, mini.Tree.prototype.miniGetAttrs = mini.Tree.prototype.getAttrs, mini.Tree.prototype.mini_OnNodeMouseDown = mini.Tree.prototype._OnNodeMouseDown, mini.Tree.prototype.mini_OnNodeClick = mini.Tree.prototype._OnNodeClick, mini.Tree.prototype.mini_doCheckNode = mini.Tree.prototype._doCheckNode, mini.copyTo(mini.Tree.prototype, {
	showTreeIcon : !0,
	resultAsTree : !1,
	recursiveParent : !1,
	recursiveChild : !1,
	allowParentSelect : !0,
	allowAnim : !1,
	getAttrs : function(t) {
		var e = mini.Tree.prototype.miniGetAttrs.call(this, t);
		return mini._ParseBool(t, e, [ "allowParentSelect" ]), e
	},
	_initEvents : function() {
		this.mini_initEvents(), this.on("nodeClick", this.__OnNodeClick, this)
	},
	__OnNodeClick : function(t) {
		var e = this._getCheckBoxEl(t.node);
		e && e.click()
	},
	_OnNodeClick : function(t, e) {
		(this.allowParentSelect || this.isLeaf(t)) && this.mini_OnNodeClick(t, e)
	},
	_OnNodeMouseDown : function(t, e) {
		(this.allowParentSelect || this.isLeaf(t)) && this.mini_OnNodeMouseDown(t, e)
	},
	setAllowParentSelect : function(t) {
		this.allowParentSelect = t
	},
	setRecursiveParent : function(t) {
		this.recursiveParent = t
	},
	setRecursiveChild : function(t) {
		this.recursiveChild = t
	},
	_doCheckNode : function(t, e, i) {
		mini.Tree.prototype.mini_doCheckNode.call(this, t, e, i);
		var n = [];
		if (this.recursiveParent) {
			var s = this.getAncestors(t);
			s.reverse();
			for (var o = 0, l = s.length; l > o; o++) {
				for (var r = s[o], a = this.getChildNodes(r), h = !0, d = !1, u = 0, c = a.length; c > u; u++) {
					var m = a[u];
					this.isCheckedNode(m) ? d = !0 : h = !1
				}
				h ? (r.checked = !0, r._indeterminate = !1) : (r.checked = !1, r._indeterminate = d), n.push(r)
			}
		}
		this.recursiveChild && this.cascadeChild(t, function(t) {
			t.checked = e, t._indeterminate = !1, n.push(t)
		}, this);
		for (var o = 0, l = n.length; l > o; o++) {
			var p = n[o],
				f = this._getCheckBoxEl(p);
			f && (p.checked ? (f.indeterminate = !1, f.checked = !0) : (f.indeterminate = p._indeterminate, f.checked = !1))
		}
	},
	getMaxLevel : function() {
		var t = 0;
		return this.cascadeChild(this.root, function(e, i, n) {
				t = Math.max(t, e._level)
			}, this), t
	}
})), mini.TreeGrid && mini.copyTo(mini.TreeGrid.prototype, {
	width : "100%",
	height : "100%",
	showTreeIcon : !0,
	resultAsTree : !1,
	allowResize : !1,
	leafIcon : "mini-tree-folder"
}), mini.ButtonEdit && (mini.ButtonEdit.prototype.miniGetAttrs = mini.ButtonEdit.prototype.getAttrs, mini.ButtonEdit.prototype.miniSet = mini.ButtonEdit.prototype.set, mini.copyTo(mini.ButtonEdit.prototype, {
	width : "100%",
	emptyText : "-请选择-",
	buttonText : "",
	getAttrs : function(t) {
		var e = mini.ButtonEdit.prototype.miniGetAttrs.call(this, t);
		return mini._ParseString(t, e, [ "buttonText" ]), e
	},
	set : function(t) {
		var e = t.buttonText;
		delete t.buttonText
		, mini.ButtonEdit.prototype.miniSet.call(this, t), e && this.setButtonText(e)
	},
	setButtonText : function(t) {
		this.buttonText = t, $(this._buttonEl).empty().html(this.buttonText)
	}
})), mini.FileUpload && mini.copyTo(mini.FileUpload.prototype, {
	width : "100%",
	showClose : !1,
	flashUrl : "/daie/scripts/swf/swfupload.swf"
}), mini.Splitter && mini.copyTo(mini.Splitter.prototype, {
	width : "100%",
	height : "100%"
}), mini.PopupEdit && mini.copyTo(mini.PopupEdit.prototype, {
	width : "100%"
}), mini.WDatePicker && mini.copyTo(mini.WDatePicker.prototype, {
	width : "100%",
	showClose : !1
}), mini.DatePicker && mini.copyTo(mini.DatePicker.prototype, {
	width : "100%",
	showClose : !1
}), mini.ListControl && (mini.ListControl.prototype.mini_initEvents = mini.ListControl.prototype._initEvents, mini.copyTo(mini.ListControl.prototype, {
	_initEvents : function() {
		mini.ListControl.prototype.mini_initEvents.call(this), this.on("beforeload", mini.ListControl.prototype.__OnBeforeLoad, this)
	},
	__OnBeforeLoad : function(t) {
		t.async = !0
	}
})), mini.ListBox && mini.copyTo(mini.ListBox.prototype, {
	nullItemText : "-请选择-",
	width : "100%",
	height : "100%",
	delimiter : ", "
}), mini.ComboBox && (mini.ComboBox.prototype.mini__createPopup = mini.ComboBox.prototype._createPopup, mini.ComboBox.prototype.mini_setData = mini.ComboBox.prototype.setData, mini.ComboBox.prototype.miniGetAttrs = mini.ComboBox.prototype.getAttrs, mini.ComboBox.prototype.miniSetValue = mini.ComboBox.prototype.setValue, mini.ComboBox.prototype.miniSet = mini.ComboBox.prototype.set, mini.copyTo(mini.ComboBox.prototype, {
	width : "100%",
	selectFirst : !0,
	showClose : !1,
	valueFromSelect : !0,
	emptyText : "-请选择-",
	set : function(t) {
		this._value = t.value, this.miniSet(t)
	},
	getAttrs : function(t) {
		var e = mini.ComboBox.prototype.miniGetAttrs.call(this, t);
		return mini._ParseString(t, e, [ "relations", "url2" ]), mini._ParseBool(t, e, [ "selectFirst", "defaultValueTriggerChange" ]), e
	},
	getRelations : function() {
		return this.relations
	},
	setRelations : function(t) {
		this.relations = t, mini.Relations.add(this)
	},
	getUrl2 : function() {
		return this.url2
	},
	setUrl2 : function(t) {
		this.url2 = t
	},
	__OnItemLoad : function() {
		this.data = this._listbox.data, !this.showNullItem && this.selectFirst && ("undefined" == typeof this._value && "" === this.value || "undefined" != typeof this._value && "" === this._value) && this.data.length > 0 ? (this.setValue(this.data[0][this.valueField]), this.defaultValue = this.data[0][this.valueField]) : ("undefined" != typeof this._value ? this.setValue(this._value, this.defaultValueTriggerChange) : this.setValue(this.value),
		delete this._value
		)
	},
	__OnItemBeforeLoad : function(t) {
		t.async = !0
	},
	_createPopup : function() {
		this.mini__createPopup(), this._listbox.on("load", this.__OnItemLoad, this), this._listbox.on("beforeload", this.__OnItemBeforeLoad, this)
	},
	setData : function(t) {
		this.mini_setData(t), "pagesize" != this.name && !this.showNullItem && this.selectFirst && "" === this.value && this.data.length > 0 && (this.setValue(this.data[0][this.valueField]), this.defaultValue = this.data[0][this.valueField])
	},
	setValue : function(t, e) {
		if (this._value = t, this.miniSetValue(t, e), !this.valueFromSelect && this._textEl) {
			var i = this.getText();
			"" !== t && ("" === i || this.showNullItem && mini.isEquals(i, this._listbox.getNullItemText())) && this.setText(this.getValue())
		}
	},
	getTextByValue : function(t) {
		return this._listbox.getValueAndText(t)[1]
	}
})), mini.TreeSelect && (mini.TreeSelect.prototype.miniGetAttrs = mini.TreeSelect.prototype.getAttrs, mini.TreeSelect.prototype.miniGetFormValue = mini.TreeSelect.prototype.getFormValue, mini.TreeSelect.prototype.miniSetValue = mini.TreeSelect.prototype.setValue, mini.TreeSelect.prototype.mini_createPopup = mini.TreeSelect.prototype._createPopup, mini.TreeSelect.prototype.miniSet = mini.TreeSelect.prototype.set, mini.TreeSelect.prototype.mini_createQueryToolBar = mini.TreeSelect.prototype._createQueryToolBar, mini.TreeSelect.prototype.mini_destroyQueryToolBar = mini.TreeSelect.prototype._destroyQueryToolBar, mini.copyTo(mini.TreeSelect.prototype, {
	width : "100%",
	popupWidth : "100%",
	popupMinWidth : 250,
	showQueryToolBar : !0,
	showRecursiveCbx : !1,
	hasClear : !0,
	valueFormat : "json",
	emptyText : "-请选择-",
	delimiter : ", ",
	popupHeight : 300,
	popupMaxHeight : 300,
	popupMinHeight : 200,
	valueFromSelect : !0,
	allowParentSelect : !0,
	defaultText : "",
	set : function(t) {
		var e = t.leafIcon;
		delete t.leafIcon
		, mini.isNull(e) || this.setLeafIcon(e), this.miniSet(t), mini.isNull(this.emptyText) || this._doEmpty(), mini.isNull(this.text) || (this.defaultText = this.text)
	},
	mini__onTreeLoad : function() {
		if (this.recursiveCbx && this.multiSelect && this.showRecursiveCbx) {
			var t = this.tree.getMaxLevel();
			t > 0 ? this.recursiveCbx.show() : this.recursiveCbx.hide()
		}
	},
	_createPopup : function() {
		this.mini_createPopup(), this.tree.on("load", this.mini__onTreeLoad, this)
	},
	getAttrs : function(t) {
		var e = this.miniGetAttrs(t);
		return mini._ParseString(t, e, [ "valueFields", "valueFormat", "relations", "emptyText", "url2", "leafIcon" ]), mini._ParseBool(t, e, [ "valueFromSelect", "allowParentSelect", "showRecursiveCbx" ]), e
	},
	setLeafIcon : function(t) {
		this.getPopup(), this.tree.setLeafIcon(t), this.leafIcon = this.tree.leafIcon
	},
	setValueFields : function(t) {
		this.valueFields = t
	},
	setValueFormat : function(t) {
		this.valueFormat = t
	},
	getRelations : function() {
		return this.relations
	},
	setRelations : function(t) {
		this.relations = t, mini.Relations.add(this)
	},
	getUrl2 : function() {
		return this.url2
	},
	setUrl2 : function(t) {
		this.url2 = t
	},
	getFormValue : function() {
		function t(t, e, i) {
			if (i && "json" != i) {
				var n = [];
				e.length > 0 && n.push(t[e[0]]);
				for (var s = 1; s < e.length; s++) {
					var o = e[s];
					n.push(t[o])
				}
				return n.join(i)
			}
			for (var l = {}, s = 0; s < e.length; s++) {
				var o = e[s];
				l[o] = t[o]
			}
			return l
		}
		if (this.valueFields) {
			var e,
				i = this.valueFields.split(",");
			if (this.multiSelect) {
				e = [];
				for (var n = this.tree.getNodesByValue(this.value), s = 0; s < n.length; s++) {
					var o = n[s];
					e.push(t(o, i, this.valueFormat))
				}
				this.valueFormat && "json" != this.valueFormat && (e = e.join(this.delimiter))
			} else {
				var o = this.tree.getNode(this.value);
				o && (e = t(o, i, this.valueFormat))
			}
			return mini.isNull(e) ? "" : mini.encode(e)
		}
		return this.miniGetFormValue()
	},
	setText : function(t) {
		mini.TreeSelect.superclass.setText.call(this, t), this.defaultText = t
	},
	setValue : function(t, e) {
		if (this.valueFields && t)
			if (this.valueFormat && "json" != this.valueFormat)
				;else try {
					var i = mini.decode(t);
					if (this.multiSelect && i.length >= 0) {
						for (var n = i, s = [], o = 0; o < n.length; o++) {
							var l = n[o];
							l && l[this.valueField] && s.push(l[this.valueField])
						}
						t = s.join(this.delimiter)
					} else i && i[this.valueField] && (t = i[this.valueField])
				} catch (r) {}
		if (!this.valueFromSelect && "" !== t) {
			var a = this.tree.getValueAndText(t);
			if ("" === a[1] || a[1].split(this.delimiter).length < t.split(this.delimiter).length) {
				var h = this.value;
				return this.value = t, this._valueEl.value = t, this.setText(this.defaultText), void (mini.isEquals(this.value, h) || (this.tree.setValue(this.value), this._OnValueChanged()))
			}
		}
		this.miniSetValue(t, e)
	},
	setMultiSelect : function(t) {
		this.multiSelect != t && (this.multiSelect = t, this.tree.setShowCheckBox(t), this.tree.setAllowSelect(!0), this.tree.setEnableHotTrack(!0), this.multiSelect || this.recursiveCbx.hide())
	},
	setAllowParentSelect : function(t) {
		this.allowParentSelect != t && (this.allowParentSelect = t, this.tree.setAllowParentSelect(t))
	},
	setShowRecursiveCbx : function(t) {
		this.showRecursiveCbx != t && (this.showRecursiveCbx = t)
	},
	_createQueryToolBar : function() {
		this.mini_createQueryToolBar(), this.showQueryToolBar && this.queryToolbar && !this.recursiveCbx && (this.recursiveCbx = new mini.CheckBox, this.recursiveCbx.setText("联动"), this.recursiveCbx.render(this.queryToolbar.el), this.recursiveCbx.on("checkedchanged", this._onRecursiveChanged, this), this.multiSelect && this.showRecursiveCbx || this.recursiveCbx.hide(), this.popup.on("Close", function() {
			this.recursiveCbx.setChecked(!1)
		}, this)), this.showQueryToolBar && this.queryToolbar && !this.closeButton && (this.closeButton = new mini.Button, this.closeButton.setIconCls("icon-popup-close"), this.closeButton.setPlain(!0), this.closeButton.render(this.queryToolbar.el), this.closeButton.onClick(this._onClose, this)), this.on("showpopup", function() {
			var t = this.queryToolbar.getWidth();
			this.recursiveCbx.isDisplay() && (t -= 46), this.queryInput.setWidth(t - 82)
		})
	},
	_destroyQueryToolBar : function(t) {
		this.isShowPopup() && this.hidePopup(), this.closeButton && (mini.clearEvent(this.closeButton), this.closeButton.destroy(t), this.closeButton = null), this.recursiveCbx && (mini.clearEvent(this.recursiveCbx), this.recursiveCbx.destroy(t), this.recursiveCbx = null), this.mini_destroyQueryToolBar(t)
	},
	_onClose : function() {
		this.hidePopup()
	},
	_onRecursiveChanged : function(t) {
		this.tree.setRecursiveParent(!1), t.checked ? this.tree.setRecursiveChild(!0) : this.tree.setRecursiveChild(!1)
	}
})), mini.TextBox && (mini.TextBox.prototype.miniFocus = mini.TextBox.prototype.focus, mini.copyTo(mini.TextBox.prototype, {
	width : "100%",
	focus : function() {
		if (0 != this.enabled) {
			var t = this;
			setTimeout(function() {
				mini.TextBox.prototype.miniFocus.call(t);try {
					t._textEl.focus()
				} catch (e) {}
			}, 10)
		}
	}
})), mini.TextArea && mini.copyTo(mini.TextArea.prototype, {
	width : "100%"
}), mini.Password && mini.copyTo(mini.Password.prototype, {
	width : "100%"
}), mini.Layout && (mini.Layout.prototype.mini_createRegion = mini.Layout.prototype._createRegion, mini.Layout.prototype.miniDoLayout = mini.Layout.prototype.doLayout, mini.copyTo(mini.Layout.prototype, {
	_createRegion : function(t) {
		return t = t || {}, t.showSplit || (t.showSplit = !1), t.showHeader || (t.showHeader = !1), this.mini_createRegion(t)
	},
	doLayout : function() {
		this.miniDoLayout();
		for (var t = mini.getWidth(this.el, !0), e = this.regions.clone(), i = 0, n = e.length; n > i; i++) {
			var s = e[i];
			!s.expanded && "north" == s.region && s.showHeader && mini.setWidth(s._proxy, t - 20)
		}
	}
})), mini.OutlookBar && (mini.OutlookBar.prototype.mini_tryToggleGroup = mini.OutlookBar.prototype._tryToggleGroup, mini.OutlookBar.prototype.miniGetAttrs = mini.OutlookBar.prototype.getAttrs, mini.OutlookBar.prototype.miniParseGroups = mini.OutlookBar.prototype.parseGroups, mini.OutlookBar.prototype.mini__OnClick = mini.OutlookBar.prototype.__OnClick, mini.OutlookBar.prototype.miniDoUpdate = mini.OutlookBar.prototype.doUpdate, mini.OutlookBar.prototype.miniCollapseGroup = mini.OutlookBar.prototype.collapseGroup, mini.copyTo(mini.OutlookBar.prototype, {
	allowAnim : !1,
	showMaxButton : !1,
	_currMaxButton : "mini-tools-max",
	doUpdate : function() {
		mini.OutlookBar.prototype.miniDoUpdate.call(this), this.setShowMaxButton(this.showMaxButton)
	},
	getAttrs : function(t) {
		var e = mini.OutlookBar.prototype.miniGetAttrs.call(this, t);
		return mini._ParseBool(t, e, [ "showMaxButton" ]), e
	},
	parseGroups : function(t) {
		for (var e = mini.OutlookBar.prototype.miniParseGroups.call(this, t), i = 0, n = t.length; n > i; i++) {
			var s = t[i];
			mini._ParseBool(s, e[i], [ "showMaxButton" ])
		}
		return e
	},
	_tryToggleGroup : function(t) {
		t = this.getGroup(t), t.showCollapseButton && this.mini_tryToggleGroup(t)
	},
	__OnClick : function(t) {
		this._inAniming || (mini.hasClass(t.target, "mini-tools-max") ? mini.OutlookBar.prototype.___maxGroup.call(this, t) : mini.hasClass(t.target, "mini-tools-restore") ? mini.OutlookBar.prototype.___restoreGroup.call(this, t) : mini.OutlookBar.prototype.mini__OnClick.call(this, t))
	},
	___maxGroup : function(t) {
		this._currMaxButton = "mini-tools-restore", this._allowLayout = !1, $(t.target).addClass("mini-tools-restore").removeClass("mini-tools-max");
		var e = this._getGroupByEvent(t);
		this.expandGroup(e);
		for (var i = 0, n = this.groups.length; n > i; i++) e._id != this.groups[i]._id && this.hideGroup(this.groups[i]);
		this._allowLayout = !0, this.doLayout()
	},
	___restoreGroup : function(t, e) {
		this._currMaxButton = "mini-tools-max", this._allowLayout = !1, e ? $(".mini-tools-restore", e.el).addClass("mini-tools-max").removeClass("mini-tools-restore") : $(t.target).addClass("mini-tools-max").removeClass("mini-tools-restore");
		for (var e = e || this._getGroupByEvent(t), i = 0, n = this.groups.length; n > i; i++) e._id != this.groups[i]._id && this.showGroup(this.groups[i]);
		this._allowLayout = !0, this.doLayout()
	},
	collapseGroup : function(t) {
		mini.OutlookBar.prototype.miniCollapseGroup.call(this, t);
		var e = this.getActiveGroup();
		this.showMaxButton && $(".mini-tools-restore", t.el).length > 0 && null == e && mini.OutlookBar.prototype.___restoreGroup.call(this, null, t)
	},
	setShowMaxButton : function(t) {
		if (this.showMaxButton = t, this.showMaxButton) {
			for (var e = 0, i = this.groups.length; i > e; e++) {
				var n = this.groups[e],
					s = n._el,
					o = s.firstChild;
				0 != n.showMaxButton && $(".mini-tools", o).append('<span class="' + this._currMaxButton + '"></span>')
			}
			this.doLayout()
		} else $(".mini-tools-max, .mini-tools-restore").remove()
	},
	getShowMaxButton : function() {
		return this.showMaxButton
	}
})), mini.OutlookTree && mini.copyTo(mini.OutlookTree.prototype, {
	_currMaxButton : "mini-tools-max",
	__OnClick : function(t) {
		mini.OutlookTree.superclass.__OnClick.call(this, t)
	},
	setShowMaxButton : function(t) {
		mini.OutlookTree.superclass.setShowMaxButton.call(this, t)
	},
	getShowMaxButton : function() {
		return mini.OutlookTree.superclass.getShowMaxButton.call(this)
	},
	collapseGroup : function(t) {
		mini.OutlookTree.superclass.collapseGroup.call(this, t)
	},
	doUpdate : function() {
		mini.OutlookTree.superclass.doUpdate.call(this)
	}
}), mini.Tabs && (mini.Tabs.prototype.mini_doLoadTab = mini.Tabs.prototype._doLoadTab, mini.copyTo(mini.Tabs.prototype, {
	_doLoadTab : function(t) {
		if (t && t == this.getActiveTab()) {
			var e = this.getTabBodyEl(t);
			if (e) {
				var i;
				t.charset && (i = document.charset, document.charset = t.charset), this.mini_doLoadTab(t), i && setTimeout(function() {
					document.charset = i
				}, 5)
			}
		}
	}
})), mini._setMap && (mini.mini_setMap = mini._setMap, mini._setMap = function(t, e, i) {
	"string" == $.type(e) && (e = e.trim()), mini.mini_setMap(t, e, i)
}), mini._ValidateVType && (mini.mini_ValidateVType = mini._ValidateVType, mini._ValidateVType = function(t, e, i, n) {
	"string" == $.type(e) && (e = e.trim()), mini.mini_ValidateVType(t, e, i, n)
}), mini.VTypes && mini.copyTo(mini.VTypes, {
	letterNumberErrorText : "请输入数字或字母",
	letter_NumberErrorText : "请输入数字、字母、下划线",
	numberErrorText : "请输入数字",
	noSpaceErrorText : "不能输入空白字符",
	lengthErrorText : "请输入{0}个字符",
	zbMcErrorText : "请输入汉字、数字、字母、下划线或括号",
	letterNumber : function(t, e) {
		if (mini.isNull(t) || "" === t) return !0;
		var i = new RegExp("^[0-9a-zA-Z]+$");
		return i.test(t)
	},
	letter_Number : function(t, e) {
		if (mini.isNull(t) || "" === t) return !0;
		var i = new RegExp("^[0-9a-zA-Z_]+$");
		return i.test(t)
	},
	number : function(t, e) {
		if (mini.isNull(t) || "" === t) return !0;
		var i = new RegExp("^(-?\\d+)(\\.\\d+)?$");
		return i.test(t)
	},
	noSpace : function(t, e) {
		if (mini.isNull(t) || "" === t) return !0;
		var i = new RegExp("\\s+");
		return !i.test(t)
	},
	length : function(t, e) {
		if (mini.isNull(t) || "" === t) return !0;
		var i = parseInt(e);
		return isNaN(i) ? !0 : t.length == i ? !0 : !1
	},
	zbMc : function(t, e) {
		if (mini.isNull(t) || "" === t) return !0;
		var i = new RegExp("^[0-9a-zA-Z_一-龥()]+$");
		return i.test(t)
	}
}), mini && (mini.dataClone = function(t) {
	return "array" == $.type(t) ? (t = mini.encode(t), mini.decode(t)) : $.extend(!0, {}, t)
}), mini && (mini.decode = function(json) {
	return "" === json || null === json || void 0 === json ? json : eval("(" + json + ")")
}), mini && (mini.miniOpen = mini.open, mini.open = function(t) {
	function e() {
		if (!t.currentWindow) {
			i = t.win;
			var e = t.charset || document.charset;
			i.document.charset != e && (n = i.document.charset, i.document.charset = e)
		}
	}
	var i,
		n;
	if (t.beforeopen) {
		var s = t.beforeopen;
		t.beforeopen = function(t) {
			return e(), s(t)
		}
	} else
		t.beforeopen = function(t) {
			return e(), !0
		};
	var o = mini.miniOpen(t);
	return !t.currentWindow && i && n && setTimeout(function() {
			i.document.charset = n
		}, 0), o
}), mini.DataGrid && mini.copyTo(mini.DataGrid.prototype, {
	emptyText : "无记录"
});