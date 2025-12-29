export function AnalyticsPlugin() {
	return {
		name: "analytics-plugin",
		transformIndexHtml(html) {
			return html.replace(
				"</head>",
				`<script>
          var _hmt = _hmt || [];
          (function() {
            var hm = document.createElement("script");
            hm.src = "https://hm.baidu.com/hm.js?515d3e08831eb784a6545b02fa509d48";
            var s = document.getElementsByTagName("script")[0]; 
            s.parentNode.insertBefore(hm, s);
          })();
        </script>
        </head>`
			);
		},
	};
}
